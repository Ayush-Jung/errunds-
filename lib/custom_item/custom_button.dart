import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final ButtonType buttonType;
  final VoidCallback? onPress;
  final double? height;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin, padding;
  final bool loading;
  CustomButton({
    required this.label,
    this.buttonType = ButtonType.Filled,
    this.onPress,
    this.margin,
    this.padding,
    this.height,
    this.color,
    this.borderRadius,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      margin: margin ?? const EdgeInsets.all(10),
      child: MaterialButton(
        height: height,
        onPressed: loading ? null : onPress,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
        minWidth: double.infinity,
        color: color ?? const Color(0xFF00A1ED),
        child: loading
            ? const CircularProgressIndicator()
            : Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}

enum ButtonType { Filled, Outlined }
