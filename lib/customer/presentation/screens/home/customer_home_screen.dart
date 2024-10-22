import 'package:lacrima/customer/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/customer/presentation/screens/home/screens/customer_t_a_c_screen.dart';
import 'package:lacrima/customer/presentation/screens/home/screens/customer_about_screen.dart';
import 'package:lacrima/customer/presentation/screens/home/screens/customer_contact_screen.dart';
import 'package:lacrima/customer/presentation/screens/home/screens/customer_feedback_screen.dart';
import 'package:lacrima/customer/presentation/screens/home/screens/customer_apply_job_screen.dart';
import 'package:lacrima/customer/presentation/screens/home/products/customer_bulgarian_products.dart';
import 'package:lacrima/customer/presentation/screens/home/products/customer_jordanian_products.dart';
import 'package:lacrima/customer/presentation/screens/home/screens/customer_privacy_policy_screen.dart';
import 'package:lacrima/customer/presentation/screens/complaints_and_suggestion/customer_complaints_and_suggestion_screen.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 65.sp,
        elevation: 0,
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(10.sp),
          children: [
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.sp),
                child: Align(child: AppItems.customAppLogo()),
              ),
            ),
            CustomerItems.customListTileItem(
              title: 'About',
              fontSize: 12.sp,
              iconSize: 20.sp,
              icon: Icons.read_more_sharp,
              onTap: () => navigateTo(context, const AboutScreen()),
            ),
            CustomerItems.customListTileItem(
              title: 'Give us Feedback',
              fontSize: 12.sp,
              iconSize: 20.sp,
              icon: Icons.feedback_outlined,
              onTap: () => navigateTo(context, CustomerFeedbackScreen()),
            ),
            CustomerItems.customListTileItem(
              title: 'Apply Job',
              fontSize: 12.sp,
              iconSize: 30.sp,
              icon: Icons.edit_note,
              onTap: () => navigateTo(context, CustomerJobScreen()),
            ),
            CustomerItems.customListTileItem(
              title: 'Contact us',
              fontSize: 12.sp,
              iconSize: 20.sp,
              icon: Icons.phone_in_talk,
              onTap: () => navigateTo(context, const ContactUs()),
            ),
            CustomerItems.customListTileItem(
              title: 'Privacy Policy',
              fontSize: 12.sp,
              iconSize: 20.sp,
              icon: Icons.privacy_tip_outlined,
              onTap: () => navigateTo(context, const PrivacyPolicyScreen()),
            ),
            CustomerItems.customListTileItem(
              title: 'Terms And Conditions',
              fontSize: 12.sp,
              iconSize: 20.sp,
              icon: Icons.library_books_outlined,
              onTap: () => navigateTo(context, const TermsAndConditions()),
            ),
            CustomerItems.customListTileItem(
              title: 'Send enquiry',
              fontSize: 12.sp,
              iconSize: 20.sp,
              icon: Icons.integration_instructions_outlined,
              onTap: () => navigateTo(context, CustomerAddCompOrSugScreen()),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50.sp),
            AppItems.customAppLogo(),
            SizedBox(height: 40.sp),
            AppButtons.customElevatedButton(
              text: 'Jordanian Products',
              color: ConstColors.kPrimaryColor,
              fontSize: 14.sp,
              height: 40.sp,
              elevation: 5,
              onPressed: () =>
                  navigateTo(context, const CustomerJordanianProducts()),
            ),
            SizedBox(height: 20.sp),
            AppButtons.customElevatedButton(
              text: 'Bulgarian Products',
              color: ConstColors.kPrimaryColor,
              fontSize: 14.sp,
              elevation: 5,
              onPressed: () =>
                  navigateTo(context, const CustomerBulgarianProducts()),
            ),
          ],
        ),
      ),
    );
  }
}
