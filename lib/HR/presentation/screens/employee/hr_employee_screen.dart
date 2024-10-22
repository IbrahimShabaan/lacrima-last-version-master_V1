import 'package:lacrima/HR/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/HR/presentation/screens/job/hr_job_screen.dart';
import 'package:lacrima/HR/presentation/screens/employee/hr_emp_search.dart';
import 'package:lacrima/employee/business_logic/employee_cubit.dart';
import 'package:lacrima/HR/presentation/screens/employee/hr_salary_screen.dart';
import 'package:lacrima/HR/presentation/screens/employee/hr_feedback_screen.dart';
import 'package:lacrima/HR/presentation/screens/requests/hr_requests_screen.dart';
import 'package:lacrima/HR/presentation/screens/employee/hr_update_employee.dart';
import 'package:lacrima/HR/presentation/screens/employee/hr_complaint_screen.dart';
import 'package:lacrima/HR/presentation/screens/employee/hr_suggestion_screen.dart';
import 'package:lacrima/HR/presentation/screens/employee/hr_add_employee_screen.dart';
import 'package:lacrima/HR/presentation/screens/employee/hr_announcement_screen.dart';

class HREmployeeScreen extends StatelessWidget {
  const HREmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = EmployeeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Employees'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_search_rounded),
            color: ConstColors.kPrimaryColor,
            onPressed: () => showSearch(
              context: context,
              delegate: HREmployeeSearch(),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(5.sp),
          children: [
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.sp),
                child: Align(child: AppItems.customAppLogo()),
              ),
            ),
            HRItems.customListTileItem(
              title: 'Requests',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.receipt_long,
              onTap: () => navigateTo(context, HRRequestsScreen()),
            ),
            HRItems.customListTileItem(
              title: 'Complaint',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.reduce_capacity,
              onTap: () => navigateTo(context, const HRComplaintsScreen()),
            ),
            HRItems.customListTileItem(
              title: 'Suggestion',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.highlight,
              onTap: () => navigateTo(context, const HRSuggestionsScreen()),
            ),
            HRItems.customListTileItem(
              title: 'Announcement',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.campaign_rounded,
              onTap: () => navigateTo(context, const HRAnnouncementsScreen()),
            ),
            HRItems.customListTileItem(
              title: 'Jobs',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.note_alt,
              onTap: () => navigateTo(context, const HRJobScreen()),
            ),
            HRItems.customListTileItem(
              title: 'FeedBack',
              fontSize: 13.sp,
              iconSize: 20.sp,
              icon: Icons.feedback_outlined,
              onTap: () => navigateTo(context, const HrFeedbackScreen()),
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
            return Center(child: AppItems.customIndicator());
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
                  margin: EdgeInsets.all(8.sp),
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
                      Column(
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
                                context, HRAddSalaryScreen(data: data)),
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.edit, size: 18.sp),
                            style: TextButton.styleFrom(
                              foregroundColor: ConstColors.kPrimaryColor,
                            ),
                            label: Text(
                              'Edit Employee',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            onPressed: () => navigateTo(
                                context, HRUpdateEmployeeScreen(data: data)),
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
                                      onPressed: () {
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
        onPressed: () => navigateTo(context, HRAddEmployeeScreen()),
      ),
    );
  }
}
