import 'package:flutter/material.dart';

class ShadowButton extends Container {
  final Widget buttonChild;
  final Color buttonColor;
  final double borderRadius;
  final Function() onPressed;

  ShadowButton({
    super.key,
    required this.buttonChild,
    required this.buttonColor,
    required this.borderRadius,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: buttonColor.withAlpha(100),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: buttonColor,
        ),
        child: buttonChild,
      ),
    );
  }
}
