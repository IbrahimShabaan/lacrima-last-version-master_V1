import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';

class SalesFeedbackScreen extends StatelessWidget {
  const SalesFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('FeedBack'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Feedback')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AppItems.customIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.sp),
                      margin: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              AppItems.customText(
                                'first name: ${data['firstName']}',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              const Spacer(),
                              InkWell(
                                child: Icon(
                                  Icons.close,
                                  color: ConstColors.kPrimaryColor,
                                ),
                                onTap: () async => await SalesCubit.get(context)
                                    .deleteFeedBack(id: data['id']),
                              )
                            ],
                          ),
                          SizedBox(height: 5.sp),
                          AppItems.customText(
                            'last Name: ${data['lastName']}',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 5.sp),
                          AppItems.customText(
                            'Email: ${data['email']}',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 5.sp),
                          AppItems.customText(
                            'Feedback: ${data['content']}',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          const Divider(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: AppItems.customText(
                              data['date'],
                              fontSize: 12.sp,
                              fontColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
