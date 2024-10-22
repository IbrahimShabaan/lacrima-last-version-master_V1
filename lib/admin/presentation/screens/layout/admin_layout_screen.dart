import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/admin/business_logic/admin_cubit.dart';
import 'package:lacrima/admin/business_logic/admin_states.dart';

class AdminLayoutScreen extends StatelessWidget {
  const AdminLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    return BlocConsumer<AdminCubit, AdminStates>(
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
            onTap: (index) => cubit.adminChangeBottomNavBar(index),
            items: cubit.employeeBottomNavItems,
          ),
        );
      },
    );
  }
}
