import 'package:flutter/material.dart';
import 'package:topshot_scan/theme/color_theme.dart';

class SearchContainer extends StatelessWidget {
  SearchContainer(this.text, this.header, this.ontap);

  String text;
  bool header = false;
  var ontap;
  Map<String, IconData> icon_header = {
    "Players": Icons.emoji_people,
    "Teams": Icons.sports_basketball,
    "Sets": Icons.collections_bookmark,
    "Users": Icons.switch_account
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: header ? 60 : 50,
        color: header ? MainColors.black.shade700 : MainColors.black.shade900,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: header
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              children: [
                header
                    ? Icon(icon_header[text])
                    : Text(text,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Lexend",
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                SizedBox(width: 7),
                header
                    ? Text(text,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Lexend",
                            fontSize: 16,
                            fontWeight: FontWeight.w700))
                    : Icon(Icons.arrow_forward, size: 14),
              ],
            )),
      ),
    );
  }
}
