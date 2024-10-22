import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/HR/business_logic/hr_cubit.dart';

class HRJobScreen extends StatelessWidget {
  const HRJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HRCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Jobs'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Jobs')
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
                return Container(
                  height: 190.sp,
                  width: double.infinity,
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.all(5.sp),
                  margin: EdgeInsets.all(5.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppItems.customText(
                        'Title: ${data['title']}',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 5.sp),
                      AppItems.customText(
                        'Name: ${data['name']}',
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
                        'Phone: ${data['phone']}',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 5.sp),
                      AppItems.customText(
                        'Job: ${data['yourJob']}',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 5.sp),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppItems.customText(
                          data['date'],
                          fontSize: 12.sp,
                          fontColor: Colors.green,
                        ),
                      ),
                      Divider(color: ConstColors.kPrimaryColor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppButtons.customElevatedButton(
                            text: 'View CV',
                            width: 100.sp,
                            fontSize: 13.sp,
                            elevation: 0,
                            color: ConstColors.kPrimaryColor,
                            onPressed: () async => cubit.openUrl(data['cv']),
                          ),
                          AppButtons.customElevatedButton(
                            text: 'Delete',
                            width: 100.sp,
                            fontSize: 13.sp,
                            elevation: 0,
                            color: ConstColors.kPrimaryColor,
                            onPressed: () async {
                              await cubit.deleteJob(data['id']);
                              await cubit.deletePDFJob(data['cv']);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
