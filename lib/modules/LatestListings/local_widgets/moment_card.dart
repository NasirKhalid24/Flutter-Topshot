import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:topshot_scan/data/data.dart';
import 'package:topshot_scan/models/MomentSquare.dart';
import 'package:topshot_scan/theme/color_theme.dart';

class MomentCard extends StatelessWidget {
  MomentCard(this.moment, this.containerwidth, {this.hero_tag = ""});

  final MomentSquare moment;
  final double containerwidth;
  final String hero_tag;
  late final double imagecrop = containerwidth / 4;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: containerwidth,
        height: 350,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: MainColors.background,
            child: InkWell(
              splashColor: Colors.purple,
              onTap: () {
                Get.toNamed(
                    "/moment?setID=${moment.set!.id}&playID=${moment.play!.id}&assetPrefix=${moment.assetPathPrefix}&team=${moment.play!.stats!.teamAtMoment}&hero=${hero_tag}");
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        height: containerwidth - imagecrop,
                        width: containerwidth + imagecrop,
                        child: Hero(
                          tag: "${moment.play!.id}${hero_tag}",
                          child: ExtendedImage.network(
                            "${moment.assetPathPrefix}${image_endpoint}",
                            fit: BoxFit.fitWidth,
                            cache: false,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return Shimmer.fromColors(
                                      child: Container(
                                        width: containerwidth + imagecrop,
                                        height: containerwidth - imagecrop,
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
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${moment.play?.stats?.playerName}",
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                fontSize: 15)),
                        SizedBox(height: 4),
                        Text(
                            "${moment.play?.stats?.playCategory} - ${new DateFormat("MMM d yyyy").format(moment.play!.stats!.dateOfMoment!)}, ${moment.set?.flowName} (Series ${moment.set?.flowSeriesNumber})"),
                        SizedBox(height: 8),
                        Text(
                            "${RARITY[moment.set?.setVisualId]} #/${moment.circulationCount}${moment.flowRetired == false ? "+" : ""}",
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        Text("Lowest Ask",
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 11,
                                color: Colors.grey)),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "USD \$" +
                                    moment.priceRange!.min!.toStringAsFixed(2),
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18)),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 10),
                            //   child: Icon(
                            //     Icons.north_east,
                            //     color: MainColors.purple,
                            //   ),
                            // )
                          ],
                        ),
                        Text("${moment.momentListingCount} listings"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
