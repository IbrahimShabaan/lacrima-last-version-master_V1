import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/admin/business_logic/product/product_cubit.dart';
import 'package:lacrima/admin/presentation/screens/products/admin_edit_product.dart';
import 'package:lacrima/admin/presentation/screens/products/admin_product_details.dart';

class AdminJordanianProducts extends StatelessWidget {
  const AdminJordanianProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Jordanian Products'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.sp),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .where('prodNationality', isEqualTo: 'Jordanian')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: AppItems.customIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map(
                (DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return AdminItems.customProductsItem(
                    data: data,
                    onPressedEdit: () =>
                        navigateTo(context, AdminEditProductScreen(data: data)),
                    context: context,
                    onPressedDetails: () =>
                        navigateTo(context, AdminProductDetails(data: data)),
                    onPressedNo: () => Navigator.pop(context),
                    onPressedYes: () async {
                      await cubit
                          .deleteProductImageFromStorage(data['prodImage']);
                      cubit.deleteProduct(
                        productId: data['prodId'],
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
