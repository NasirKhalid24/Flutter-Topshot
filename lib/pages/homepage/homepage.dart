import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topshot_scan/modules/LatestListings/latestlistings.dart';
import 'package:topshot_scan/modules/searchbar/searchbar.dart';
import 'package:topshot_scan/pages/drawer/drawer.dart';
import 'package:topshot_scan/pages/homepage/homepage_controller.dart';
import 'package:topshot_scan/theme/color_theme.dart';

class HomePage extends GetView<HomePageController> {
  final HomePageController controller = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Theme(
          data: Theme.of(context)
              .copyWith(canvasColor: MainColors.black.shade900),
          child: HomeDrawer()),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 70),
              child: ClipRect(
                  child: ListView(
                children: [
                  // LatestListings("Latest Listings", "UPDATED_AT_DESC"),
                  LatestListings("Most Expensive", "PRICE_USD_DESC"),
                ],
              ))),
          buildFloatingSearchBar()
        ],
      )),
    );
  }
}
