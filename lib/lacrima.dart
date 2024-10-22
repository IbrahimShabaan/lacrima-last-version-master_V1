import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/styles/theme.dart';
import 'package:lacrima/HR/business_logic/hr_cubit.dart';
import 'package:lacrima/admin/business_logic/admin_cubit.dart';
import 'package:lacrima/guest/business_logic/guest_cubit.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/admin/business_logic/product/product_cubit.dart';
import 'package:lacrima/employee/business_logic/requests/requests_cubit.dart';

class Lacrima extends StatelessWidget {
  const Lacrima({Key? key, required this.startScreen}) : super(key: key);

  final Widget startScreen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HRCubit()),
        BlocProvider(create: (_) => GuestCubit()),
        BlocProvider(create: (_) => AdminCubit()),
        BlocProvider(create: (_) => SalesCubit()),
        BlocProvider(create: (_) => ProductCubit()),
        BlocProvider(create: (_) => CustomerCubit()),
        BlocProvider(create: (_) => EmployeeCubit()),
        BlocProvider(create: (_) => RequestsCubit()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'LACRIMA',
            color: Colors.white,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: startScreen,
          );
        },
      ),
    );
  }
}
