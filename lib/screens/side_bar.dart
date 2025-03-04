import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/widgets/sidebar_values.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        // Expanded ListView to take available space which i dont want
        Expanded(
          child: ListView(
            children: SidebarValues.items,
          ),
        ),
        // Horizontal divider
        const Divider(
          thickness: 1, // Thickness of the divider
        ),
        // Additional text or widgets
        TextButton(
          onPressed: () {},
          child: const Text(
            "Review limit breakdown",
            style: TextStyle(
              color: Appcolour.black,
              fontSize: 12,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Contact us anytime for help",
            style: TextStyle(
              color: Appcolour.black,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
