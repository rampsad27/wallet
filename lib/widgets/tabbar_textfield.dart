import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/app_colour.dart';

class MyInputTextField extends StatefulWidget {
  final String title;
  final double? value;
  final TextInputType inputType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool readOnly;
  final double? height;
  final double? width;
  // final String? Function(String?)? validator;

  const MyInputTextField({
    super.key,
    required this.title,
    required this.inputType,
    this.value,
    this.suffixIcon,
    this.controller,
    required this.readOnly,
    this.height,
    this.width,
    // this.validator,
  });

  @override
  MyInputTextFieldState createState() => MyInputTextFieldState();
}

class MyInputTextFieldState extends State<MyInputTextField> {
  late TextEditingController _textEditingController;
  final Color _borderColor = Appcolour.border;
  final double _borderSize = 1;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ?? TextEditingController();
    if (widget.value != null) {
      _textEditingController.text = widget.value.toString();
    }
  }

  @override
  void didUpdateWidget(MyInputTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null &&
        widget.value.toString() != _textEditingController.text) {
      _textEditingController.text = widget.value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 80.h,
      width: widget.width ?? 340.w,
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor, width: _borderSize),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: _textEditingController,
              readOnly: widget.readOnly,
              keyboardType: widget.inputType,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(
                    r'^\d*\.?\d{0,2}')), //to ensure 2 digits after decimal+ only int as input
              ],
              maxLength: 1000,
              // validator: widget.validator,
              decoration: InputDecoration(
                labelText: widget.title,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                counterText: "",
                suffixIcon: widget.suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
