import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/constants/app_text.dart';
import 'package:wallet_xuno/screens/page_indicator.dart';
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
              width: double.infinity,
              controller: sendUsdToUsdController,
              inputType: const TextInputType.numberWithOptions(decimal: true),
              readOnly: false,
              suffixIcon: SizedBox(
                  height: 40.h,
                  width: 30.w,
                  child: Image.asset('assets/images/usd.png')),
            ),
            const SizedBox(height: 12),
            CustomContainer(
              height: 118.h,
              width: 740,
              borderColor: Colors.transparent,
              backgroundColor: Appcolour.backgroundContainer,
              textColor: Colors.black,
              child: _calculateFee(),
            ),
            const SizedBox(height: 8),
            CustomContainer(
              // height: 40,
              width: 740,
              borderColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              textColor: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery time",
                    style: AppText.normalText,
                  ),
                  const Spacer(),
                  Text(
                    "4-5 business days",
                    style: AppText.normalText,
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            CustomContainer(
              height: 58.h,
              width: 740,
              borderColor: Colors.transparent,
              backgroundColor: Appcolour.backgroundContainer,
              textColor: Colors.black,
              child: Row(
                children: [
                  Text(
                    "Total debit amount",
                    style: AppText.boldText,
                  ),
                  const Spacer(),
                  Text(
                    "${sendUsdToUsdController.text.isNotEmpty ? sendUsdToUsdController.text : '0.0'} USD",
                    style: AppText.boldText,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                _navigateToPageIndicator(context, isUsdToNpr: false);
              },
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

  void _navigateToPageIndicator(BuildContext context,
      {required bool isUsdToNpr}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageIndicatorWidget(
          initialPageIndex: 1, // Set the starting page index if needed
          isUsdToNpr: isUsdToNpr,
        ),
      ),
    );
  }

  Widget _calculateFee() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Text(
              "You Send",
              style: AppText.boldText,
            ),
            const Spacer(),
            Text(
              "${sendUsdToUsdController.text.isNotEmpty ? sendUsdToUsdController.text : '0.0'} USD",
              style: AppText.boldText,
            ),
          ],
        ),
        // const SizedBox(height: 8),
        Row(
          children: [
            Text(
              "Conversion fee",
              style: AppText.normalText,
            ),
            const Spacer(),
            Text(
              "$usdToUsdConversionFee USD",
              style: AppText.normalText,
            )
          ],
        ),

        // const SizedBox(height: 8),
        Row(
          children: [
            Text(
              "Recipient gets",
              style: AppText.normalText,
            ),
            const Spacer(),
            Text(
              '$usdRecipientGets USD',
              style: AppText.normalText,
            ),
          ],
        ),
      ],
    );
  }
}
