import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/employee/data/models/financial_sheet_model.dart';

class HRItems {
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
}
