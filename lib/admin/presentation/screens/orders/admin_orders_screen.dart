import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/admin/presentation/screens/orders/admin_add_orders.dart';
import 'package:lacrima/admin/presentation/screens/orders/admin_edit_order.dart';
import 'package:lacrima/admin/presentation/screens/orders/admin_order_details.dart';
import 'package:lacrima/admin/presentation/screens/orders/admin_search_order.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SalesCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Orders'),
        actions: [
          SizedBox(width: 5.sp),
          IconButton(
            icon: const Icon(Icons.content_paste_search),
            color: ConstColors.kPrimaryColor,
            onPressed: () async =>
                showSearch(context: context, delegate: AdminOrderSearch()),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Orders')
              .orderBy('issueDate')
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
                  return AdminItems.orderItem(
                    context: context,
                    data: data,
                    onPressedNo: () => Navigator.pop(context),
                    onPressedEdit: () =>
                        navigateTo(context, AdminEditOrderScreen(data: data)),
                    onPressedYes: () {
                      cubit.deleteOrder(id: data['id']);
                      Navigator.pop(context);
                    },
                    onPressedDetails: () =>
                        navigateTo(context, OrderDetailsScreen(data: data)),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstColors.kPrimaryColor,
        child: const Icon(Icons.add_shopping_cart),
        onPressed: () async {
          List<dynamic> allCustomerName = [];
          await FirebaseFirestore.instance
              .collection('Customers')
              .get()
              .then((event) {
            for (var element in event.docs) {
              allCustomerName.add(element.data()['userName']);
            }
          });
          await cubit.getAllProducts();
          navigateTo(
              context,
              AdminAddOrderScreen(
                allCustomerName: [...allCustomerName],
              ));
        },
      ),
    );
  }
}
