import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/admin/business_logic/admin_cubit.dart';
import 'package:lacrima/admin/business_logic/admin_states.dart';
import 'package:lacrima/sales/presentation/widgets/widgets.dart';

class SalesAnnouncementScreen extends StatelessWidget {
  const SalesAnnouncementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                        SalesItems.customAnnouncementItem(data: data),
                        const Divider(),
                      ],
                    );
                  },
                ).toList());
              },
            ),
          ),
        );
      },
    );
  }
}
