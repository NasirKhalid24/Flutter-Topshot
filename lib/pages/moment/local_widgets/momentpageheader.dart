import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:topshot_scan/data/data.dart';
import 'package:topshot_scan/models/Moment.dart';
import 'package:topshot_scan/theme/color_theme.dart';
import 'package:topshot_scan/theme/nba_theme.dart';

class MomentPageHeader extends StatelessWidget {
  MomentPageHeader(this.m);

  Moment m;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m.play!.stats!.playerName!,
                    style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 23,
                        color:
                            NBAColors[m.play!.stats!.teamAtMoment]!["primary"],
                        fontWeight: FontWeight.w700),
                  ),
                  Text(m.play!.stats!.playCategory!,
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 18,
                          color:
                              NBAColors[m.play!.stats!.teamAtMoment]!["text"],
                          fontWeight: FontWeight.w500)),
                  Container(
                    height: 5,
                    width: 100,
                  ),
                  Text(
                    DateFormat("dd MMM yyyy")
                        .format(m.play!.stats!.dateOfMoment!),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
              width: 80,
              height: 80,
              child: Center(
                child: SvgPicture.asset(
                  paths[m.play!.stats!.teamAtMoment],
                  width: 80,
                  height: 80,
                ),
              ))),
      Expanded(
        child: Center(
          child: Text(
            "#${m.play!.stats!.jerseyNumber.toString()}",
            style: TextStyle(
                fontSize: 32,
                fontFamily: "Varsity",
                color: NBAColors[m.play!.stats!.teamAtMoment]!["primary"]),
          ),
        ),
      ),
    ]);
  }
}
