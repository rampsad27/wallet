import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/widgets/button_container.dart';
import 'package:wallet_xuno/widgets/custom_container.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';

class UsdToNpr extends StatefulWidget {
  final TextEditingController usdTonprController;
  final double nprRecipientGets;
  final double afterUsdToNprConversion;
  final double rate;

  const UsdToNpr({
    super.key,
    required this.usdTonprController,
    required this.nprRecipientGets,
    required this.afterUsdToNprConversion,
    required this.rate,
  });

  @override
  State<UsdToNpr> createState() => _UsdToNprState();
}

class _UsdToNprState extends State<UsdToNpr> {
  late TextEditingController usdTonprController;
  late double nprRecipientGets;
  late double afterUsdToNprConversion;
  late double rate;
  String _selectedButton = "Same Day";

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
          child: SingleChildScrollView(
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
                      controller: usdTonprController,
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      readOnly: false,
                      suffixIcon: SizedBox(
                          height: 40.h,
                          width: 30.w,
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
                const Text("Do you have a coupon code? "),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonContainer(
                      height: 44.h,
                      width: 172.w,
                      text: "Instant",
                      isSelected: _selectedButton == "Instant",
                      onTap: () => _selectButton("Instant"),
                      textColour: Appcolour.black,
                    ),
                    CustomButtonContainer(
                      height: 44.h,
                      width: 172.w,
                      text: "Same Day",
                      isSelected: _selectedButton == "Same Day",
                      onTap: () => _selectButton("Same Day"),
                      textColour: Appcolour.black,
                    ),
                    CustomButtonContainer(
                      height: 44.h,
                      width: 172.w,
                      text: "Standard",
                      isSelected: _selectedButton == "Standard",
                      onTap: () => _selectButton("Standard"),
                      textColour: Appcolour.black,
                    ),
                    Stack(
                      children: [
                        CustomButtonContainer(
                          height: 44.h,
                          width: 172.w,
                          text: "Best Deal",
                          icon: SizedBox(
                              height: 24.h,
                              child: Image.asset('assets/images/stars.png')),
                          isSelected: _selectedButton == "Best Deal",
                          onTap: () => _selectButton("Best Deal"),
                          textColour: Appcolour.green,
                        ),
                        Positioned(
                          bottom: 20,
                          right:
                              20, // Adjust this to position the circle horizontally
                          child: Container(
                            width: 10, // Adjust width
                            height: 10, // Adjust height
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "You just saved ",
                              ),
                              TextSpan(
                                text: "1655 NPR",
                                style: TextStyle(
                                  color: Appcolour.green,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Text("Compare"),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.keyboard_arrow_down))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
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
              ],
            ),
          ),
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
