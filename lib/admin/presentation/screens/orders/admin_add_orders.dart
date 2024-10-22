import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/sales/data/models/order_model.dart';
import 'package:lacrima/sales/business_logic/sales_cubit.dart';
import 'package:lacrima/sales/business_logic/sales_states.dart';
import 'package:lacrima/admin/presentation/widgets/widgets.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';

// ignore: must_be_immutable
class AdminAddOrderScreen extends StatelessWidget {
  AdminAddOrderScreen({
    Key? key,
    required this.allCustomerName,
  }) : super(key: key);

  final List<String> allCustomerName;
  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final priceController = TextEditingController();
  final issueDateController = TextEditingController();
  final shipmentController = TextEditingController();
  final receivingTimeController = TextEditingController();
  final descriptionController = TextEditingController();
  List<ProductModel> allProduct = [];
  List<TextEditingController> quantity = [];

  @override
  Widget build(BuildContext context) {
    var cubit = SalesCubit.get(context);
    List<bool> isChecked = List<bool>.filled(cubit.products.length, false);
    return BlocConsumer<SalesCubit, SalesStates>(
      listener: (context, state) {
        if (state is InsertOrderSuccessState) {
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
            title: const Text('New Order'),
            leading: AppButtons.customButtonBack(context),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 15.sp),
                    AppItems.customAppLogo(),
                    SizedBox(height: 10.sp),
                    AppItems.customTextField(
                      hintText: 'ID',
                      controller: idController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customDropDownButtonFormField(
                      items: allCustomerName,
                      hintText: 'Customer User Name',
                      margin: EdgeInsets.all(0.sp),
                      onChanged: (value) => cubit.selectCustomerName(value),
                      validator: (value) {
                        if (value == null) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    Row(
                      children: [
                        SizedBox(width: 15.sp),
                        SizedBox(
                          width: 140.sp,
                          child: AppItems.customTextField(
                            hintText: 'Price',
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 125.sp,
                          child: AppButtons.customDropDownButtonFormField(
                            hintText: 'Select',
                            items: cubit.currencyItems,
                            onChanged: (value) => cubit.currencyChange(value),
                            validator: (value) {
                              if (value == null) {
                                return 'Field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
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
                          firstDate: DateTime.parse('1900-12-31'),
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
                          return 'Field is required';
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
                          return 'Field is required';
                        }
                        return null;
                      },
                      onTap: () async {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.parse('1900-12-31'),
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
                      maxLines: 6,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    Container(
                      height: 230.sp,
                      padding: EdgeInsets.all(5.sp),
                      color: Colors.grey.shade100,
                      child: cubit.products.isEmpty
                          ? const Center(child: Text('No Item'))
                          : ListView.separated(
                              itemCount: cubit.products.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 5.sp),
                              itemBuilder: (context, index) {
                                quantity.add(TextEditingController());
                                var data = cubit.products[index];
                                return AdminItems.orderSelectItem(
                                  data: data,
                                  isChecked: isChecked[index],
                                  quantity: quantity[index],
                                  onChanged: (value) {
                                    if (quantity[index].text == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          'Enter Quantity',
                                          textAlign: TextAlign.center,
                                        ),
                                      ));
                                    } else {
                                      cubit.checkBoxChange(
                                          index, value!, isChecked);
                                      if (isChecked[index]) {
                                        allProduct.add(ProductModel(
                                          prodSize: data['prodSize'],
                                          prodImage: data['prodImage'],
                                          prodTitle: data['prodTitle'],
                                          prodFlavor: data['prodFlavor'],
                                          quantity: quantity[index].text,
                                        ));
                                      } else if (isChecked[index] == false) {
                                        if (allProduct.length == 1) {
                                          allProduct = [];
                                          return;
                                        } else {
                                          allProduct.removeAt(index);
                                        }
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 50.sp),
                    BuildCondition(
                      condition: state is! InsertOrderLoadingState,
                      fallback: (context) => AppItems.customIndicator(),
                      builder: (context) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        color: ConstColors.kPrimaryColor,
                        elevation: 5,
                        fontSize: 14.sp,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (allProduct.isNotEmpty) {
                              String token = await cubit
                                  .getCustomerToken(cubit.customerNameValue);
                              await cubit.insertOrder(
                                customerToken: token,
                                id: idController.text,
                                customerName: cubit.customerNameValue,
                                price:
                                    cubit.currencyValue + priceController.text,
                                description: descriptionController.text,
                                shipment: shipmentController.text,
                                issueDate: issueDateController.text,
                                receivingTime: receivingTimeController.text,
                                product:
                                    allProduct.map((e) => e.toJson()).toList(),
                              );
                              await NotificationServices
                                  .sendNotificationToToken(
                                token: token,
                                title: 'New Order',
                                body: descriptionController.text,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Select Item')));
                            }
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
