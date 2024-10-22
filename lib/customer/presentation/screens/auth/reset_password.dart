import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';
import 'package:lacrima/customer/business_logic/customer_states.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is CustomerResetPasswordSuccessState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 5),
              content: AppItems.customText(
                'Sent successfully, check your email',
                textAlign: TextAlign.center,
                fontSize: 14.sp,
              ),
              dismissDirection: DismissDirection.up,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 120.sp, left: 8.sp, right: 8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppItems.customAppLogo(),
                  SizedBox(height: 30.sp),
                  AppItems.customText(
                    'reset password your account\n please enter email this your account',
                    textAlign: TextAlign.center,
                    fontSize: 14.sp,
                  ),
                  SizedBox(height: 20.sp),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppItems.customTextField(
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is required';
                            } else if (!value.contains('@')) {
                              return 'invalid email';
                            } else if (!value.contains('.com')) {
                              return 'invalid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 60.sp),
                        BuildCondition(
                          condition:
                              state is! CustomerResetPasswordLoadingState,
                          fallback: (context) => CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            color: ConstColors.kPrimaryColor,
                          ),
                          builder: (context) => AppButtons.customElevatedButton(
                            text: 'Send',
                            fontSize: 14.sp,
                            elevation: 5,
                            color: ConstColors.kPrimaryColor,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.resetPassword(emailController.text);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
