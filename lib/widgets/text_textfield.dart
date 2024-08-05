import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/constants/app_text.dart';

class TextTextField extends StatelessWidget {
  final String hintText;
  const TextTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Appcolour.border),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none, // Remove the default border
            hintText: hintText,
            hintStyle: AppText.hindlabelText,
            contentPadding: const EdgeInsets.fromLTRB(12, 0, 0, 4)),
      ),
    );
  }
}
