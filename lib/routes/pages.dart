// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:topshot_scan/pages/homepage/homepage.dart';
import 'package:topshot_scan/pages/homepage/homepage_bindings.dart';
import 'package:topshot_scan/pages/moment/momentpage.dart';
import 'package:topshot_scan/pages/moment/momentpage_bindings.dart';
import 'package:topshot_scan/pages/results/results.dart';
import 'package:topshot_scan/pages/results/results_bindings.dart';
import 'package:topshot_scan/routes/routes.dart';

class Pages {
  static final pages = [
    GetPage(
        name: Routes.HOME, page: () => HomePage(), binding: HomePageBinding()),
    GetPage(
        name: Routes.MOMENT,
        page: () => MomentPage(),
        transition: Transition.noTransition,
        transitionDuration: Duration(milliseconds: 250),
        binding: MomentPageBinding()),
    GetPage(
        name: Routes.RESULTS,
        page: () => Results(),
        binding: ResultsPageBinding())
  ];
}
