import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: false,
    color: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 16.sp,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  primarySwatch: Colors.blue,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.black,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    ),
  ),
);
