import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';
import 'package:lacrima/employee/business_logic/requests/requests_cubit.dart';
import 'package:lacrima/employee/business_logic/requests/requests_states.dart';

class RequestsScreen extends StatelessWidget {
  RequestsScreen({Key? key}) : super(key: key);

  final vacationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = RequestsCubit.get(context);
    return BlocConsumer<RequestsCubit, RequestsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Requests'),
            leading: AppButtons.customButtonBack(context),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('Requests')
                .orderBy('createdAt')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: AppItems.customIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return AdminItems.customRequestItem(
                      data: data,
                      context: context,
                      vacationController: vacationController,
                      rejectOnPressed: () async {
                        await cubit.updateRequest(
                          requestId: data['requestId'],
                          status: 'Rejected',
                        );
                        await NotificationServices.sendNotificationToToken(
                          token: data['empToken'],
                          title: 'Request ${data['type']}',
                          body:
                              'The request you sent "${data['requestType']}" was rejected',
                        );
                      },
                      acceptOnPressed: () async {
                        await cubit.updateVacationEmployee(
                          context: context,
                          type: data['type'],
                          empId: data['empId'],
                          empToken: data['empToken'],
                          requestId: data['requestId'],
                          requestType: data['requestType'],
                          discount: double.parse(vacationController.text),
                        );
                      },
                    );
                  },
                ).toList(),
              );
            },
          ),
        );
      },
    );
  }
}
