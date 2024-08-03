import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/screens/wallet_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AmountBloc(),
      child: ScreenUtilInit(
        designSize: const Size(1920, 961), // Replace with your design size
        minTextAdapt:
            true, // Optional: Adjust text scaling based on the design size
        builder: (context, child) => MaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.plusJakartaSansTextTheme(
              Theme.of(context).textTheme.apply(
                  bodyColor: Appcolour.black, displayColor: Appcolour.black),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const WalletScreen(),
        ),
      ),
    );
  }
}
