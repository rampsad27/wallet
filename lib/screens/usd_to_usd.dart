import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/widgets/custom_container.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';

class UsdToUsd extends StatefulWidget {
  final TextEditingController usdTonprController;
  final double nprRecipientGets;
  final double afterUsdToNprConversion;
  final double rate;
  const UsdToUsd({
    super.key,
    required this.usdTonprController,
    required this.nprRecipientGets,
    required this.afterUsdToNprConversion,
    required this.rate,
  });

  @override
  State<UsdToUsd> createState() => _UsdToUsdState();
}

class _UsdToUsdState extends State<UsdToUsd> {
  late TextEditingController usdTonprController;
  late double nprRecipientGets;
  late double afterUsdToNprConversion;
  late double rate;
  @override
  void initState() {
    super.initState();
    usdTonprController = widget.usdTonprController;
    nprRecipientGets = widget.nprRecipientGets;
    afterUsdToNprConversion = widget.afterUsdToNprConversion;
    rate = widget.rate;

    usdTonprController.addListener(onSendAmountChanged);
  }

  @override
  void dispose() {
    usdTonprController.removeListener(onSendAmountChanged);
    super.dispose();
  }

  void onSendAmountChanged() {
    double sendValue = double.tryParse(usdTonprController.text) ?? 0.0;
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
                nprRecipientGets = state.nprRecipientGets;
                afterUsdToNprConversion = state.afterUsdToNprConversion;
                rate = state.rate; // Update rate if it changes
              });
            }
          },
          child: Column(children: [
            const SizedBox(height: 8),
            MyInputTextField(
              title: "You Send",
              controller: usdTonprController,
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
                    "${usdTonprController.text.isNotEmpty ? usdTonprController.text : '0.0'} USD",
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
              "${usdTonprController.text.isNotEmpty ? usdTonprController.text : '0.0'} USD",
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
            Text("${afterUsdToNprConversion.toStringAsFixed(2)} USD"),
          ],
        ),
        // const SizedBox(height: 8),
        Row(
          children: [
            const Text("New customer rate"),
            const Spacer(),
            Text("x $rate"),
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
              '$nprRecipientGets NPR',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
