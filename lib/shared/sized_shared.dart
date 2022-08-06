import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

extension TextStyleHelper on TextStyle {
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get ls1p5 => copyWith(letterSpacing: 1.5);
  TextStyle letterSpace(double value) => copyWith(letterSpacing: value);
  TextStyle customColor(Color value) => copyWith(color: value);
}

class Height {
  // ignore: non_constant_identifier_names
  static final double sizedbox_height_10 = 1.23.h;
  // ignore: non_constant_identifier_names
  static final double sizedbox_height_15 = 1.85.h;
  // ignore: non_constant_identifier_names
  static final double sizedbox_height_20 = 2.46.h;
  // ignore: non_constant_identifier_names
  static final double sizedbox_height_25 = 3.08.h;
}

class Width {
  // ignore: non_constant_identifier_names
  static final double sizedbox_width_10 = 2.66.w;
  // ignore: non_constant_identifier_names
  static final double sizedbox_width_15 = 4.w;
  // ignore: non_constant_identifier_names
  static final double sizedbox_width_20 = 5.33.w;
  // ignore: non_constant_identifier_names

}

class AppText extends TextTheme {
  static final px10 = TextStyle(
    fontSize: 7.7.sp,
  );
  static final px12 = TextStyle(
    fontSize: 9.2.sp,
  );
  static final px13 = TextStyle(
    fontSize: 10.0.sp,
  );
  static final px14 = TextStyle(
    fontSize: 10.8.sp,
  );
  static final px15 = TextStyle(
    fontSize: 11.5.sp,
  );
  static final px16 = TextStyle(
    fontSize: 12.3.sp,
  );
  static final px17 = TextStyle(
    fontSize: 13.1.sp,
  );
  static final px18 = TextStyle(
    fontSize: 13.8.sp,
  );
  static final px20 = TextStyle(
    fontSize: 15.5.sp,
  );
  static final px22 = TextStyle(
    fontSize: 16.6.sp,
  );
  static final px23 = TextStyle(
    fontSize: 17.6.sp,
  );
  static final px24 = TextStyle(
    fontSize: 18.5.sp,
  );
  static final px26 = TextStyle(
    fontSize: 20.0.sp,
  );
  static final px30 = TextStyle(
    fontSize: 23.1.sp,
  );
}
