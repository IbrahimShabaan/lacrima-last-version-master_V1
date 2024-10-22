import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/sales/presentation/widgets/widgets.dart';

class SalesCustomerComplaintsScreen extends StatelessWidget {
  const SalesCustomerComplaintsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Complaints'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Complaints And Suggestions')
            .doc('Customers')
            .collection('Complaints And Suggestions')
            .where('type', isEqualTo: 'Complaint')
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
              return SalesItems.customCompAndSugItem(
                data: data,
                onPressed: () async {
                  await SalesCubit.get(context).deleteComplaintsOrSuggestions(
                    id: data['id'],
                    docName: 'Customers',
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
