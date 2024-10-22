import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/sales/business_logic/sales_states.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';

class SalesLayoutScreen extends StatelessWidget {
  const SalesLayoutScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    var empCubit = EmployeeCubit.get(context);
    empCubit.getEmployeeData(id);
    empCubit.getSalaryEmployee(year: DateTime.now().year, empId: id);
    return BlocConsumer<SalesCubit, SalesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SalesCubit.get(context);
        return Scaffold(
          body: cubit.salesScreens[cubit.salesCurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 20.sp,
            elevation: 16,
            fixedColor: ConstColors.kPrimaryColor,
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            currentIndex: cubit.salesCurrentIndex,
            onTap: (index) => cubit.salesChangeBottomNavBar(index),
            items: cubit.salesBottomNavItems,
          ),
        );
      },
    );
  }
}
