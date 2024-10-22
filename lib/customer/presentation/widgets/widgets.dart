import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';

class CustomerItems {
  static Widget customProductsItem({
    void Function()? onTap,
    required Map<String, dynamic> data,
  }) =>
      InkWell(
        onTap: onTap,
        splashColor: ConstColors.kPrimaryColor.withOpacity(0.3),
        highlightColor: ConstColors.kPrimaryColor.withOpacity(0.1),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.sp),
          margin: EdgeInsets.all(5.sp),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Row(
            children: [
              Container(
                width: 95.sp,
                height: 90.sp,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: FadeInImage(
                  width: 95.sp,
                  height: 120.sp,
                  fit: BoxFit.fill,
                  image: NetworkImage(data['prodImage']),
                  placeholder: AssetImage(ConstIcons.loading),
                ),
              ),
              SizedBox(width: 8.sp),
              SizedBox(
                width: 160.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppItems.customText(
                      data['prodTitle'],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 8.sp),
                    AppItems.customText(
                      'Flavor: ${data['prodFlavor']}',
                      fontSize: 13.sp,
                      fontColor: Colors.grey,
                    ),
                    SizedBox(height: 8.sp),
                    AppItems.customText(
                      'Size: ${data['prodSize']}',
                      fontSize: 13.sp,
                      fontColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  static Widget orderDetailsItem({
    required Map<String, dynamic> data,
  }) =>
      Container(
        width: 130.sp,
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Column(
          children: [
            Container(
              width: 120.sp,
              height: 100.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(data['prodImage']),
                ),
              ),
            ),

            Column(
              children: [
                AppItems.customText(
                  data['prodTitle'],
                  fontSize: 9.sp,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.sp),
                AppItems.customText(
                  data['prodSize'],
                  fontSize: 10.sp,
                ),
                SizedBox(height: 3.sp),
                AppItems.customText(
                  data['prodFlavor'],
                  fontSize: 10.sp,
                ),
                SizedBox(height: 3.sp),
                AppItems.customText(
                  data['quantity'],
                  fontSize: 12.sp,
                ),
              ],
            ),
          ],
        ),
      );

  static Widget customProfileDataItem({
    required String text,
  }) =>
      Container(
        // height: 40.sp,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: Colors.grey.shade50.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Text(text, style: TextStyle(fontSize: 14.sp)),
      );

  static Widget customNutritionFactItem(
    Map<String, dynamic> nutrition,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppItems.customText(
              '${nutrition['servingPer']} serving per container'),
          Row(
            children: [
              AppItems.customText(
                'Serving size',
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
              const Spacer(),
              AppItems.customText(
                '${nutrition['servingSize']}',
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Divider(thickness: 5.sp, color: Colors.black),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppItems.customText(
                    'Amount per serving',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  AppItems.customText(
                    'Calories',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const Spacer(),
              AppItems.customText(
                '${nutrition['calories']}',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Divider(thickness: 5.sp, color: Colors.black),
          Align(
            alignment: Alignment.centerRight,
            child: AppItems.customText(
              '% Daily Value',
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.sp),
          Table(
            border: const TableBorder(
              horizontalInside: BorderSide(),
              left: BorderSide(),
              right: BorderSide(),
              top: BorderSide(),
              bottom: BorderSide(),
            ),
            columnWidths: {
              1: FixedColumnWidth(110.sp),
              2: FixedColumnWidth(50.sp),
            },
            children: [
              customTableRows(
                text: 'Total Fat',
                text1: '${nutrition['totalFatG']}',
                text2: '%${nutrition['totalFatPercent']}',
              ),
              customTableRows(
                text: 'Saturated Fat',
                text1: '${nutrition['saturatedFatG']}',
                text2: '%${nutrition['saturatedFatPercent']}',
              ),
              customTableRows(
                text: 'Trans Fat',
                text1: '${nutrition['transFatG']}',
                text2: '%${nutrition['transFatPercent']}',
              ),
              customTableRows(
                text: 'Cholesterol',
                text1: '${nutrition['cholesterolG']}',
                text2: '%${nutrition['cholesterolPercent']}',
              ),
              customTableRows(
                text: 'Sodium',
                text1: '${nutrition['sodiumG']}',
                text2: "%${nutrition['sodiumPercent']}",
              ),
              customTableRows(
                text: 'Total Carbohydrate',
                text1: '${nutrition['carbohydrateG']}',
                text2: '%${nutrition['carbohydratePercent']}',
              ),
              customTableRows(
                text: 'Dietary Fiber',
                text1: '${nutrition['dietaryFiberG']}',
                text2: '%${nutrition['dietaryFiberPercent']}',
              ),
              customTableRows(
                text: 'Total Sugars',
                text1: '${nutrition['sugarsG']}',
                text2: '%${nutrition['sugarsPercent']}',
              ),
              customTableRows(
                text: 'Includes',
                text1: '${nutrition['includesG']} Added Sugars',
                text2: '%${nutrition['includesPercent']}',
              ),
              customTableRows(
                text: 'Protein',
                text1: '${nutrition['proteinG']}',
                text2: '%${nutrition['proteinPercent']}',
              ),
              customTableRows(
                text: 'Vitamin D',
                text1: '${nutrition['vitaminG']}',
                text2: '%${nutrition['vitaminPercent']}',
              ),
              customTableRows(
                text: 'Calcium',
                text1: '${nutrition['calciumG']}',
                text2: '%${nutrition['calciumPercent']}',
              ),
              customTableRows(
                text: 'Iron',
                text1: '${nutrition['ironG']}',
                text2: '%${nutrition['ironPercent']}',
              ),
              customTableRows(
                text: 'Potassium',
                text1: '${nutrition['potassiumG']}',
                text2: '%${nutrition['potassiumPercent']}',
              )
            ],
          ),
          SizedBox(height: 5.sp),
          AppItems.customText(
            'ingredients: ${nutrition['ingredient']}',
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
          ),
          Divider(thickness: 5.sp, color: Colors.black),
        ],
      );

  static Widget customListTileItem({
    required String title,
    required double fontSize,
    required IconData icon,
    double? iconSize,
    IconData? trailingIcon,
    required Function()? onTap,
  }) =>
      ListTile(
        trailing: Icon(
          trailingIcon,
          size: iconSize,
          color: ConstColors.kPrimaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          icon,
          size: iconSize,
          color: ConstColors.kPrimaryColor,
        ),
        onTap: onTap,
      );

  static TableRow customTableRows({
    required String text,
    required String text1,
    required String text2,
  }) =>
      TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: AppItems.customText(text, fontSize: 12.sp),
          ),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: AppItems.customText(text1, fontSize: 12.sp),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.sp,
              horizontal: 4.sp,
            ),
            child: AppItems.customText(
              text2,
              fontSize: 11.sp,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );

  static Widget customRadioButton({
    required String text,
    required String value,
    required String? groupValue,
    required void Function(String?)? onChanged,
  }) =>
      Row(
        children: [
          Radio(
            toggleable: true,
            value: value,
            groupValue: groupValue,
            activeColor: ConstColors.kPrimaryColor,
            onChanged: onChanged,
          ),
          Text(text),
        ],
      );
}
