import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/HR/presentation/widgets/widgets.dart';
import 'package:lacrima/admin/business_logic/admin_cubit.dart';

class HRSuggestionsScreen extends StatelessWidget {
  const HRSuggestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Suggestions'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Complaints And Suggestions')
            .doc('Employees')
            .collection('Complaints And Suggestions')
            .where('type', isEqualTo: 'Suggestion')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return HRItems.customCompAndSugItem(
                data: data,
                onPressed: () async {
                  await AdminCubit.get(context).deleteComplaintsOrSuggestions(
                    id: data['id'],
                    docName: 'Employees',
                  );
                },
              );
            },
          ).toList());
        },
      ),
    );
  }
}
