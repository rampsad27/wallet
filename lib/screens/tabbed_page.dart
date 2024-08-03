import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final TextEditingController sendController = TextEditingController();
  double recipientGets = 0.0;
  double afterConversion = 0.0;
  double rate = 133.64; // Set a default rate

  @override
  void initState() {
    super.initState();
    sendController.addListener(onSendAmountChanged);
  }

  @override
  void dispose() {
    sendController.removeListener(onSendAmountChanged);
    sendController.dispose();
    super.dispose();
  }

  void onSendAmountChanged() {
    double sendValue = double.tryParse(sendController.text) ?? 0.0;
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
    return Center(
      child: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 1.5,
                  color: Appcolour.green,
                ),
                insets: EdgeInsets.symmetric(horizontal: 182),
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
          body: Container(
            color: Colors.transparent, // Make TabBarView transparent
            child: TabBarView(
              children: [
                // First Tab - USD to NPR
                UsdToNpr(
                  sendController: sendController,
                  recipientGets: recipientGets,
                  afterConversion: afterConversion,
                  rate: rate,
                ),
                // Second Tab - USD to USD
                const UsdToUsd(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
