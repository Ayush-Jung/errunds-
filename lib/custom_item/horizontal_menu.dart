import 'package:errunds_application/helpers/colors.dart';
import 'package:flutter/material.dart';

class HorizontalMenuLab extends StatelessWidget {
  HorizontalMenuLab(this.items, this.selected, this.onChanged,
      {this.fontSize, this.padding});
  final List items;
  final selected;
  final Function onChanged;
  final double fontSize;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor.withOpacity(0.2)),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: items.map(
          (item) {
            bool isLast = items.indexOf(item) == items.length - 1;

            bool isFirst = items.indexOf(item) == 0;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  onChanged(item);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: padding ?? const EdgeInsets.all(6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected == item ? primaryColor : Colors.white,
                    borderRadius: isFirst || isLast
                        ? BorderRadius.only(
                            topLeft: Radius.circular(isFirst ? 12 : 0),
                            bottomLeft: Radius.circular(isFirst ? 12 : 0),
                            topRight: Radius.circular(isLast ? 12 : 0),
                            bottomRight: Radius.circular(isLast ? 12 : 0))
                        : null,
                  ),
                  height: MediaQuery.of(context).size.height * 0.01,
                  constraints: const BoxConstraints(minHeight: 40.0),
                  child: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).accentTextTheme.subtitle1.copyWith(
                          color: selected == item
                              ? Colors.white
                              : buttonBackgroundColor,
                          fontSize: fontSize ?? 12,
                        ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
