import 'package:beyondmarks/ui/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final Function function;
  final String text;
  final TextStyle textStyle;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;

  const DefaultTextButton({
    required this.function,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.41,
      height: 0.09,
    ),
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: width ?? 345,
        height: height ?? 56,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: TextButton(
          onPressed: function as void Function()?,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
