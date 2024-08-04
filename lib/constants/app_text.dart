import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:wallet_xuno/constants/app_colour.dart';

class AppText {
  static TextStyle boldText = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );
  static TextStyle normalText =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);
  static TextStyle smallnormalText = TextStyle(
    fontSize: 14.sp,
  );
  static TextStyle hindText = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Hind',
    color: Colors.black,
  );
  static TextStyle hindTextNormal = TextStyle(
      fontSize: 16.sp,
      fontFamily: 'Hind',
      color: Colors.black,
      fontWeight: FontWeight.w600);
  static TextStyle hindlabelText = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Hind',
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static TextStyle hindButtonText = TextStyle(
      fontSize: 14.sp,
      fontFamily: 'Hind',
      fontWeight: FontWeight.w400,
      color: Appcolour.green);
  static TextStyle hindlabelgreyText = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Hind',
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}
