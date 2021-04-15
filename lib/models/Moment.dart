import 'package:topshot_scan/models/Play.dart';
import 'package:topshot_scan/models/Moment.dart';
import 'package:topshot_scan/models/SetPlay.dart';
import 'package:topshot_scan/models/TSet.dart';

import 'MomentListing.dart';
import 'PriceRange.dart';

class Moment {
  Moment(
      {this.circulationCount,
      this.flowRetired,
      this.version,
      this.tset,
      this.play,
      this.setPlay,
      this.assetPathPrefix,
      this.priceRange,
      this.momentListings,
      this.momentListingCount});

  int? circulationCount;
  bool? flowRetired;
  int? version;
  TSet? tset;
  Play? play;
  SetPlay? setPlay;
  String? assetPathPrefix;
  PriceRange? priceRange;
  List<dynamic>? momentListings;
  int? momentListingCount;

  factory Moment.fromMap(Map<String, dynamic> json) => Moment(
      circulationCount:
          json["circulationCount"] == null ? null : json["circulationCount"],
      version: json["version"] == null ? null : int.parse(json["version"]),
      tset: json["set"] == null ? TSet.fromMap({}) : TSet.fromMap(json["set"]),
      play:
          json["play"] == null ? Play.fromMap({}) : Play.fromMap(json["play"]),
      setPlay: json["setPlay"] == null
          ? SetPlay.fromMap({})
          : SetPlay.fromMap(json["setPlay"]),
      assetPathPrefix:
          json["assetPathPrefix"] == null ? null : json["assetPathPrefix"],
      priceRange: json["priceRange"] == null
          ? PriceRange.fromMap({})
          : PriceRange.fromMap(json["priceRange"]),
      momentListings: json["momentListings"] == null
          ? []
          : json["momentListings"]
              .map((data) => MomentListing.fromMap(data))
              .toList(),
      momentListingCount: json["momentListingCount"] == null
          ? null
          : json["momentListingCount"]);

  Map<String, dynamic> toMap() => {
        "circulationCount": circulationCount,
        "version": version,
        "set": tset,
        "play": play,
        "assetPathPrefix": assetPathPrefix,
        "priceRange": priceRange,
        "momentListings": momentListings,
        "setPlay": setPlay,
        "momentListingCount": momentListingCount
      };

  @override
  String toString() {
    return """
    Moment(
      circulationCount: $circulationCount,
      version: $version,
      set: $tset,
      play: $play,
      setPlay: $setPlay,
      assetPathPrefix: $assetPathPrefix,
      priceRange: $priceRange,
      momentListings: $momentListings,
      momentListingCount: $momentListingCount
      )';
    """;
  }
}
