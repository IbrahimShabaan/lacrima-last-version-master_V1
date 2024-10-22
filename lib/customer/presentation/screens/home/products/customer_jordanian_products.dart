import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'customer_product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/customer/presentation/widgets/widgets.dart';

class CustomerJordanianProducts extends StatelessWidget {
  const CustomerJordanianProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  return CustomerItems.customProductsItem(
                    data: data,
                    onTap: () =>
                        navigateTo(context, CustomerProductDetails(data: data)),
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
