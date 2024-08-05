import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';
import 'package:wallet_xuno/constants/app_text.dart';
import 'package:wallet_xuno/widgets/tabbar_textfield.dart';
import 'package:wallet_xuno/widgets/text_textfield.dart';

class UsdPaymentInfo extends StatefulWidget {
  // final TextEditingController usdController;
  // final double nprValue;

  const UsdPaymentInfo({
    super.key,
    // required this.usdController,
    // required this.nprValue,
  });

  @override
  State<UsdPaymentInfo> createState() => _UsdPaymentInfoState();
}

class _UsdPaymentInfoState extends State<UsdPaymentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyInputTextField(
            title: "You Send",
            width: double.infinity,

            // controller: sendUsdToUsdController,
            inputType: const TextInputType.numberWithOptions(decimal: true),
            readOnly: false,
            suffixIcon: SizedBox(
                height: 40.h,
                width: 30.w,
                child: Image.asset('assets/images/usd.png')),
          ),
          SizedBox(height: 18.h),
          Text("Bank Account*", style: AppText.hindTextNormal),
          SizedBox(height: 8.h),
          const TextTextField(
            hintText: 'Enter your bank name',
          ),
          TextButton(
            onPressed: () {},
            child:
                Text("Add another bank account", style: AppText.hindButtonText),
          ),
          SizedBox(height: 8.h),
          Text("Select Recipient*", style: AppText.hindTextNormal),
          SizedBox(height: 8.h),
          const TextTextField(
            hintText: "Select your recipient",
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
          SizedBox(height: 8.h),
          Text("Reason For Sending Money ", style: AppText.hindTextNormal),
          SizedBox(height: 8.h),
          const TextTextField(
            // border: Border.all(color: Appcolour.grey.grey),
            hintText: "Select reason for sending money",
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
              onTap: () => _showTransferDialog(context),
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
      ),
    );
  }

  void _showTransferDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Container(
            width: 920.w,
            height: 690.h,
            padding: const EdgeInsets.fromLTRB(60, 40, 50, 70),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header section with a close button

                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                ),
                Text(
                  'Confirm Transaction',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                // Add your dialog content here
                Expanded(
                  child: Center(
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions ",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 379.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: Appcolour.green,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Appcolour.green,
                        ), // Border color
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          // Add your action here
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 379.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.red), // Border color
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Appcolour.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
