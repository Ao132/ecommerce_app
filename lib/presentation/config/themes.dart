import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.50.sp),
    ),
  );

  static final darkTheme = ThemeData();
}
