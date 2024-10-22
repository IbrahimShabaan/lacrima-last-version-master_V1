import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/sales/business_logic/sales_states.dart';
import 'package:lacrima/customer/presentation/widgets/widgets.dart';
import 'package:lacrima/customer/presentation/screens/home/screens/customer_feedback_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const OrderDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List product = data['product'];
    return BlocConsumer<SalesCubit, SalesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: AppItems.customText('Order Details'),
            leading: AppButtons.customButtonBack(context),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppItems.customText(
                          'Price: ${data['price']}',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 8.sp),
                        AppItems.customText(
                          'Shipment to: ${data['shipment']}',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 8.sp),
                        AppItems.customText(
                          'IssueDate: ${data['issueDate']}',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 8.sp),
                        AppItems.customText(
                          'Receiving on: ${data['receivingTime']}',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 8.sp),
                        AppItems.customText(
                          'Description: ${data['description']}',
                          fontSize: 12.sp,
                        ),
                        const Divider(),
                        SizedBox(height: 8.sp),
                        AppItems.customText(
                          'Items',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 8.sp),
                        SizedBox(
                          height: 190.sp,
                          width: double.infinity,
                          child: ListView.separated(
                            itemCount: product.length,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 5.sp),
                            itemBuilder: (context, index) =>
                                CustomerItems.orderDetailsItem(
                                    data: product[index]),
                          ),
                        ),
                        ExpandableNotifier(
                          child: ExpandablePanel(
                            collapsed: const Text(''),
                            theme: ExpandableThemeData(
                              iconColor: ConstColors.kPrimaryColor,
                              iconSize: 22.sp,
                              animationDuration: const Duration(seconds: 1),
                            ),
                            header: Padding(
                              padding: EdgeInsets.symmetric(vertical: 9.sp),
                              child: AppItems.customText(
                                'Track Order',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            expanded: Column(
                              children: [
                                SizedBox(
                                  height: 280.sp,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      IconStepper(
                                        direction: Axis.vertical,
                                        steppingEnabled: false,
                                        enableStepTapping: true,
                                        scrollingDisabled: true,
                                        enableNextPreviousButtons: false,
                                        activeStepBorderColor: Colors.green,
                                        activeStepBorderWidth: 2,
                                        lineLength: 60.sp,
                                        lineColor: Colors.black,
                                        activeStepColor: Colors.green,
                                        activeStep: data['tracking'],
                                        stepRadius: 20.sp,
                                        icons: const [
                                          Icon(Icons.inventory_sharp,
                                              color: Colors.white),
                                          Icon(Icons.local_shipping,
                                              color: Colors.white),
                                          Icon(Icons.done, color: Colors.white),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 16.sp),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppItems.customText(
                                                'Order Placed',
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              AppItems.customText(
                                                'We have received your order\n on ${data['receivingTime']}',
                                                fontSize: 13.sp,
                                                fontColor: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 60.sp),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppItems.customText(
                                                'Out for Delivery',
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              AppItems.customText(
                                                'Your order is out for Delivery',
                                                fontSize: 13.sp,
                                                fontColor: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 68.sp),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppItems.customText(
                                                'Completed',
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              AppItems.customText(
                                                'Order Completed',
                                                fontSize: 13.sp,
                                                fontColor: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (data['tracking'] == 2)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppItems.customText(
                                'Order Completed',
                                fontSize: 14.sp,
                              ),
                              AppButtons.customTextButton(
                                text: 'Feedback',
                                fontSize: 16.sp,
                                color: ConstColors.kPrimaryColor,
                                decoration: TextDecoration.underline,
                                onPressed: () => navigateTo(
                                    context, CustomerFeedbackScreen()),
                              ),
                            ],
                          ),
                        SizedBox(height: 10.sp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
