import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';

class Emptyscreen extends StatefulWidget {
  const Emptyscreen({super.key});

  @override
  State<Emptyscreen> createState() => _EmptyscreenState();
}

class _EmptyscreenState extends State<Emptyscreen> {
  String _selectedButton = "Same Day";

  void _selectButton(String buttonText) {
    setState(() {
      _selectedButton = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          clipBehavior: Clip.none, // Allow overflow of children
          children: [
            GestureDetector(
              onTap: () => _selectButton("Best Deal"),
              child: Container(
                height: 74.h,
                width: 164.w,
                decoration: BoxDecoration(
                  color: _selectedButton == "Best Deal"
                      ? Appcolour.green
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selectedButton == "Best Deal"
                        ? Appcolour.green
                        : Colors.grey,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Appcolour.green,
                        size: 19,
                      ),
                      SizedBox(
                        height: 12.h,
                        // child: Image.asset('assets/images/stars.png'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 24.h,
                              child: Image.asset('assets/images/stars.png')),
                          SizedBox(width: 8.w),
                          Text(
                            "Best Deal",
                            style: TextStyle(
                              color: _selectedButton == "Best Deal"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -8, // Adjust as needed
              left: 18.5, // Adjust as needed
              child: Container(
                width: 122.w, // Adjust size as needed
                height: 20.h, // Adjust size as needed
                decoration: BoxDecoration(
                  color: Appcolour.green,
                  borderRadius:
                      BorderRadius.circular(8), // Optional: rounded corners
                  border: Border.all(
                    color: Appcolour.green,
                  ),
                ),

                child: Center(
                  child: Text(
                    "USD 1=NPR 133.34",
                    style: TextStyle(
                      color: Appcolour.white,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
