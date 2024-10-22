import 'package:lacrima/sales/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/Start_Screen/start_screen.dart';
import 'package:lacrima/shared/local/cache_helper.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/sales/business_logic/sales_states.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';

class SalesProfile extends StatelessWidget {
  const SalesProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesCubit, SalesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = EmployeeCubit.get(context);
        var data = cubit.employeeModel;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text('My Profile'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout,
                    size: 22.sp, color: ConstColors.kPrimaryColor),
                onPressed: () async {
                  navigateAndFinish(context, const StartScreen());
                  cubit.employeeModel = null;
                  await CacheHelper.removeData(key: 'userData');
                  await FirebaseMessaging.instance.deleteToken();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                children: [
                  SizedBox(height: 15.sp),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage(
                      width: 100.sp,
                      height: 100.sp,
                      fit: BoxFit.fill,
                      image: NetworkImage(data!.image!),
                      placeholder: AssetImage(ConstIcons.loading),
                    ),
                  ),
                  SizedBox(height: 30.sp),
                  SalesItems.customProfileDataItem(text: 'ID: ${data.empId}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'FirstName: ${data.firstName}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'LastName: ${data.lastName}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'UserName: ${data.userName}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'Section: ${data.section}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'Position: ${data.position}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'Education: ${data.education}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'Address: ${data.address}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'HiringDate: ${data.hiringDate}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'Birthday: ${data.birthday}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'Email: ${data.email}'),
                  SizedBox(height: 10.sp),
                  SalesItems.customProfileDataItem(
                      text: 'Gender: ${data.gender}'),
                  SizedBox(height: 20.sp),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
