import 'package:flutter/material.dart';
import 'package:topshot_scan/theme/color_theme.dart';

class CustomDrawerHeader extends StatelessWidget {
  var icon_t;

  var text;

  CustomDrawerHeader(this.icon_t, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
          icon: Icon(icon_t),
          color: MainColors.purple.shade300,
          onPressed: () => {}),
      Text(
        text,
        style: TextStyle(
            fontFamily: "Lexend", fontWeight: FontWeight.w600, fontSize: 17),
      ),
    ]);
  }
}
