import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/Start_Screen/start_screen.dart';
import 'package:lacrima/shared/local/cache_helper.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lacrima/customer/presentation/widgets/widgets.dart';
import 'package:lacrima/customer/business_logic/customer_cubit.dart';
import 'package:lacrima/customer/business_logic/customer_states.dart';
import 'package:lacrima/customer/presentation/screens/profile/customer_edit_profile.dart';

class CustomerProfile extends StatelessWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit = CustomerCubit.get(context);
        var data = cubit.customerModel;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text('My Profile'),
            actions: [
              IconButton(
                icon: Icon(Icons.edit, size: 22.sp, color: Colors.green),
                onPressed: () async {
                  navigateTo(
                      context, CustomerEditProfile(customerModel: data!));
                },
              ),
              IconButton(
                icon: Icon(Icons.logout,
                    size: 22.sp, color: ConstColors.kPrimaryColor),
                onPressed: () async {
                  navigateAndFinish(context, const StartScreen());
                  await cubit.customerSignOut();
                  await CacheHelper.removeData(key: 'userData');
                  cubit.customerModel = null;
                  await FirebaseMessaging.instance.deleteToken();
                },
              ),
            ],
          ),
          body: cubit.customerModel != null
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: ListView(
              children: [
                SizedBox(height: 10.sp),
                CircleAvatar(
                  radius: 57.sp,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                      radius: 55.sp,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(data!.image!)),
                ),
                SizedBox(height: 30.sp),
                CustomerItems.customProfileDataItem(
                    text: 'UserName: ${data.userName}'),
                SizedBox(height: 10.sp),
                CustomerItems.customProfileDataItem(
                    text: 'FirstName: ${data.firstName}'),
                SizedBox(height: 10.sp),
                CustomerItems.customProfileDataItem(
                    text: 'LastName: ${data.lastName}'),
                SizedBox(height: 10.sp),
                CustomerItems.customProfileDataItem(
                    text: 'Email: ${data.email}'),
                SizedBox(height: 10.sp),
                CustomerItems.customProfileDataItem(
                    text: 'Phone: ${data.phone}'),
                SizedBox(height: 10.sp),
                CustomerItems.customProfileDataItem(
                    text: 'CompanyName: ${data.companyName}'),
                SizedBox(height: 10.sp),
                CustomerItems.customProfileDataItem(
                    text: 'Birthday: ${data.birthday}'),
              ],
            ),
          )
              : AppItems.customIndicator(),
        );
      },
    );
  }
}
