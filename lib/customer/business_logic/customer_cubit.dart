import 'dart:io';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:min_id/min_id.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lacrima/customer/data/models/job_model.dart';
import 'package:lacrima/customer/data/models/customer_model.dart';
import 'package:lacrima/customer/data/models/feedback_model.dart';
import 'package:lacrima/customer/business_logic/customer_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lacrima/customer/data/models/complaints_and_suggestion.dart';
import 'package:lacrima/customer/presentation/screens/profile/customer_profile.dart';
import 'package:lacrima/customer/presentation/screens/home/customer_home_screen.dart';
import 'package:lacrima/customer/presentation/screens/catalogue/customer_catalogue.dart';
import 'package:lacrima/customer/presentation/screens/layout/customer_layout_screen.dart';
import 'package:lacrima/customer/presentation/screens/orders/customer_orders_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerCubit extends Cubit<CustomerStates> {
  CustomerCubit() : super(CustomerInitialState());

  static CustomerCubit get(context) => BlocProvider.of(context);

  // ############ Customer SignUp ############
  Future<void> customerSignUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
     String? birthday,
    required String phone,
    required String userName,
    required String companyName,
    required List<dynamic> interest,
    required BuildContext context,
  }) async {
    try {
      emit(CustomerSignUpLoadingState());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        await insertCustomer(
          docId: value.user!.uid,
          firstName: firstName,
          lastName: lastName,
          birthday: birthday,
          companyName: companyName,
          email: email,
          phone: phone,
          userName: userName,
          interest: interest,
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppItems.customText(
              'The password provided is too weak.',
              fontSize: 12.sp,
            ),
          ),
        );
        emit(CustomerSignUpErrorState(e.toString()));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppItems.customText(
              'The account already exists for that email.',
              fontSize: 12.sp,
            ),
          ),
        );
        emit(CustomerSignUpErrorState(e.toString()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppItems.customText(
            e.toString(),
            fontSize: 12.sp,
          ),
        ),
      );
      emit(CustomerSignUpErrorState(e.toString()));
    }
  }

  // ############ Customer SignIn ############
  Future customerSignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(CustomerSignInLoadingState());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ConstText.customerId = value.user!.uid;
      });
      navigateAndFinish(
          context, CustomerLayoutScreen(id: ConstText.customerId));
      emit(CustomerSignInSuccessState(ConstText.customerId));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppItems.customText(
              'No user found for that email.',
              fontSize: 12.sp,
            ),
          ),
        );
        emit(CustomerSignInErrorState(error.toString()));
      } else if (error.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppItems.customText(
              'Wrong password provided for that user.',
              fontSize: 12.sp,
            ),
          ),
        );
        emit(CustomerSignInErrorState(error.toString()));
      }
    }
  }

  // ############ Get Customer Data ############
  CustomerModel? customerModel;
  Future getCustomerData({
    required String id,
  }) async {
    emit(GetCustomerLoadingState());
    await FirebaseFirestore.instance
        .collection('Customers')
        .doc(id)
        .get()
        .then((value) {
      customerModel = CustomerModel.fromJson(value.data()!);
      emit(GetCustomerSuccessState());
    }).catchError((error) {
      emit(GetCustomerErrorState(error.toString()));
    });
  }

  // ############ Customer SignOut ############
  Future<void> customerSignOut() async {
    emit(CustomerSignOutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      emit(CustomerSignOutSuccessState());
    }).catchError((error) {
      emit(CustomerSignOutErrorState(error.toString()));
    });
  }

  // ############ Insert Customer ############
  Future<void> insertCustomer({
    required String docId,
    required String firstName,
    required String lastName,
     String? birthday,
    required String companyName,
    required String email,
    required String phone,
    required String userName,
    required List<dynamic> interest,
  }) async {
    await uploadProfileImage(docId);
    emit(InsertCustomerLoadingState());
    CustomerModel customerModel = CustomerModel(
      docId: docId,
      token: '',
      email: email,
      phone: phone,
      lastName: lastName,
      birthday: birthday,
      userName: userName,
      firstName: firstName,
      gender: selectGender,
      companyName: companyName,
      interest: interest,
    );
    await FirebaseFirestore.instance
        .collection('Customers')
        .doc(docId)
        .set(customerModel.toJson())
        .then((value) {
      if (profileImageUrl.isNotEmpty) {
        setProfileImage(id: docId, urlImage: profileImageUrl);
      }
      emit(InsertCustomerSuccessState(docId));
    }).catchError((error) {
      emit(InsertCustomerErrorState(error.toString()));
    });
  }

  // ############ Update Customer ############
  Future<void> updateCustomer({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
    required String companyName,
    required String birthday,
  }) async {
    emit(UpdateCustomerLoadingState());
    if (profileImage != null) {
      await uploadProfileImage(id);
    }
    FirebaseFirestore.instance.collection('Customers').doc(id).set({
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'companyName': companyName,
      'birthday': birthday,
    }, SetOptions(merge: true)).then((value) async {
      if (profileImageUrl.isNotEmpty) {
        setProfileImage(id: id, urlImage: profileImageUrl);
      }
      emit(UpdateCustomerSuccessState());
    }).catchError((error) {
      emit(UpdateCustomerErrorState(error.toString()));
    });
  }

  // ===================== Set Customer Device Token =====================
  Future<void> setCustomerToken({
    required String id,
    required String token,
  }) async {
    emit(SetCustomerTokenLoadingState());
    await FirebaseFirestore.instance.collection('Customers').doc(id).set({
      'token': token,
    }, SetOptions(merge: true)).then((value) async {
      emit(SetCustomerTokenSuccessState());
    }).catchError((error) {
      emit(SetCustomerTokenErrorState(error.toString()));
    });
  }

  // ===================== Reset Password =====================
  Future<void> resetPassword(String email) async {
    emit(CustomerResetPasswordLoadingState());
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) async {
      emit(CustomerResetPasswordSuccessState());
    }).catchError((error) {
      emit(CustomerResetPasswordErrorState(error.toString()));
    });
  }

  // ################# Handling Bottom Nav Customer #################
  int currentIndex = 0;
  List<BottomNavigationBarItem> customerBottomNavItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    const BottomNavigationBarItem(
      label: 'Catalogue',
      icon: Icon(Icons.collections_bookmark_sharp),
    ),
    const BottomNavigationBarItem(
      label: 'Orders',
      icon: Icon(Icons.fact_check_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'Account',
      icon: Icon(Icons.person_sharp),
    ),
  ];

  List<Widget> screens = [
    const CustomerHomeScreen(),
    const CustomerCatalogue(),
    const CustomerOrdersScreen(),
     CustomerProfile(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(CustomerBottomNavChangeState());
  }
// ######################################################################

  ComplaintsAndSuggestionModel? complaintsAndSuggestionModel;
  Future<void> insertComplaintsAndSuggestion({
    required String fullName,
    required String content,
    required String email,
  }) async {
    var id = MinId.getId();
    ComplaintsAndSuggestionModel model = ComplaintsAndSuggestionModel(
      id: id,
      email: email,
      content: content,
      fullName: fullName,
      type: enquiryTypeValue,
      createdAt: Timestamp.fromDate(DateTime.now()),
      date: DateFormat.yMMMd().format(DateTime.now()),
    );
    emit(InsertComplaintsAndSuggestionLoadingState());
    await FirebaseFirestore.instance
        .collection('Complaints And Suggestions')
        .doc('Customers')
        .collection('Complaints And Suggestions')
        .doc(id)
        .set(model.toJson())
        .then((value) {
      emit(InsertComplaintsAndSuggestionSuccessState());
    }).catchError((error) {
      emit(InsertComplaintsAndSuggestionErrorState(error.toString()));
    });
  }

  Future<void> insertFeedBack({
    required String email,
    required String content,
    required String lastName,
    required String firstName,
  }) async {
    var id = MinId.getId();
    FeedbackModel feedbackModel = FeedbackModel(
      id: id,
      email: email,
      content: content,
      lastName: lastName,
      firstName: firstName,
      date: DateFormat.yMMMMd().format(DateTime.now()),
    );
    emit(InsertFeedbackLoadingState());
    await FirebaseFirestore.instance
        .collection('Feedback')
        .doc(id)
        .set(feedbackModel.toJson())
        .then((value) {
      emit(InsertFeedbackSuccessState());
    }).catchError((error) {
      emit(InsertFeedbackErrorState(error.toString()));
    });
  }

  // ####### Handling Insert Job To Fire store #######
  Future<void> insertJob({
    required String name,
    required String title,
    required String phone,
    required String email,
  }) async {
    var id = MinId.getId();
    JobModel jobModel = JobModel(
      id: id,
      name: name,
      title: title,
      phone: phone,
      email: email,
      yourJob: jobValue,
      date: DateFormat.yMMMMd().format(DateTime.now()),
    );
    emit(InsertJobLoadingState());
    FirebaseFirestore.instance
        .collection('Jobs')
        .doc(id)
        .set(jobModel.toJson())
        .then((value) async {
      emit(InsertJobSuccessState());
      await uploadCvPDF(id: id);
    }).catchError((error) {
      emit(InsertJobErrorState(error.toString()));
    });
  }

  // ############ Handling Employee Section ############
  List<String> jobs = [
    'Production engineer',
    'Production supervisor',
    'Production manager',
    'production worker',
    'Storekeeper',
    'Warehouse supervisor',
    'Warehouse worker',
    'Warehouse manager',
    'Procurement supervisor',
    'Logistics supervisor',
    'Supply chain head department',
    'Supply chain manager',
    'Finance manager',
    'Accountant',
    'Senior Accountant',
    'Accountant head department',
    'Senior Cost accountant',
    'Internal audit',
    'Accountant analysis',
    'Sales supervisor',
    'Sales head department',
    'Sales manager',
    'Sales coordinator',
    'Hr assistant',
    'Hr supervisor',
    'Hr head department',
    'Hr manager',
    'Office manager',
    'Office management assistance',
    'Technical support',
    'IT manager',
    'Cleaner',
    'Research and development assistance',
    'Research and development manager',
    'Research and development supervisor',
    'Planning supervisor',
    'Planning assistance',
    'Planning manager',
    'QA supervisor',
    'QA manager',
    'QC manager',
    'QC supervisor',
    'Quality department manager',
    'Public relation manager',
    'Marketing manager',
    'Business development manager',
    'Business development assistance',
    'Business project manager',
    'Business project assistance',
    'Electrical engineer',
    'Mechanical engineer',
    'Mechatronics engineer',
    'Industrial engineer',
    'Civil engineer',
    'Electrical technical',
    'Mechanical technical',
    'Mechatronics technical',
    'Maintenance worker',
    'Maintenance manager',
    'Graphic designer',
    'Marketing supervisor',
    'Export Supervisor',
    'Export manager',
    'Cost Manager',
    'Budget manager',
    'other',
  ];
  var jobValue = 'Production engineer';
  void jobChange(value) {
    jobValue = value;
    emit(ApplyYourJobDropDownChangeState());
  }

  // ############ Handling PDF File Set and View ############
  String? paths;
  File? file;
  Future pickedFile() async {
    FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    ).then((value) {
      paths = value!.names.last;
      file = File(value.files.single.path!);
      emit(ApplyYourJobDropDownChangeState());
    }).catchError((error) {});
  }

  // ####### Handling Upload CV PDF To Storage #######
  Future<void> uploadCvPDF({
    required String id,
  }) async {
    emit(UploadCVPDfLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('CV/$id/${Uri.file(file!.path).pathSegments.last}')
        .putFile(file!)
        .then((value) async {
      await setCvPDF(id: id, urlCV: await value.ref.getDownloadURL());
      emit(UploadCVPDfSuccessState());
    }).catchError((error) {
      emit(UploadCVPDfErrorState(error.toString()));
    });
  }

  // ####### Handling Set Image To Fire store #######
  Future<void> setCvPDF({
    required String id,
    required String urlCV,
  }) async {
    emit(SetCVPDfLoadingState());
    await FirebaseFirestore.instance.collection('Jobs').doc(id).set(
      {'cv': urlCV},
      SetOptions(merge: true),
    ).then((value) {
      emit(SetCVPDfSuccessState());
    }).catchError((error) {
      emit(SetCVPDfErrorState(error.toString()));
    });
  }

  void clearFileSelect() {
    file = null;
    emit(ClearFileSelectChangeState());
  }

  var enquirySelectType = [
    'Suggestion',
    'Complaint',
  ];
  var enquiryTypeValue = 'Suggestion';
  void enquiryTypeChangeChange(value) {
    enquiryTypeValue = value;
    emit(EnquirySelectTypeChangeState());
  }

// ############ Handling Customer Gender ############
  var selectGender = '';
  void changeRadioButton(value) {
    selectGender = value;
    emit(CustomerChangeRadioButton());
  }

// ####### Handling Picked Image To Storage #######
  File? profileImage;
  var imageSource = ImageSource.gallery;
  Future pickedImage(imageSource) async {
    emit(PickedProfileImageLoadingState());
    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickedProfileImageSuccessState());
    } else {
      // ignore: avoid_print
      print('no image select');
      emit(PickedProfileImageErrorState());
    }
  }

  // ####### Handling Upload Image To Storage #######
  String profileImageUrl = '';
  Future<void> uploadProfileImage(id) async {
    emit(UploadProfileImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'Customers/$id/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      profileImageUrl = await value.ref.getDownloadURL();
      emit(UploadProfileImageSuccessState());
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  // ####### Handling Contact Us #######
  Future<void> openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // ####### Handling Open Whats App #######
  openWhatsApp(String number) async {
    var android = Uri.parse('whatsapp://send?phone=$number?&text=hello');
    var ios = Uri.parse("https://wa.me/$number?text=${Uri.parse("hello")}");
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(ios)) {
        await launchUrl(ios);
      } else {}
    } else {
      // android , web
      if (await canLaunchUrl(android)) {
        await launchUrl(android);
      } else {}
    }
  }

  // ####### Handling Set Image To Fire store #######
  Future<void> setProfileImage({
    required String id,
    required String urlImage,
  }) async {
    emit(SetProfileImageLoadingState());
    await FirebaseFirestore.instance
        .collection('Customers')
        .doc(id)
        .set({'image': urlImage}, SetOptions(merge: true)).then((value) {
      emit(SetProfileImageSuccessState());
    }).catchError((error) {
      emit(SetProfileImageErrorState(error.toString()));
    });
  }

  // ####### Handling Delete Image From Storage #######
  Future<void> deleteProfileImageFromStorage(String url) async {
    // emit(UploadProfileImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(url)
        .delete()
        .then((value) async {
      // emit(UploadProfileImageSuccessState());
    }).catchError((error) {
      // emit(UploadProfileImageErrorState());
    });
  }

  void changeCloseImage() {
    profileImage = null;
    emit(CloseImageChangeState());
  }

  void customerToken(String id) async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.getAPNSToken().then((token) async {
        await setCustomerToken(id: id, token: '$token');
      });
    } else {
      await FirebaseMessaging.instance.getToken().then((token) async {
        await setCustomerToken(id: id, token: '$token');
      });
    }
  }

  // ####### Handling delete Customer  #######
  Future<void> deleteCustomer(String id) async {
    emit(DeleteCustomerLoadingState());
    FirebaseFirestore.instance
        .collection('Customers')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteCustomerSuccessState());
    }).catchError((error) {
      emit(DeleteCustomerErrorState(error.toString()));
    });
  }

  // ========= Handling Delete Profile Image From Storage =========
  Future<void> deleteProfileImage(String url) async {
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(url)
        .delete()
        .then((value) {})
        .catchError((error) {});
  }

}
