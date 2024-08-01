import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_xuno/constants/appColour.dart';

class MyInputTextField extends StatefulWidget {
  final String title;
  final double? value;
  // final String hint;
  // final String helperText;
  final TextInputType inputType;
  // final Color backColor;
  final Icon? suffixIcon;
  final TextEditingController? controller;
  final bool readOnly;

  const MyInputTextField({
    super.key,
    required this.title,
    // required this.hint,
    // required this.helperText,
    required this.inputType,
    // required this.backColor,
    this.value,
    this.suffixIcon,
    this.controller,
    required this.readOnly,
  });

  @override
  _MyInputTextFieldState createState() => _MyInputTextFieldState();
}

class _MyInputTextFieldState extends State<MyInputTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  // final FocusNode _focusNode = FocusNode();
  final Color _borderColor = Appcolour.border;
  final double _borderSize = 1;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.value.toString();

    // _focusNode.addListener(() {
    //   setState(() {
    //     _borderSize = _focusNode.hasFocus ? 1.7 : 1;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      width: 355.w,
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor, width: _borderSize),
        borderRadius: BorderRadius.circular(8),
        // color: widget.backColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _textEditingController,
              // focusNode: _focusNode,
              readOnly: widget.readOnly,
              keyboardType: widget.inputType,
              // cursorColor: Colors.white,
              maxLength: 500,
              maxLines: 1,
              decoration: InputDecoration(
                counterText: "",
                // hintText: widget.hint,
                hintStyle: const TextStyle(color: Appcolour.black),
                floatingLabelStyle: const TextStyle(color: Appcolour.black),
                labelText: widget.title,
                // helperText: widget.helperText,
                border: InputBorder.none,
                suffixIcon: widget.suffixIcon,
              ),
            ),
          ),
          // const Icon(Icons.check),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}
