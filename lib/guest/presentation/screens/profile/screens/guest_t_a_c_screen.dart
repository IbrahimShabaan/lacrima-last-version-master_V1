import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/shared/components/widgets.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Terms & Conditions'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              Text(ConstText.termsAndConditions),
            ],
          ),
        ),
      ),
    );
  }
}
