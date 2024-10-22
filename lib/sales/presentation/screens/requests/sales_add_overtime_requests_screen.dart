import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:min_id/min_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';
import 'package:lacrima/employee/business_logic/requests/requests_cubit.dart';
import 'package:lacrima/employee/business_logic/requests/requests_states.dart';

class SalesAddOverTimeRequestScreen extends StatelessWidget {
  SalesAddOverTimeRequestScreen({Key? key}) : super(key: key);

  final overTimeKey = GlobalKey<FormState>();
  final overEndTimeController = TextEditingController();
  final overStartTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = RequestsCubit.get(context);
    var empData = EmployeeCubit.get(context).employeeModel;
    return BlocConsumer<RequestsCubit, RequestsStates>(
      listener: (context, state) {
        if (state is InsertRequestsSuccessState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppItems.customText(
                'Successfully',
                fontSize: 12.sp,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Send Request'),
            leading: AppButtons.customButtonBack(context),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Form(
                key: overTimeKey,
                child: Column(
                  children: [
                    SizedBox(height: 50.sp),
                    AppItems.customText(
                      'OverTime Request',
                      fontSize: 22.sp,
                    ),
                    SizedBox(height: 30.sp),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'OverTime Type:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: AppButtons.customDropDownButtonFormField(
                            items: cubit.overTimeTypeItems,
                            fontSize: 14.sp,
                            onChanged: (value) => cubit.leaveChange(value),
                            validator: (value) {
                              if (value == null) {
                                return 'Field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.sp),
                    AppItems.customTextField(
                      hintText: 'From Time',
                      readOnly: true,
                      keyboardType: TextInputType.datetime,
                      controller: overStartTimeController,
                      validator: (value) {
                        if (value == null) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year + 100),
                          initialDatePickerMode: DatePickerMode.day,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        ).then((date) {
                          var value = DateFormat("yyyy-MM-dd").format(date!);
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((time) {
                            String timeValues =
                                value + ' ' + time!.format(context);
                            overStartTimeController.text = timeValues;
                          });
                        });
                      },
                    ),
                    SizedBox(height: 20.sp),
                    AppItems.customTextField(
                      hintText: 'End Time',
                      readOnly: true,
                      keyboardType: TextInputType.datetime,
                      controller: overEndTimeController,
                      validator: (value) {
                        if (value == null) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year + 100),
                          initialDatePickerMode: DatePickerMode.day,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        ).then((date) {
                          var value = DateFormat("yyyy-MM-dd").format(date!);
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((time) {
                            String timeValues =
                                value + ' ' + time!.format(context);
                            overEndTimeController.text = timeValues;
                          });
                        });
                      },
                    ),
                    SizedBox(height: 50.sp),
                    BuildCondition(
                      condition: state is! InsertRequestsLoadingState,
                      fallback: (context) => AppItems.customIndicator(),
                      builder: (context) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        fontSize: 14.sp,
                        color: ConstColors.kPrimaryColor,
                        hoverColor: Colors.white,
                        onPressed: () async {
                          final id = MinId.getId();
                          if (overTimeKey.currentState!.validate()) {
                            await cubit.insertEmployeeRequest(
                              empId: empData!.empId!,
                              empToken: empData.empToken!,
                              empLastName: empData.lastName!,
                              empFirstName: empData.firstName!,
                              requestId: id,
                              status: 'Under Review',
                              vacationType: 'Overtime',
                              endDateTime: overEndTimeController.text,
                              startDateTime: overStartTimeController.text,
                              requestType: cubit.overTimeTypeItemsValue,
                            );

                            await NotificationServices.sendNotificationToTopic(
                              topic: ConstText.requests,
                              title: 'Overtime Request',
                              body: 'Sales Overtime Request, Type ' +
                                  cubit.overTimeTypeItemsValue,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
