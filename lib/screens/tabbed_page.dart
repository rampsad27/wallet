import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/screens/usd_to_usd.dart';
import 'package:wallet_xuno/screens/usd_to_npr.dart';

class TabbedScreen extends StatefulWidget {
  const TabbedScreen({super.key});

  @override
  State<TabbedScreen> createState() => _TabbedScreenState();
}

class _TabbedScreenState extends State<TabbedScreen> {
  final TextEditingController sendUsdToNprController = TextEditingController();
  final TextEditingController sendUsdToUsdController = TextEditingController();
  double nprRecipientGets = 0.0;
  double usdRecipientGets = 0.0;
  double afterUsdToNprConversion = 0.0;
  double rate = 133.64; // Set a default rate

  double usdToUsdConversionFee = 0.0;

  @override
  void initState() {
    super.initState();
    sendUsdToNprController.addListener(onSendAmountChanged);
  }

  @override
  void dispose() {
    sendUsdToNprController.removeListener(onSendAmountChanged);
    sendUsdToNprController.dispose();
    super.dispose();
  }

  void onSendAmountChanged() {
    double sendValue = double.tryParse(sendUsdToNprController.text) ?? 0.0;
    if (sendValue > 3000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount should be less than 3000')),
      );
      return;
    }
    context.read<AmountBloc>().add(UpdateSenderAmount(sendValue));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 1,
                color: Appcolour.green,
              ),
              // insets: EdgeInsets.symmetric(horizontal: 182),
            ),
            labelStyle: TextStyle(
              fontSize: 14, // Adjust size for selected tab
              fontWeight: FontWeight.bold,
              color: Appcolour.black,
            ),
            unselectedLabelStyle: TextStyle(
                fontSize: 12, // Adjust size for unselected tabs
                fontWeight: FontWeight.normal,
                color: Appcolour.black),
            tabs: [
              Tab(text: 'USD to NPR'),
              Tab(text: 'USD to USD'),
            ],
          ),
        ),
        body: Center(
          child: Container(
            width: 694
                .w, //make tabbar body fit the screen as per the tabbar appbar
            color: Colors.transparent, // Make TabBarView transparent
            child: TabBarView(
              children: [
                // First Tab - USD to NPR
                UsdToNpr(
                  sendUsdToNprController: sendUsdToNprController,
                  nprRecipientGets: nprRecipientGets,
                  afterUsdToNprConversion: afterUsdToNprConversion,
                  rate: rate,
                ),
                // Second Tab - USD to USD
                UsdToUsd(
                  sendUsdToUsdController: sendUsdToUsdController,
                  usdRecipientGets: usdRecipientGets,
                  usdToUsdConversionFee: afterUsdToNprConversion,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
