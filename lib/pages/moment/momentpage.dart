import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:topshot_scan/data/data.dart';
import 'package:topshot_scan/models/Moment.dart';
import 'package:topshot_scan/modules/PriceSerialNumberChart/priceserialnumberchart.dart';
import 'package:topshot_scan/modules/PriceSerialNumberChart/priceserialnumberchart_controller.dart';
import 'package:topshot_scan/pages/moment/momentpage_controller.dart';
import 'package:topshot_scan/repositories/Moment_repo.dart';
import 'package:topshot_scan/theme/color_theme.dart';
import 'package:topshot_scan/theme/nba_theme.dart';

import 'local_widgets/listingschart.dart';
import 'local_widgets/momentdetails.dart';
import 'local_widgets/momentpageheader.dart';
import 'local_widgets/momentvideo.dart';

class MomentPage extends StatefulWidget {
  @override
  _MomentPageState createState() => _MomentPageState();
}

class _MomentPageState extends State<MomentPage> {
  MomentPageController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.fetchAll(Get.parameters['setID']!, Get.parameters['playID']!);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    print(
        "[GETX] \"MomentPageController\" and chart controller deleted from memory");
  }

  @override
  Widget build(BuildContext context) {
    return mounted
        ? Container(
            child: Scaffold(
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
                          onPressed: Get.back),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          MomentVideo(
                              Get.parameters['playID'],
                              Get.parameters['assetPrefix'],
                              Get.parameters['team'],
                              hero: Get.parameters['hero']),
                          Obx(() {
                            if (controller.loading.isTrue) {
                              return Center(
                                child: Container(
                                    child: SpinKitCircle(
                                        color: MainColors.purple)),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    MomentPageHeader(controller.m.value!),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    MomentDetails(controller.m.value!),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    Text(
                                        "Details on lowest ask and listings here"),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    PriceSerialNumberChart(
                                        listings:
                                            controller.m.value.momentListings!,
                                        scatterColors: [
                                          NBAColors[controller.m.value.play!
                                              .stats!.teamAtMoment]!["primary"],
                                          NBAColors[controller.m.value.play!
                                              .stats!.teamAtMoment]!["text"]
                                        ],
                                        jerseynumber: controller
                                            .m.value.play!.stats!.jerseyNumber)
                                  ],
                                ),
                              );
                            }
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Text("Not Mounted");
  }
}

//                AnimatedCrossFade(
//                     firstChild: Hero(
//                       tag: "${Get.parameters['playID']}",
//                       child: ExtendedImage.network(
//                         "${Get.parameters['assetPrefix']}${image_endpoint}",
//                       ),
//                     ),
//                     secondChild: BetterPlayer.network(
//                         "${Get.parameters['assetPrefix']}${video_endpoint}"),
//                     crossFadeState: CrossFadeState.showSecond,
//                     duration: Duration(seconds: 1),
//                   ),
//                   Obx(() {
//                     if (controller.loading.isTrue) {
//                       return SpinKitCircle(color: MainColors.purple);
//                     } else {
//                       return Column(
//                         children: [
//                           MomentPageHeader(
//                             m.play!.stats!.playerName!,
//                             m.play!.stats!.playCategory!,
//                             m.play!.stats!.dateOfMoment!,
//                             m.tset!.flowName!,
//                             m.play!.description!,
//                             m.play!.stats!.jerseyNumber!,
//                             m.play!.stats!.teamAtMoment!,
//                           )
//                         ],
//                       );
//                     }
//                   })

// Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   MomentVideo(
//                       Get.parameters['playID'], Get.parameters['assetPrefix']),
//                   Obx(() {
//                     if (controller.loading.isTrue) {
//                       return Expanded(
//                           child: SpinKitCircle(color: MainColors.purple));
//                     } else {
//                       return Expanded(
//                           child: Container(
//                         color: Colors.red,
//                       ));
//                     }
//                   })
//                 ],
//               )
