import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/bloc/amount_bloc.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';

class PaymentInfo extends StatefulWidget {
  // final TextEditingController sendUsdToNprController;
  // final double nprRecipientGets;
  // final double afterUsdToNprConversion;
  // final double rate;
  const PaymentInfo({
    super.key,
    // required this.sendUsdToNprController,
    // required this.nprRecipientGets,
    // required this.afterUsdToNprConversion,
    // required this.rate
  });

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  // late TextEditingController sendUsdToNprController;
  // late double nprRecipientGets;
  // late double afterUsdToNprConversion;
  // late double rate;

  // @override
  // void initState() {
  //   super.initState();
  //   // sendUsdToNprController = widget.sendUsdToNprController;
  //   // nprRecipientGets = widget.nprRecipientGets;
  //   // afterUsdToNprConversion = widget.afterUsdToNprConversion;
  //   // rate = widget.rate;

  //   sendUsdToNprController.addListener(onSendAmountChanged);
  // }

  // @override
  // void dispose() {
  //   sendUsdToNprController.removeListener(onSendAmountChanged);
  //   super.dispose();
  // }

  // void onSendAmountChanged() {
  //   double sendValue = double.tryParse(sendUsdToNprController.text) ?? 0.0;
  //   if (sendValue > 3000) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Amount should be less than 3000')),
  //     );
  //     return;
  //   }
  //   context.read<AmountBloc>().add(UpdateSenderAmount(sendValue));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AmountBloc, AmountState>(
        listener: (context, state) {
          // if (state is AmountUpdated) {
          //   setState(() {
          //     nprRecipientGets = state.nprRecipientGets;
          //     afterUsdToNprConversion = state.afterUsdToNprConversion;
          //     rate = state.rate; // Update rate if it changes
          //   });
          // }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyInputTextField(
              title: "You Send",
              // controller: sendUsdToNprController,
              inputType: const TextInputType.numberWithOptions(decimal: true),
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
              // value: nprRecipientGets,
              inputType: TextInputType.number,
              suffixIcon: SizedBox(
                  height: 40.h,
                  width: 30.w,
                  child: Image.asset('assets/images/nep.png')),
            ),
          ],
        ),
      ),
    );
  }
}
