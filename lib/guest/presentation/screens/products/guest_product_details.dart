import 'package:lacrima/guest/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';

class GuestProductDetails extends StatelessWidget {
  const GuestProductDetails({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: AppButtons.customButtonBack(context),
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200.sp,
                width: double.infinity,
                child: Center(
                  child: Container(
                    height: 120.sp,
                    width: 120.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage('${data['prodImage']}'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.sp),
              AppItems.customText(
                data['prodTitle'],
                fontSize: 18.sp,
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10.sp),
              AppItems.customText(
                'Flavor: ${data['prodFlavor']}',
                fontSize: 12.sp,
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10.sp),
              AppItems.customText(
                'description ${data['prodDescription']}',
                fontSize: 12.sp,
                fontColor: Colors.black,
              ),
              SizedBox(height: 10.sp),
              AppItems.customText(
                'Size: ${data['prodSize']}',
                fontSize: 12.sp,
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 20.sp),
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
                    child: Text(
                      'Nutrition Facts',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  expanded:
                      GuestItems.customNutritionFactItem(data['nutrition']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
