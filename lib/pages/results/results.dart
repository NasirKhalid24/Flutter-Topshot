import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:topshot_scan/models/SearchQuery.dart';
import 'package:topshot_scan/modules/LatestListings/local_widgets/moment_card.dart';
import 'package:topshot_scan/pages/homepage/homepage_controller.dart';
import 'package:topshot_scan/pages/results/results_controller.dart';
import 'package:topshot_scan/repositories/Codex_repo.dart';
import 'package:topshot_scan/theme/color_theme.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final ResultsPageController controller = Get.find<ResultsPageController>();
  RefreshController _rc = RefreshController(initialRefresh: false);
  Codex_repo cr = Codex_repo();

  ScrollController sc = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.fetchAll(Get.arguments, false);
    });
    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent &&
          controller.loading_additional.isFalse &&
          controller.limit.isFalse) {
        controller.fetchAll(Get.arguments, true);
      }
    });
  }

  void _onRefresh() async {
    cr.dataFetch();
    // monitor network fetch
    controller.fetchAll(Get.arguments, false);
    // if failed,use refreshFailed()
    _rc.refreshCompleted();
  }

  void _onLoading() async {
    cr.dataFetch();
    // monitor network fetch
    controller.fetchAll(Get.arguments, false);
    // if failed,use refreshFailed()
    _rc.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 70,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: OutlinedButton.icon(
                    icon: Icon(Icons.filter_alt),
                    label: Text("Filter Settings"),
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: MainColors.purple)),
                        minimumSize: MaterialStateProperty.all(
                            Size(double.infinity, 50))),
                    onPressed: () => {print("Tapped")}),
              ),
              SizedBox(height: 9),
              Obx(() {
                // ignore: unrelated_type_equality_checks
                if (controller.loading == true) {
                  return Center(
                    child: Container(
                      color: MainColors.background,
                      height: 500,
                      child: SpinKitSquareCircle(
                        color: MainColors.purple,
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      controller: _rc,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: GridView(
                        controller: sc,
                        scrollDirection: Axis.vertical,
                        children: [
                          for (var p in controller.loaded_moments)
                            MomentCard(
                                p, MediaQuery.of(context).size.width / 2),
                        ],
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                MediaQuery.of(context).size.width / 700,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20),
                      ),
                    ),
                  );
                }
              }),
              Obx(() {
                return controller.loading_additional.isTrue &
                        controller.limit.isFalse
                    ? SpinKitWave(
                        color: MainColors.purple,
                        size: 20.0,
                      )
                    : SizedBox.shrink();
              })
            ],
          )),
        ],
      )),
    );
  }
}
