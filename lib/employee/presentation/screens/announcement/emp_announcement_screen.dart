import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/employee/presentation/widgets/widgets.dart';
import 'package:lacrima/employee/presentation/screens/requests/emp_requests_screen.dart';
import 'package:lacrima/employee/presentation/screens/complaints_and_suggestion/emp_complaints_and_suggestion_screen.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Announcement'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(5.sp),
          children: [
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.sp),
                child: Align(child: AppItems.customAppLogo()),
              ),
            ),
            EmployeeItems.customListTileItem(
              title: 'Requests',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.border_color_rounded,
              onTap: () => navigateTo(context, const EmployeeRequestsScreen()),
            ),
            EmployeeItems.customListTileItem(
              title: 'Send enquiry',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.integration_instructions_outlined,
              onTap: () => navigateTo(context, EmpAddCompOrSugScreen()),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(6.sp),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Announcements')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: AppItems.customIndicator(),
              );
            }
            return ListView(
                children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                    EmployeeItems.customAnnouncementItem(data: data),
                    const Divider(),
                  ],
                );
              },
            ).toList());
          },
        ),
      ),
    );
  }
}
