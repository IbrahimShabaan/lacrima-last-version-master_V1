import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/sales/presentation/widgets/widgets.dart';
import 'package:lacrima/sales/presentation/screens/orders/sales_edit_order.dart';
import 'package:lacrima/sales/presentation/screens/orders/sales_order_details.dart';

class SalesOrderSearch extends SearchDelegate {
  SalesOrderSearch()
      : super(
            searchFieldLabel: 'Customer Name',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            searchFieldStyle:
                TextStyle(fontSize: 14.sp, color: Colors.grey.shade400));
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
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
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var cubit = SalesCubit.get(context);
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('Orders')
          .where('customerName', isEqualTo: query)
          .get(),
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
        return ListView(
          children: snapshot.data!.docs.map(
            (DocumentSnapshot doc) {
              Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
              return SalesItems.orderItemsHome(
                context: context,
                data: data,
                onPressedNo: () => Navigator.pop(context),
                onPressedEdit: () =>
                    navigateTo(context, SalesEditOrderScreen(data: data)),
                onPressedYes: () {
                  cubit.deleteOrder(id: data['id']);
                  Navigator.pop(context);
                },
                onPressedDetails: () =>
                    navigateTo(context, SalesOrderDetailsScreen(data: data)),
              );
            },
          ).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var cubit = SalesCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
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
              data['customerName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              data['customerName']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()));
          return ListView(
              children: results.map(
            (DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return SalesItems.orderItemsHome(
                context: context,
                data: data,
                onPressedNo: () => Navigator.pop(context),
                onPressedEdit: () =>
                    navigateTo(context, SalesEditOrderScreen(data: data)),
                onPressedYes: () {
                  cubit.deleteOrder(id: data['id']);
                  Navigator.pop(context);
                },
                onPressedDetails: () =>
                    navigateTo(context, SalesOrderDetailsScreen(data: data)),
              );
            },
          ).toList());
        },
      ),
    );
  }
}
