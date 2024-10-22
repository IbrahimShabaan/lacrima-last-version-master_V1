import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/admin/business_logic/admin_cubit.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_add_announcement.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Announcement'),
        leading: AppButtons.customButtonBack(context),
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
                    AdminItems.customAnnouncementItem(
                      data: data,
                      context: context,
                      onPressed: () async {
                        var cubit = AdminCubit.get(context);
                        await cubit.deleteAnnouncement(data['id']);
                        Navigator.pop(context);
                        await cubit.deleteAnnouncementImage(data['image']);
                      },
                    ),
                    const Divider(),
                  ],
                );
              },
            ).toList());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstColors.kPrimaryColor,
        child: const Text('ADD'),
        onPressed: () => navigateTo(context, AddAnnouncementScreen()),
      ),
    );
  }
}
