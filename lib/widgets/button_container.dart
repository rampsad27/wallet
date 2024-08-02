import 'package:flutter/material.dart';
import 'package:wallet_xuno/constants/appColour.dart';

class CustomButtonContainer extends StatefulWidget {
  final double? height;
  final double? width;
  final String text;
  final Icon? icon;

  const CustomButtonContainer({
    super.key,
    this.height,
    this.width,
    required this.text,
    this.icon,
  });

  @override
  CustomButtonContainerState createState() => CustomButtonContainerState();
}

class CustomButtonContainerState extends State<CustomButtonContainer> {
  final Color _borderColor = Appcolour.border;
  Color _backgroundColor = Colors.transparent;

  void _onTap() {
    setState(() {
      _backgroundColor = _backgroundColor == Colors.transparent
          ? Appcolour.green
          : Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(
              color: _borderColor, width: 1), // Example border color and size
          borderRadius: BorderRadius.circular(6),
          color: _backgroundColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: 8), // Add some space
              ],
              Text(
                widget.text,
                style:
                    const TextStyle(color: Colors.black), // Example text style
              ),
            ],
          ),
        ),
      ),
    );
  }
}
