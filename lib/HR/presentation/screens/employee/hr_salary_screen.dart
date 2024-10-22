import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/employee/business_logic/employee_states.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';

class HRAddSalaryScreen extends StatelessWidget {
  HRAddSalaryScreen({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;
  final formKey = GlobalKey<FormState>();
  final taxController = TextEditingController();
  final otherController = TextEditingController();
  final salaryController = TextEditingController();
  final totalVacationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {
        if (state is InsertSalaryEmployeeSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppItems.customText(
                'Successfully',
                fontSize: 12.sp,
              ),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = EmployeeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Salary'),
            leading: AppButtons.customButtonBack(context),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                children: [
                  AppItems.customAppLogo(),
                  SizedBox(height: 30.sp),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Select Month:',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: AppButtons.customDropDownButtonFormField(
                                  items: cubit.months,
                                  fontSize: 14.sp,
                                  hintText: 'Select',
                                  margin: EdgeInsets.only(left: 10.sp),
                                  contentPadding: EdgeInsets.all(10.sp),
                                  onChanged: (value) {
                                    cubit.selectMonthChange(value);
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Field is Required';
                                    }
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.sp),
                        if (now.month == DateTime.december)
                          AppItems.customTextField(
                            hintText: 'Total Vacation',
                            keyboardType: TextInputType.number,
                            controller: totalVacationController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is Required';
                              }
                              return null;
                            },
                          ),
                        SizedBox(height: 5.sp),
                        AppItems.customTextField(
                          hintText: 'Salary',
                          keyboardType: TextInputType.number,
                          controller: salaryController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 5.sp),
                        AppItems.customTextField(
                          hintText: 'Tax',
                          keyboardType: TextInputType.number,
                          controller: taxController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is Required';
                            }
                            return null;
                          },
                        ),
                        AppItems.customTextField(
                          hintText: 'Other',
                          keyboardType: TextInputType.number,
                          controller: otherController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is Required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.sp),
                  AppButtons.customElevatedButton(
                    text: 'Submit',
                    color: ConstColors.kPrimaryColor,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (now.month == DateTime.december) {
                          await cubit.updateTotalVacationsEveryYear(
                            empId: data['empId'],
                            lastYearVacations: data['lastYearVacations'] +
                                data['totalVacations'],
                            totalVacations:
                                double.parse(totalVacationController.text),
                          );
                        }
                        await cubit.setSalaryEmployee(
                          year: now.year,
                          empId: data['empId'],
                          tax: taxController.text,
                          other: otherController.text,
                          salary: salaryController.text,
                        );
                        await NotificationServices.sendNotificationToToken(
                          token: data['empToken'],
                          title: 'Added Salary',
                          body: 'The current month\'s salary has been added',
                        );
                      }
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
}
