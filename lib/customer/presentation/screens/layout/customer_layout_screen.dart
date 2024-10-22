import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';
import 'package:lacrima/customer/business_logic/customer_states.dart';

class CustomerLayoutScreen extends StatelessWidget {
  const CustomerLayoutScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        cubit.getCustomerData(id: id);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 16,
            iconSize: 20.sp,
            type: BottomNavigationBarType.fixed,
            fixedColor: ConstColors.kPrimaryColor,
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.customerBottomNavItems,
          ),
        );
      },
    );
  }
}
