import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/screens/complete.dart';
import 'package:wallet_xuno/screens/confirmation.dart';
import 'package:wallet_xuno/screens/dottedline.dart';
import 'package:wallet_xuno/screens/payment_info.dart';
import 'package:wallet_xuno/screens/wallet_screen.dart';

class PageIndicatorWidget extends StatefulWidget {
  const PageIndicatorWidget({super.key});

  @override
  State<PageIndicatorWidget> createState() => _PageIndicatorWidgetState();
}

class _PageIndicatorWidgetState extends State<PageIndicatorWidget> {
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
      backgroundColor:
          Colors.transparent, // Make Scaffold background transparent
      body: Center(
        child: SizedBox(
          // color: Colors.transparent, // Make container background transparent
          width: 694.w,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 32),
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
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      currentIndex = page;
                    });
                  },
                  children: [
                    const WalletScreen(),
                    Container(
                      color: Colors
                          .transparent, // Make page background transparent
                      child: const PaymentInfo(
                          // usdController: widget.usdController,
                          // nprValue: widget.nprValue,
                          ),
                    ),
                    const Confirmation(),
                    const Complete(),
                  ],
                ),
              ),
            ],
          ),
        ),
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
}
