import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/screens/complete.dart';
import 'package:wallet_xuno/screens/confirmation.dart';
import 'package:wallet_xuno/screens/dottedline.dart';
import 'package:wallet_xuno/screens/payment_info.dart';
import 'package:wallet_xuno/screens/usd_payment_info.dart';
import 'package:wallet_xuno/screens/wallet_screen.dart';

class PageIndicatorWidget extends StatefulWidget {
  final int initialPageIndex;
  final bool isUsdToNpr;

  const PageIndicatorWidget({
    super.key,
    this.initialPageIndex = 0,
    this.isUsdToNpr = false,
  });

  @override
  State<PageIndicatorWidget> createState() => _PageIndicatorWidgetState();
}

class _PageIndicatorWidgetState extends State<PageIndicatorWidget> {
  PageController _pageController = PageController();
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialPageIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

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
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
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
                  children: widget.isUsdToNpr
                      ? [
                          const WalletScreen(),
                          Container(
                            color: Colors.transparent,
                            child: const PaymentInfo(),
                          ),
                          const Confirmation(),
                          const Complete(),
                        ]
                      : [
                          const WalletScreen(),
                          Container(
                            color: Colors.transparent,
                            child: const UsdPaymentInfo(),
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
