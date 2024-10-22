import 'package:lacrima/guest/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/guest/business_logic/guest_cubit.dart';
import 'package:lacrima/guest/business_logic/guest_states.dart';
import 'package:lacrima/customer/presentation/screens/auth/customer_login.dart';
import 'package:lacrima/guest/presentation/screens/profile/screens/guest_t_a_c_screen.dart';
import 'package:lacrima/guest/presentation/screens/profile/screens/guest_about_screen.dart';
import 'package:lacrima/guest/presentation/screens/profile/screens/guest_contact_screen.dart';
import 'package:lacrima/guest/presentation/screens/profile/screens/guest_feedback_screen.dart';
import 'package:lacrima/guest/presentation/screens/profile/screens/guest_apply_job_screen.dart';
import 'package:lacrima/guest/presentation/screens/profile/screens/guest_privacy_policy_screen.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuestCubit, GuestStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GuestCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 50.sp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 52.sp,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 50.sp,
                      backgroundColor: Colors.white,
                      child: Image.asset(ConstIcons.placeholder),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  AppItems.customText(
                    'Sign in to manage your Lacrima account',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.sp),
                  AppButtons.customElevatedButton(
                    text: 'Sign in Now',
                    width: 80.sp,
                    elevation: 5,
                    fontSize: 14.sp,
                    color: ConstColors.kPrimaryColor,
                    onPressed: () => navigateTo(context, CustomerLogin()),
                  ),
                  SizedBox(height: 20.sp),
                  AppItems.customText(
                    'Want to Sign Up with Lacrima',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 30.sp),
                  GuestItems.customProfileItem(
                    text: 'About',
                    onTap: () => navigateTo(context, const AboutScreen()),
                  ),
                  SizedBox(height: 5.sp),
                  GuestItems.customProfileItem(
                    text: 'Exhibition Portal',
                    onTap: () => navigateTo(context, CustomerLogin()),
                  ),
                  SizedBox(height: 5.sp),
                  GuestItems.customProfileItem(
                    text: 'Give Us Feedback',
                    onTap: () => navigateTo(context, FeedbackScreen()),
                  ),
                  SizedBox(height: 5.sp),
                  GuestItems.customProfileItem(
                    text: 'Apply Job',
                    onTap: () => navigateTo(context, GuestJobScreen()),
                  ),
                  SizedBox(height: 5.sp),
                  GuestItems.customProfileItem(
                    text: 'Contact us',
                    onTap: () => navigateTo(context, const ContactUs()),
                  ),
                  SizedBox(height: 5.sp),
                  GuestItems.customProfileItem(
                    text: 'Privacy Policy',
                    onTap: () =>
                        navigateTo(context, const PrivacyPolicyScreen()),
                  ),
                  SizedBox(height: 5.sp),
                  GuestItems.customProfileItem(
                    text: 'Terms And Conditions',
                    onTap: () =>
                        navigateTo(context, const TermsAndConditions()),
                  ),
                  SizedBox(height: 30.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset(
                          ConstIcons.facebook,
                          fit: BoxFit.cover,
                          height: 50.sp,
                        ),
                        onPressed: () async => await cubit.openUrl(
                            'https://www.facebook.com/103653561762989/posts/pfbid01RBufadZEvKv8bD7SRYHNgUBmhJ5ZFYYUy3PGi3oWKCJxva3mHyYyabscYk7bsg6l/?d=n'),
                      ),
                      SizedBox(width: 15.sp),
                      IconButton(
                        icon: Image.asset(
                          ConstIcons.instagram,
                          fit: BoxFit.cover,
                          height: 50.sp,
                        ),
                        onPressed: () async => await cubit.openUrl(
                            'https://instagram.com/lacrima.middleeast?igshid=YmMyMTA2M2Y='),
                      ),
                      SizedBox(width: 15.sp),
                      IconButton(
                        icon: Image.asset(
                          ConstIcons.linkedin,
                          fit: BoxFit.fill,
                          height: 50.sp,
                        ),
                        onPressed: () async => await cubit.openUrl(
                            'https://www.linkedin.com/company/l%C3%A0crima/'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
