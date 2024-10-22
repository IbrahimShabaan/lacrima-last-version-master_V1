import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/admin/presentation/screens/customers/customer_info.dart';

class AdminCustomerSearch extends SearchDelegate {
  @override
  AdminCustomerSearch()
      : super(
          searchFieldLabel: 'name',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade400,
          ),
        );
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('Customers')
          .where('userName', isEqualTo: query)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: AppItems.customIndicator());
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return AdminItems.customerItem(
              data: data,
              margin: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 4.sp),
              onTap: () => navigateTo(context, CustomerInfo(data: data)),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Customers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AppItems.customIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Empty'));
          }
          final results = snapshot.data!.docs.where((data) =>
              data['userName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              data['userName']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()));
          return ListView(
              children: results.map(
            (DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return AdminItems.customerItem(
                data: data,
                margin: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 4.sp),
                onTap: () => navigateTo(context, CustomerInfo(data: data)),
              );
            },
          ).toList());
        },
      ),
    );
  }
}
