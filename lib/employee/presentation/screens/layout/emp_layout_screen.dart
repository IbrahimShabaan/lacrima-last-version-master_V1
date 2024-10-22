import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/employee/business_logic/employee_states.dart';

class EmployeeLayoutScreen extends StatelessWidget {
  const EmployeeLayoutScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    var cubit = EmployeeCubit.get(context);
    cubit.getEmployeeData(id);
    cubit.getSalaryEmployee(year: DateTime.now().year, empId: id);
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 20.sp,
            elevation: 16,
            fixedColor: ConstColors.kPrimaryColor,
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.employeeChangeBottomNavBar(index);
            },
            items: cubit.employeeBottomNavItems,
          ),
        );
      },
    );
  }
}
