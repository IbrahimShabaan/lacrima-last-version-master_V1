import 'package:sizer/sizer.dart';
import 'customer_order_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userName = CustomerCubit.get(context).customerModel!.userName;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Orders'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Orders')
              .where('customerName', isEqualTo: userName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: AppItems.customIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map(
                (DocumentSnapshot doc) {
                  Map<String, dynamic> data =
                      doc.data()! as Map<String, dynamic>;
                  return InkWell(
                    highlightColor: ConstColors.kPrimaryColor.withOpacity(0.1),
                    splashColor: ConstColors.kPrimaryColor.withOpacity(0.3),
                    child: Container(
                      height: 130.sp,
                      padding: EdgeInsets.all(4.sp),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 196.sp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AppItems.customText(
                                  'name: ${data['customerName']}',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                AppItems.customText(
                                  'Price: ${data['price']}',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    AppItems.customText(
                                      'IssueDate: ${data['issueDate']}',
                                      fontSize: 12.sp,
                                      fontColor: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.green,
                                      size: 12.sp,
                                    ),
                                  ],
                                ),
                                AppItems.customText(
                                  'Receiving on: ${data['receivingTime']}',
                                  fontSize: 12.sp,
                                  fontColor: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 80.sp,
                            height: 80.sp,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: FadeInImage(
                              height: 100.sp,
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(data['product'][0]['prodImage']),
                              placeholder: AssetImage(ConstIcons.loading),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () =>
                        navigateTo(context, OrderDetailsScreen(data: data)),
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
