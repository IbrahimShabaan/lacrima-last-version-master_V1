import 'package:lacrima/shared/components/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/constants/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('About'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Text(ConstText.about),
        ),
      ),
    );
  }
}
