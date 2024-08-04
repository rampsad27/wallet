import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/screens/payment_info.dart';
import 'package:wallet_xuno/screens/confirmation.dart';
import 'package:wallet_xuno/screens/complete.dart';
import 'package:wallet_xuno/screens/dottedline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';

class PageIndicatorWidget extends StatefulWidget {
  const PageIndicatorWidget({
    super.key,
  });

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

  void _navigateToPage(int index) {
    if (index >= 0 && index < 4) {
      setState(() {
        currentIndex = index;
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
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
                  _buildPageIndicator(0),
                  Expanded(
                    child: DottedLine(
                      color: currentIndex >= 1 ? Colors.green : Colors.grey,
                    ),
                  ),
                  _buildPageIndicator(1),
                  Expanded(
                    child: DottedLine(
                      color: currentIndex >= 2 ? Colors.green : Colors.grey,
                    ),
                  ),
                  _buildPageIndicator(2),
                  Expanded(
                    child: DottedLine(
                      color: currentIndex >= 3 ? Colors.green : Colors.grey,
                    ),
                  ),
                  _buildPageIndicator(3),
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
                Complete(), // change later
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

  Widget _buildPageIndicator(int index) {
    return InkWell(
      onTap: () => _navigateToPage(index),
      child: Icon(
        Icons.circle,
        color: currentIndex >= index ? Colors.green : Colors.grey,
        size: 12.0,
      ),
    );
  }
}
