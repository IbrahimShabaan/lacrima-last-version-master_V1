import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/employee/data/models/financial_sheet_model.dart';

class SalesItems {
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

  static Widget customAnnouncementItem({
    required Map<String, dynamic> data,
  }) =>
      Padding(
        padding: EdgeInsets.all(8.sp),
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
                      '${data['date']}',
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

  static Widget customRequestItem({
    required Map<String, dynamic> data,
  }) =>
      SizedBox(
        height: 120.sp,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 5.sp,
                ),
                Container(
                  height: 100.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Icon(
                    Icons.note_alt_outlined,
                    color: Colors.green,
                    size: 70.sp,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppItems.customText(
                      data['type'],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    AppItems.customText(
                      data['requestType'],
                      fontSize: 14.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppItems.customText(
                      data['status'],
                      fontSize: 14.sp,
                      fontColor: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    AppItems.customText(
                      data['startDateTime'],
                      fontSize: 11.sp,
                      fontColor: Colors.green,
                    ),
                    SizedBox(width: 5.sp),
                    Icon(Icons.watch_later_outlined,
                        size: 12.sp, color: Colors.green),
                  ],
                ),
                SizedBox(width: 18.sp),
                Row(
                  children: [
                    AppItems.customText(
                      data['endDateTime'],
                      fontSize: 11.sp,
                      fontColor: Colors.red,
                    ),
                    SizedBox(width: 5.sp),
                    Icon(Icons.watch_later_outlined,
                        size: 12.sp, color: Colors.red),
                  ],
                ),
              ],
            ),
          ],
        ),
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

  static Widget customSummarySalary({
    required double tax,
    required String month,
    required double other,
    required double salary,
  }) {
    var finalSalary = salary - salary * tax / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppItems.customText(
          'Month: $month',
          fontSize: 14.sp,
          fontColor: Colors.green,
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            AppItems.customText(
              'Total Salary',
              fontSize: 13.sp,
              fontColor: Colors.grey.shade600,
            ),
            const Spacer(),
            AppItems.customText(
              '$salary',
              fontSize: 13.sp,
              fontColor: Colors.green,
            ),
            SizedBox(width: 20.sp),
          ],
        ),
        SizedBox(height: 10.sp),
        Row(
          children: [
            AppItems.customText(
              'Tax',
              fontSize: 13.sp,
              fontColor: Colors.grey.shade600,
            ),
            const Spacer(),
            AppItems.customText(
              '$tax',
              fontSize: 13.sp,
              fontColor: Colors.green,
            ),
            SizedBox(width: 20.sp),
          ],
        ),
        SizedBox(height: 10.sp),
        Row(
          children: [
            AppItems.customText(
              'other',
              fontSize: 13.sp,
              fontColor: Colors.grey.shade600,
            ),
            const Spacer(),
            AppItems.customText(
              '$other',
              fontSize: 13.sp,
              fontColor: Colors.green,
            ),
            SizedBox(width: 20.sp),
          ],
        ),
        SizedBox(height: 10.sp),
        Row(
          children: [
            AppItems.customText(
              'Final Salary',
              fontSize: 13.sp,
              fontColor: Colors.grey.shade600,
            ),
            const Spacer(),
            AppItems.customText(
              '${finalSalary.round() - other}',
              fontSize: 13.sp,
              fontColor: Colors.green,
            ),
            SizedBox(width: 20.sp),
          ],
        ),
      ],
    );
  }

  static Widget financialSummaryItem({
    required PageController controller,
    required FinancialSheetModel salariesOfYear,
  }) =>
      Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppItems.customText(
                    'Financial Summary',
                    fontSize: 16.sp,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(0.sp),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 15.sp,
                        ),
                        onPressed: () => controller.previousPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.fastLinearToSlowEaseIn,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0.sp),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.sp,
                        ),
                        onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.fastLinearToSlowEaseIn,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.sp),
              SizedBox(
                height: 120.sp,
                width: double.infinity,
                child: PageView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    customSummarySalary(
                      month: 'January',
                      tax: salariesOfYear.january['tax'],
                      other: salariesOfYear.january['other'],
                      salary: salariesOfYear.january['salary'],
                    ),
                    customSummarySalary(
                      month: 'February',
                      tax: salariesOfYear.february['tax'],
                      other: salariesOfYear.february['other'],
                      salary: salariesOfYear.february['salary'],
                    ),
                    customSummarySalary(
                      month: 'March',
                      tax: salariesOfYear.march['tax'],
                      other: salariesOfYear.march['other'],
                      salary: salariesOfYear.march['salary'],
                    ),
                    customSummarySalary(
                      month: 'April',
                      tax: salariesOfYear.april['tax'],
                      other: salariesOfYear.april['other'],
                      salary: salariesOfYear.april['salary'],
                    ),
                    customSummarySalary(
                      month: 'May',
                      tax: salariesOfYear.may['tax'],
                      other: salariesOfYear.may['other'],
                      salary: salariesOfYear.may['salary'],
                    ),
                    customSummarySalary(
                      month: 'June',
                      tax: salariesOfYear.june['tax'],
                      other: salariesOfYear.june['other'],
                      salary: salariesOfYear.june['salary'],
                    ),
                    customSummarySalary(
                      month: 'July',
                      tax: salariesOfYear.july['tax'],
                      other: salariesOfYear.july['other'],
                      salary: salariesOfYear.july['salary'],
                    ),
                    customSummarySalary(
                      month: 'August',
                      tax: salariesOfYear.august['tax'],
                      other: salariesOfYear.august['other'],
                      salary: salariesOfYear.august['salary'],
                    ),
                    customSummarySalary(
                      month: 'September',
                      tax: salariesOfYear.september['tax'],
                      other: salariesOfYear.september['other'],
                      salary: salariesOfYear.september['salary'],
                    ),
                    customSummarySalary(
                      month: 'October',
                      tax: salariesOfYear.october['tax'],
                      other: salariesOfYear.october['other'],
                      salary: salariesOfYear.october['salary'],
                    ),
                    customSummarySalary(
                      month: 'November',
                      tax: salariesOfYear.november['tax'],
                      other: salariesOfYear.november['other'],
                      salary: salariesOfYear.november['salary'],
                    ),
                    customSummarySalary(
                      month: 'December',
                      tax: salariesOfYear.december['tax'],
                      other: salariesOfYear.december['other'],
                      salary: salariesOfYear.december['salary'],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  static Widget vacationSummaryItem({
    required double totalVacation,
    required double usedVacation,
    required double lastYearVacations,
  }) =>
      Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppItems.customText(
                'Vacation Summary',
                fontSize: 16.sp,
              ),
              SizedBox(height: 10.sp),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppItems.customText(
                        'Total Vacation',
                        fontSize: 13.sp,
                        fontColor: Colors.grey.shade600,
                      ),
                      const Spacer(),
                      AppItems.customText(
                        '$totalVacation',
                        fontSize: 13.sp,
                        fontColor: Colors.green,
                      ),
                      SizedBox(width: 20.sp),
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppItems.customText(
                        'Used Vacation',
                        fontSize: 13.sp,
                        fontColor: Colors.grey.shade600,
                      ),
                      const Spacer(),
                      AppItems.customText(
                        '$usedVacation',
                        fontSize: 13.sp,
                        fontColor: Colors.green,
                      ),
                      SizedBox(width: 20.sp),
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppItems.customText(
                        'Last Year Vacations',
                        fontSize: 13.sp,
                        fontColor: Colors.grey.shade600,
                      ),
                      const Spacer(),
                      AppItems.customText(
                        '$lastYearVacations',
                        fontSize: 13.sp,
                        fontColor: Colors.green,
                      ),
                      SizedBox(width: 20.sp),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  static Widget orderItemsHome({
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

  static Widget fABRequests({
    required BuildContext context,
    required void Function()? onPressedLeave,
    required void Function()? onPressedOverTime,
    required void Function()? onPressedVacation,
  }) =>
      FloatingActionButton(
        child: Icon(Icons.note_alt_outlined, size: 24.sp),
        backgroundColor: ConstColors.kPrimaryColor,
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Select Request'),
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
                          foregroundColor: ConstColors.kPrimaryColor),
                      label: Text('Leave Request',
                          style: TextStyle(fontSize: 14.sp)),
                      onPressed: onPressedLeave,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.edit, size: 18.sp),
                      style: TextButton.styleFrom(
                          foregroundColor: ConstColors.kPrimaryColor),
                      label: Text('Vacation Request',
                          style: TextStyle(fontSize: 14.sp)),
                      onPressed: onPressedVacation,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.edit, size: 18.sp),
                      style: TextButton.styleFrom(
                          foregroundColor: ConstColors.kPrimaryColor),
                      label: Text('OverTime Request',
                          style: TextStyle(fontSize: 14.sp)),
                      onPressed: onPressedOverTime,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

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
}
