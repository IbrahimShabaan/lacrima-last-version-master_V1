import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:lacrima/sales/presentation/widgets/widgets.dart';

class SalesCustomerInfo extends StatelessWidget {
  const SalesCustomerInfo({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    List<dynamic> interest = data['interest'] ?? [];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Info'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: ListView(
          children: [
            SizedBox(height: 10.sp),
            CircleAvatar(
              radius: 57.sp,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                  radius: 55.sp,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(data['image'])),
            ),
            SizedBox(height: 10.sp),
            SalesItems.customProfileDataItem(
                text: 'UserName: ${data['userName']}'),
            SizedBox(height: 10.sp),
            SalesItems.customProfileDataItem(
                text: 'FirstName: ${data['firstName']}'),
            SizedBox(height: 10.sp),
            SalesItems.customProfileDataItem(
                text: 'LastName: ${data['lastName']}'),
            SizedBox(height: 10.sp),
            SalesItems.customProfileDataItem(text: 'Email: ${data['email']}'),
            SizedBox(height: 10.sp),
            SalesItems.customProfileDataItem(text: 'Phone: ${data['phone']}'),
            SizedBox(height: 10.sp),
            SalesItems.customProfileDataItem(
                text: 'CompanyName: ${data['companyName']}'),
            SizedBox(height: 10.sp),
            AppItems.customText(
              'interests',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            MultiSelectChipDisplay(
              chipColor: ConstColors.kPrimaryColor.withOpacity(0.5),
              scrollBar: HorizontalScrollBar(isAlwaysShown: true),
              scroll: true,
              textStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              ),
              items:
                  interest.map((item) => MultiSelectItem(item, item)).toList(),
            ),
            SizedBox(height: 10.sp),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .where('customerName', isEqualTo: data['userName'])
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: AppItems.customIndicator());
                }
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    Map<String, dynamic> data =
                        doc.data()! as Map<String, dynamic>;
                    return Column(
                      children: [
                        SalesItems.customerOrderItem(data: data),
                        SizedBox(height: 10.sp),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}