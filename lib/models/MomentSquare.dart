import 'package:topshot_scan/models/Play.dart';

import 'PriceRange.dart';
import 'TSet.dart';

class MomentSquare {
  MomentSquare(
      {this.id,
      this.version,
      this.circulationCount,
      this.flowRetired,
      this.set,
      this.play,
      this.assetPathPrefix,
      this.priceRange,
      this.momentListingCount});

  final String? id;
  final int? version;
  final int? circulationCount;
  final bool? flowRetired;
  final TSet? set;
  final Play? play;
  final String? assetPathPrefix;
  final PriceRange? priceRange;
  final int? momentListingCount;

  factory MomentSquare.fromMap(Map<String, dynamic> json) => MomentSquare(
      id: json["id"],
      version: int.parse(json["version"]),
      circulationCount: json["circulationCount"],
      flowRetired: json["flowRetired"] == true,
      set: TSet.fromMap(json["set"]),
      play: Play.fromMap(json["play"]),
      assetPathPrefix: json["assetPathPrefix"],
      priceRange: PriceRange.fromMap(json["priceRange"]),
      momentListingCount: json["momentListingCount"]);

  @override
  String toString() {
    return """
    MomentSquare(
      id: $id,
      version: $version,
      circulationCount: $circulationCount,
      flowRetired: $flowRetired
      set: $set,
      play: $play,
      assetPathPrefix: $assetPathPrefix,
      priceRange: $priceRange,
      momentListingCount: $momentListingCount
      )';
    """;
  }
}
