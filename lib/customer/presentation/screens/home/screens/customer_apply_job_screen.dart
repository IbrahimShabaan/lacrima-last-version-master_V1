import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';
import 'package:lacrima/customer/business_logic/customer_states.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';

class CustomerJobScreen extends StatelessWidget {
  CustomerJobScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = CustomerCubit.get(context);
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is InsertJobSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppItems.customText(
                'Successfully',
                fontSize: 12.sp,
              ),
            ),
          );
          Navigator.pop(context);
          cubit.clearFileSelect();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Job'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
              onPressed: () {
                Navigator.pop(context);
                cubit.clearFileSelect();
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    AppItems.customAppLogo(),
                    SizedBox(height: 30.sp),
                    AppItems.customTextField(
                      hintText: 'Your name',
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Your title',
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Your phone',
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Your Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.sp),
                      child: Row(
                        children: [
                          if (cubit.file != null)
                            Container(
                              width: 180.sp,
                              padding: EdgeInsets.only(left: 15.sp),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30.sp),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 125.sp,
                                    child: Text(
                                      cubit.paths!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: ConstColors.kPrimaryColor,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => cubit.clearFileSelect(),
                                  ),
                                ],
                              ),
                            ),
                          if (cubit.file == null)
                            Text(
                              'Attachment your CV:',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                              ),
                            ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: ConstColors.kPrimaryColor,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.picture_as_pdf_rounded,
                                  size: 18.sp),
                              color: Colors.white,
                              onPressed: () async => cubit.pickedFile(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (cubit.file != null) SizedBox(height: 10.sp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Your job required:',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 5.sp),
                          AppButtons.customDropDownButtonFormField(
                            hintText: 'Select',
                            menuMaxHeight: double.infinity,
                            margin: EdgeInsets.all(0.sp),
                            contentPadding: EdgeInsets.all(10.sp),
                            onChanged: (value) => cubit.jobChange(value),
                            items: cubit.jobs,
                            fontSize: 13.sp,
                            validator: (value) {
                              if (value == null) {
                                return 'Section is require';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.sp),
                    BuildCondition(
                      condition: state is! InsertJobLoadingState,
                      fallback: (context) => CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: ConstColors.kPrimaryColor,
                      ),
                      builder: (context) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        fontSize: 13.sp,
                        elevation: 5,
                        color: ConstColors.kPrimaryColor,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (cubit.file != null) {
                              await cubit.insertJob(
                                name: nameController.text,
                                title: titleController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                              );
                              await NotificationServices
                                  .sendNotificationToTopic(
                                topic: ConstText.job,
                                title: 'Job By Customer',
                                body: nameController.text +
                                    ':' +
                                    emailController.text,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: AppItems.customText(
                                    'most be upload resume',
                                    fontSize: 12.sp,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.sp),
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
