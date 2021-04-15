import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:topshot_scan/data/data.dart';
import 'package:topshot_scan/models/Moment.dart';
import 'package:topshot_scan/models/SearchQuery.dart';
import 'package:topshot_scan/models/TSet.dart';
import 'package:topshot_scan/models/Tag.dart';
import 'package:topshot_scan/modules/CustomToolTip/customtooltip.dart';
import 'package:topshot_scan/pages/homepage/homepage_controller.dart';
import 'package:topshot_scan/theme/color_theme.dart';
import 'package:topshot_scan/theme/nba_theme.dart';

class MomentDetails extends StatefulWidget {
  MomentDetails(this.m);

  Moment m;

  @override
  _MomentDetailsState createState() => _MomentDetailsState();
}

class _MomentDetailsState extends State<MomentDetails> {
  RxList<dynamic> s_l = Get.find<HomePageController>().set_codex;
  RxMap<dynamic, dynamic> s_map =
      Get.find<HomePageController>().set_name_id_map;
  late TSet s;
  double size = 120;
  bool rookieprem = false;

  @override
  void initState() {
    super.initState();
    for (var i in s_l) {
      if (i.id == widget.m.tset!.id) {
        s = i;
      }
    }
    if (widget.m.play!.tags != null) {
      for (var t in widget.m.play!.tags!) {
        if (t.title == "Rookie Premiere") {
          rookieprem = true;
        }
      }
    }
  }

  List<Widget> BuildTags(tags) {
    if (tags == null) {
      return [SizedBox.shrink()];
    } else {
      return tags
          .map<Widget>((e) => MyTooltip(
              message: e.title,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child:
                    ExtendedImage.asset(TAGS[e.title]!, width: 40, height: 40),
              )))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        InkWell(
          onTap: () => {
            Get.toNamed('/results',
                arguments: SearchQuery.fromMap({
                  "bySets": [s_map[s.flowName].toString()],
                  "byListingType": ["BY_USERS"],
                  "orderBy": "UPDATED_AT_DESC",
                  "searchInput": {
                    "cursor": "",
                    "direction": "RIGHT",
                    "limit": 12
                  },
                }))
          },
          child: ExtendedImage.network(
            s.assetPath.toString(),
            fit: BoxFit.fitWidth,
            cache: true,
            width: size,
            height: size,
            loadStateChanged: (ExtendedImageState state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  return Shimmer.fromColors(
                      child: Container(
                        width: size,
                        height: size,
                        color: MainColors.background,
                      ),
                      baseColor: MainColors.background,
                      highlightColor: MainColors.black.shade700,
                      period: Duration(milliseconds: 1000));
                  break;

                case LoadState.completed:
                  return null;
                  break;

                case LoadState.failed:
                  return null;
                  break;
              }
            },
          ),
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${s.flowName}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Lexend",
                      fontWeight: FontWeight.w500,
                      color: NBAColors[widget.m.play!.stats!.teamAtMoment]![
                          "text"],
                      fontSize: 20)),
              Text("(Series ${s.flowSeriesNumber})",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Lexend",
                      fontWeight: FontWeight.w500,
                      color: NBAColors[widget.m.play!.stats!.teamAtMoment]![
                          "text"],
                      fontSize: 20)),
              SizedBox(
                height: 5,
              ),
              Text(
                  RARITY[s.setVisualId!]! +
                      " - " +
                      "#/${widget.m.circulationCount}${widget.m.setPlay!.flowRetired == false ? "+" : ""}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Lexend",
                      fontWeight: FontWeight.w300,
                      fontSize: 16)),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rookieprem
                      ? BuildTags([Tag(title: "Rookie Premiere")])
                      : [
                          ...BuildTags(widget.m.play!.tags),
                          ...BuildTags(widget.m.setPlay!.tags)
                        ])
            ]),
      ]),
    );
  }
}
