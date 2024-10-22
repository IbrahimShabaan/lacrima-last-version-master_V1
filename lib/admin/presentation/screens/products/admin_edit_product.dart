import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'admin_edit_nutrition_screen.dart';
import 'package:expandable/expandable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/admin/business_logic/product/product_cubit.dart';
import 'package:lacrima/admin/business_logic/product/product_states.dart';

class AdminEditProductScreen extends StatelessWidget {
  AdminEditProductScreen({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  final formKey = GlobalKey<FormState>();
  final productTitleController = TextEditingController();
  final productSizeController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productFlavorController = TextEditingController();

  /// Nutrition Controllers ........
  final servingPerController = TextEditingController();
  final servingSizeController = TextEditingController();
  final caloriesController = TextEditingController();
  final totalFatGController = TextEditingController();
  final totalFatPercentController = TextEditingController();
  final saturatedFatGController = TextEditingController();
  final saturatedFatPercentController = TextEditingController();
  final transFatGController = TextEditingController();
  final transFatPercentController = TextEditingController();
  final cholesterolGController = TextEditingController();
  final cholesterolPercentController = TextEditingController();
  final sodiumGController = TextEditingController();
  final sodiumPercentController = TextEditingController();
  final carbohydrateGController = TextEditingController();
  final carbohydratePercentController = TextEditingController();
  final dietaryFiberGController = TextEditingController();
  final dietaryFiberPercentController = TextEditingController();
  final sugarsGController = TextEditingController();
  final sugarsPercentController = TextEditingController();
  final includesGController = TextEditingController();
  final includesPercentController = TextEditingController();
  final proteinGController = TextEditingController();
  final proteinPercentController = TextEditingController();
  final vitaminDGController = TextEditingController();
  final vitaminDPercentController = TextEditingController();
  final calciumGController = TextEditingController();
  final calciumPercentController = TextEditingController();
  final ironGController = TextEditingController();
  final ironPercentController = TextEditingController();
  final potassiumGController = TextEditingController();
  final potassiumPercentController = TextEditingController();
  final ingredientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    productSizeController.text = '${data['prodSize']}';
    productTitleController.text = '${data['prodTitle']}';
    productFlavorController.text = '${data['prodFlavor']}';
    productDescriptionController.text = '${data['prodDescription']}';
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {
        if (state is UpdateProductSuccessState) {
          Navigator.pop(context);
          cubit.changeCloseImage();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Edit Product'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
              onPressed: () {
                cubit.changeCloseImage();
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: cubit.productImage == null
                                ? NetworkImage('${data['prodImage']}')
                                : FileImage(cubit.productImage!)
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          width: 35.sp,
                          height: 35.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.sp),
                            color: Colors.grey.shade300,
                          ),
                          child: IconButton(
                            alignment: Alignment.center,
                            icon: Icon(
                              Icons.camera_alt,
                              size: 18.sp,
                              color: ConstColors.kPrimaryColor,
                            ),
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: SizedBox(
                                    height: 80.sp,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton.icon(
                                            label: Text(
                                              'Camera',
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            icon: Icon(Icons.camera_alt,
                                                size: 18.sp),
                                            style: TextButton.styleFrom(
                                              foregroundColor: ConstColors.kPrimaryColor,
                                            ),
                                            onPressed: () {
                                              cubit.pickedImage(
                                                  ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton.icon(
                                            label: Text(
                                              'Gallery',
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            icon:
                                                Icon(Icons.camera, size: 18.sp),
                                            style: TextButton.styleFrom(
                                                foregroundColor: ConstColors.kPrimaryColor),
                                            onPressed: () {
                                              cubit.pickedImage(
                                                  ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30.sp),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Product Title',
                          controller: productTitleController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Product Flavor',
                          controller: productFlavorController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Product Size',
                          controller: productSizeController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Product Description',
                          controller: productDescriptionController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.sp),
                        ExpandableNotifier(
                          child: ExpandablePanel(
                            collapsed: const Text(''),
                            theme: ExpandableThemeData(
                              iconColor: ConstColors.kPrimaryColor,
                              iconSize: 22.sp,
                              animationDuration: const Duration(seconds: 1),
                            ),
                            header: Padding(
                              padding: EdgeInsets.symmetric(vertical: 9.sp),
                              child: Text(
                                'Nutrition Facts',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            expanded: AdminEditNutritionScreen(
                              servingPerController: servingPerController,
                              servingSizeController: servingSizeController,
                              caloriesController: caloriesController,
                              totalFatGController: totalFatGController,
                              totalFatPercentController:
                                  totalFatPercentController,
                              saturatedFatGController: saturatedFatGController,
                              saturatedFatPercentController:
                                  saturatedFatPercentController,
                              transFatGController: transFatGController,
                              transFatPercentController:
                                  transFatPercentController,
                              cholesterolGController: cholesterolGController,
                              cholesterolPercentController:
                                  cholesterolPercentController,
                              sodiumGController: sodiumGController,
                              sodiumPercentController: sodiumPercentController,
                              carbohydrateGController: carbohydrateGController,
                              carbohydratePercentController:
                                  carbohydratePercentController,
                              dietaryFiberGController: dietaryFiberGController,
                              dietaryFiberPercentController:
                                  dietaryFiberPercentController,
                              sugarsGController: sugarsGController,
                              sugarsPercentController: sugarsPercentController,
                              includesGController: includesGController,
                              includesPercentController:
                                  includesPercentController,
                              proteinGController: proteinGController,
                              proteinPercentController:
                                  proteinPercentController,
                              vitaminDGController: vitaminDGController,
                              vitaminDPercentController:
                                  vitaminDPercentController,
                              calciumGController: calciumGController,
                              calciumPercentController:
                                  calciumPercentController,
                              ironGController: ironGController,
                              ironPercentController: ironPercentController,
                              potassiumGController: potassiumGController,
                              potassiumPercentController:
                                  potassiumPercentController,
                              ingredientController: ingredientController,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.sp),
                        BuildCondition(
                          condition: cubit.isLoading == false,
                          fallback: (context) => AppItems.customIndicator(),
                          builder: (context) => AppButtons.customElevatedButton(
                            text: 'Submit',
                            fontSize: 13.sp,
                            color: ConstColors.kPrimaryColor,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.updateProduct(
                                  prodId: data['prodId'],
                                  prodTitle: productTitleController.text,
                                  prodSize: productSizeController.text,
                                  prodDescription:
                                      productDescriptionController.text,
                                  prodFlavor: productFlavorController.text,
                                  ////// Nutrition Data ........ //////
                                  servingPer: servingPerController.text,
                                  servingSize: servingSizeController.text,
                                  calories: caloriesController.text,
                                  totalFatG: totalFatGController.text,
                                  totalFatPercent:
                                      totalFatPercentController.text,
                                  saturatedFatG: saturatedFatGController.text,
                                  saturatedFatPercent:
                                      saturatedFatPercentController.text,
                                  transFatG: transFatGController.text,
                                  transFatPercent:
                                      transFatPercentController.text,
                                  cholesterolG: cholesterolGController.text,
                                  cholesterolPercent:
                                      cholesterolPercentController.text,
                                  sodiumG: sodiumGController.text,
                                  sodiumPercent: sodiumPercentController.text,
                                  carbohydrateG: carbohydrateGController.text,
                                  carbohydratePercent:
                                      carbohydratePercentController.text,
                                  dietaryFiberG: dietaryFiberGController.text,
                                  dietaryFiberPercent:
                                      dietaryFiberPercentController.text,
                                  sugarsG: sugarsGController.text,
                                  sugarsPercent: sugarsPercentController.text,
                                  includesG: includesGController.text,
                                  includesPercent:
                                      includesPercentController.text,
                                  proteinG: proteinGController.text,
                                  proteinPercent: proteinPercentController.text,
                                  vitaminG: vitaminDGController.text,
                                  vitaminPercent:
                                      vitaminDPercentController.text,
                                  calciumG: calciumGController.text,
                                  calciumPercent: calciumPercentController.text,
                                  ironG: ironGController.text,
                                  ironPercent: ironPercentController.text,
                                  potassiumG: potassiumGController.text,
                                  potassiumPercent:
                                      potassiumPercentController.text,
                                  ingredient: ingredientController.text,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20.sp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
