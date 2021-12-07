import 'package:errunds_application/helpers/colors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer(
      {this.child,
      this.borderRadius,
      this.shadow = false,
      this.margin,
      this.padding,
      this.color,
      this.borderColor,
      this.border});
  final Widget child;
  final bool shadow;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  final Color borderColor;
  final Border border;
  final BorderRadius borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(8),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: color ?? primaryColor,
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(10)),
        border: this.border ??
            Border.all(color: borderColor ?? Colors.grey, width: 1.5),
        boxShadow: shadow
            ? [
                BoxShadow(
                    color: borderColor ?? Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 10))
              ]
            : [],
      ),
      child: child,
    );
  }
}
