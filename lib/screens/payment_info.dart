import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/constants/app_text.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';

class PaymentInfo extends StatefulWidget {
  // final TextEditingController usdController;
  // final double nprValue;

  const PaymentInfo({
    super.key,
    // required this.usdController,
    // required this.nprValue,
  });

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(0, 5, 128, 87),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyInputTextField(
                    title: "You Send",
                    // controller: widget.usdController,
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    readOnly: false,
                    suffixIcon: SizedBox(
                        height: 40.h,
                        width: 30.w,
                        child: Image.asset('assets/images/usd.png')),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: MyInputTextField(
                    readOnly: true,
                    title: "Recipient Gets",
                    // value: widget.nprValue,
                    inputType: TextInputType.number,
                    suffixIcon: SizedBox(
                        height: 40.h,
                        width: 30.w,
                        child: Image.asset('assets/images/nep.png')),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Text("Bank Account*", style: AppText.hindTextNormal),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: "Enter Bank Name",
                  hintStyle: AppText.hindlabelText),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Add another bank account",
                  style: AppText.hindButtonText),
            ),
            SizedBox(height: 16.h),
            Text("Select Recipient*", style: AppText.hindTextNormal),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Select your recipient",
                  hintStyle: AppText.hindlabelText),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Add personal recipient",
                      style: AppText.hindButtonText),
                ),
                const Spacer(),
                Text("Now you can", style: AppText.hindlabelgreyText),
                TextButton(
                  onPressed: () {},
                  child: Text("add business recipient",
                      style: AppText.hindButtonText),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text("Reason For Sending Money ", style: AppText.hindTextNormal),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  hintText: "Select reason for sendinng money",
                  hintStyle: AppText.hindlabelText),
            ),
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                color: Appcolour.green,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 56.h,
              width: double.infinity,
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Text(
                    'Transfer Money',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
