import 'package:extended_image/extended_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:statistical_dart/statistical_dart.dart';
import 'package:topshot_scan/modules/PriceSerialNumberChart/priceserialnumberchart_controller.dart';
import 'package:topshot_scan/theme/color_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class PriceSerialNumberChart extends StatefulWidget {
  PriceSerialNumberChart(
      {required this.listings,
      required this.scatterColors,
      required this.jerseynumber});

  var listings;
  var scatterColors;
  var jerseynumber;

  @override
  _PriceSerialNumberChart createState() => _PriceSerialNumberChart();
}

class _PriceSerialNumberChart extends State<PriceSerialNumberChart> {
  PriceSerialNumberChartController controller =
      Get.find<PriceSerialNumberChartController>();

  late RangeValues x_range_init = RangeValues(0, 1);
  late RangeValues y_range_init = RangeValues(0, 1);
  Color background_chart = Color(0xff0C0C0C);

  @override
  void initState() {
    super.initState();
    controller.ready.value = false;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      x_range_init = GetRangeValuesInit(widget.listings, true);
      y_range_init = GetRangeValuesInit(widget.listings, false);
      controller.x_slider_range.value = x_range_init;
      controller.y_slider_range.value = y_range_init;
      controller.main_data.value =
          GetMainData(false, x_range_init, y_range_init);
      controller.filter_data.value =
          GetMainData(true, x_range_init, y_range_init);
      controller.ready.value = true;
      setState(() => {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.ready.isTrue
        ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(
              children: [
                SizedBox(height: 5),
                Text(
                  "Market Listings",
                  style: TextStyle(
                      color: widget.scatterColors[0],
                      fontFamily: "Lexend",
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Obx(() {
              return Container(
                width: double.infinity,
                height: 450,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Card(
                      color: background_chart,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: controller.filter.isTrue
                            ? ScatterChart(controller.filter_data.value)
                            : ScatterChart(controller.main_data.value),
                      )),
                ),
              );
            }),
            SizedBox(
              height: 6,
            ),
            Obx(() {
              return Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color: background_chart,
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: controller.view_image_url.string == ""
                      ? Center(
                          child: Text(
                            "Touch a point to see listing ↑",
                            style: TextStyle(
                                color: widget.scatterColors[1],
                                fontFamily: "Lexend",
                                fontSize: 14),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 11, right: 11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: ExtendedImage.network(
                                  controller.view_image_url.string,
                                  height: 40,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Text(controller.view_username.string,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontFamily: "Lexend")),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 11),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "#${controller.view_serial.string}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: "Lexend",
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text("\$${controller.view_price.string}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: "Lexend",
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.open_in_new),
                                  color: widget.scatterColors[0],
                                  onPressed: () => _launchURL(
                                      "https://nbatopshot.com/moment/${controller.view_username.string}+${controller.view_id.string}"))
                            ],
                          ),
                        ));
            }),
            widget.listings.length > 10
                ? Obx(() {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Filter Data: ",
                                style: TextStyle(
                                    color:
                                        widget.scatterColors[1] == Colors.black
                                            ? Colors.white
                                            : widget.scatterColors[1],
                                    fontFamily: "Lexend",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700)),
                            FlutterSwitch(
                              value: controller.filter.isTrue,
                              borderRadius: 0,
                              activeColor:
                                  widget.scatterColors[1] == Colors.black
                                      ? Colors.blueAccent
                                      : widget.scatterColors[1],
                              height: 25,
                              width: 50,
                              toggleSize: 10,
                              onToggle: (e) {
                                controller.filter.toggle();
                              },
                            ),
                            IconButton(
                                padding: EdgeInsets.only(left: 5),
                                icon: Icon(Icons.help),
                                iconSize: 20,
                                onPressed: () => {
                                      Get.defaultDialog(
                                        title: "Filtering Listings",
                                        backgroundColor: Colors.white,
                                        titleStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Lexend",
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                        content: Column(children: [
                                          Center(
                                            child: Text(
                                                "The theory for filtering data comes from Taylor Stein and his blog @MintedMoment.\n\nTap the logo below to visit his page and see how his research lets us cut through the noise and see the best lisitngs\n\n",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Lexend",
                                                    fontSize: 17)),
                                          ),
                                          GestureDetector(
                                            onTap: () => _launchURL(
                                                "https://mintedmoment.substack.com/p/simple-marketplace-strategies"),
                                            child: ExtendedImage.asset(
                                                "lib/assets/mintedmoment.png"),
                                          )
                                        ]),
                                      )
                                    })
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Serial # Range",
                                  style: TextStyle(
                                      color: widget.scatterColors[1] ==
                                              Colors.black
                                          ? Colors.white
                                          : widget.scatterColors[1],
                                      fontFamily: "Lexend",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                    showValueIndicator:
                                        ShowValueIndicator.always,
                                    valueIndicatorColor: background_chart,
                                    valueIndicatorTextStyle: TextStyle(
                                        color: widget.scatterColors[1])),
                                child: RangeSlider(
                                  min: x_range_init.start,
                                  max: x_range_init.end,
                                  activeColor: widget.scatterColors[0],
                                  labels: RangeLabels(
                                    controller.x_slider_range.value.start
                                        .round()
                                        .toString(),
                                    controller.x_slider_range.value.end
                                        .round()
                                        .toString(),
                                  ),
                                  values: controller.x_slider_range.value,
                                  onChanged: (e) =>
                                      {controller.x_slider_range.value = e},
                                  onChangeStart: (e) => {},
                                  onChangeEnd: (e) => UpdateGraphX(
                                      e, controller.y_slider_range.value),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Price \$ Range",
                                  style: TextStyle(
                                      color: widget.scatterColors[1] ==
                                              Colors.black
                                          ? Colors.white
                                          : widget.scatterColors[1],
                                      fontFamily: "Lexend",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                    showValueIndicator:
                                        ShowValueIndicator.always,
                                    valueIndicatorColor: background_chart,
                                    valueIndicatorTextStyle: TextStyle(
                                        color: widget.scatterColors[1])),
                                child: RangeSlider(
                                  min: y_range_init.start,
                                  max: y_range_init.end,
                                  activeColor: widget.scatterColors[0],
                                  labels: RangeLabels(
                                      controller.y_slider_range.value.start
                                          .toInt()
                                          .toString(),
                                      controller.y_slider_range.value.end
                                          .toInt()
                                          .toString()),
                                  values: controller.y_slider_range.value,
                                  onChanged: (e) =>
                                      {controller.y_slider_range.value = e},
                                  onChangeEnd: (e) => UpdateGraphY(
                                      e, controller.x_slider_range.value),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  })
                : SizedBox.shrink()
          ])
        : Container(
            width: double.infinity,
            height: 50,
            child: SpinKitCircle(
              color: widget.scatterColors[0],
            ),
          );
  }

  ScatterChartData GetMainData(b, x_range, y_range) {
    return controller.ReturnChartData(widget.listings, widget.scatterColors,
        widget.jerseynumber, b, x_range, y_range);
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void UpdateGraphX(RangeValues e, y_range) {
    controller.main_data.value = GetMainData(false, e, y_range);
    controller.filter_data.value = GetMainData(true, e, y_range);

    // if(controller.main_data.value.scatterSpots.length == 0 || controller.filter_data.value.scatterSpots.length == 0){
    //   controller.main_data.value
    // }
  }

  void UpdateGraphY(RangeValues e, x_range) {
    controller.main_data.value = GetMainData(false, x_range, e);
    controller.filter_data.value = GetMainData(true, x_range, e);
  }

  RangeValues GetRangeValuesInit(lm, x) {
    double min = double.infinity;
    double max = double.negativeInfinity;

    List<num> y_copy = [];
    for (var i in lm) {
      y_copy.add(i.mintedmoment.price);
    }

    if (y_copy.length < 2) {
      return RangeValues(0, 50000);
    }
    int median = Statistical().arrMedian(y_copy).toInt();

    int start = -1;
    int idx = 0;

    while (start == -1) {
      if (y_copy[idx] >= median) {
        start = idx;
      }
      idx++;
    }

    // IQ3
    var y_copy_two = y_copy.sublist(start, y_copy.length);
    var iqthree = Statistical().arrMedian(y_copy_two);

    // IQ1
    y_copy.sort();
    y_copy = y_copy.sublist(0, start);
    var iqone = Statistical().arrMedian(y_copy);

    // IQR
    var iqr = iqthree - iqone;
    var outlier_thresh = 1.5;
    var lim = iqthree + (outlier_thresh * iqr);

    if (x) {
      for (var i in lm) {
        if (i.mintedmoment.flowSerialNumber.toDouble() < min) {
          min = i.mintedmoment.flowSerialNumber.toDouble();
        }

        if (i.mintedmoment.flowSerialNumber.toDouble() > max) {
          max = i.mintedmoment.flowSerialNumber.toDouble();
        }
      }
    } else {
      for (var i in lm) {
        if (i.mintedmoment.price < min && i.mintedmoment.price < lim) {
          min = i.mintedmoment.price;
        }

        if (i.mintedmoment.price > max && i.mintedmoment.price < lim) {
          max = i.mintedmoment.price;
        }
      }
    }
    return RangeValues(min, max);
  }
}
