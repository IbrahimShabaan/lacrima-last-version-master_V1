import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/local/cache_helper.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/Start_Screen/start_screen.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/admin/presentation/screens/job/admin_job_screen.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_emp_search.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_salary_screen.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_feedback_screen.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_requests_screen.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_update_employee.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_complaint_screen.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_suggestion_screen.dart';
import 'package:lacrima/admin/presentation/screens/customers/admin_complaint_screen.dart';
import 'package:lacrima/admin/presentation/screens/customers/admin_customers_screen.dart';
import 'package:lacrima/admin/presentation/screens/customers/admin_suggestion_screen.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_add_employee_screen.dart';
import 'package:lacrima/admin/presentation/screens/employee/admin_announcement_screen.dart';

import 'admin_events_and_news_screen.dart';

class AdminEmployeeScreen extends StatelessWidget {
  const AdminEmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = EmployeeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text('Employees'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_search_rounded),
            color: ConstColors.kPrimaryColor,
            onPressed: () => showSearch(
              context: context,
              delegate: AdminEmployeeSearch(),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.sp),
                child: Align(child: AppItems.customAppLogo()),
              ),
            ),
            AdminItems.customListTileItem(
              title: 'Requests',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.receipt_long,
              onTap: () {
                navigateTo(context, RequestsScreen());
              },
            ),
            AdminItems.customListTileItem(
              title: 'Employees Complaint',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.reduce_capacity,
              onTap: () => navigateTo(context, const ComplaintsScreen()),
            ),
            AdminItems.customListTileItem(
              title: 'Employees Suggestion',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.highlight,
              onTap: () => navigateTo(context, const SuggestionsScreen()),
            ),
            AdminItems.customListTileItem(
              title: 'Customers',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.group_sharp,
              onTap: () => navigateTo(context, const AdminCustomerScreen()),
            ),
            AdminItems.customListTileItem(
              title: 'Customers Complaint',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.reduce_capacity,
              onTap: () =>
                  navigateTo(context, const CustomerComplaintsScreen()),
            ),
            AdminItems.customListTileItem(
              title: 'Customers Suggestions',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.highlight,
              onTap: () =>
                  navigateTo(context, const CustomerSuggestionsScreen()),
            ),
            AdminItems.customListTileItem(
              title: 'Announcement',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.campaign_rounded,
              onTap: () => navigateTo(context, const AnnouncementsScreen()),
            ),
            AdminItems.customListTileItem(
              title: 'News and Events',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.event_sharp,
              onTap: () => navigateTo(context, const admin_events_news_screen()),
            ),
            AdminItems.customListTileItem(
              title: 'Jobs',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.note_alt,
              onTap: () => navigateTo(context, const AdminJobScreen()),
            ),
            AdminItems.customListTileItem(
              title: 'FeedBack',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.feedback_outlined,
              onTap: () => navigateTo(context, const AdminFeedbackScreen()),
            ),
            AdminItems.customListTileItem(
              title: 'Logout',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.logout,
              onTap: () async {
                await CacheHelper.removeData(key: 'userData');
                await FirebaseMessaging.instance.deleteToken();
                navigateAndFinish(context, const StartScreen());
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Employees')
            .where('empId', isNotEqualTo: 'admin')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: AppItems.customIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return InkWell(
                borderRadius: BorderRadius.circular(10.sp),
                child: Container(
                  height: 80.sp,
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 70.sp,
                        margin: EdgeInsets.only(right: 10.sp),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          width: 70.sp,
                          height: 100.sp,
                          image: NetworkImage(data['image']),
                          placeholder: AssetImage(ConstIcons.loading),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              data['userName'],
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              data['position'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,

                              ),

                            ),
                            Text(
                              data['empId'],
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Enter Actions'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    actions: [
                      AppButtons.customTextButton(
                        text: 'Close',
                        color: ConstColors.kPrimaryColor,
                        fontSize: 14.sp,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                    content: SizedBox(
                      height: 120.sp,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            icon: Icon(Icons.attach_money, size: 18.sp),
                            style: TextButton.styleFrom(
                              foregroundColor: ConstColors.kPrimaryColor,
                            ),
                            label: Text(
                              'Insert Salary',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            onPressed: () => navigateTo(
                                context, AddSalaryScreen(data: data)),
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.edit, size: 18.sp),
                            style: TextButton.styleFrom(
                              foregroundColor: ConstColors.kPrimaryColor,
                            ),
                            label: Text(
                              'Edit Employee',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            onPressed: () => navigateTo(
                                context, AdminUpdateEmployeeScreen(data: data)),
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.delete_forever, size: 18.sp),
                            style: TextButton.styleFrom(
                              foregroundColor: ConstColors.kPrimaryColor,
                            ),
                            label: Text(
                              'Delete Employee',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog<String>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text(
                                    'Do you want to delete the Employee',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  title: Icon(
                                    Icons.warning_rounded,
                                    color: Colors.yellow.shade800,
                                  ),
                                  actions: [
                                    AppButtons.customTextButton(
                                      text: 'Yes',
                                      color: ConstColors.kPrimaryColor,
                                      fontSize: 14.sp,
                                      onPressed: () async {
                                        await cubit
                                            .deleteProfileImage(data['image']);
                                        cubit.deleteEmployee(data['empId']);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    AppButtons.customTextButton(
                                      text: 'No',
                                      color: ConstColors.kPrimaryColor,
                                      fontSize: 14.sp,
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstColors.kPrimaryColor,
        child: const Icon(Icons.person_add),
        onPressed: () => navigateTo(context, AddEmployeeScreen()),
      ),
    );
  }
}
