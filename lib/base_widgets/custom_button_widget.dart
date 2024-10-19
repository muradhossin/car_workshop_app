import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final BoxDecoration? decoration;
  final AlignmentGeometry? alignment;
  final BorderRadiusGeometry? borderRadius;
  final BoxShadow? boxShadow;
  final Gradient? gradient;

  CustomButtonWidget({
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.color,
    this.textColor,
    this.textStyle,
    this.decoration,
    this.alignment,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: decoration ??
          BoxDecoration(
            gradient: gradient ??
                LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
            color: color ?? Colors.blue,
            borderRadius: borderRadius ?? BorderRadius.circular(8.0),
            boxShadow: boxShadow != null
                ? [boxShadow!]
                : [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
          ),
      child: Material(
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white.withOpacity(0.3),
          child: Container(
            padding: padding ?? const EdgeInsets.all(8.0),
            alignment: alignment,
            child: Center(
              child: Text(
                text,
                style: textStyle ??
                    TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
