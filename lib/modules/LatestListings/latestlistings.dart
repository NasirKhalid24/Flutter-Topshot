import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topshot_scan/models/SearchQuery.dart';
import 'package:topshot_scan/modules/LatestListings/latestlistings_controller.dart';
import 'package:topshot_scan/modules/LatestListings/local_widgets/column_header.dart';
import 'package:topshot_scan/modules/LatestListings/local_widgets/moment_card.dart';
import 'package:topshot_scan/repositories/Search_repo.dart';
import 'package:topshot_scan/theme/color_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LatestListings extends StatefulWidget {
  var heading;
  var orderby;

  LatestListings(this.heading, this.orderby);

  @override
  _LatestListingsState createState() => _LatestListingsState();
}

class _LatestListingsState extends State<LatestListings> {
  final double momentwidth = 220;
  final double momentheight = 350;
  final double momentcrop = 58;

  final LatestListingsController controller =
      Get.find<LatestListingsController>();

  late final SearchQuery s;

  @override
  void initState() {
    super.initState();

    s = SearchQuery.fromMap({
      "byListingType": ["BY_USERS"],
      "orderBy": widget.orderby,
      "searchInput": {"limit": 5},
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.fetchAll(s);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ColumnHeader(widget.heading, () {
                    Get.toNamed('/results',
                        arguments: SearchQuery.fromMap({
                          "byListingType": ["BY_USERS"],
                          "orderBy": widget.orderby,
                          "searchInput": {
                            "cursor": "",
                            "direction": "RIGHT",
                            "limit": 4
                          },
                        }));
                  }),
                  Obx(() {
                    // ignore: unrelated_type_equality_checks
                    if (controller.loading == true) {
                      return Container(
                        width: double.infinity,
                        height: momentheight,
                        color: MainColors.background,
                        child: SpinKitSquareCircle(
                          color: MainColors.purple,
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var p in controller.latest_moments)
                              MomentCard(p, momentwidth,
                                  hero_tag: widget.orderby)
                          ],
                        ),
                      );
                    }
                  }),
                ])));
  }
}
