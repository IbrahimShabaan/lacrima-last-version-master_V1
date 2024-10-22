import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/sales/presentation/widgets/widgets.dart';
import 'package:lacrima/sales/presentation/screens/orders/sales_add_orders.dart';
import 'package:lacrima/sales/presentation/screens/orders/sales_edit_order.dart';
import 'package:lacrima/sales/presentation/screens/orders/sales_search_order.dart';
import 'package:lacrima/sales/presentation/screens/orders/sales_order_details.dart';
import 'package:lacrima/sales/presentation/screens/requests/sales_requests_screen.dart';
import 'package:lacrima/sales/presentation/screens/feedback/sales_feedback_screen.dart';
import 'package:lacrima/sales/presentation/screens/customer/sales_customers_screen.dart';
import 'package:lacrima/sales/presentation/screens/announcement/sales_announcement_screen.dart';
import 'package:lacrima/sales/presentation/screens/customer/sales_customer_complaint_screen.dart';
import 'package:lacrima/sales/presentation/screens/customer/sales_customer_suggestion_screen.dart';
import 'package:lacrima/sales/presentation/screens/complaints_and_suggestion/sales_comp_sug_screen.dart';

class SalesOrdersScreen extends StatelessWidget {
  const SalesOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SalesCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.content_paste_search),
            color: ConstColors.kPrimaryColor,
            onPressed: () => showSearch(
              context: context,
              delegate: SalesOrderSearch(),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.sp),
                child: Align(child: AppItems.customAppLogo()),
              ),
            ),
            SalesItems.customListTileItem(
              title: 'Requests',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.border_color_rounded,
              onTap: () => navigateTo(context, const SalesRequestListScreen()),
            ),
            SalesItems.customListTileItem(
              title: 'Announcement',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.campaign_rounded,
              onTap: () => navigateTo(context, const SalesAnnouncementScreen()),
            ),
            SalesItems.customListTileItem(
              title: 'Send enquiry',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.integration_instructions_outlined,
              onTap: () => navigateTo(context, SalesAddCompOrSugScreen()),
            ),
            SalesItems.customListTileItem(
              title: 'Customers',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.group_sharp,
              onTap: () => navigateTo(context, const SalesCustomerScreen()),
            ),
            SalesItems.customListTileItem(
              title: 'Customers Complaints',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.reduce_capacity,
              onTap: () =>
                  navigateTo(context, const SalesCustomerComplaintsScreen()),
            ),
            SalesItems.customListTileItem(
              title: 'Customers Suggestions',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.highlight,
              onTap: () =>
                  navigateTo(context, const SalesCustomerSuggestionsScreen()),
            ),
            SalesItems.customListTileItem(
              title: 'Feedback',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.feedback,
              onTap: () => navigateTo(context, const SalesFeedbackScreen()),
            ),
          ],
        ),
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
                    onPressedDetails: () => navigateTo(
                        context, SalesOrderDetailsScreen(data: data)),
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
              SalesAddOrderScreen(
                allCustomerName: [...allCustomerName],
              ));
        },
      ),
    );
  }
}
