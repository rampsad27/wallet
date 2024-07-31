import 'package:flutter/material.dart';
import 'package:wallet_xuno/constants/appColour.dart';
import 'package:wallet_xuno/widgets/sideBar_values.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 400,
      child: Column(
        children: [
          // Expanded ListView to take available space
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
                color: Appcolour.primary,
                fontSize: 12,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Contact us anytime for help",
              style: TextStyle(
                color: Appcolour.primary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
