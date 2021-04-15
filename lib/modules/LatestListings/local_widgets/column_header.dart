import 'package:flutter/material.dart';
import 'package:topshot_scan/theme/color_theme.dart';

class ColumnHeader extends StatelessWidget {
  ColumnHeader(
    this.title,
    this.onViewMore,
  );
  final String title;
  final Function onViewMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 5),
          child: Text(title,
              style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w900,
                  fontSize: 24)),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, top: 2),
          child: TextButton(
            onPressed: () => onViewMore(),
            child: Text(
              'View More ›',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: MainColors.purple,
                  fontStyle: FontStyle.italic),
            ),
          ),
        )
      ],
    );
  }
}
