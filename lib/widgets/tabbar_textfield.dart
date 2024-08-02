import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/appColour.dart';

class MyInputTextField extends StatefulWidget {
  final String title;
  final double? value;
  final TextInputType inputType;
  final Icon? suffixIcon;
  final TextEditingController? controller;
  final bool readOnly;

  const MyInputTextField({
    super.key,
    required this.title,
    required this.inputType,
    this.value,
    this.suffixIcon,
    this.controller,
    required this.readOnly,
  });

  @override
  _MyInputTextFieldState createState() => _MyInputTextFieldState();
}

class _MyInputTextFieldState extends State<MyInputTextField> {
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
      width: 368.w,
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor, width: _borderSize),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _textEditingController,
              readOnly: widget.readOnly,
              keyboardType: widget.inputType,
              maxLength: 500,
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
