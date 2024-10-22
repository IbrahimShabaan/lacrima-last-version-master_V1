import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/guest/business_logic/guest_cubit.dart';
import 'package:lacrima/guest/business_logic/guest_states.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuestCubit, GuestStates>(
      listener: (context, state) {
        if (state is InsertFeedbackSuccessState) {
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
        var cubit = GuestCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('New Feedback'),
            leading: AppButtons.customButtonBack(context),
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
                    AppItems.customTextField(
                      hintText: 'First Name',
                      controller: firstNameController,
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
                      hintText: 'Last Name',
                      controller: lastNameController,
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
                      hintText: 'Email',
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
                    AppItems.customTextField(
                      hintText: 'Please Type Your Feedback',
                      maxLines: 10,
                      controller: contentController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50.sp),
                    BuildCondition(
                      condition: state is! InsertFeedbackLoadingState,
                      fallback: (context) => AppItems.customIndicator(),
                      builder: (context) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        fontSize: 14.sp,
                        color: ConstColors.kPrimaryColor,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.insertFeedback(
                              email: emailController.text,
                              content: contentController.text,
                              lastName: lastNameController.text,
                              firstName: firstNameController.text,
                            );

                            await NotificationServices.sendNotificationToTopic(
                              topic: ConstText.feedback,
                              title: 'Guest FeedBack',
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
