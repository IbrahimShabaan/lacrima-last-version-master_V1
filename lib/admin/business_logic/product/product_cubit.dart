import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/admin/data/models/product/product_model.dart';
import 'package:lacrima/admin/business_logic/product/product_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;
  Future<void> insertProduct({
    required String prodId,
    required String prodTitle,
    required String prodSize,
    required String prodDescription,
    required String prodFlavor,
    // Nutrition Variable...............
    required double servingPer,
    required String servingSize,
    required double calories,
    required String totalFatG,
    required double totalFatPercent,
    required String saturatedFatG,
    required double saturatedFatPercent,
    required String transFatG,
    required double transFatPercent,
    required String cholesterolG,
    required double cholesterolPercent,
    required String sodiumG,
    required double sodiumPercent,
    required String carbohydrateG,
    required double carbohydratePercent,
    required String dietaryFiberG,
    required double dietaryFiberPercent,
    required String sugarsG,
    required double sugarsPercent,
    required String includesG,
    required double includesPercent,
    required String proteinG,
    required double proteinPercent,
    required String vitaminG,
    required double vitaminPercent,
    required String calciumG,
    required double calciumPercent,
    required String ironG,
    required double ironPercent,
    required String potassiumG,
    required double potassiumPercent,
    required String ingredient,
  }) async {
    isLoading = true;
    emit(InsertProductLoadingState());
    await uploadProductImage(prodId);
    ProductModel productModel = ProductModel(
      prodId: prodId,
      prodImage: productImageUrl,
      prodTitle: prodTitle,
      prodSize: prodSize,
      prodDescription: prodDescription,
      prodFlavor: prodFlavor,
      prodNationality: productNationalityValue,
      nutrition: {
        'servingPer': servingPer,
        'servingSize': servingSize,
        'calories': calories,
        'totalFatG': totalFatG,
        'totalFatPercent': totalFatPercent,
        'saturatedFatG': saturatedFatG,
        'saturatedFatPercent': saturatedFatPercent,
        'transFatG': transFatG,
        'transFatPercent': transFatPercent,
        'cholesterolG': cholesterolG,
        'cholesterolPercent': cholesterolPercent,
        'sodiumG': sodiumG,
        'sodiumPercent': sodiumPercent,
        'carbohydrateG': carbohydrateG,
        'carbohydratePercent': carbohydratePercent,
        'dietaryFiberG': dietaryFiberG,
        'dietaryFiberPercent': dietaryFiberPercent,
        'sugarsG': sugarsG,
        'sugarsPercent': sugarsPercent,
        'includesG': includesG,
        'includesPercent': includesPercent,
        'proteinG': proteinG,
        'proteinPercent': proteinPercent,
        'vitaminG': vitaminG,
        'vitaminPercent': vitaminPercent,
        'calciumG': calciumG,
        'calciumPercent': calciumPercent,
        'ironG': ironG,
        'ironPercent': ironPercent,
        'potassiumG': potassiumG,
        'potassiumPercent': potassiumPercent,
        'ingredient': ingredient,
      },
    );
    FirebaseFirestore.instance
        .collection('Products')
        .doc(prodId)
        .set(productModel.toJson())
        .then((value) async {
      if (productImageUrl.isNotEmpty) {
        await setProductImage(
          productId: prodId,
          productImageUrl: productImageUrl,
        );
      }
      emit(InsertProductSuccessState());
      isLoading = false;
    }).catchError((error) {
      emit(InsertProductErrorState(error.toString()));
    });
  }

  Future<void> updateProduct({
    required String prodId,
    required String prodTitle,
    required String prodSize,
    required String prodDescription,
    required String prodFlavor,
    // Nutrition Variable...............
    required String servingPer,
    required String servingSize,
    required String calories,
    required String totalFatG,
    required String totalFatPercent,
    required String saturatedFatG,
    required String saturatedFatPercent,
    required String transFatG,
    required String transFatPercent,
    required String cholesterolG,
    required String cholesterolPercent,
    required String sodiumG,
    required String sodiumPercent,
    required String carbohydrateG,
    required String carbohydratePercent,
    required String dietaryFiberG,
    required String dietaryFiberPercent,
    required String sugarsG,
    required String sugarsPercent,
    required String includesG,
    required String includesPercent,
    required String proteinG,
    required String proteinPercent,
    required String vitaminG,
    required String vitaminPercent,
    required String calciumG,
    required String calciumPercent,
    required String ironG,
    required String ironPercent,
    required String potassiumG,
    required String potassiumPercent,
    required String ingredient,
  }) async {
    isLoading = true;
    emit(UpdateProductLoadingState());
    if (productImage != null) {
      await uploadProductImage(prodId);
    }
    FirebaseFirestore.instance.collection('Products').doc(prodId).set({
      'prodId': prodId,
      'prodTitle': prodTitle,
      'prodSize': prodSize,
      'prodDescription': prodDescription,
      'prodFlavor': prodFlavor,
      'nutrition': {
        'servingPer': servingPer,
        'servingSize': servingSize,
        'calories': calories,
        'totalFatG': totalFatG,
        'totalFatPercent': totalFatPercent,
        'saturatedFatG': saturatedFatG,
        'saturatedFatPercent': saturatedFatPercent,
        'transFatG': transFatG,
        'transFatPercent': transFatPercent,
        'cholesterolG': cholesterolG,
        'cholesterolPercent': cholesterolPercent,
        'sodiumG': sodiumG,
        'sodiumPercent': sodiumPercent,
        'carbohydrateG': carbohydrateG,
        'carbohydratePercent': carbohydratePercent,
        'dietaryFiberG': dietaryFiberG,
        'dietaryFiberPercent': dietaryFiberPercent,
        'sugarsG': sugarsG,
        'sugarsPercent': sugarsPercent,
        'includesG': includesG,
        'includesPercent': includesPercent,
        'proteinG': proteinG,
        'proteinPercent': proteinPercent,
        'vitaminG': vitaminG,
        'vitaminPercent': vitaminPercent,
        'calciumG': calciumG,
        'calciumPercent': calciumPercent,
        'ironG': ironG,
        'ironPercent': ironPercent,
        'potassiumG': potassiumG,
        'potassiumPercent': potassiumPercent,
        'ingredient': ingredient,
      },
    }, SetOptions(merge: true)).then((value) async {
      if (productImageUrl.isNotEmpty) {
        await setProductImage(
          productId: prodId,
          productImageUrl: productImageUrl,
        );
      }
      emit(UpdateProductSuccessState());
      isLoading = false;
    }).catchError((error) {
      emit(UpdateProductErrorState(error.toString()));
    });
  }

  Future<void> deleteProduct({
    required String productId,
  }) async {
    emit(DeleteProductLoadingState());
    FirebaseFirestore.instance
        .collection('Products')
        .doc(productId)
        .delete()
        .then((value) {
      emit(DeleteProductSuccessState());
    }).catchError((error) {
      emit(DeleteProductErrorState(error.toString()));
    });
  }

  // ############ Handling Picked Image Employee ############
  File? productImage;
  var imageSource = ImageSource.gallery;
  Future pickedImage(imageSource) async {
    emit(PickedProductImageLoadingState());
    final pickedFile = await ImagePicker().pickImage(
        source: imageSource, preferredCameraDevice: CameraDevice.front);
    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      emit(PickedProductImageSuccessState());
    } else {
      // ignore: avoid_print
      print('no image select');
      emit(PickedProductImageErrorState());
    }
  }

  // ####### Handling Upload Image To Storage #######
  String productImageUrl = '';
  Future<void> uploadProductImage(productId) async {
    emit(UploadProductImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'Products/$productId/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!)
        .then((value) async {
      productImageUrl = await value.ref.getDownloadURL();
      emit(UploadProductImageSuccessState());
    }).catchError((error) {
      emit(UploadProductImageErrorState(error.toString()));
    });
  }

  // ####### Handling Delete ProductImage Image From Storage #######
  Future<void> deleteProductImageFromStorage(String url) async {
    // emit(UploadAnnouncementImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(url)
        .delete()
        .then((value) {
      // emit(UploadAnnouncementImageSuccessState());
    }).catchError((error) {
      // emit(UploadAnnouncementImageErrorState(error.toString()));
    });
  }

  // ####### Handling Set Image To Fire store #######
  Future<void> setProductImage({
    required String productId,
    required String productImageUrl,
  }) async {
    emit(SetProductImageLoadingState());
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(productId)
        .update({'prodImage': productImageUrl}).then((value) {
      emit(SetProductImageSuccessState());
    }).catchError((error) {
      emit(SetProductImageErrorState(error.toString()));
    });
  }

  void changeCloseImage() {
    productImage = null;
    emit(CloseImageChangeState());
  }

  // ############ Handling Request Leave Type ############
  var productNationality = [
    'Jordanian',
    'Bulgarian',
  ];
  var productNationalityValue = 'Jordanian';
  void productNationalityChange(value) {
    productNationalityValue = value;
    emit(NationalityProductsState());
  }
}
