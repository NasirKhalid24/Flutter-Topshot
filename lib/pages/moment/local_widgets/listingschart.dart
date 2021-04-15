import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:statistical_dart/statistical_dart.dart';
import 'package:topshot_scan/models/MomentListing.dart';
import 'package:topshot_scan/theme/color_theme.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ListingsChart extends StatefulWidget {
  ListingsChart(
      {required this.listings,
      required this.scatterColors,
      required this.maxserial,
      required this.jerseynumber});

  var listings;
  var scatterColors;
  var maxserial;
  var jerseynumber;

  @override
  _ListingsChartState createState() => _ListingsChartState();
}

class _ListingsChartState extends State<ListingsChart> {
  // Normal Data
  late List<ScatterSpot> data = [];
  late List<double> best_fit_data = [];
  late List<double> x_data = [];
  late List<double> y_data = [];

  // Best Data according to https://mintedmoment.substack.com/p/simple-marketplace-strategies
  late List<ScatterSpot> data_best = [];
  late List<double> best_fit_data_best = [];
  late List<double> x_data_best = [];
  late List<double> y_data_best = [];

  static final List<double> ranges = [0.1, 0.25, 0.5, 1];
  late bool chartready = false;
  bool toggle = false;
  double radius = 3;

  @override
  void initState() {
    super.initState();
    ProcessData(widget.listings);
    BestFitCurve(x_data, y_data);
    chartready = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(" Serial Number vs Price"),
      Row(
        children: [
          Text("Filter Data: "),
          FlutterSwitch(
            value: toggle,
            onToggle: (e) {
              toggle = e;
            },
          )
        ],
      ),
      AspectRatio(
        aspectRatio: 1,
        child: Card(
          color: MainColors.background,
          child: chartready
              ? ScatterChart(ReturnChartData(data))
              : SpinKitCircle(color: widget.scatterColors[0]),
        ),
      ),
    ]);
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

  void BestFitCurve(x, y) {
    // y = a + b*ln(x)

    List<double> lnx = [];
    List<double> bias = [];
    int max_x = -1;

    for (var i in x) {
      if (i > max_x) {
        max_x = i.toInt();
      }
      lnx.add(log(i));
      bias.add(1);
    }

    final Matrix matrix_y = Matrix.column(y);
    final Vector vector_lnx = Vector.fromList(lnx);
    final Matrix matrix_bias = Matrix.column(bias);

    final matrix_new = matrix_bias.insertColumns(1, [vector_lnx]);
    final matrix_new_transposed = matrix_new.transpose();

    final v1 = matrix_new_transposed * matrix_new;

    final t1 = Inverse2x2(v1);
    final t2 = matrix_new_transposed * matrix_y;
    final res = t1 * t2;

    double a = res[0][0];
    double b = res[1][0];

    List<int> range = [for (var i = 1; i < max_x; i += 1) i];
    for (var j in range) {
      data.add(ScatterSpot(j.toDouble(), a + (b * log(j)),
          color: Colors.white, radius: 1));
    }
  }

  void ProcessData(listings_arr) {
    List<num> best_serials = [];

    for (var i in listings_arr) {
      var s = i.mintedmoment.flowSerialNumber.toDouble();
      var p = i.mintedmoment.price;
      x_data.add(s);
      y_data.add(p);
    }

    int median = Statistical().arrMedian(y_data).toInt();

    // IQ3
    List<num> y_copy = List.from(y_data);
    y_copy.sort();
    y_copy = y_copy.sublist(y_copy.indexOf(median), y_copy.length);
    var iqthree = Statistical().arrMedian(y_copy);

    // IQ1
    y_copy = List.from(y_data);
    y_copy.sort();
    y_copy = y_copy.sublist(0, y_copy.indexOf(median));
    var iqone = Statistical().arrMedian(y_copy);

    // IQR
    var iqr = iqthree - iqone;

    var outlier_thresh = 1.5;

    x_data = [];
    y_data = [];

    for (var i = 0; i < listings_arr.length; i++) {
      var e = listings_arr[i];
      double s = e.mintedmoment.flowSerialNumber.toDouble();

      if (e.mintedmoment.price < iqthree + (outlier_thresh * iqr) &&
          s != widget.jerseynumber) {
        x_data.add(s);
        y_data.add(e.mintedmoment.price);

        data.add(ScatterSpot(s, e.mintedmoment.price,
            radius: s == widget.jerseynumber ? radius + 2 : radius,
            color: s == widget.jerseynumber
                ? widget.scatterColors[1]
                : widget.scatterColors[0]));
      }
    }
  }

  ScatterChartData ReturnChartData(d) {
    return ScatterChartData(
        scatterSpots: d,
        gridData: FlGridData(show: false),
        scatterTouchData: ScatterTouchData(
            enabled: true,
            touchTooltipData: ScatterTouchTooltipData(
                tooltipBgColor: Colors.black87,
                fitInsideHorizontally: true,
                getTooltipItems: (point) => ScatterTooltipItem(
                    "Serial: ${point.x.toInt()} \nPrice: \$${point.y.toInt()}",
                    TextStyle(
                      fontFamily: "Lexend",
                      fontWeight: FontWeight.w500,
                      color: widget.scatterColors[0],
                    ),
                    point.radius * 8))),
        axisTitleData: FlAxisTitleData(
            show: true,
            leftTitle: AxisTitle(
                showTitle: true,
                margin: 2,
                titleText: "Price USD",
                textStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w300))),
        titlesData: FlTitlesData(
            show: true,
            leftTitles: SideTitles(
                showTitles: true,
                getTitles: (d) => d.toInt().toString(),
                interval: (y_data.reduce(max) - y_data.reduce(min)) / 15,
                getTextStyles: (d) => TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w400)),
            bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (d) => d.toInt().toString(),
                interval: (x_data.reduce(max) - x_data.reduce(min)) / 10,
                getTextStyles: (d) => TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w400))));
  }
}
