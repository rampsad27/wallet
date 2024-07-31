import 'package:flutter/material.dart';

class CustomButtonContainer extends StatefulWidget {
  final double height;
  final double width;
  final String text;
  final Icon? icon;

  const CustomButtonContainer({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    this.icon,
  });

  @override
  CustomButtonContainerState createState() => CustomButtonContainerState();
}

class CustomButtonContainerState extends State<CustomButtonContainer> {
  final Color _borderColor = Colors.black;
  Color _backgroundColor = Colors.transparent;

  void _onTap() {
    setState(() {
      _backgroundColor = _backgroundColor == Colors.transparent
          ? Colors.green
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
          borderRadius: BorderRadius.circular(8),
          color: _backgroundColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(
                    width: 8), // Add some space between the icon and text
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
