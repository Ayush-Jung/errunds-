import 'package:errunds_application/helpers/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) saved;
  final Function(String) onvalidate;
  final String label, initialValue;
  final TextInputType textInputType;
  final bool obscureText;
  const CustomTextField({
    Key key,
    this.saved,
    this.onvalidate,
    this.label,
    this.textInputType,
    this.obscureText = false,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        keyboardType: textInputType,
        obscureText: obscureText,
        initialValue: initialValue,
        decoration: InputDecoration(
          isDense: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          labelText: label,
        ),
        validator: (value) => onvalidate(value),
        onSaved: (value) => saved(value),
      ),
    );
  }
}

getKeyValue(BuildContext context, String key,
    {Widget icon,
    String value,
    Widget widgetValue,
    bool div = true,
    Color valueColor}) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: icon,
                ),
                const SizedBox(width: 2),
                Text(key,
                    style: Theme.of(context)
                        .accentTextTheme
                        .subtitle2
                        .copyWith(color: valueColor ?? secondaryColor)),
              ],
            ),
            if (widgetValue != null)
              Expanded(child: widgetValue)
            else
              Expanded(
                child: Text(
                  value ?? "",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).accentTextTheme.subtitle1.copyWith(
                        color: valueColor ?? secondaryColor,
                        fontSize: 12,
                      ),
                ),
              )
          ],
        ),
      ),
      if (div == true) const Divider(height: 1) else const SizedBox(),
    ],
  );
}
