import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/constants/app_text.dart';
import 'package:wallet_xuno/screens/blur_transition.dart';
import 'package:wallet_xuno/screens/page_indicator.dart';
import 'package:wallet_xuno/screens/payment_info.dart';
import 'package:wallet_xuno/widgets/button_container.dart';
import 'package:wallet_xuno/widgets/custom_container.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';

class UsdToNpr extends StatefulWidget {
  final TextEditingController sendUsdToNprController;
  final double nprRecipientGets;
  final double afterUsdToNprConversion;
  final double rate;

  const UsdToNpr({
    super.key,
    required this.sendUsdToNprController,
    required this.nprRecipientGets,
    required this.afterUsdToNprConversion,
    required this.rate,
  });

  @override
  State<UsdToNpr> createState() => _UsdToNprState();
}

class _UsdToNprState extends State<UsdToNpr> {
  late TextEditingController sendUsdToNprController;
  late double nprRecipientGets;
  late double afterUsdToNprConversion;
  late double rate;
  String _selectedButton = "Same Day";

  @override
  void initState() {
    super.initState();
    sendUsdToNprController = widget.sendUsdToNprController;
    nprRecipientGets = widget.nprRecipientGets;
    afterUsdToNprConversion = widget.afterUsdToNprConversion;
    rate = widget.rate;

    sendUsdToNprController.addListener(onSendAmountChanged);
  }

  @override
  void dispose() {
    sendUsdToNprController.removeListener(onSendAmountChanged);
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

  void _selectButton(String buttonText) {
    setState(() {
      _selectedButton = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 238, 72, 72),
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
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyInputTextField(
                    title: "You Send",
                    controller: sendUsdToNprController,
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    readOnly: false,
                    suffixIcon: SizedBox(
                        height: 40.h,
                        width: 30.w, //image
                        child: Image.asset('assets/images/usd.png')),
                  ),
                  const SizedBox(width: 8),
                  MyInputTextField(
                    readOnly: true,
                    title: "Recipient Gets",
                    value: nprRecipientGets,
                    inputType: TextInputType.number,
                    suffixIcon: SizedBox(
                        height: 40.h,
                        width: 30.w,
                        child: Image.asset('assets/images/nep.png')),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Do you have a coupon code? ",
                style: AppText.normalText,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButtonContainer(
                    height: 44.h,
                    width: 164.w,
                    text: "Instant",
                    isSelected: _selectedButton == "Instant",
                    onTap: () => _selectButton("Instant"),
                    textColour: Appcolour.black,
                  ),
                  CustomButtonContainer(
                    height: 44.h,
                    width: 164.w,
                    text: "Same Day",
                    isSelected: _selectedButton == "Same Day",
                    onTap: () => _selectButton("Same Day"),
                    textColour: Appcolour.black,
                  ),
                  CustomButtonContainer(
                    height: 44.h,
                    width: 164.w,
                    text: "Standard",
                    isSelected: _selectedButton == "Standard",
                    onTap: () => _selectButton("Standard"),
                    textColour: Appcolour.black,
                  ),
                  Stack(
                    clipBehavior: Clip.none, // Allow overflow of children
                    children: [
                      GestureDetector(
                        onTap: () => _selectButton("Best Deal"),
                        child: Container(
                          height: 44.h,
                          width: 164.w,
                          decoration: BoxDecoration(
                            color: _selectedButton == "Best Deal"
                                ? Appcolour.green
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _selectedButton == "Best Deal"
                                  ? Appcolour.green
                                  : Colors.grey,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 24.h,
                                        child: Image.asset(
                                            'assets/images/stars.png')),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "Best Deal",
                                      style: TextStyle(
                                        color: _selectedButton == "Best Deal"
                                            ? Colors.white
                                            : Appcolour.green,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -8, // Adjust as needed
                        left: 18.5, // Adjust as needed
                        child: Container(
                          width: 122.w, // Adjust size as needed
                          height: 20.h, // Adjust size as needed
                          decoration: BoxDecoration(
                            color: Appcolour.green,
                            borderRadius: BorderRadius.circular(
                                8), // Optional: rounded corners
                            border: Border.all(
                              color: Appcolour.green,
                            ),
                          ),

                          child: Center(
                            child: Text(
                              "USD 1=NPR 133.34",
                              style: TextStyle(
                                color: Appcolour.white,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomContainer(
                height: 40.h,
                width: double.infinity,
                text: "Message regarding delivery limits",
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
                      "${sendUsdToNprController.text.isNotEmpty ? sendUsdToNprController.text : '0.0'} USD",
                      style: AppText.boldText,
                    ),
                  ],
                ),
              ),
              Container(
                // height: 40,
                width: 740,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  color: Colors.transparent,
                ),

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 8, 8),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/ru.png',
                        height: 20.h,
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "You just saved ",
                              style: AppText.normalText,
                            ),
                            TextSpan(
                              text: "1655 NPR",
                              style: TextStyle(
                                color: Appcolour.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Compare",
                        style: AppText.normalText,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.keyboard_arrow_down))
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 4),
              InkWell(
                onTap: () {
                  _navigateToPageIndicator(context, isUsdToNpr: true);
                  // context.go(
                  //   '/home/pageindicator',
                  //   // extra: {
                  //   //   'usdController': sendUsdToNprController,
                  //   //   'nprValue': nprRecipientGets,
                  //   // },
                  // );
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
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
              )
            ],
          ),
        ),
      ),
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
              "${sendUsdToNprController.text.isNotEmpty ? sendUsdToNprController.text : '0.0'} USD",
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
            Text("-0.70%", style: AppText.normalText)
          ],
        ),
        Row(
          children: [
            Text("Amount after conversion fees", style: AppText.normalText),
            const Spacer(),
            Text("${afterUsdToNprConversion.toStringAsFixed(2)} USD",
                style: AppText.normalText),
          ],
        ),
        // const SizedBox(height: 8),
        Row(
          children: [
            Text("New customer rate", style: AppText.normalText),
            const Spacer(),
            Text("x $rate NPR", style: AppText.normalText),
          ],
        ),
        // const SizedBox(height: 8),
        Row(
          children: [
            Text("Recipient gets", style: AppText.boldText),
            const Spacer(),
            Text('$nprRecipientGets NPR', style: AppText.normalText),
          ],
        ),
      ],
    );
  }
}
