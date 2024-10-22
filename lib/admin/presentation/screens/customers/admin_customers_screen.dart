import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/admin/presentation/screens/customers/customer_info.dart';
import 'package:lacrima/admin/presentation/screens/customers/admin_customer_search.dart';
import 'package:sizer/sizer.dart';

class AdminCustomerScreen extends StatelessWidget {
  const AdminCustomerScreen({Key? key}) : super(key: key);

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
                showSearch(context: context, delegate: AdminCustomerSearch()),
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
                return AdminItems.customerItem(
                  data: data,
                  margin:
                      EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                  onTap: () => navigateTo(context, CustomerInfo(data: data)),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
