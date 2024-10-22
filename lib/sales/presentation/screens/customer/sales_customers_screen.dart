import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/sales/presentation/widgets/widgets.dart';
import 'package:lacrima/sales/presentation/screens/customer/sales_customer_info.dart';
import 'package:lacrima/sales/presentation/screens/customer/sales_customer_search.dart';

class SalesCustomerScreen extends StatelessWidget {
  const SalesCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: AppButtons.customButtonBack(context),
        title: const Text('Customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_search_rounded),
            color: ConstColors.kPrimaryColor,
            onPressed: () =>
                showSearch(context: context, delegate: SalesCustomerSearch()),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Customers').snapshots(),
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
                return SalesItems.customerItem(
                  data: data,
                  margin:
                      EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                  onTap: () =>
                      navigateTo(context, SalesCustomerInfo(data: data)),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
