import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/admin/presentation/screens/products/admin_add_product_screen.dart';
import 'package:lacrima/admin/presentation/screens/products/admin_bulgarian_products.dart';
import 'package:lacrima/admin/presentation/screens/products/admin_jordanian_products.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppItems.customAppLogo(),
            SizedBox(height: 40.sp),
            AppButtons.customElevatedButton(
              text: 'Jordanian Products',
              color: ConstColors.kPrimaryColor,
              fontSize: 14.sp,
              height: 40.sp,
              elevation: 5,
              onPressed: () =>
                  navigateTo(context, const AdminJordanianProducts()),
            ),
            SizedBox(height: 20.sp),
            AppButtons.customElevatedButton(
              text: 'Bulgarian Products',
              color: ConstColors.kPrimaryColor,
              fontSize: 14.sp,
              elevation: 5,
              onPressed: () =>
                  navigateTo(context, const AdminBulgarianProducts()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.post_add_rounded),
        backgroundColor: ConstColors.kPrimaryColor,
        onPressed: () => navigateTo(context, AddProductScreen()),
      ),
    );
  }
}
