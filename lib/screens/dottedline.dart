import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double width;
  final double height;
  final double lineWidth;
  final Color color;

  const DottedLine({
    super.key,
    this.width = double.infinity,
    this.height = 2.0,
    this.lineWidth = 5.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth =
            width == double.infinity ? constraints.maxWidth : width;
        return Container(
          width: boxWidth,
          height: height,
          color: color,
        );
      },
    );
  }
}
