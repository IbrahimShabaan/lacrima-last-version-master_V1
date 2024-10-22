import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/HR/business_logic/hr_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lacrima/HR/presentation/screens/financial/hr_financial.dart';
import 'package:lacrima/HR/presentation/screens/profile/hr_profile_screen.dart';
import 'package:lacrima/HR/presentation/screens/employee/hr_employee_screen.dart';

class HRCubit extends Cubit<HRStates> {
  HRCubit() : super(HRInitialState());

  static HRCubit get(context) => BlocProvider.of(context);

  // ################# Handling Bottom Nav HR #################
  int hrCurrentIndex = 0;
  List<BottomNavigationBarItem> hrBottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Employees',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.article_rounded),
      label: 'Financial',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_sharp),
      label: 'Account',
    ),
  ];

  List<Widget> hrScreens = [
    const HREmployeeScreen(),
    HRFinancialSheet(),
    const HRProfile(),
  ];
  void hrChangeBottomNavBar(int index) {
    emit(HRBottomNavChangeState());
    hrCurrentIndex = index;
  }

  // ####### Handling Delete FeedBack #######
  Future<void> deleteFeedBack(String id) async {
    emit(DeleteFeedBackLoadingState());
    FirebaseFirestore.instance
        .collection('Feedback')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteFeedBackSuccessState());
    }).catchError((error) {
      emit(DeleteFeedBackErrorState(error.toString()));
    });
  }

  // ####### Handling Delete Job #######
  Future<void> deleteJob(String id) async {
    emit(DeleteJobLoadingState());
    FirebaseFirestore.instance
        .collection('Jobs')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteJobSuccessState());
    }).catchError((error) {
      emit(DeleteJobErrorState(error.toString()));
    });
  }

  // ####### Handling Delete PDF Job From Storage #######
  Future<void> deletePDFJob(String url) async {
    emit(DeletePDFJobLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(url)
        .delete()
        .then((value) {
      emit(DeletePDFJobSuccessState());
    }).catchError((error) {
      emit(DeletePDFJobErrorState(error.toString()));
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
}
