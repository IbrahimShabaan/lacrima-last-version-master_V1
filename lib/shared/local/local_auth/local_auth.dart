import 'package:flutter/material.dart';
import 'package:lacrima/Start_Screen/start_screen.dart';
import 'package:lacrima/shared/local/cache_helper.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';
import 'package:lacrima/HR/presentation/screens/layout/hr_layout_screen.dart';
import 'package:lacrima/sales/presentation/screens/layout/sales_layout_screen.dart';
import 'package:lacrima/admin/presentation/screens/layout/admin_layout_screen.dart';
import 'package:lacrima/employee/presentation/screens/layout/emp_layout_screen.dart';
import 'package:lacrima/customer/presentation/screens/layout/customer_layout_screen.dart';

usersAuth() {
  Widget? startScreen;
  var empCubit = EmployeeCubit();
  var customerCubit = CustomerCubit();
  List<String> data = CacheHelper.getListOfData(key: 'userData') ?? [];
  if (data.isEmpty) {
    startScreen = const StartScreen();
  } else {
    String id = data[0];
    String section = data[1];
    if (section == 'Admin') {
      startScreen = const AdminLayoutScreen();
    }
    if (section == 'HR') {
      empCubit.getEmployeeData(id);
      empCubit.getSalaryEmployee(year: DateTime.now().year, empId: id);
      startScreen = HRLayoutScreen(id: id);
    }
    if (section == 'Sales') {
      empCubit.getEmployeeData(id);
      empCubit.getSalaryEmployee(year: DateTime.now().year, empId: id);
      startScreen = SalesLayoutScreen(id: id);
    }
    if (section == 'Normal') {
      empCubit.getEmployeeData(id);
      empCubit.getSalaryEmployee(year: DateTime.now().year, empId: id);
      startScreen = EmployeeLayoutScreen(id: id);
    }
    if (section == 'Customer') {
      customerCubit.getCustomerData(id: id);
      startScreen = CustomerLayoutScreen(id: id);
    }
  }
  return startScreen;
}
