import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/employee/data/models/financial_sheet_model.dart';

class EmployeeItems {
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
