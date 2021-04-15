import 'package:flutter/material.dart';
import 'package:topshot_scan/theme/color_theme.dart';

class Maintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: MainColors.black.shade600,
      child: AlertDialog(
        backgroundColor: MainColors.background,
        title: Center(
          child: Text("Under Maintenance",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Lexend",
                  color: MainColors.purple,
                  fontSize: 28,
                  fontWeight: FontWeight.w400)),
        ),
        content: Center(
            widthFactor: 0.2,
            heightFactor: 1.2,
            child: Text(
              "We will be back soon, this interruption will not affect your alerts\n\nSee you in a bit!",
              style: TextStyle(),
              textAlign: TextAlign.center,
            )),
      ),
    ));
  }
}
