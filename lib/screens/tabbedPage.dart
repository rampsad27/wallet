import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/appColour.dart';
import 'package:wallet_xuno/widgets/button_container.dart';
import 'package:wallet_xuno/widgets/container.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';

class TabbedScreen extends StatefulWidget {
  const TabbedScreen({super.key});

  @override
  State<TabbedScreen> createState() => _TabbedScreenState();
}

class _TabbedScreenState extends State<TabbedScreen> {
  final TextEditingController _sendController = TextEditingController();
  double _recipientGets = 0.0;

  @override
  void initState() {
    super.initState();
    // _calculateRecipientGets();
    _sendController.addListener(_calculateRecipientGets);
  }

  // @override
  // void dispose() {
  //   _sendController.removeListener(_calculateRecipientGets);
  //   _sendController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const TabBar(
              indicatorColor: Appcolour.green,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'USD to NPR'),
                Tab(text: 'USD to USD'),
                Tab(text: 'Send Now Convert Later'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // First Tab - USD to NPR
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyInputTextField(
                            title: "You Send",
                            controller: _sendController,
                            inputType: TextInputType.number,
                            readOnly: false,
                            suffixIcon: const Icon(Icons.usb),
                          ),
                          // log(_sendController.text),
                          const SizedBox(width: 4),
                          MyInputTextField(
                            readOnly: true,
                            title: "Recipient Gets",
                            value: _recipientGets,
                            inputType: TextInputType.number,
                            suffixIcon: const Icon(Icons.near_me),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButtonContainer(
                            //raj m
                            height: 44.h,
                            width: 172.w,
                            text: "Instant",
                          ),
                          CustomButtonContainer(
                            height: 44.h,
                            width: 172.w,
                            text: "Same Day",
                          ),
                          CustomButtonContainer(
                            height: 44.h,
                            width: 172.w,
                            text: "Standard",
                          ),
                          CustomButtonContainer(
                            height: 44.h,
                            width: 172.w,
                            text: "Best Deal",
                            icon: const Icon(Icons.star_border_purple500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      CustomContainer(
                        height: 40.h,
                        width: 740.w,
                        text: "Message regarding delivery limits",
                        borderColor: Appcolour.red,
                        backgroundColor: Colors.transparent,
                        textColor: Appcolour.red,
                      ),
                      const SizedBox(height: 12),
                      CustomContainer(
                        height: 190.h,
                        width: 740,
                        borderColor: Colors.transparent,
                        backgroundColor:
                            const Color.fromARGB(255, 221, 237, 222),
                        textColor: Colors.black,
                        child: _calculateFee(),
                      ),
                      const SizedBox(height: 20),
                      CustomContainer(
                        height: 58.h,
                        width: 740,
                        borderColor: Colors.transparent,
                        backgroundColor:
                            const Color.fromARGB(255, 221, 237, 222),
                        textColor: Colors.black,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Total debit amount from Walllet"),
                              Spacer(),
                              Text("Sdf")
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const CustomContainer(
                        height: 40,
                        width: 740,
                        borderColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        textColor: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("You just saved"),
                              Spacer(),
                              Text("Compare")
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const CustomButtonContainer(
                        height: 40,
                        width: 420,
                        text: "Continue",
                      ),
                    ],
                  ),
                ),
              ),
              // Second Tab - USD to USD
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: const Center(child: Text("USD to USD")),
              ),
              // Third Tab - Send Now Convert Later
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: const Center(child: Text("Send Now Convert Later")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateRecipientGets() {
    log('$_sendController');
    double sendValue = double.tryParse(_sendController.text) ?? 0.0;
    setState(() {
      _recipientGets = sendValue * 134; // Assuming the conversion rate is 134
      log('$_sendController');
      log('$sendValue');
    });
  }

  _calculateFee() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [Text("You Send"), Spacer(), Text("df")],
          ),
          Row(
            children: [Text("Conversion fee"), Spacer(), Text("df")],
          ),
          Row(
            children: [
              Text("Amount after conversion fees"),
              Spacer(),
              Text("df")
            ],
          ),
          Row(
            children: [Text("New customer rate"), Spacer(), Text("df")],
          ),
          Row(
            children: [Text("Your Recipient gets"), Spacer(), Text("df")],
          ),
        ],
      ),
    );
  }
}
