import 'package:errunds_application/helpers/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String label;
  final IconData prefix;
  final bool loading;
  final double width;
  final IconData suffixIcon;
  final Color color;
  final Color textColor;
  final bool borderRadius;
  final Border border;

  CustomButton(
      {this.onPress,
      this.suffixIcon,
      this.prefix,
      this.label,
      this.loading = false,
      this.width,
      this.color,
      this.textColor,
      this.border,
      this.borderRadius = true});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: EdgeInsets.only(
                top: constraints.biggest.height * 0.3 > 16
                    ? 16
                    : constraints.biggest.height * 0.3),
            padding: EdgeInsets.all(constraints.biggest.height * 0.2 > 12
                ? 12
                : constraints.biggest.height * 0.2),
            width: width ?? double.maxFinite,
            constraints: const BoxConstraints(maxHeight: 44),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color ?? buttonBackgroundColor,
              border: border,
              borderRadius: BorderRadius.circular(16),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (prefix != null) ...[
                        Icon(prefix, color: Theme.of(context).backgroundColor),
                        const SizedBox(width: 20)
                      ],
                      Text(label,
                          style: TextStyle(
                            color: textColor ?? Colors.white,
                            fontSize: constraints.biggest.height > 15
                                ? 18
                                : constraints.biggest.height,
                          )),
                      if (suffixIcon != null)
                        Icon(suffixIcon,
                            color: Theme.of(context).backgroundColor),
                    ]);
              },
            ),
          );
        },
      ),
    );
  }
}
