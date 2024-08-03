import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';

class CustomButtonContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final Widget? icon;
  final String? image;
  final bool isSelected; // New parameter for selection state
  final VoidCallback onTap; // Callback for tap
  final Color textColour;
  const CustomButtonContainer({
    super.key,
    this.height,
    this.width,
    required this.text,
    this.icon,
    this.isSelected = false, // Default value
    required this.onTap,
    this.image,
    required this.textColour,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Appcolour.green : Appcolour.border,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
          color: isSelected
              ? Appcolour.green
              : Colors.transparent, // Change color based on selection
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if (image != null) ...[ //!latee to change colour
              //   Image.asset(
              //     image!,
              //     color: isSelected
              //         ? Colors.white
              //         : Appcolour.black, // Change image color on select
              //     width: 20, // Adjust as needed
              //     height: 20, // Adjust as needed
              //   ),
              //   const SizedBox(width: 8),
              // ],
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Appcolour.white : textColour,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
