import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/sales/data/models/order_model.dart';
import 'package:lacrima/sales/business_logic/sales_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lacrima/sales/presentation/screens/profile/sales_profile.dart';
import 'package:lacrima/sales/presentation/screens/orders/sales_orders_screen.dart';
import 'package:lacrima/sales/presentation/screens/financial/sales_financial_screen.dart';

class SalesCubit extends Cubit<SalesStates> {
  SalesCubit() : super(SalesInitialState());

  static SalesCubit get(context) => BlocProvider.of(context);

  // ################# Handling Bottom Nav Employee #################
  int salesCurrentIndex = 0;
  List<BottomNavigationBarItem> salesBottomNavItems = [
    const BottomNavigationBarItem(
      label: 'Orders',
      icon: Icon(Icons.shopping_cart_checkout_outlined),
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

  List<Widget> salesScreens = [
    const SalesOrdersScreen(),
    SalesFinancialScreen(),
    const SalesProfile(),
  ];
  void salesChangeBottomNavBar(int index) {
    salesCurrentIndex = index;
    emit(SalesBottomNavChangeState());
  }
  // ######################################################################

  // ############ Handling Insert Orders ############
  Future insertOrder({
    required String id,
    required String price,
    required String shipment,
    required String issueDate,
    required String description,
    required String customerName,
    required String customerToken,
    required String receivingTime,
    required List<dynamic> product,
  }) async {
    emit(InsertOrderLoadingState());
    OrderModel orderModel = OrderModel(
      id: id,
      tracking: 0,
      price: price,
      shipment: shipment,
      issueDate: issueDate,
      product: [...product],
      description: description,
      customerName: customerName,
      customerToken: customerToken,
      receivingTime: receivingTime,
    );
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(id)
        .set(orderModel.toJson())
        .then((value) async {
      emit(InsertOrderSuccessState());
    }).catchError((error) {
      InsertOrderErrorState(error.toString());
    });
  }

  // ############ Handling Update Order Track ############
  Future updateOrderTrack({
    required String id,
    required int tracking,
  }) async {
    emit(UpdateTrackOrderLoadingState());
    FirebaseFirestore.instance.collection('Orders').doc(id).set(
      {'tracking': tracking},
      SetOptions(merge: true),
    ).then((value) {
      emit(UpdateTrackOrderSuccessState());
    }).catchError((error) {
      emit(UpdateTrackOrderErrorState(error.toString()));
    });
  }

  // ############ Handling Update Order ############
  Future updateOrder({
    required String id,
    required String price,
    required String shipment,
    required String issueDate,
    required String description,
    required String receivingTime,
  }) async {
    emit(UpdateOrderLoadingState());
    FirebaseFirestore.instance.collection('Orders').doc(id).set({
      'price': price,
      'description': description,
      'shipment': shipment,
      'issueDate': issueDate,
      'receivingTime': receivingTime,
    }, SetOptions(merge: true)).then((value) async {
      emit(UpdateOrderSuccessState());
    }).catchError((error) {
      emit(UpdateOrderErrorState(error.toString()));
    });
  }

  // ############ Handling Delete Order ############
  Future deleteOrder({
    required String id,
  }) async {
    emit(DeleteOrderLoadingState());
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteOrderSuccessState());
    }).catchError((error) {
      emit(DeleteOrderErrorState(error.toString()));
    });
  }

  // ####### Handling Delete Order Image From Storage #######
  Future<void> deleteOrderImageFromStorage(String url) async {
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(url)
        .delete()
        .then((value) {})
        .catchError((error) {});
  }

  // // ####### Handling Upload Image To Storage #######

  Future<String> uploadImage({
    required String orderId,
    required XFile image,
  }) async {
    emit(SalesUploadOrderImageLoadingState());
    var db = firebase_storage.FirebaseStorage.instance
        .ref('Orders/$orderId/${Uri.file(image.path.split("/").last)}');
    await db.putFile(File(image.path));
    emit(SalesUploadOrderImageSuccessState());
    return db.getDownloadURL();
  }

  // ############ Handling Change Currency ############
  var currencyItems = [
    'JD',
    '\$',
    '€',
  ];
  var currencyValue = 'JD';
  void currencyChange(value) {
    emit(SalesCurrencyChangeState());
    currencyValue = value;
  }

// ############ Handling Change Customer ID ############
  String customerNameValue = '';
  void selectCustomerName(value) {
    emit(CustomerIdChangeState());
    customerNameValue = value;
  }

  List<dynamic> products = [];
  Future<void> getAllProducts() async {
    await FirebaseFirestore.instance.collection('Products').get().then((event) {
      products = [];
      for (var element in event.docs) {
        products.add(element.data());
      }
    });
  }

  void checkBoxChange(int? index, bool? value, List<bool>? isChecked) {
    isChecked![index!] = value!;
    emit(CheckBoxChangeState());
  }

  // ####### Handling Set Image To Fire store #######
  Future<void> setOrderImage({
    required String orderId,
    required List<String> urlImage,
  }) async {
    emit(SalesSetOrderImageLoadingState());
    await FirebaseFirestore.instance.collection('Orders').doc(orderId).set({
      'orderImage': [...urlImage]
    }, SetOptions(merge: true)).then((value) {
      emit(SalesSetOrderImageSuccessState());
    }).catchError((error) {
      emit(SalesSetOrderImageErrorState(error.toString()));
    });
  }

  Future<String> getCustomerToken(String id) async {
    String token = '';
    await FirebaseFirestore.instance
        .collection('Customers')
        .where('id', isEqualTo: id)
        .get()
        .then((value) {
      for (var element in value.docs) {
        token = element.data()['token'];
      }
    });
    return token;
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

  // ####### Handling Delete FeedBack #######
  Future<void> deleteFeedBack({
    required String id,
  }) async {
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
}
