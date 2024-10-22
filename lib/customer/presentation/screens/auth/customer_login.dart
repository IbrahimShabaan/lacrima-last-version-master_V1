import 'customer_register.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/local/cache_helper.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';
import 'package:lacrima/customer/business_logic/customer_states.dart';
import 'package:lacrima/customer/presentation/screens/auth/reset_password.dart';
import 'package:lacrima/customer/presentation/screens/layout/customer_layout_screen.dart';

class CustomerLogin extends StatelessWidget {
   CustomerLogin({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = CustomerCubit.get(context);
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is CustomerSignInSuccessState) {
          cubit.getCustomerData(id: state.id);
          navigateAndFinish(context, CustomerLayoutScreen(id: state.id));
          CacheHelper.setListOfData('userData',
              id: state.id, section: 'Customer');
          cubit.customerToken(state.id);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 120.sp, left: 8.sp, right: 8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppItems.customAppLogo(),
                  SizedBox(height: 30.sp),
                  Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Password',
                          obscureText: true,
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is required';
                            } else if (value.length < 6) {
                              return 'weak password';
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AppButtons.customTextButton(
                            text: 'Forget Password?',
                            fontSize: 12.sp,
                            padding: EdgeInsets.all(4.sp),
                            color: ConstColors.kPrimaryColor,
                            hoverColor:
                                ConstColors.kPrimaryColor.withOpacity(0.3),
                            decoration: TextDecoration.underline,
                            onPressed: () =>
                                navigateTo(context, ResetPassword()),
                          ),
                        ),
                        SizedBox(height: 40.sp),
                        BuildCondition(
                          condition: state is! CustomerSignInLoadingState,
                          fallback: (context) => AppItems.customIndicator(),
                          builder: (context) => AppButtons.customElevatedButton(
                            text: 'Login',
                            fontSize: 14.sp,
                            elevation: 5,
                            color: ConstColors.kPrimaryColor,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.customerSignIn(
                                  context: context,
                                  email:
                                      emailController.text.trim().toLowerCase(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(fontSize: 11.sp),
                            ),
                            AppButtons.customTextButton(
                              text: 'Register now',
                              fontSize: 11.sp,
                              color: ConstColors.kPrimaryColor,
                              decoration: TextDecoration.underline,
                              hoverColor:
                                  ConstColors.kPrimaryColor.withOpacity(0.3),
                              onPressed: () async {
                                List<dynamic> proTitle = [];
                                await FirebaseFirestore.instance
                                    .collection('Products')
                                    .get()
                                    .then((event) {
                                  for (var element in event.docs) {
                                    proTitle.add(element.data()['prodTitle']);
                                  }
                                });
                                navigateTo(context,
                                    CustomerRegister(proTitle: proTitle));
                              },
                            ),
                          ],
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
