import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/screens/complete.dart';
import 'package:wallet_xuno/screens/confirmation.dart';
import 'package:wallet_xuno/screens/dottedline.dart';
import 'package:wallet_xuno/screens/payment_info.dart';
import 'package:wallet_xuno/screens/wallet_screen.dart';

class Recipientscreen extends StatefulWidget {
  const Recipientscreen({super.key});

  @override
  State<Recipientscreen> createState() => _RecipientscreenState();
}

class _RecipientscreenState extends State<Recipientscreen> {
  final PageController _pageController = PageController(initialPage: 1);
  int currentIndex = 1;

  void _previousPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _nextPage() {
    if (currentIndex < 3) {
      setState(() {
        currentIndex++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(34, 0, 34, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.circle,
                        color: currentIndex >= 0 ? Colors.green : Colors.grey,
                        size: 12.0,
                      ),
                    ],
                  ),
                  Expanded(
                    child: DottedLine(
                      color: currentIndex >= 1 ? Colors.green : Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: currentIndex >= 1 ? Colors.green : Colors.grey,
                    size: 12.0,
                  ),
                  Expanded(
                    child: DottedLine(
                      color: currentIndex >= 2 ? Colors.green : Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: currentIndex >= 2 ? Colors.green : Colors.grey,
                    size: 12.0,
                  ),
                  Expanded(
                    child: DottedLine(
                      color: currentIndex >= 3 ? Colors.green : Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: currentIndex >= 3 ? Colors.green : Colors.grey,
                    size: 12.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              children: const [
                WalletScreen(),
                PaymentInfo(),
                Confirmation(),
                Complete(),
              ],
            ),
          ),
          Container(
            color: Appcolour.green,
            height: 60,
            child: InkWell(
              onTap: _nextPage,
              child: const Center(
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Icon _getStepIcon(int index) {
    return Icon(
      currentIndex >= index ? Icons.circle : Icons.circle_outlined,
      color: currentIndex >= index ? Colors.green : Colors.grey,
      size: 42.0,
    );
  }

  // Widget _buildStepLine(int nextIndex) {
  //   return Expanded(
  //     child: DottedLine(
  //       color: currentIndex >= nextIndex ? Appcolour.green : Colors.grey,
  //       height: 2.0, // Adjust this height if needed
  //     ),
  //   );
  // }

  // Widget _buildStepCircle(int index, String label) {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         width: 40.h, // Ensure width matches the circle diameter
  //         child: Stack(
  //           alignment: Alignment.center,
  //           children: [
  //             CircleAvatar(
  //               radius: 16.h, // Adjust the radius as needed
  //               backgroundColor:
  //                   currentIndex >= index ? Appcolour.green : Colors.grey,
  //             ),
  //             if (index < 3) // Add a line only if there's another step
  //               Positioned(
  //                 right: 0,
  //                 child: Container(
  //                   width: 30.h, // Adjust width to match the circle diameter
  //                   height: 2.0, // Line height
  //                   color: currentIndex >= index + 1
  //                       ? Appcolour.green
  //                       : Colors.grey,
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 4.h),
  //       Text(
  //         label,
  //         style: TextStyle(
  //           color: currentIndex >= index ? Appcolour.green : Colors.grey,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
