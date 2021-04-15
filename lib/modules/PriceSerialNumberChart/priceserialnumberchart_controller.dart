import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:statistical_dart/statistical_dart.dart';
import 'package:topshot_scan/models/MintedMoment.dart';
import 'package:topshot_scan/models/MomentListing.dart';
import 'package:topshot_scan/theme/color_theme.dart';

class PriceSerialNumberChartController extends GetxController {
  static PriceSerialNumberChartController get to => Get.find();

  var filter = false.obs;
  var ready = false.obs;

  var view_image_url = "".obs;
  var view_price = "".obs;
  var view_serial = "".obs;
  var view_username = "".obs;
  var view_id = "".obs;

  var x_slider_range = RangeValues(0, 1).obs;

  var y_slider_range = RangeValues(0, 1).obs;

  var main_data = ScatterChartData().obs;
  var filter_data = ScatterChartData().obs;

  double radius = 3;

  late double main_x_axis_interval;
  late double main_y_axis_interval;

  var moment_collection = {}.obs();

  @override
  void onInit() {
    super.onInit();
  }

  Matrix Inverse2x2(matrix) {
    double a = matrix[0][0];
    double b = matrix[0][1];
    double c = matrix[1][0];
    double d = matrix[1][1];

    double determinant = 1 / ((a * d) - (b * c));
    Matrix t = Matrix.fromList([
      [d, -1 * b],
      [-1 * c, a]
    ]);

    return t * determinant;
  }

  List<ScatterSpot> ProcessData(lm, colors, jerseynumber, x_range, y_range) {
    List<double> x_data = [];
    List<double> y_data = [];
    double x_start = x_range.start;
    double x_end = x_range.end;
    double y_start = y_range.start;
    double y_end = y_range.end;

    for (var i in lm) {
      var s = i.mintedmoment.flowSerialNumber.toDouble();
      var p = i.mintedmoment.price;
      moment_collection["${s}+${p}"] = i;

      x_data.add(s);
      y_data.add(p);
    }

    if (lm.length < 2) {
      List<ScatterSpot> result = [];
      for (var i in lm) {
        double s = i.mintedmoment.flowSerialNumber.toDouble();
        double p = i.mintedmoment.price;

        x_data.add(s);
        y_data.add(p);

        result.add(ScatterSpot(s, p,
            radius: s == jerseynumber ? radius + 2 : radius,
            color: s == jerseynumber ? colors[1] : colors[0]));

        main_y_axis_interval = 500000;
        main_x_axis_interval = 500000;
      }
      return result;
    }

    int median = Statistical().arrMedian(y_data).toInt();

    int start = -1;
    int idx = 0;

    while (start == -1) {
      if (y_data[idx] >= median) {
        start = idx;
      }
      idx++;
    }

    List<num> y_copy = List.from(y_data);

    // IQ3
    y_copy = y_copy.sublist(start, y_copy.length);
    var iqthree = Statistical().arrMedian(y_copy);

    // IQ1
    y_copy = List.from(y_data);
    y_copy.sort();
    y_copy = y_copy.sublist(0, start);
    var iqone = Statistical().arrMedian(y_copy);

    // IQR
    var iqr = iqthree - iqone;

    var outlier_thresh = 1.5;

    x_data = [];
    y_data = [];
    List<ScatterSpot> result = [];

    if (lm.length > 10) {
      for (var i = 0; i < lm.length; i++) {
        var e = lm[i];
        double s = e.mintedmoment.flowSerialNumber.toDouble();
        double p = e.mintedmoment.price;
        // Check if point is not an outlier
        if (e.mintedmoment.price < iqthree + (outlier_thresh * iqr) &&
            (s > x_start && s < x_end) &&
            (p > y_start && p < y_end)) {
          x_data.add(s);
          y_data.add(p);

          result.add(ScatterSpot(s, p,
              radius: s == jerseynumber ? radius + 2 : radius,
              color: s == jerseynumber ? colors[1] : colors[0]));
        }
      }
    } else {
      for (var i = 0; i < lm.length; i++) {
        var e = lm[i];
        double s = e.mintedmoment.flowSerialNumber.toDouble();
        double p = e.mintedmoment.price;

        x_data.add(s);
        y_data.add(p);

        result.add(ScatterSpot(s, p,
            radius: s == jerseynumber ? radius + 2 : radius,
            color: s == jerseynumber ? colors[1] : colors[0]));
      }
    }

    if (result.length == 0) {
      main_y_axis_interval = y_start - y_end;
      main_x_axis_interval = x_end - x_start;
      return result;
    } else {
      main_y_axis_interval =
          max((y_data.reduce(max) - y_data.reduce(min)) / 15, 15);
      main_x_axis_interval =
          max((x_data.reduce(max) - x_data.reduce(min)) / 10, 10);
      return result;
    }

    return result;
  }

  ProcessDataFiltered(lm, colors, jerseynumber, x_range, y_range) {
    List<double> x_data = [];
    List<double> y_data = [];
    double x_start = x_range.start;
    double x_end = x_range.end;
    double y_start = y_range.start;
    double y_end = y_range.end;

    for (var i in lm) {
      var s = i.mintedmoment.flowSerialNumber.toDouble();
      var p = i.mintedmoment.price;
      x_data.add(s);
      y_data.add(p);
    }

    if (lm.length < 2) {
      List<ScatterSpot> result = [];
      for (var i in lm) {
        double s = i.mintedmoment.flowSerialNumber.toDouble();
        double p = i.mintedmoment.price;

        x_data.add(s);
        y_data.add(p);

        result.add(ScatterSpot(s, p,
            radius: s == jerseynumber ? radius + 2 : radius,
            color: s == jerseynumber ? colors[1] : colors[0]));

        main_y_axis_interval = 500000;
        main_x_axis_interval = 500000;
      }
      return result;
    }

    int median = Statistical().arrMedian(y_data).toInt();

    int start = -1;
    int idx = 0;

    while (start == -1) {
      if (y_data[idx] >= median) {
        start = idx;
      }
      idx++;
    }

    List<num> y_copy = List.from(y_data);

    // IQ3
    y_copy = y_copy.sublist(start, y_copy.length);
    var iqthree = Statistical().arrMedian(y_copy);

    // IQ1
    y_copy = List.from(y_data);
    y_copy.sort();
    y_copy = y_copy.sublist(0, start);
    var iqone = Statistical().arrMedian(y_copy);

    // IQR
    var iqr = iqthree - iqone;

    var outlier_thresh = 1.5;

    x_data = [];
    y_data = [];
    List<ScatterSpot> result = [];
    Map<double, double> result_t = {};

    for (var i = 0; i < lm.length; i++) {
      var e = lm[i];
      double s = e.mintedmoment.flowSerialNumber.toDouble();
      double p = e.mintedmoment.price;
      // Check if point is not an outlier
      if (p < iqthree + (outlier_thresh * iqr)) {
        // We take lowest serial number for a price
        if (result_t[p] != null) {
          if (s < result_t[p]!) {
            result_t[p] = s;
          }
        } else {
          result_t[p] = s;
        }
      }
    }

    var p = result_t.keys.first;
    var s = result_t[p]!;

    // Better value strat
    for (var item in result_t.keys) {
      if (p != item) {
        if (result_t[item]! < s &&
            (result_t[item]! > x_start && result_t[item]! < x_end) &&
            (item > y_start && item < y_end)) {
          p = item;
          s = result_t[p]!;
          x_data.add(s);
          y_data.add(p);
          result.add(ScatterSpot(s, p,
              radius: s == jerseynumber ? radius + 2 : radius,
              color: s == jerseynumber ? colors[1] : colors[0]));
        }
      } else {
        if ((result_t[item]! > x_start && result_t[item]! < x_end) &&
            (item > y_start && item < y_end)) {
          x_data.add(s);
          y_data.add(p);
          result.add(ScatterSpot(s, p,
              radius: s == jerseynumber ? radius + 2 : radius,
              color: s == jerseynumber ? colors[1] : colors[0]));
        } else {}
      }
    }

    if (result.length == 0) {
      result.add(ScatterSpot(x_end, y_end, show: false));
      result.add(ScatterSpot(x_start, y_start, show: false));
      main_y_axis_interval = y_end - y_start;
      main_x_axis_interval = x_end - x_start;
      return result;
    } else {
      main_y_axis_interval =
          max((y_data.reduce(max) - y_data.reduce(min)) / 15, 15);
      main_x_axis_interval =
          max((x_data.reduce(max) - x_data.reduce(min)) / 10, 10);

      return result;
    }

    // y = Ae^(Bx)
    // ln y = Bx*ln(a)
    // y = a + b*ln(x)
    // Best Fit Log
    // List<double> lnx = [];
    // List<double> bias = [];
    // int max_x = -1;

    // for (var i in x_data) {
    //   if (i > max_x) {
    //     max_x = i.toInt();
    //   }
    //   lnx.add(log(i));
    //   bias.add(1);
    // }

    // final Matrix matrix_y = Matrix.column(y_data);
    // final Vector vector_lnx = Vector.fromList(lnx);
    // final Matrix matrix_bias = Matrix.column(bias);

    // final matrix_new = matrix_bias.insertColumns(1, [vector_lnx]);
    // final matrix_new_transposed = matrix_new.transpose();

    // final v1 = matrix_new_transposed * matrix_new;

    // final t1 = Inverse2x2(v1);
    // final t2 = matrix_new_transposed * matrix_y;
    // final res = t1 * t2;

    // double a = res[0][0];
    // double b = res[1][0];

    // print(a);
    // print(b);

    // List<int> range = [for (var i = 1; i < max_x; i += 1) i];
    // for (var j in range) {
    //   result.add(ScatterSpot(j.toDouble(), a + (b * log(j)),
    //       color: Colors.white, radius: 1));
    // }
  }

  void TouchedListUpdate(e, _t, colors) {
    for (var _i in _t) {
      _i.color = colors[0];
    }

    e.touchedSpot.spot.color =
        colors[1] == Colors.black ? Colors.blueAccent : colors[1];

    var q =
        moment_collection["${e.touchedSpot!.spot.x}+${e.touchedSpot!.spot.y}"]
            .mintedmoment;

    view_id.value = q.id;
    view_image_url.value = q.owner.profileImageUrl;
    view_price.value = q.price.toString();
    view_serial.value = q.flowSerialNumber.toString();
    view_username.value = q.owner.username;
  }

  ScatterChartData ReturnChartData(
      lm, colors, jerseynumber, filter_data, x_range, y_range) {
    List<ScatterSpot> _t = [];
    if (filter_data) {
      _t = ProcessDataFiltered(lm, colors, jerseynumber, x_range, y_range);
    } else {
      _t = ProcessData(lm, colors, jerseynumber, x_range, y_range);
    }

    return ScatterChartData(
        scatterSpots: _t,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        scatterTouchData: ScatterTouchData(
            enabled: true,
            touchTooltipData: ScatterTouchTooltipData(
                tooltipBgColor: MainColors.background,
                fitInsideHorizontally: true,
                getTooltipItems: (point) => ScatterTooltipItem(
                    "Serial: ${point.x.toInt()} \nPrice: \$${point.y.toInt()}",
                    TextStyle(
                      fontFamily: "Lexend",
                      fontWeight: FontWeight.w500,
                      color: colors[0],
                    ),
                    point.radius * 8)),
            touchCallback: (e) => {
                  e.touchedSpot != null ? TouchedListUpdate(e, _t, colors) : ""
                }),
        axisTitleData: FlAxisTitleData(
            show: true,
            leftTitle: AxisTitle(
                showTitle: true,
                margin: 2,
                titleText: "Price USD",
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontFamily: "Lexend")),
            bottomTitle: AxisTitle(
                showTitle: true,
                margin: 2,
                titleText: "Serial Number",
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontFamily: "Lexend"))),
        titlesData: FlTitlesData(
            show: true,
            leftTitles: SideTitles(
                showTitles: true,
                getTitles: (d) => d.toInt().toString(),
                interval: max(main_y_axis_interval, 1),
                getTextStyles: (d) => TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w400)),
            bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (d) => d.toInt().toString(),
                interval: max(main_x_axis_interval, 1),
                getTextStyles: (d) => TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w400))));
  }
}
