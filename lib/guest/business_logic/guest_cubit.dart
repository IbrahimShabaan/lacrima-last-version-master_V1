import 'dart:io';
import 'package:intl/intl.dart';
import 'package:min_id/min_id.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/guest/data/models/job_model.dart';
import 'package:lacrima/guest/data/models/feedback_model.dart';
import 'package:lacrima/guest/business_logic/guest_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lacrima/guest/presentation/screens/profile/guest_profile.dart';
import 'package:lacrima/guest/presentation/screens/home/guest_home_screen.dart';
import 'package:lacrima/guest/presentation/screens/catalogue/guest_catalogue.dart';

class GuestCubit extends Cubit<GuestStates> {
  GuestCubit() : super(GuestInitialState());

  static GuestCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    const BottomNavigationBarItem(
      label: 'Catalogue',
      icon: Icon(Icons.collections_bookmark_sharp),
    ),
    const BottomNavigationBarItem(
      label: 'Account',
      icon: Icon(Icons.person_sharp),
    ),
  ];

  List<Widget> screens = [
    const GuestHomeScreen(),
    const GuestCatalogue(),
    const GuestProfile(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(BottomNavChangeState());
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
    required String name,
  }) async {
    emit(UploadCVPDfLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('CV/$name/${Uri.file(file!.path).pathSegments.last}')
        .putFile(file!)
        .then((value) async {
      await setCvPDF(name: name, urlCV: await value.ref.getDownloadURL());
      emit(UploadCVPDfSuccessState());
    }).catchError((error) {
      emit(UploadCVPDfErrorState(error.toString()));
    });
  }

  // ####### Handling Set Image To Fire store #######
  Future<void> setCvPDF({
    required String name,
    required String urlCV,
  }) async {
    emit(SetCVPDfLoadingState());
    await FirebaseFirestore.instance.collection('Jobs').doc(name).set(
      {'cv': urlCV},
      SetOptions(merge: true),
    ).then((value) {
      emit(SetCVPDfSuccessState());
    }).catchError((error) {
      emit(SetCVPDfErrorState(error.toString()));
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
      await uploadCvPDF(name: id);
    }).catchError((error) {
      emit(InsertJobErrorState(error.toString()));
    });
  }

  // ####### Handling Insert Feedback To Fire store #######
  Future<void> insertFeedback({
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

  void clearFileSelect() {
    file = null;
    emit(ClearFileSelectChangeState());
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

  // ####### Handling Delete Announcement Image From Storage #######
  Future<void> deletePDFFromStorage(String url) async {
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(url)
        .delete()
        .then((value) {})
        .catchError((error) {});
  }
}
