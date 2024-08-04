import 'dart:ui';

import 'package:flutter/material.dart';

class BlurTransitionPage extends PageRouteBuilder {
  final Widget page;

  BlurTransitionPage({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            // Blur effect on the current page
            var blurAnimation = Tween<double>(begin: 0.0, end: 10.0)
                .animate(CurvedAnimation(parent: animation, curve: curve));

            return Stack(
              children: [
                // Current page blurred out
                FadeTransition(
                  opacity: animation,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: blurAnimation.value,
                        sigmaY: blurAnimation.value),
                    child: Container(color: Colors.transparent),
                  ),
                ),
                // New page appearing
                SlideTransition(position: offsetAnimation, child: child),
              ],
            );
          },
        );
}
