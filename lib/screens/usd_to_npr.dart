import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/widgets/button_container.dart';
import 'package:wallet_xuno/widgets/custom_container.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';

class UsdToNpr extends StatefulWidget {
  final TextEditingController sendController;
  final double recipientGets;
  final double afterConversion;
  final double rate;

  const UsdToNpr({
    super.key,
    required this.sendController,
    required this.recipientGets,
    required this.afterConversion,
    required this.rate,
  });

  @override
  State<UsdToNpr> createState() => _UsdToNprState();
}

class _UsdToNprState extends State<UsdToNpr> {
  late TextEditingController sendController;
  late double recipientGets;
  late double afterConversion;
  late double rate;

  @override
  void initState() {
    super.initState();
    sendController = widget.sendController;
    recipientGets = widget.recipientGets;
    afterConversion = widget.afterConversion;
    rate = widget.rate;

    sendController.addListener(onSendAmountChanged);
  }

  @override
  void dispose() {
    sendController.removeListener(onSendAmountChanged);
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<AmountBloc, AmountState>(
        listener: (context, state) {
          if (state is AmountUpdated) {
            setState(() {
              recipientGets = state.recipientGets;
              afterConversion = state.afterConversion;
              rate = state.rate; // Update rate if it changes
            });
          }
        },
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 4),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    MyInputTextField(
                      title: "You Send",
                      controller: sendController,
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      readOnly: false,
                      suffixIcon: const Icon(Icons.usb),
                    ),
                    const SizedBox(width: 8),
                    MyInputTextField(
                      readOnly: true,
                      title: "Recipient Gets",
                      value: recipientGets,
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
                          "${sendController.text.isNotEmpty ? sendController.text : '0.0'} USD",
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                "${sendController.text.isNotEmpty ? sendController.text : '0.0'} USD",
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
              Text("${afterConversion.toStringAsFixed(2)} USD"),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text("New customer rate"),
              const Spacer(),
              Text("x $rate"),
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
                '$recipientGets NPR',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
