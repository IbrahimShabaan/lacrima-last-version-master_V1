import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/employee/business_logic/employee_states.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';

class EmpAddCompOrSugScreen extends StatelessWidget {
  EmpAddCompOrSugScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {
        if (state is InsertComplaintsAndSuggestionSuccessState) {
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
            leading: AppButtons.customButtonBack(context),
            title: const Text('Send enquiry'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10.sp),
                    AppItems.customAppLogo(),
                    SizedBox(height: 30.sp),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Select enquiry:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: AppButtons.customDropDownButtonFormField(
                            items: cubit.enquirySelectType,
                            hintText: 'Select',
                            onChanged: (value) =>
                                cubit.enquiryTypeChangeChange(value),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Full Name',
                      controller: fullNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Email',
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Write your query suggestion/complaints',
                      controller: contentController,
                      maxLines: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50.sp),
                    BuildCondition(
                      condition:
                          state is! InsertComplaintsAndSuggestionLoadingState,
                      fallback: (context) => AppItems.customIndicator(),
                      builder: (context) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        fontSize: 14.sp,
                        color: ConstColors.kPrimaryColor,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.insertComplaintsAndSuggestion(
                              fullName: fullNameController.text,
                              content: contentController.text,
                              email: emailController.text,
                            );

                            await NotificationServices.sendNotificationToTopic(
                              topic: ConstText.cusCompAndSug,
                              title: 'Employee ${cubit.enquiryTypeValue}',
                              body: contentController.text,
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
