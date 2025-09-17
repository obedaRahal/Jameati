import 'package:flutter/material.dart';

class CustomBackgroundWithWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double borderRadius;
  final Widget child;
  Alignment alignment;

  CustomBackgroundWithWidget({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.borderRadius,
    required this.child,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: child,
    );
  }
}
