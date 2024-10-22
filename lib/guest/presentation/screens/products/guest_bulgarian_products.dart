import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/guest/presentation/widgets/widgets.dart';
import 'package:lacrima/guest/presentation/screens/products/guest_product_details.dart';

class BulgarianProducts extends StatelessWidget {
  const BulgarianProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Bulgarian Products'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.sp),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .where('prodNationality', isEqualTo: 'Bulgarian')
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
                  return GuestItems.customProductsItem(
                    data: data,
                    onTap: () =>
                        navigateTo(context, GuestProductDetails(data: data)),
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
