import 'package:errunds_application/helpers/colors.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key key, this.icon, this.title, this.callback})
      : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.width * 0.45,
            minWidth: MediaQuery.of(context).size.width * 0.45),
        decoration: const BoxDecoration(
          color: Color(0xFFFDFAE4),
          borderRadius: BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            size: 70,
            color: secondaryColor,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                color: Color(0XFFEF2F2C),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
