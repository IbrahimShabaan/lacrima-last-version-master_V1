import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/guest/presentation/screens/products/guest_jordanian_products.dart';
import 'package:lacrima/guest/presentation/screens/products/guest_bulgarian_products.dart';

class GuestHomeScreen extends StatelessWidget {
  const GuestHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppItems.customAppLogo(),
            SizedBox(height: 80.sp),
            AppButtons.customElevatedButton(
              text: 'Jordanian Products',
              color: ConstColors.kPrimaryColor,
              fontSize: 12.sp,
              width: 200.sp,
              borderRadius: 20,
              elevation: 5,
              onPressed: () => navigateTo(context, const JordanianProducts()),
            ),
            SizedBox(height: 20.sp),
            AppButtons.customElevatedButton(
              text: 'Bulgarian Products',
              color: ConstColors.kPrimaryColor,
              fontSize: 12.sp,
              width: 200.sp,
              borderRadius: 20,
              elevation: 5,
              onPressed: () => navigateTo(context, const BulgarianProducts()),
            ),
          ],
        ),
      ),
    );
  }
}
