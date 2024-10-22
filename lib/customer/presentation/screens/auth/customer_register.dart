import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:lacrima/customer/presentation/widgets/widgets.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';
import 'package:lacrima/customer/business_logic/customer_states.dart';
import 'package:lacrima/customer/presentation/screens/auth/customer_login.dart';
import 'package:lacrima/customer/presentation/screens/layout/customer_layout_screen.dart';

class CustomerRegister extends StatelessWidget {
  CustomerRegister({
    Key? key,
    required this.proTitle,
  }) : super(key: key);

  final List<dynamic> proTitle;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdayController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final companyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = CustomerCubit.get(context);
    var items = proTitle.map((title) => MultiSelectItem(title, title)).toList();
    List<dynamic> interestValue = [];
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is InsertCustomerSuccessState) {
          cubit.getCustomerData(id: state.id);
          navigateAndFinish(context, CustomerLayoutScreen(id: state.id));
          cubit.changeCloseImage();
          cubit.customerToken(state.id);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 50.sp, left: 8.sp, right: 8.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.sp),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 57.sp,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          radius: 55.sp,
                          backgroundColor: Colors.white,
                          backgroundImage: cubit.profileImage == null
                              ? AssetImage(ConstIcons.placeholder)
                              : FileImage(cubit.profileImage!) as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 3.sp,
                        right: 2.sp,
                        child: CircleAvatar(
                          radius: 16.sp,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            alignment: Alignment.center,
                            icon: Icon(Icons.camera_alt,
                                size: 18.sp, color: Colors.white),
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  contentPadding: EdgeInsets.all(2.sp),
                                  content: SizedBox(
                                    height: 80.sp,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          TextButton.icon(
                                            label: Text(
                                              'Camera',
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            icon: Icon(Icons.camera_alt,
                                                size: 18.sp),
                                            style: TextButton.styleFrom(
                                              foregroundColor: ConstColors.kPrimaryColor,
                                            ),
                                            onPressed: () {
                                              cubit.pickedImage(
                                                  ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton.icon(
                                            label: Text(
                                              'Gallery',
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            icon:
                                            Icon(Icons.camera, size: 18.sp),
                                            style: TextButton.styleFrom(
                                                foregroundColor:
                                                ConstColors.kPrimaryColor),
                                            onPressed: () {
                                              cubit.pickedImage(
                                                  ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.sp),
                  Text(
                    'SignUp For Free',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppItems.customTextField(
                          hintText: 'First Name',
                          keyboardType: TextInputType.name,
                          controller: firstNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Last Name',
                          controller: lastNameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
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
                          hintText: 'Phone',
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Company Name',
                          controller: companyNameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'birthday',
                          readOnly: true,
                          keyboardType: TextInputType.datetime,
                          controller: birthdayController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                          onTap: () async {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.parse('1900-12-31'),
                              lastDate: DateTime.now(),
                              initialDatePickerMode: DatePickerMode.day,
                              initialEntryMode:
                              DatePickerEntryMode.calendarOnly,
                            ).then((value) {
                              birthdayController.text =
                                  DateFormat.yMMMd().format(value!);
                            }).catchError((e) {});
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Username',
                          controller: userNameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppButtons.customMultiSelectDialogField(
                          items: items,
                          onConfirm: (value) => interestValue = value,
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Password',
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            } else if (value.length < 6) {
                              return 'weak password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomerItems.customRadioButton(
                              text: 'Male',
                              value: 'Male',
                              groupValue: cubit.selectGender,
                              onChanged: (value) =>
                                  cubit.changeRadioButton(value),
                            ),
                            CustomerItems.customRadioButton(
                              text: 'Female',
                              value: 'Female',
                              groupValue: cubit.selectGender,
                              onChanged: (value) =>
                                  cubit.changeRadioButton(value),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.sp),
                        BuildCondition(
                          condition: state is! CustomerSignUpLoadingState,
                          fallback: (context) => AppItems.customIndicator(),
                          builder: (context) => AppButtons.customElevatedButton(
                            text: 'Register',
                            elevation: 5,
                            fontSize: 14.sp,
                            color: ConstColors.kPrimaryColor,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (cubit.profileImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: AppItems.customText(
                                        'must be upload Image',
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  );
                                } else {
                                  await cubit.customerSignUp(
                                    context: context,
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    birthday: birthdayController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    userName: userNameController.text.trim(),
                                    companyName:
                                    companyNameController.text.trim(),
                                    interest: [...interestValue],
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(fontSize: 11.sp),
                            ),
                            AppButtons.customTextButton(
                              text: 'Login now',
                              fontSize: 11.sp,
                              color: ConstColors.kPrimaryColor,
                              onPressed: () {
                                navigateTo(context, CustomerLogin());
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
