import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/HR/presentation/widgets/widgets.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/employee/business_logic/employee_states.dart';

class HRUpdateEmployeeScreen extends StatelessWidget {
  HRUpdateEmployeeScreen({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final educationController = TextEditingController();
  final hiringDateController = TextEditingController();
  final positionController = TextEditingController();
  final birthdayController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final departmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = EmployeeCubit.get(context);
    emailController.text = data['email'];
    firstNameController.text = data['firstName'];
    lastNameController.text = data['lastName'];
    addressController.text = data['address'];
    educationController.text = data['education'];
    hiringDateController.text = data['hiringDate'];
    positionController.text = data['position'];
    birthdayController.text = data['birthday'];
    phoneController.text = data['phone'];
    userNameController.text = data['userName'];
    departmentController.text = data['department'];
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {
        if (state is UpdateEmployeeSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppItems.customText(
                'Successfully',
                fontSize: 12.sp,
              ),
            ),
          );
          Navigator.pop(context);
          cubit.changeCloseImage();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Edit Employee'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
              onPressed: () {
                cubit.changeCloseImage();
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
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
                              ? NetworkImage(data['image'])
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
                                  title: Text(
                                    'Select Image',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  content: SizedBox(
                                    height: 80.sp,
                                    child: Column(
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
                                          icon: Icon(Icons.camera, size: 18.sp),
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
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.sp),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppItems.customTextField(
                          hintText: 'First name',
                          controller: firstNameController,
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
                          hintText: 'Last Name',
                          controller: lastNameController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Section:',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                child: AppButtons.customDropDownButtonFormField(
                                    hintText: 'Select',
                                    onChanged: (value) =>
                                        cubit.sectionChange(value),
                                    items: cubit.section,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Section is require';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Position',
                          controller: positionController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'education',
                          controller: educationController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Address',
                          controller: addressController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Hiring date',
                          controller: hiringDateController,
                          keyboardType: TextInputType.text,
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
                              firstDate: DateTime.parse('1900-01-01'),
                              lastDate: DateTime.parse('2050-12-31'),
                              initialDatePickerMode: DatePickerMode.day,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            ).then((value) {
                              hiringDateController.text =
                                  DateFormat.yMMMd().format(value!);
                            }).catchError((e) {});
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
                          hintText: 'birthday',
                          controller: birthdayController,
                          keyboardType: TextInputType.datetime,
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
                              firstDate: DateTime.parse('1900-01-01'),
                              lastDate: DateTime.parse('2050-12-31'),
                              initialDatePickerMode: DatePickerMode.day,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            ).then((value) {
                              hiringDateController.text =
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HRItems.customRadioButton(
                              text: 'Male',
                              value: 'Male',
                              groupValue: cubit.selectGender,
                              onChanged: (value) =>
                                  cubit.changeRadioButton(value),
                            ),
                            HRItems.customRadioButton(
                              text: 'Female',
                              value: 'Female',
                              groupValue: cubit.selectGender,
                              onChanged: (value) =>
                                  cubit.changeRadioButton(value),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
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
                        SizedBox(height: 30.sp),
                        BuildCondition(
                          condition: state is! UpdateEmployeeLoadingState,
                          fallback: (context) => AppItems.customIndicator(),
                          builder: (context) => AppButtons.customElevatedButton(
                            text: 'Submit',
                            elevation: 5,
                            fontSize: 14.sp,
                            width: 150.sp,
                            color: ConstColors.kPrimaryColor,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.updateEmployee(
                                  id: data['empId'],
                                  email: emailController.text,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  address: addressController.text,
                                  education: educationController.text,
                                  hiringDate: hiringDateController.text,
                                  position: positionController.text,
                                  birthday: birthdayController.text,
                                  phone: phoneController.text,
                                  userName: userNameController.text,
                                  department: departmentController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20.sp),
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
