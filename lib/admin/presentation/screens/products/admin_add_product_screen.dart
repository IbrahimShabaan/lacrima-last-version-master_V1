import 'package:sizer/sizer.dart';
import 'package:min_id/min_id.dart';
import 'package:flutter/material.dart';
import 'admin_add_nutrition_screen.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/admin/business_logic/product/product_cubit.dart';
import 'package:lacrima/admin/business_logic/product/product_states.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);

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
  final ingredientsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {
        if (state is InsertProductSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppItems.customText(
                'Successfully',
                fontSize: 12.sp,
              ),
            ),
          );
          Navigator.pop(context);
          cubit.changeCloseImage();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Product'),
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
                  AppItems.customAppLogo(),
                  SizedBox(height: 30.sp),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppItems.customTextField(
                          hintText: 'Title',
                          keyboardType: TextInputType.name,
                          controller: productTitleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Size',
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
                          hintText: 'Flavor',
                          keyboardType: TextInputType.name,
                          controller: productFlavorController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Select Nationality:',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: AppButtons.customDropDownButtonFormField(
                                items: cubit.productNationality,
                                hintText: 'Select',
                                validator: (value) {
                                  if (value == null) {
                                    return 'Field is require';
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    cubit.productNationalityChange(value),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Description',
                          keyboardType: TextInputType.emailAddress,
                          controller: productDescriptionController,
                          maxLines: 6,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        if (cubit.productImage != null)
                          Stack(
                            children: [
                              Image.file(
                                cubit.productImage!,
                                fit: BoxFit.fitWidth,
                              ),
                              Positioned(
                                right: 1,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => cubit.changeCloseImage(),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 10.sp),
                        if (cubit.productImage == null)
                          ElevatedButton.icon(
                            icon: const Icon(Icons.image),
                            label: AppItems.customText('Select Image'),
                            style: TextButton.styleFrom(
                              backgroundColor: ConstColors.kPrimaryColor,
                            ),
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: SizedBox(
                                    height: 80.sp,
                                    width: 60.sp,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton.icon(
                                          label: Text(
                                            'Camera',
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                          icon: const Icon(Icons.camera_alt),
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
                                          icon: const Icon(Icons.camera),
                                          style: TextButton.styleFrom(
                                            foregroundColor: ConstColors.kPrimaryColor,
                                          ),
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
                              );
                            },
                          ),
                        SizedBox(height: 10.sp),
                        ExpandableNotifier(
                          child: ExpandablePanel(
                            collapsed: const Text(''),
                            theme: ExpandableThemeData(
                              iconColor: ConstColors.kPrimaryColor,
                              iconSize: 22.sp,
                              animationDuration:
                                  const Duration(milliseconds: 500),
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
                            expanded: AdminAddNutritionScreen(
                              formKey: formKey,
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
                              ingredientController: ingredientsController,
                            ),
                          ),
                        ),
                        SizedBox(height: 25.sp),
                        BuildCondition(
                          // condition: state is! InsertProductLoadingState,
                          condition: cubit.isLoading == false,
                          fallback: (context) => AppItems.customIndicator(),
                          builder: (context) => AppButtons.customElevatedButton(
                            text: 'Submit',
                            color: ConstColors.kPrimaryColor,
                            onPressed: () async {
                              final id = MinId.getId();
                              if (formKey.currentState!.validate()) {
                                if (cubit.productImage != null) {
                                  await cubit.insertProduct(
                                    prodId: id,
                                    prodTitle: productTitleController.text,
                                    prodSize: productSizeController.text,
                                    prodDescription:
                                        productDescriptionController.text,
                                    prodFlavor: productFlavorController.text,
                                    ////// Nutrition Data ........ //////
                                    servingPer:
                                        double.parse(servingPerController.text),
                                    servingSize: servingSizeController.text,
                                    calories:
                                        double.parse(caloriesController.text),
                                    totalFatG: totalFatGController.text,
                                    totalFatPercent: double.parse(
                                        totalFatPercentController.text),
                                    saturatedFatG: saturatedFatGController.text,
                                    saturatedFatPercent: double.parse(
                                        saturatedFatPercentController.text),
                                    transFatG: transFatGController.text,
                                    transFatPercent: double.parse(
                                        transFatPercentController.text),
                                    cholesterolG: cholesterolGController.text,
                                    cholesterolPercent: double.parse(
                                        cholesterolPercentController.text),
                                    sodiumG: sodiumGController.text,
                                    sodiumPercent: double.parse(
                                        sodiumPercentController.text),
                                    carbohydrateG: carbohydrateGController.text,
                                    carbohydratePercent: double.parse(
                                        carbohydratePercentController.text),
                                    dietaryFiberG: dietaryFiberGController.text,
                                    dietaryFiberPercent: double.parse(
                                        dietaryFiberPercentController.text),
                                    sugarsG: sugarsGController.text,
                                    sugarsPercent: double.parse(
                                        sugarsPercentController.text),
                                    includesG: includesGController.text,
                                    includesPercent: double.parse(
                                        includesPercentController.text),
                                    proteinG: proteinGController.text,
                                    proteinPercent: double.parse(
                                        proteinPercentController.text),
                                    vitaminG: vitaminDGController.text,
                                    vitaminPercent: double.parse(
                                        vitaminDPercentController.text),
                                    calciumG: calciumGController.text,
                                    calciumPercent: double.parse(
                                        calciumPercentController.text),
                                    ironG: ironGController.text,
                                    ironPercent: double.parse(
                                        ironPercentController.text),
                                    potassiumG: potassiumGController.text,
                                    potassiumPercent: double.parse(
                                        potassiumPercentController.text),
                                    ingredient: ingredientsController.text,
                                  );
                                } else {
                                  return ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('must be upload image'),
                                  ));
                                }
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
