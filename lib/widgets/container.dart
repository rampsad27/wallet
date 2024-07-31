import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final double height;
  final double width;
  final String text;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  const CustomContainer({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.borderColor,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  CustomContainerState createState() => CustomContainerState();
}

class CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(
            color: widget.borderColor,
            width: 1), // Example border color and size
        borderRadius: BorderRadius.circular(8),
        color: widget.backgroundColor,
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(color: widget.textColor), // Example text style
        ),
      ),
    );
  }
}
