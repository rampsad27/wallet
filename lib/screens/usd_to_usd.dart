import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/widgets/custom_container.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';

class UsdToUsd extends StatefulWidget {
  final TextEditingController sendUsdToUsdController;
  final double usdRecipientGets;
  final double usdToUsdConversionFee;

  const UsdToUsd({
    super.key,
    required this.sendUsdToUsdController,
    required this.usdRecipientGets,
    required this.usdToUsdConversionFee,
  });

  @override
  State<UsdToUsd> createState() => _UsdToUsdState();
}

class _UsdToUsdState extends State<UsdToUsd> {
  late TextEditingController sendUsdToUsdController;
  late double usdRecipientGets;
  late double usdToUsdConversionFee;

  @override
  void initState() {
    super.initState();
    sendUsdToUsdController = widget.sendUsdToUsdController;
    usdRecipientGets = widget.usdRecipientGets;
    usdToUsdConversionFee = widget.usdToUsdConversionFee;

    sendUsdToUsdController.addListener(onSendAmountChanged);
  }

  @override
  void dispose() {
    sendUsdToUsdController.removeListener(onSendAmountChanged);
    super.dispose();
  }

  void onSendAmountChanged() {
    double sendValue = double.tryParse(sendUsdToUsdController.text) ?? 0.0;
    if (sendValue > 3000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount should be less than 3000')),
      );
      return;
    }
    context.read<AmountBloc>().add(UpdateUsdToUsdSenderAmount(sendValue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<AmountBloc, AmountState>(
          listener: (context, state) {
            if (state is AmountUSDUpdated) {
              setState(() {
                usdRecipientGets = state.usdRecipientGets;
                usdToUsdConversionFee = state.usdToUsdConversionFee;
              });
            }
          },
          child: Column(children: [
            const SizedBox(height: 8),
            MyInputTextField(
              title: "You Send",
              controller: sendUsdToUsdController,
              inputType: const TextInputType.numberWithOptions(decimal: true),
              readOnly: false,
              suffixIcon: SizedBox(
                  height: 40.h,
                  width: double.infinity,
                  child: Image.asset('assets/images/usd.png')),
            ),
            CustomContainer(
              height: 180.h,
              width: 740,
              borderColor: Colors.transparent,
              backgroundColor: Appcolour.backgroundContainer,
              textColor: Colors.black,
              child: _calculateFee(),
            ),
            const CustomContainer(
              // height: 40,
              width: 740,
              borderColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              textColor: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery time"),
                  Spacer(),
                  Text("4-5 business days")
                ],
              ),
            ),
            CustomContainer(
              height: 58.h,
              width: 740,
              borderColor: Colors.transparent,
              backgroundColor: Appcolour.backgroundContainer,
              textColor: Colors.black,
              child: Row(
                children: [
                  const Text(
                    "Total debit amount",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    "${sendUsdToUsdController.text.isNotEmpty ? sendUsdToUsdController.text : '0.0'} USD",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 40,
                width: 740,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  color: Appcolour.green,
                ),
                child: const Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Appcolour.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ])),
    );
  }

  Widget _calculateFee() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            const Text(
              "You Send",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              "${sendUsdToUsdController.text.isNotEmpty ? sendUsdToUsdController.text : '0.0'} USD",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // const SizedBox(height: 8),
        const Row(
          children: [Text("Conversion fee"), Spacer(), Text("-0.70%")],
        ),
        Row(
          children: [
            const Text("Amount after conversion fees"),
            const Spacer(),
            Text("${usdToUsdConversionFee.toStringAsFixed(2)} USD"),
          ],
        ),
        // const SizedBox(height: 8),
        const Row(
          children: [
            Text("New customer rate"),
            Spacer(),
          ],
        ),
        // const SizedBox(height: 8),
        Row(
          children: [
            const Text(
              "Recipient gets",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              '$usdRecipientGets USD',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
