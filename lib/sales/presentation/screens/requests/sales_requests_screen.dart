import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/sales/presentation/widgets/widgets.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/employee/business_logic/requests/requests_cubit.dart';
import 'package:lacrima/employee/business_logic/requests/requests_states.dart';
import 'package:lacrima/sales/presentation/screens/requests/sales_add_leave_requests_screen.dart';
import 'package:lacrima/sales/presentation/screens/requests/sales_add_overtime_requests_screen.dart';
import 'package:lacrima/sales/presentation/screens/requests/sales_add_vacation_requests_screen.dart';

class SalesRequestListScreen extends StatelessWidget {
  const SalesRequestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestsCubit, RequestsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var data = EmployeeCubit.get(context).employeeModel;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: AppButtons.customButtonBack(context),
            title: const Text('My Requests'),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.sp),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Requests')
                  .where('empId', isEqualTo: data!.empId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: AppItems.customIndicator());
                }
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return SalesItems.customRequestItem(data: data);
                  }).toList(),
                );
              },
            ),
          ),
          floatingActionButton: SalesItems.fABRequests(
            context: context,
            onPressedLeave: () =>
                navigateTo(context, SalesAddLeaveRequestScreen()),
            onPressedOverTime: () =>
                navigateTo(context, SalesAddOverTimeRequestScreen()),
            onPressedVacation: () =>
                navigateTo(context, SalesAddVacationRequestScreen()),
          ),
        );
      },
    );
  }
}
