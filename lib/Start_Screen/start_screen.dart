import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/employee/presentation/screens/auth/emp_login.dart';
import 'package:lacrima/customer/presentation/screens/auth/customer_login.dart';
import 'package:lacrima/guest/presentation/screens/layout/guest_layout_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          children: [
            SizedBox(height: 80.sp),
            AppItems.customAppLogo(),
            SizedBox(height: 20.sp),
            AppItems.customText(
              'Welcome to Lacrima dairy industrial ltd',
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 15.sp),
            AppItems.customText(
              'Connect with Lacrima for your personalized plan to get inspired in the kitchen',
              fontSize: 12.sp,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.sp),
            AppButtons.customElevatedButton(
              text: 'Continue as employee',
              elevation: 5,
              width: 200.sp,
              fontSize: 12.sp,
              borderRadius: 20,
              color: ConstColors.kPrimaryColor,
              onPressed: () {
                navigateTo(context, EmployeeLogin());
              },
            ),
            SizedBox(height: 20.sp),
            AppButtons.customElevatedButton(
              text: 'Continue as customer',
              elevation: 5,
              width: 200.sp,
              fontSize: 12.sp,
              borderRadius: 20,
              color: ConstColors.kPrimaryColor,
              onPressed: () => navigateTo(context,  CustomerLogin()),
            ),
            const Spacer(),
            AppButtons.customTextButton(
              text: 'Continue as guest',
              fontSize: 11.sp,
              color: ConstColors.kPrimaryColor,
              onPressed: () => navigateTo(context, const GuestLayoutScreen()),
            ),
            SizedBox(height: 10.sp),
          ],
        ),
      ),
    );
  }
}
