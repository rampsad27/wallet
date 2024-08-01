import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:wallet_xuno/screens/wallet_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 961), // Replace with your design size
      minTextAdapt:
          true, // Optional: Adjust text scaling based on the design size
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WalletScreen(),
      ),
    );
  }
}
