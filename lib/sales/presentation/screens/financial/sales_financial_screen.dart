import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/sales/presentation/widgets/widgets.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/employee/business_logic/employee_states.dart';

class SalesFinancialScreen extends StatelessWidget {
  SalesFinancialScreen({Key? key}) : super(key: key);

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = EmployeeCubit.get(context);
        var employeeData = cubit.employeeModel;
        var data = cubit.model;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text('My Financial Sheet'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Column(
              children: [
                SizedBox(height: 10.sp),
                SalesItems.financialSummaryItem(
                  controller: controller,
                  salariesOfYear: data!,
                ),
                SalesItems.vacationSummaryItem(
                  totalVacation: employeeData!.totalVacations!,
                  usedVacation: employeeData.usedVacations!,
                  lastYearVacations: cubit.employeeModel!.lastYearVacations!,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
