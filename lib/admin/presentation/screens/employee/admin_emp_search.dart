import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_salary_screen.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_update_employee.dart';

class AdminEmployeeSearch extends SearchDelegate {
  @override
  AdminEmployeeSearch()
      : super(
          searchFieldLabel: 'name',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade400,
          ),
        );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var cubit = EmployeeCubit.get(context);
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('Employees')
          .where('empId', isNotEqualTo: 'admin')
          .where('userName', isEqualTo: query)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: AppItems.customIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('Empty'));
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot doc) {
            Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
            return AdminItems.employeeItem(
              context: context,
              data: data,
              onPressedEdit: () =>
                  navigateTo(context, AdminUpdateEmployeeScreen(data: data)),
              onPressedSalary: () =>
                  navigateTo(context, AddSalaryScreen(data: data)),
              onPressedYes: () {
                cubit.deleteEmployee(data['empId']);
                Navigator.pop(context);
              },
              onPressedNo: () => Navigator.pop(context),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var cubit = EmployeeCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Employees')
            .where('empId', isNotEqualTo: 'admin')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AppItems.customIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Empty'));
          }
          final results = snapshot.data!.docs.where((data) =>
              data['userName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              data['userName']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()));
          return ListView(
              children: results.map(
            (DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return AdminItems.employeeItem(
                context: context,
                data: data,
                onPressedEdit: () =>
                    navigateTo(context, AdminUpdateEmployeeScreen(data: data)),
                onPressedSalary: () =>
                    navigateTo(context, AddSalaryScreen(data: data)),
                onPressedYes: () {
                  cubit.deleteEmployee(data['empId']);
                  Navigator.pop(context);
                },
                onPressedNo: () => Navigator.pop(context),
              );
            },
          ).toList());
        },
      ),
    );
  }
}
