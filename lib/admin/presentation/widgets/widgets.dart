import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';

class AdminItems {
  static Widget customCompAndSugItem({
    required Map<String, dynamic> data,
    required void Function()? onPressed,
  }) =>
      Container(
        width: double.infinity,
        margin: EdgeInsets.all(8.sp),
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        data['fullName'],
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: ConstColors.kPrimaryColor,
                        padding: EdgeInsets.zero,
                        onPressed: onPressed,
                      ),
                    ],
                  ),
                  SizedBox(height: 7.sp),
                  Text(
                    data['email'],
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Text(
                    data['content'],
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Divider(
                    height: 1.sp,
                    thickness: 1.sp,
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        data['date'],
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 5.sp),
                      Icon(
                        Icons.watch_later_outlined,
                        size: 12.sp,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  static Widget customProfileDataItem({
    required String text,
  }) =>
      Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: Colors.grey.shade50.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Text(text, style: TextStyle(fontSize: 14.sp)),
      );

  static Widget customAnnouncementItem({
    required BuildContext context,
    required Map<String, dynamic> data,
    required void Function()? onPressed,
  }) =>
      Padding(
        padding: EdgeInsets.all(8.sp),
        child: InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: TextButton.icon(
                label: Text(
                  'Delete',
                  style: TextStyle(fontSize: 14.sp),
                ),
                icon: Icon(
                  Icons.delete_forever,
                  size: 24.sp,
                ),
                style: TextButton.styleFrom(
                  foregroundColor: ConstColors.kPrimaryColor,
                ),
                onPressed: onPressed,
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 100.sp,
                    height: 100.sp,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: FadeInImage(
                      width: 100.sp,
                      height: 100.sp,
                      fit: BoxFit.fill,
                      placeholder: AssetImage(ConstIcons.loading),
                      image: NetworkImage(data['image']),
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppItems.customText(
                        data['title'],
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 5.sp),
                      AppItems.customText(
                        data['date'].toString(),
                        fontSize: 13.sp,
                        fontColor: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.sp),
              SizedBox(
                width: double.infinity,
                child: AppItems.customText(
                  data['description'],
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      );

  static Widget customRequestItem({
    required BuildContext context,
    required Map<String, dynamic> data,
    required dynamic Function() rejectOnPressed,
    required dynamic Function() acceptOnPressed,
    required TextEditingController vacationController,
  }) =>
      Container(
        height: 165.sp,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
        margin: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 5.sp,
                ),
                Container(
                  height: 90.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Icon(
                    Icons.note_alt_outlined,
                    color: Colors.green,
                    size: 65.sp,
                  ),
                ),
                SizedBox(
                  width: 190.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppItems.customText('ID: ${data['empId']}',
                          fontSize: 12.sp),
                      SizedBox(height: 3.sp),
                      AppItems.customText('First Name: ${data['empFirstName']}',
                          fontSize: 12.sp),
                      SizedBox(height: 3.sp),
                      AppItems.customText('Last Name: ${data['empLastName']}',
                          fontSize: 12.sp),
                      SizedBox(height: 3.sp),
                      AppItems.customText('Type: ${data['type']}',
                          fontSize: 12.sp),
                      SizedBox(height: 3.sp),
                      AppItems.customText(
                          'Request Type: ${data['requestType']}',
                          fontSize: 12.sp),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      data['startDateTime'],
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 5.sp),
                    Icon(
                      Icons.watch_later_outlined,
                      size: 12.sp,
                      color: Colors.green,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      data['endDateTime'],
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 5.sp),
                    Icon(
                      Icons.watch_later_outlined,
                      size: 12.sp,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.sp),
            Divider(color: Colors.green, height: 1.sp),
            if (data['status'] == 'Under Review')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButtons.customTextButton(
                    text: 'Rejected',
                    width: 120.sp,
                    height: 25.sp,
                    fontSize: 14.sp,
                    color: Colors.red,
                    hoverColor: Colors.red,
                    padding: EdgeInsets.all(0.sp),
                    onPressed: rejectOnPressed,
                  ),
                  AppButtons.customTextButton(
                    text: 'Accept',
                    width: 120.sp,
                    height: 25.sp,
                    fontSize: 14.sp,
                    color: Colors.green,
                    hoverColor: Colors.green,
                    padding: EdgeInsets.all(0.sp),
                    onPressed: () async => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: AppItems.customText('number of vacation days'),
                        content: Container(
                          padding: EdgeInsets.all(8.sp),
                          margin: EdgeInsets.all(8.sp),
                          child: AppItems.customTextField(
                            hintText: 'enter number',
                            keyboardType: TextInputType.number,
                            controller: vacationController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        actions: [
                          AppButtons.customTextButton(
                            text: 'Accept',
                            fontSize: 14.sp,
                            color: ConstColors.kPrimaryColor,
                            onPressed: acceptOnPressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            if (data['status'] != 'Under Review')
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: AppItems.customText(
                    data['status'],
                    fontSize: 14.sp,
                    fontColor: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      );

  static Widget orderDetailsItem({
    required Map<String, dynamic> productData,
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
                  image: NetworkImage(productData['prodImage']),
                ),
              ),
            ),

            Column(
              children: [
                AppItems.customText(
                  productData['prodTitle'],
                  fontSize: 9.sp,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.sp),
                AppItems.customText(
                  productData['prodSize'],
                  fontSize: 10.sp,
                ),
                SizedBox(height: 3.sp),
                AppItems.customText(
                  productData['prodFlavor'],
                  fontSize: 10.sp,
                ),
                SizedBox(height: 3.sp),
                AppItems.customText(
                  productData['quantity'],
                  fontSize: 12.sp,
                ),
              ],
            ),
          ],
        ),
      );

  static Widget customProductsItem({
    required BuildContext context,
    required Map<String, dynamic> data,
    required void Function()? onPressedEdit,
    required void Function()? onPressedDetails,
    required dynamic Function() onPressedYes,
    required dynamic Function() onPressedNo,
  }) =>
      InkWell(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              content: SizedBox(
                height: 120.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.edit, size: 18.sp),
                      style: TextButton.styleFrom(
                        foregroundColor: ConstColors.kPrimaryColor,
                      ),
                      label: Text(
                        'Edit Product',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      onPressed: onPressedEdit,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.description_sharp, size: 18.sp),
                      style: TextButton.styleFrom(
                        foregroundColor: ConstColors.kPrimaryColor,
                      ),
                      label: Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      onPressed: onPressedDetails,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.delete_forever, size: 18.sp),
                      style: TextButton.styleFrom(
                        foregroundColor: ConstColors.kPrimaryColor,
                      ),
                      label: Text(
                        'Delete Product',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog<String>(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text(
                              'Do you want to delete the Product',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            title: Icon(
                              Icons.warning_rounded,
                              color: Colors.yellow.shade800,
                            ),
                            actions: [
                              AppButtons.customTextButton(
                                text: 'Yes',
                                color: ConstColors.kPrimaryColor,
                                fontSize: 14.sp,
                                onPressed: onPressedYes,
                              ),
                              AppButtons.customTextButton(
                                text: 'No',
                                color: ConstColors.kPrimaryColor,
                                fontSize: 14.sp,
                                onPressed: onPressedNo,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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

  static Widget orderSelectItem({
    required Map<String, dynamic> data,
    required bool isChecked,
    TextEditingController? quantity,
    void Function(String)? onFieldSubmitted,
    required void Function(bool?)? onChanged,
  }) =>
      Container(
        height: 220.sp,
        width: 140.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        padding: EdgeInsets.all(5.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 130.sp,
              height: 100.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(data['prodImage']),
                ),
              ),
            ),
            SizedBox(height: 5.sp),
            Text(data['prodTitle']),
            Text(data['prodFlavor']),
            Text(data['prodSize']),
            SizedBox(height: 5.sp),
            Row(
              children: [
                Container(
                  width: 80.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: AppItems.customTextField(
                    hintText: 'Quantity',
                    controller: quantity,
                    onFieldSubmitted: onFieldSubmitted,
                  ),
                ),
                Checkbox(
                  value: isChecked,
                  onChanged: onChanged,
                  activeColor: ConstColors.kPrimaryColor,
                ),
              ],
            ),
          ],
        ),
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

  static Widget customerOrderItem({
    required Map<String, dynamic> data,
  }) =>
      Container(
        height: 120.sp,
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.sp)),
        child: Row(
          children: [
            SizedBox(
              width: 190.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppItems.customText(
                    'name: ${data['customerName']}',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  AppItems.customText(
                    'Price: ${data['price']}',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      AppItems.customText(
                        'IssueDate: ${data['issueDate']}',
                        fontSize: 12.sp,
                        fontColor: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      Icon(
                        Icons.calendar_month,
                        color: Colors.green,
                        size: 12.sp,
                      ),
                    ],
                  ),
                  AppItems.customText(
                    'Receiving on: ${data['receivingTime']}',
                    fontSize: 12.sp,
                    fontColor: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 74.sp,
              height: 80.sp,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: FadeInImage(
                height: 100.sp,
                fit: BoxFit.cover,
                image: NetworkImage(data['product'][0]['prodImage']),
                placeholder: AssetImage(ConstIcons.loading),
              ),
            ),
          ],
        ),
      );

  static Widget customerItem({
    required void Function()? onTap,
    required Map<String, dynamic> data,
    required EdgeInsetsGeometry? margin,
  }) =>
      InkWell(
        child: Container(
          height: 80.sp,
          width: double.infinity,
          margin: margin,
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Row(
            children: [
              Container(
                width: 70.sp,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  width: 70.sp,
                  height: 100.sp,
                  image: NetworkImage(data['image']),
                  placeholder: AssetImage(ConstIcons.loading),
                ),
              ),
              SizedBox(width: 5.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppItems.customText(
                    data['userName'],
                    fontSize: 12.sp,
                  ),
                  AppItems.customText(
                    data['companyName'],
                    fontSize: 12.sp,
                  ),
                  SizedBox(
                    width: 190.sp,
                    child: AppItems.customText(
                      data['email'],
                      fontSize: 12.sp,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: onTap,
      );

  static Widget employeeItem({
    required BuildContext context,
    required Map<String, dynamic> data,
    required void Function()? onPressedEdit,
    required void Function()? onPressedSalary,
    required dynamic Function() onPressedYes,
    required dynamic Function() onPressedNo,
  }) =>
      InkWell(
        borderRadius: BorderRadius.circular(10.sp),
        child: Container(
          height: 80.sp,
          width: double.infinity,
          margin: EdgeInsets.all(8.sp),
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Row(
            children: [
              Container(
                width: 70.sp,
                margin: EdgeInsets.only(right: 10.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.sp),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(data['image']),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    data['userName'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    data['position'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    data['empId'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: () => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Enter Actions'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            actions: [
              AppButtons.customTextButton(
                text: 'Close',
                color: ConstColors.kPrimaryColor,
                fontSize: 14.sp,
                onPressed: () => Navigator.pop(context),
              ),
            ],
            content: SizedBox(
              height: 120.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    icon: Icon(Icons.attach_money, size: 18.sp),
                    style: TextButton.styleFrom(
                      foregroundColor: ConstColors.kPrimaryColor,
                    ),
                    label: Text(
                      'Insert Salary',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    onPressed: onPressedSalary,
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.edit, size: 18.sp),
                    style: TextButton.styleFrom(
                      foregroundColor: ConstColors.kPrimaryColor,
                    ),
                    label: Text(
                      'Edit Employee',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    onPressed: onPressedEdit,
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.delete_forever, size: 18.sp),
                    style: TextButton.styleFrom(
                      foregroundColor: ConstColors.kPrimaryColor,
                    ),
                    label: Text(
                      'Delete Employee',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(
                            'Do you want to delete the Employee',
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          title: Icon(
                            Icons.warning_rounded,
                            color: Colors.yellow.shade800,
                          ),
                          actions: [
                            AppButtons.customTextButton(
                              text: 'Yes',
                              color: ConstColors.kPrimaryColor,
                              fontSize: 14.sp,
                              onPressed: onPressedYes,
                            ),
                            AppButtons.customTextButton(
                              text: 'No',
                              color: ConstColors.kPrimaryColor,
                              fontSize: 14.sp,
                              onPressed: onPressedNo,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  static Widget orderItem({
    required BuildContext context,
    required Map<String, dynamic> data,
    required void Function()? onPressedEdit,
    required dynamic Function() onPressedNo,
    required dynamic Function() onPressedYes,
    required void Function()? onPressedDetails,
  }) =>
      InkWell(
        highlightColor: ConstColors.kPrimaryColor.withOpacity(0.1),
        splashColor: ConstColors.kPrimaryColor.withOpacity(0.3),
        child: Container(
          height: 130.sp,
          padding: EdgeInsets.all(4.sp),
          child: Row(
            children: [
              SizedBox(
                width: 196.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppItems.customText(
                      'name: ${data['customerName']}',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    AppItems.customText(
                      'Price: ${data['price']}',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        AppItems.customText(
                          'IssueDate: ${data['issueDate']}',
                          fontSize: 12.sp,
                          fontColor: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        Icon(
                          Icons.calendar_month,
                          color: Colors.green,
                          size: 12.sp,
                        ),
                      ],
                    ),
                    AppItems.customText(
                      'Receiving on: ${data['receivingTime']}',
                      fontSize: 12.sp,
                      fontColor: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: 80.sp,
                height: 80.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${data['product'][0]['prodImage']}'),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              content: SizedBox(
                height: 120.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.edit, size: 18.sp),
                      style: TextButton.styleFrom(
                        foregroundColor: ConstColors.kPrimaryColor,
                      ),
                      label: Text(
                        'Edit Order',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      onPressed: onPressedEdit,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.description_sharp, size: 18.sp),
                      style: TextButton.styleFrom(
                        foregroundColor: ConstColors.kPrimaryColor,
                      ),
                      label: Text(
                        'Order Details',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      onPressed: onPressedDetails,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.delete_forever, size: 18.sp),
                      style: TextButton.styleFrom(
                        foregroundColor: ConstColors.kPrimaryColor,
                      ),
                      label: Text(
                        'Delete Order',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog<String>(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text(
                              'Do you want to delete the Order',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            title: Icon(
                              Icons.warning_rounded,
                              color: Colors.yellow.shade800,
                            ),
                            actions: [
                              AppButtons.customTextButton(
                                text: 'Yes',
                                color: ConstColors.kPrimaryColor,
                                fontSize: 14.sp,
                                onPressed: onPressedYes,
                              ),
                              AppButtons.customTextButton(
                                text: 'No',
                                fontSize: 14.sp,
                                color: ConstColors.kPrimaryColor,
                                onPressed: onPressedNo,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
