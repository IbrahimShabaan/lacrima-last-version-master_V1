import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/HR/business_logic/hr_cubit.dart';
import 'package:lacrima/HR/business_logic/hr_states.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';

class HRLayoutScreen extends StatelessWidget {
  const HRLayoutScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    var cubit = HRCubit.get(context);
    var empCubit = EmployeeCubit.get(context);
    empCubit.getEmployeeData(id);
    empCubit.getSalaryEmployee(year: DateTime.now().year, empId: id);
    return BlocConsumer<HRCubit, HRStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.hrScreens[cubit.hrCurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 20.sp,
            elevation: 16,
            fixedColor: ConstColors.kPrimaryColor,
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            currentIndex: cubit.hrCurrentIndex,
            onTap: (index) => cubit.hrChangeBottomNavBar(index),
            items: cubit.hrBottomNavItems,
          ),
        );
      },
    );
  }
}
