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

class HRAddVacationRequestScreen extends StatelessWidget {
  HRAddVacationRequestScreen({Key? key}) : super(key: key);

  final vacationKey = GlobalKey<FormState>();
  final vacationEndTimeController = TextEditingController();
  final vacationStartTimeController = TextEditingController();

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
              padding: EdgeInsets.all(4.sp),
              child: Form(
                key: vacationKey,
                child: Column(
                  children: [
                    SizedBox(height: 50.sp),
                    AppItems.customText(
                      'Vacation Request',
                      fontSize: 22.sp,
                    ),
                    SizedBox(height: 30.sp),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Vacation Type:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: AppButtons.customDropDownButtonFormField(
                            items: cubit.vacationTypeItems,
                            onChanged: (value) => cubit.vacationChange(value),
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
                      controller: vacationStartTimeController,
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
                          vacationStartTimeController.text = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.sp),
                    AppItems.customTextField(
                      hintText: 'End Time',
                      readOnly: true,
                      keyboardType: TextInputType.datetime,
                      controller: vacationEndTimeController,
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
                          vacationEndTimeController.text = value;
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
                          if (vacationKey.currentState!.validate()) {
                            await cubit.insertEmployeeRequest(
                              empId: empData!.empId!,
                              empToken: empData.empToken!,
                              empLastName: empData.lastName!,
                              empFirstName: empData.firstName!,
                              requestId: id,
                              status: 'Under Review',
                              vacationType: 'Vacation',
                              endDateTime: vacationEndTimeController.text,
                              startDateTime: vacationStartTimeController.text,
                              requestType: cubit.vacationTypeItemsValue,
                            );
                            await NotificationServices.sendNotificationToTopic(
                              topic: ConstText.requests,
                              title: 'Vacation Request',
                              body: 'Employee Normal Vacation Request, Type ' +
                                  cubit.vacationTypeItemsValue,
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
