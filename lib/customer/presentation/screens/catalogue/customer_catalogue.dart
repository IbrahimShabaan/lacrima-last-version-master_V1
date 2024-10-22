import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';

class CustomerCatalogue extends StatelessWidget {
  const CustomerCatalogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = CustomerCubit.get(context);
    var url =
        'https://drive.google.com/file/d/1RHTFPjsEoTk52MJEiRc9TxyT69bAUO7N/view?fbclid=IwAR1OfHc-tHbhH3cEj0JH3joPiEuvK5RzDuxs7IM1ohegD9HccS01ZFuLkwY';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppItems.customAppLogo(),
            SizedBox(height: 30.sp),
            AppItems.customText(
              'Browse Product Catalogue',
              fontSize: 16.sp,
              fontColor: ConstColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 30.sp),
            AppButtons.customElevatedButton(
              text: 'Our Catalogue',
              fontSize: 12.sp,
              width: 200.sp,
              borderRadius: 20,
              color: ConstColors.kPrimaryColor,
              onPressed: () => cubit.openUrl(url),
            ),
            SizedBox(height: 10.sp),
            AppButtons.customElevatedButton(
              text: 'Download Catalogue',
              borderRadius: 20,
              width: 200.sp,
              fontSize: 12.sp,
              color: ConstColors.kPrimaryColor,
              onPressed: () => cubit.openUrl(url),
            ),
          ],
        ),
      ),
    );
  }
}
