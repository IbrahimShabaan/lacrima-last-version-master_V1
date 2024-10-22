import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/sales/business_logic/sales_states.dart';

class SalesEditOrderScreen extends StatelessWidget {
  SalesEditOrderScreen({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  final updateOrderFormKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final issueDateController = TextEditingController();
  final shipmentController = TextEditingController();
  final receivingTimeController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = SalesCubit.get(context);
    priceController.text = data['price'];
    shipmentController.text = data['shipment'];
    issueDateController.text = data['issueDate'];
    descriptionController.text = data['description'];
    receivingTimeController.text = data['receivingTime'];
    return BlocConsumer<SalesCubit, SalesStates>(
      listener: (context, state) {
        if (state is UpdateOrderSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppItems.customText(
                'Successfully',
                fontSize: 12.sp,
              ),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Update Order'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Form(
                key: updateOrderFormKey,
                child: Column(
                  children: [
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Price',
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is require';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Issue date',
                      readOnly: true,
                      controller: issueDateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is require';
                        }
                        return null;
                      },
                      onTap: () async {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2050-12-31'),
                          initialDatePickerMode: DatePickerMode.day,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        ).then((value) {
                          issueDateController.text =
                              DateFormat.yMMMd().format(value!);
                        }).catchError((e) {});
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Shipment',
                      controller: shipmentController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is require';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Receiving Time',
                      readOnly: true,
                      controller: receivingTimeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is require';
                        }
                        return null;
                      },
                      onTap: () async {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2050-12-31'),
                          initialDatePickerMode: DatePickerMode.day,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        ).then((value) {
                          receivingTimeController.text =
                              DateFormat.yMMMd().format(value!);
                        }).catchError((e) {});
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'Description',
                      controller: descriptionController,
                      maxLines: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is require';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50.sp),
                    BuildCondition(
                      condition: state is! UpdateOrderLoadingState,
                      fallback: (context) => AppItems.customIndicator(),
                      builder: (context) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        color: ConstColors.kPrimaryColor,
                        elevation: 5,
                        fontSize: 14.sp,
                        onPressed: () async {
                          if (updateOrderFormKey.currentState!.validate()) {
                            cubit.updateOrder(
                              id: data['id'],
                              price: priceController.text,
                              description: descriptionController.text,
                              shipment: shipmentController.text,
                              issueDate: issueDateController.text,
                              receivingTime: receivingTimeController.text,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.sp),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
