import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';

class AdminEditNutritionScreen extends StatelessWidget {
  const AdminEditNutritionScreen({
    Key? key,
    required this.servingPerController,
    required this.servingSizeController,
    required this.caloriesController,
    required this.totalFatGController,
    required this.totalFatPercentController,
    required this.saturatedFatGController,
    required this.saturatedFatPercentController,
    required this.transFatGController,
    required this.transFatPercentController,
    required this.cholesterolGController,
    required this.cholesterolPercentController,
    required this.sodiumGController,
    required this.sodiumPercentController,
    required this.carbohydrateGController,
    required this.carbohydratePercentController,
    required this.dietaryFiberGController,
    required this.dietaryFiberPercentController,
    required this.sugarsGController,
    required this.sugarsPercentController,
    required this.includesGController,
    required this.includesPercentController,
    required this.proteinGController,
    required this.proteinPercentController,
    required this.vitaminDGController,
    required this.vitaminDPercentController,
    required this.calciumGController,
    required this.calciumPercentController,
    required this.ironGController,
    required this.ironPercentController,
    required this.potassiumGController,
    required this.potassiumPercentController,
    required this.ingredientController,
  }) : super(key: key);

  final TextEditingController servingPerController;
  final TextEditingController servingSizeController;
  final TextEditingController caloriesController;
  final TextEditingController totalFatGController;
  final TextEditingController totalFatPercentController;
  final TextEditingController saturatedFatGController;
  final TextEditingController saturatedFatPercentController;
  final TextEditingController transFatGController;
  final TextEditingController transFatPercentController;
  final TextEditingController cholesterolGController;
  final TextEditingController cholesterolPercentController;
  final TextEditingController sodiumGController;
  final TextEditingController sodiumPercentController;
  final TextEditingController carbohydrateGController;
  final TextEditingController carbohydratePercentController;
  final TextEditingController dietaryFiberGController;
  final TextEditingController dietaryFiberPercentController;
  final TextEditingController sugarsGController;
  final TextEditingController sugarsPercentController;
  final TextEditingController includesGController;
  final TextEditingController includesPercentController;
  final TextEditingController proteinGController;
  final TextEditingController proteinPercentController;
  final TextEditingController vitaminDGController;
  final TextEditingController vitaminDPercentController;
  final TextEditingController calciumGController;
  final TextEditingController calciumPercentController;
  final TextEditingController ironGController;
  final TextEditingController ironPercentController;
  final TextEditingController potassiumGController;
  final TextEditingController potassiumPercentController;
  final TextEditingController ingredientController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppItems.customText('serving per container:'),
            ),
            SizedBox(height: 5.sp),
            Expanded(
              flex: 2,
              child: AppItems.customTextField(
                hintText: '16 serving per container',
                controller: servingPerController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(
              child: AppItems.customText('Serving Size:'),
            ),
            SizedBox(height: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '1 cup (240ml)',
                controller: servingSizeController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('calories:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '150',
                controller: caloriesController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Total Fat:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '8g',
                controller: totalFatGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '10%',
                controller: totalFatPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Saturated Fat:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '5g',
                controller: saturatedFatGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '25%',
                controller: saturatedFatPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Trans Fat:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '0g',
                controller: transFatGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '0%',
                controller: transFatPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Cholesterol:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '35g',
                controller: cholesterolGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '11%',
                controller: cholesterolPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Sodium:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '25g',
                controller: sodiumGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '5%',
                controller: sodiumPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Total Carbohydrate:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '12g',
                controller: carbohydrateGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '5%',
                controller: carbohydratePercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Dietary Fiber:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '0g',
                controller: dietaryFiberGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '0%',
                controller: dietaryFiberPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Total Sugars:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '12g',
                controller: sugarsGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '0%',
                controller: sugarsPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Includes:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '0g Added Sugars',
                controller: includesGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '0%',
                controller: includesPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Protein:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '8g',
                controller: proteinGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '16%',
                controller: proteinPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Vitamin D:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '2.5mcg',
                controller: vitaminDGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '15%',
                controller: vitaminDPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Calcium:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '300mg',
                controller: calciumGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '25%',
                controller: calciumPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Iron:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '0.1mg',
                controller: ironGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '0%',
                controller: ironPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Expanded(child: AppItems.customText('Potassium:')),
            Expanded(
              child: AppItems.customTextField(
                hintText: '400g',
                controller: potassiumGController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: AppItems.customTextField(
                hintText: '8%',
                controller: potassiumPercentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
        AppItems.customTextField(
          hintText: 'ingredient',
          controller: ingredientController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
