import 'package:sizer/sizer.dart';
import 'guest_feedback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/guest/business_logic/guest_cubit.dart';
import 'package:lacrima/guest/business_logic/guest_states.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuestCubit, GuestStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = GuestCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Contact Lacrima'),
            leading: AppButtons.customButtonBack(context),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.phone,
                    size: 30.sp,
                    color: ConstColors.kPrimaryColor,
                  ),
                  label: AppItems.customText(
                    'Call US',
                    fontSize: 14.sp,
                    fontColor: Colors.black,
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.white, minimumSize: Size(200.sp, 60.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                  ),
                  onPressed: () => cubit.openUrl('tel:+96253824671'),
                ),
                SizedBox(height: 30.sp),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.watch,
                    size: 30.sp,
                    color: ConstColors.kPrimaryColor,
                  ),
                  label: AppItems.customText(
                    'Whatsapp Chat',
                    fontSize: 14.sp,
                    fontColor: Colors.black,
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.white, minimumSize: Size(200.sp, 60.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                  ),
                  onPressed: () => cubit.openWhatsApp('+962786812920'),
                ),
                SizedBox(height: 30.sp),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.mode_edit,
                    size: 30.sp,
                    color: ConstColors.kPrimaryColor,
                  ),
                  label: AppItems.customText(
                    'Submit Feedback',
                    fontSize: 14.sp,
                    fontColor: Colors.black,
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.white, minimumSize: Size(200.sp, 60.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                  ),
                  onPressed: () => navigateTo(context, FeedbackScreen()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
