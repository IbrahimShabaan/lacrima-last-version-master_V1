import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/employee/business_logic/employee_states.dart';

class EmployeeLogin extends StatelessWidget {
  EmployeeLogin({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = EmployeeCubit.get(context);
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {
        if (state is EmployeeSignInSuccessState) {
          cubit.getEmployeeData(state.empId);
          cubit.getSalaryEmployee(
              year: DateTime.now().year, empId: state.empId);
          ConstText.employeeId = state.empId;
        }
      },
      builder: (context, state) {
        var cubit = EmployeeCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: [
                  SizedBox(height: 80.sp),
                  AppItems.customAppLogo(),
                  SizedBox(height: 15.sp),
                  AppItems.customText(
                    'Login as Lacrima Employee',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 30.sp),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppItems.customTextField(
                          hintText: 'id',
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: idController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Password',
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is required';
                            } else if (value.length < 6) {
                              return 'weak password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 50.sp),
                        BuildCondition(
                          condition: state is! EmployeeSignInLoadingState,
                          fallback: (context) => AppItems.customIndicator(),
                          builder: (context) => AppButtons.customElevatedButton(
                            text: 'Login',
                            color: ConstColors.kPrimaryColor,
                            fontSize: 14.sp,
                            elevation: 5,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.loginValidate(
                                  context: context,
                                  empId: idController.text.toLowerCase().trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 130.sp),
                  Row(
                    children: [
                      const Icon(Icons.info_outline),
                      SizedBox(width: 5.sp),
                      Expanded(
                        child: AppItems.customText(
                          'if you haven\'t id and password please contact your administrator',
                          fontSize: 11.sp,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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
