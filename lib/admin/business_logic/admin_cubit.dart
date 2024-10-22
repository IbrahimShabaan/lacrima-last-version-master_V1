import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/admin/business_logic/admin_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lacrima/admin/data/models/announcement/announcement_model.dart';
import 'package:lacrima/admin/presentation/screens/orders/admin_orders_screen.dart';
import 'package:lacrima/admin/presentation/screens/products/admin_products_screen.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_employee_screen.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  // ################# Handling Add Announcement Employee #################

  Future insertAnnouncement({
    required String id,
    required String title,
    required String description,
    required String dateTime,
  }) async {
    AnnouncementModel announcementModel = AnnouncementModel(
      id: id,
      title: title,
      image: announcementImageUrl,
      date: dateTime,
      description: description,
      createdAt: Timestamp.fromDate(DateTime.now()),
    );
    await uploadAnnouncementImage(id);
    emit(InsertAnnouncementLoadingState());
    FirebaseFirestore.instance
        .collection('Announcements')
        .doc(id)
        .set(announcementModel.toJson())
        .then((value) async {
      await setAnnouncementImage(id: id, urlImage: announcementImageUrl);
      emit(InsertAnnouncementSuccessState());
    }).catchError((error) {
      emit(InsertAnnouncementErrorState(error.toString()));
    });
  }

  // ############ Handling Picked Image Employee ############
  File? announcementImage;
  Future pickedImageAnnouncement(ImageSource imageSource) async {
    emit(PickedAnnouncementImageLoadingState());
    final pickedFile = await ImagePicker().pickImage(
        source: imageSource, preferredCameraDevice: CameraDevice.front);
    if (pickedFile != null) {
      announcementImage = File(pickedFile.path);
      emit(PickedAnnouncementImageSuccessState());
    } else {
      emit(PickedAnnouncementImageErrorState());
    }
  }

  // ####### Handling Upload Announcement Image To Storage #######
  String announcementImageUrl = '';
  Future<void> uploadAnnouncementImage(id) async {
    emit(UploadAnnouncementImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'Announcements/$id/${Uri.file(announcementImage!.path).pathSegments.last}')
        .putFile(announcementImage!)
        .then((value) async {
      announcementImageUrl = await value.ref.getDownloadURL();
      emit(UploadAnnouncementImageSuccessState());
    }).catchError((error) {
      emit(UploadAnnouncementImageErrorState(error.toString()));
    });
  }

  // ####### Handling Delete Announcement #######
  Future<void> deleteAnnouncement(String id) async {
    emit(DeleteAnnouncementLoadingState());
    FirebaseFirestore.instance
        .collection('Announcements')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteAnnouncementSuccessState());
    }).catchError((error) {
      emit(DeleteAnnouncementErrorState(error.toString()));
    });
  }

  // ####### Handling Delete Announcement Image From Storage #######
  Future<void> deleteAnnouncementImage(String url) async {
    emit(DeleteAnnouncementImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(url)
        .delete()
        .then((value) {
      emit(DeleteAnnouncementImageSuccessState());
    }).catchError((error) {
      emit(DeleteAnnouncementImageErrorState(error.toString()));
    });
  }

  // ####### Handling Set Announcement Image To Firestore #######
  Future<void> setAnnouncementImage({
    required String id,
    required String urlImage,
  }) async {
    emit(SetAnnouncementImageLoadingState());
    await FirebaseFirestore.instance
        .collection('Announcements')
        .doc(id)
        .set({'image': urlImage}, SetOptions(merge: true)).then((value) {
      emit(SetAnnouncementImageSuccessState());
    }).catchError((error) {
      emit(SetAnnouncementImageErrorState(error.toString()));
    });
  }

  // ####### Handling Delete Complaints Or Suggestions #######
  Future<void> deleteComplaintsOrSuggestions({
    required String id,
    required String docName,
  }) async {
    emit(DeleteComplaintsOrSuggestionsSuccessState());
    FirebaseFirestore.instance
        .collection('Complaints And Suggestions')
        .doc(docName)
        .collection('Complaints And Suggestions')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteComplaintsOrSuggestionsSuccessState());
    }).catchError((error) {
      emit(DeleteComplaintsOrSuggestionsErrorState(error.toString()));
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

  void changeCloseImage() {
    announcementImage = null;
    emit(AdminCloseImageChangeState());
  }

  // ################# Handling Bottom Nav Employee #################
  int currentIndex = 0;
  List<BottomNavigationBarItem> employeeBottomNavItems = [
    const BottomNavigationBarItem(
      label: 'Employees',
      icon: Icon(Icons.people_alt),
    ),
    const BottomNavigationBarItem(
      label: 'Products',
      icon: Icon(Icons.content_paste_sharp),
    ),
    const BottomNavigationBarItem(
      label: 'Orders',
      icon: Icon(Icons.shopping_cart_checkout),
    ),
  ];

  List<Widget> screens = [
    const AdminEmployeeScreen(),
    const ProductsScreen(),
    const AdminOrdersScreen(),
  ];
  void adminChangeBottomNavBar(int index) {
    currentIndex = index;
    emit(AdminBottomNavChangeState());
  }

// ############ Handling Employee Gender ############
  var selectGender = '';
  void changeRadioButton(value) {
    selectGender = value;
    emit(EmployeeChangeRadioButton());
  }
  // ######################################################################

  // ####### Handling Contact Us #######
  Future<void> openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
