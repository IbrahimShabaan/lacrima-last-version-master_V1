import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/employee/business_logic/employee_states.dart';

class AddEmployeeScreen extends StatelessWidget {
  AddEmployeeScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final empIdController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final lastNameController = TextEditingController();
  final positionController = TextEditingController();
  final birthdayController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final educationController = TextEditingController();
  final hiringDateController = TextEditingController();
  final departmentController = TextEditingController();
  final totalVacationsController = TextEditingController();
  final lastYearVacationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = EmployeeCubit.get(context);
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {
        if (state is InsertEmployeeSuccessState) {
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
            title: const Text('Add Employee'),
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
                                  contentPadding: EdgeInsets.zero,
                                  content: SizedBox(
                                    height: 80.sp,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton.icon(
                                            label: Text(
                                              'Gallery',
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            icon:
                                                Icon(Icons.camera, size: 18.sp),
                                            style: TextButton.styleFrom(
                                                foregroundColor: ConstColors.kPrimaryColor),
                                            onPressed: () {
                                              cubit.pickedImage(
                                                  ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                          ),
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
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppItems.customTextField(
                          hintText: 'Employee ID',
                          controller: empIdController,
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
                        SizedBox(height: 10.sp),
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
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Position',
                          keyboardType: TextInputType.text,
                          controller: positionController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.sp),
                        AppItems.customTextField(
                          hintText: 'Department',
                          keyboardType: TextInputType.text,
                          controller: departmentController,
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
                          keyboardType: TextInputType.text,
                          controller: educationController,
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
                          keyboardType: TextInputType.text,
                          controller: addressController,
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
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          controller: hiringDateController,
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
                              firstDate: DateTime(DateTime.now().year - 100),
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
                          hintText: 'Phone',
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
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
                              firstDate: DateTime(DateTime.now().year - 100),
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
                        AppItems.customTextField(
                          hintText: 'Total Vacations',
                          controller: totalVacationsController,
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
                          hintText: 'Last Year Vacations',
                          controller: lastYearVacationsController,
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
                          hintText: 'Password',
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is required';
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
                            AdminItems.customRadioButton(
                              text: 'Male',
                              value: 'Male',
                              groupValue: cubit.selectGender,
                              onChanged: (value) =>
                                  cubit.changeRadioButton(value),
                            ),
                            AdminItems.customRadioButton(
                              text: 'Female',
                              value: 'Female',
                              groupValue: cubit.selectGender,
                              onChanged: (value) =>
                                  cubit.changeRadioButton(value),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.sp),
                        BuildCondition(
                          condition: state is! InsertEmployeeLoadingState,
                          fallback: (context) => AppItems.customIndicator(),
                          builder: (context) => AppButtons.customElevatedButton(
                            text: 'Submit',
                            elevation: 5,
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
                                  await cubit.insertEmployee(
                                    id: empIdController.text.toLowerCase(),
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    userName: userNameController.text,
                                    phone: phoneController.text,
                                    hiringDate: hiringDateController.text,
                                    birthday: birthdayController.text,
                                    address: addressController.text,
                                    education: educationController.text,
                                    position: positionController.text,
                                    department: departmentController.text,
                                    password: passwordController.text,
                                    totalVacations: double.parse(
                                        totalVacationsController.text),
                                    lastYearVacations: double.parse(
                                        lastYearVacationsController.text),
                                  );
                                  if (state is InsertEmployeeSuccessState) {
                                    await cubit.insertSalariesEmployee(
                                      year: DateTime.now().year,
                                      empId: empIdController.text,
                                    );
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.sp),
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
