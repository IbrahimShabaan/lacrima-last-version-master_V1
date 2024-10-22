import 'dart:io';
import 'employee_states.dart';
import 'package:intl/intl.dart';
import 'package:min_id/min_id.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/local/cache_helper.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lacrima/employee/data/models/employee_model.dart';
import 'package:lacrima/employee/data/models/financial_sheet_model.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lacrima/customer/data/models/complaints_and_suggestion.dart';
import 'package:lacrima/HR/presentation/screens/layout/hr_layout_screen.dart';
import 'package:lacrima/employee/presentation/screens/profile/emp_profile.dart';
import 'package:lacrima/sales/presentation/screens/layout/sales_layout_screen.dart';
import 'package:lacrima/admin/presentation/screens/layout/admin_layout_screen.dart';
import 'package:lacrima/employee/presentation/screens/layout/emp_layout_screen.dart';
import 'package:lacrima/employee/presentation/screens/financial/emp_financial_screen.dart';
import 'package:lacrima/employee/presentation/screens/announcement/emp_announcement_screen.dart';

class EmployeeCubit extends Cubit<EmployeeStates> {
  EmployeeCubit() : super(EmployeeInitialState());

  static EmployeeCubit get(context) => BlocProvider.of(context);

  EmployeeModel? employeeModel;
  // ===================== Insert Employee =====================
  Future<void> insertEmployee({
    required String id,
    required String email,
    required String phone,
    required String address,
    required String lastName,
    required String position,
    required String birthday,
    required String userName,
    required String password,
    required String education,
    required String firstName,
    required String hiringDate,
    required String department,
    required double totalVacations,
    required double lastYearVacations,
  }) async {
    EmployeeModel employeeModel = EmployeeModel(
      empId: id,
      empToken: '',
      email: email,
      phone: phone,
      address: address,
      position: position,
      lastName: lastName,
      birthday: birthday,
      userName: userName,
      password: password,
      usedVacations: 0.0,
      education: education,
      firstName: firstName,
      gender: selectGender,
      section: sectionValue,
      image: profileImageUrl,
      hiringDate: hiringDate,
      department: department,
      createdAt: Timestamp.fromDate(DateTime.now()),
      totalVacations: totalVacations,
      lastYearVacations: lastYearVacations,
    );
    await uploadProfileImage(id);
    emit(InsertEmployeeLoadingState());
    FirebaseFirestore.instance
        .collection('Employees')
        .doc(id)
        .set(employeeModel.toJson())
        .then((value) async {
      await setProfileImage(empId: id, urlImage: profileImageUrl);
      await insertSalariesEmployee(year: DateTime.now().year, empId: id);
      emit(InsertEmployeeSuccessState());
    }).catchError((error) {
      emit(InsertEmployeeErrorState(error.toString()));
    });
  }

  // ==================== Get EmployeeBy ID ====================
  Future<void> getEmployeeData(String id) async {
    emit(GetEmployeeLoadingState());
    await FirebaseFirestore.instance
        .collection('Employees')
        .doc(id)
        .get()
        .then((value) {
      employeeModel = EmployeeModel.fromJson(value.data()!);
      emit(GetEmployeeSuccessState());
    }).catchError((error) {
      emit(GetEmployeeErrorState(error.toString()));
    });
  }

  // ===================== Update Employee =====================
  Future<void> updateEmployee({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String address,
    required String education,
    required String hiringDate,
    required String position,
    required String birthday,
    required String phone,
    required String userName,
    required String department,
    required String password,
  }) async {
    emit(UpdateEmployeeLoadingState());
    if (profileImage != null) {
      await uploadProfileImage(id);
    }
    FirebaseFirestore.instance.collection('Employees').doc(id).set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'education': education,
      'hiringDate': hiringDate,
      'position': position,
      'birthday': birthday,
      'section': sectionValue,
      'gender': selectGender,
      'userName': userName,
      'department': department,
      'password': password,
    }, SetOptions(merge: true)).then((value) async {
      if (profileImageUrl.isNotEmpty) {
        await setProfileImage(empId: id, urlImage: profileImageUrl);
      }
      emit(UpdateEmployeeSuccessState());
    }).catchError((error) {
      emit(UpdateEmployeeErrorState(error.toString()));
    });
  }

  // ===================== Update Employee =====================
  Future<void> setEmployeeToken({
    required String empId,
    required String token,
  }) async {
    emit(SetEmployeeTokenLoadingState());
    await FirebaseFirestore.instance.collection('Employees').doc(empId).set({
      'empToken': token,
    }, SetOptions(merge: true)).then((value) async {
      emit(SetEmployeeTokenSuccessState());
    }).catchError((error) {
      emit(SetEmployeeTokenErrorState(error.toString()));
    });
  }

  void employeeToken(String id) async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.getAPNSToken().then((token) async {
        await setEmployeeToken(empId: id, token: '$token');
      });
    } else {
      await FirebaseMessaging.instance.getToken().then((token) async {
        await setEmployeeToken(empId: id, token: '$token');
      });
    }
  }

  // ================= Update Vacation Employee ================
  Future<void> updateTotalVacationsEveryYear({
    required String empId,
    required double totalVacations,
    required double lastYearVacations,
  }) async {
    emit(UpdateVacationEveryYearLoadingState());
    await FirebaseFirestore.instance.collection('Employees').doc(empId).set({
      'usedVacations': 0.0,
      'totalVacations': totalVacations,
      'lastYearVacations': lastYearVacations,
    }, SetOptions(merge: true)).then((value) {
      emit(UpdateVacationEveryYearSuccessState());
    }).catchError((error) {
      emit(UpdateVacationEveryYearErrorState(error.toString()));
    });
  }

  // ===================== Delete Employee =====================
  Future<void> deleteEmployee(id) async {
    emit(DeleteEmployeeLoadingState());
    FirebaseFirestore.instance
        .collection('Employees')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteEmployeeSuccessState());
    }).catchError((error) {});
  }

  // =============== Handling Bottom Nav Employee ===============
  int currentIndex = 0;
  List<BottomNavigationBarItem> employeeBottomNavItems = [
    const BottomNavigationBarItem(
      label: 'Announcement',
      icon: Icon(Icons.campaign_rounded),
    ),
    const BottomNavigationBarItem(
      label: 'Financial',
      icon: Icon(Icons.article_rounded),
    ),
    const BottomNavigationBarItem(
      label: 'Account',
      icon: Icon(Icons.person_sharp),
    ),
  ];

  List<Widget> screens = [
    const AnnouncementScreen(),
    FinancialSheetScreen(),
    const EmployeeProfile(),
  ];
  void employeeChangeBottomNavBar(int index) {
    currentIndex = index;
    emit(EmployeeBottomNavChangeState());
  }
  // ============================================================

  // ================= Handling Employee Section ================
  var section = [
    'HR',
    'Sales',
    'Normal',
  ];
  var sectionValue = 'Normal';
  void sectionChange(value) {
    sectionValue = value;
    emit(EmployeeDropDownChangeState());
  }

// ================== Handling Employee Gender ==================
  var selectGender = '';
  void changeRadioButton(value) {
    selectGender = value;
    emit(EmployeeChangeRadioButton());
  }

  // =========== Handling Insert Salary Employee Sheet ===========
  Future<void> insertSalariesEmployee({
    required int year,
    required String empId,
  }) async {
    emit(InsertSalaryEmployeeLoadingState());
    FinancialSheetModel model = FinancialSheetModel(
      january: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      february: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      march: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      april: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      may: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      june: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      july: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      august: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      september: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      october: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      november: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
      december: {
        'tax': 0.0,
        'other': 0.0,
        'salary': 0.0,
      },
    );
    FirebaseFirestore.instance
        .collection('Salaries')
        .doc('$year')
        .collection('Employees')
        .doc(empId)
        .set(model.toJson(), SetOptions(merge: true))
        .then((value) {
      emit(InsertSalaryEmployeeSuccessState());
    }).catchError((error) {
      emit(InsertSalaryEmployeeErrorState(error.toString()));
    });
  }
  // =========== Handling Get Salary Employee Sheet ===========

  FinancialSheetModel? model;
  Future getSalaryEmployee({
    required int year,
    required String empId,
  }) async {
    emit(GetSalaryEmployeeLoadingState());
    await FirebaseFirestore.instance
        .collection('Salaries')
        .doc('$year')
        .collection('Employees')
        .doc(empId)
        .get()
        .then((value) {
      model = FinancialSheetModel.fromJson(value.data()!);
      emit(GetSalaryEmployeeSuccessState());
    }).catchError((error) {
      emit(GetSalaryEmployeeErrorState(error.toString()));
    });
  }

// =========== Handling Get Salary Employee Sheet ===========
  Future setSalaryEmployee({
    required int year,
    required String empId,
    required String tax,
    required String other,
    required String salary,
  }) async {
    emit(UpdateSalaryEmployeeLoadingState());
    await FirebaseFirestore.instance
        .collection('Salaries')
        .doc('$year')
        .collection('Employees')
        .doc(empId)
        .set({
      valueSelect: {
        'other': double.parse(other),
        'tax': double.parse(tax),
        'salary': double.parse(salary),
      }
    }, SetOptions(merge: true)).then((value) {
      emit(UpdateSalaryEmployeeSuccessState());
    }).catchError((error) {
      emit(UpdateSalaryEmployeeErrorState(error.toString()));
    });
  }

  // ===================== Delete Employee =====================
  Future<void> deleteEmployeeSalary(empId) async {
    emit(DeleteEmployeeSalaryLoadingState());
    await FirebaseFirestore.instance
        .collection('Salaries')
        .doc('${DateTime.now().year}')
        .collection('Employees')
        .doc(empId)
        .delete()
        .then((value) {
      emit(DeleteEmployeeSalarySuccessState());
    }).catchError((error) {
      emit(DeleteEmployeeSalaryErrorState(error.toString()));
    });
  }

  // ========= Handling Insert Complaints And Suggestion =========
  Future<void> insertComplaintsAndSuggestion({
    required String fullName,
    required String content,
    required String email,
  }) async {
    var id = MinId.getId();
    ComplaintsAndSuggestionModel model = ComplaintsAndSuggestionModel(
      id: id,
      type: enquiryTypeValue,
      fullName: fullName,
      content: content,
      email: email,
      createdAt: Timestamp.fromDate(DateTime.now()),
      date: DateFormat.yMMMd().format(DateTime.now()),
    );
    emit(InsertComplaintsAndSuggestionLoadingState());
    await FirebaseFirestore.instance
        .collection('Complaints And Suggestions')
        .doc('Employees')
        .collection('Complaints And Suggestions')
        .doc(id)
        .set(model.toJson())
        .then((value) {
      emit(InsertComplaintsAndSuggestionSuccessState());
    }).catchError((error) {
      emit(InsertComplaintsAndSuggestionErrorState(error.toString()));
    });
  }

  // =========== Handling Select Month Financial Sheet ===========
  var months = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december',
  ];
  var valueSelect = 'january';
  void selectMonthChange(value) {
    valueSelect = value;
    emit(SelectMonthFinancialSheetState());
  }

  // ============== Handling Picked Image Employee ==============
  File? profileImage;
  var imageSource = ImageSource.gallery;
  Future pickedImage(imageSource) async {
    emit(PickedProfileImageLoadingState());
    final pickedFile = await ImagePicker().pickImage(
        source: imageSource, preferredCameraDevice: CameraDevice.front);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickedProfileImageSuccessState());
    } else {
      // ignore: avoid_print
      print('no image select');
      emit(PickedProfileImageErrorState());
    }
  }

  // ============== Handling Upload Image To Storage ==============
  String profileImageUrl = '';
  Future<void> uploadProfileImage(empId) async {
    emit(UploadProfileImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'Employees/$empId/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      profileImageUrl = await value.ref.getDownloadURL();
      emit(UploadProfileImageSuccessState());
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  // ============== Handling Set Image To Fire store ==============
  Future<void> setProfileImage({
    required String empId,
    required String urlImage,
  }) async {
    emit(SetProfileImageLoadingState());
    await FirebaseFirestore.instance
        .collection('Employees')
        .doc(empId)
        .update({'image': urlImage}).then((value) {
      emit(SetProfileImageSuccessState());
    }).catchError((error) {
      emit(SetProfileImageErrorState(error.toString()));
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

  void changeCloseImage() {
    profileImage = null;
    emit(CloseImageChangeState());
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

  // =================== Handling Login Validate ===================

  Future<void> adminLogin(String empId) async {
    await NotificationServices.subscribeToTopic(ConstText.job);
    await NotificationServices.subscribeToTopic(ConstText.feedback);
    await NotificationServices.subscribeToTopic(ConstText.requests);
    await NotificationServices.subscribeToTopic(ConstText.cusCompAndSug);
    await NotificationServices.subscribeToTopic(ConstText.empCompAndSug);
    await CacheHelper.setListOfData('userData', id: empId, section: 'Admin');
  }

  Future<void> empLogin(String empId, String section) async {
    await getEmployeeData(empId);
    await getSalaryEmployee(year: DateTime.now().year, empId: empId);
    await CacheHelper.setListOfData('userData', id: empId, section: section);
  }

  Future<void> loginValidate({
    required String empId,
    required String password,
    required BuildContext context,
  }) async {
    emit(EmployeeSignInLoadingState());
    try {
      var firebase = FirebaseFirestore.instance;
      var admin = await firebase.collection('Admins').doc(empId).get();
      var employee = await firebase.collection('Employees').doc(empId).get();
      if (admin.exists) {
        if (admin.data()!.containsValue(password)) {
          if (admin.data()!.containsValue('124')) {
            adminLogin(empId);
            navigateAndFinish(context, const AdminLayoutScreen());
          } else if (admin.data()!.containsValue('126')) {
            adminLogin(empId);
            navigateAndFinish(context, const AdminLayoutScreen());
          } else if (admin.data()!.containsValue('179')) {
            adminLogin(empId);
            navigateAndFinish(context, const AdminLayoutScreen());
          }
        } else {
          AppItems.customSnackBar(context, msg: 'invalid password');
        }
      } else if (employee.exists) {
        if (employee.data()!.containsValue(password)) {
          if (employee.data()!.containsValue('HR')) {
            empLogin(empId, 'HR');
            navigateAndFinish(context, HRLayoutScreen(id: empId));
            NotificationServices.subscribeToTopic(ConstText.job);
            NotificationServices.subscribeToTopic(ConstText.requests);
            NotificationServices.subscribeToTopic(ConstText.empCompAndSug);
          } else if (employee.data()!.containsValue('Sales')) {
            empLogin(empId, 'Sales');
            navigateAndFinish(context, SalesLayoutScreen(id: empId));
            NotificationServices.subscribeToTopic(ConstText.announcements);
            await FirebaseMessaging.instance.getToken().then((token) {
              setEmployeeToken(empId: empId, token: '$token');
            });
          } else if (employee.data()!.containsValue('Normal')) {
            empLogin(empId, 'Normal');
            navigateAndFinish(context, EmployeeLayoutScreen(id: empId));
            NotificationServices.subscribeToTopic(ConstText.announcements);
            await FirebaseMessaging.instance.getToken().then((token) {
              setEmployeeToken(empId: empId, token: '$token');
            });
          }
        } else {
          AppItems.customSnackBar(context, msg: 'invalid password');
        }
      } else {
        AppItems.customSnackBar(context, msg: 'invalid Id');
      }
      emit(EmployeeSignInSuccessState(empId));
    } catch (error) {
      emit(EmployeeSignInErrorState(error.toString()));
    }
  }
}
