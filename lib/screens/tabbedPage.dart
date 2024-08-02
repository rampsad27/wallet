import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
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
  double _afterConversion = 0.0;
  double _rate = 133.64; // Set a default rate

  @override
  void initState() {
    super.initState();
    _sendController.addListener(_onSendAmountChanged);
  }

  @override
  void dispose() {
    _sendController.removeListener(_onSendAmountChanged);
    _sendController.dispose();
    super.dispose();
  }

  void _onSendAmountChanged() {
    double sendValue = double.tryParse(_sendController.text) ?? 0.0;
    context.read<AmountBloc>().add(UpdateSenderAmount(sendValue));
  }

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
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 1.5,
                  color: Appcolour.green,
                ),
                insets: EdgeInsets.symmetric(horizontal: 75),
              ),
              tabs: [
                Tab(text: 'USD to NPR'),
                Tab(text: 'USD to USD'),
                Tab(text: 'Send Now Convert Later'),
              ],
            ),
          ),
          body: BlocListener<AmountBloc, AmountState>(
            listener: (context, state) {
              if (state is AmountUpdated) {
                setState(() {
                  _recipientGets = state.recipientGets;
                  _afterConversion = state.afterConversion;
                  _rate = state.rate; // Update rate if it changes
                });
              }
            },
            child: TabBarView(
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
                          text: "Message regarding delivery limits,",
                          borderColor: Appcolour.red,
                          backgroundColor: Colors.transparent,
                          textColor: Appcolour.red,
                        ),
                        const SizedBox(height: 12),
                        CustomContainer(
                          height: 180.h,
                          width: 740,
                          borderColor: Colors.transparent,
                          backgroundColor: Appcolour.backgroundContainer,
                          textColor: Colors.black,
                          child: _calculateFee(),
                        ),
                        const SizedBox(height: 20),
                        CustomContainer(
                          height: 58.h,
                          width: 740,
                          borderColor: Colors.transparent,
                          backgroundColor: Appcolour.backgroundContainer,
                          textColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Total debit amount from Wallet",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  "${_sendController.text} USD",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
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
                          width: 740,
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
      ),
    );
  }

  Widget _calculateFee() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "You Send",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                "${_sendController.text} USD",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            children: [Text("Conversion fee"), Spacer(), Text("-0.70%")],
          ),
          Row(
            children: [
              const Text("Amount after conversion fees"),
              const Spacer(),
              Text("${_afterConversion.toStringAsFixed(2)} USD"),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text("New customer rate"),
              const Spacer(),
              Text("x $_rate"),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                "Your Recipient gets",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '$_recipientGets NPR',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
