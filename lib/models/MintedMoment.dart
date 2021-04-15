import 'package:topshot_scan/models/UserD.dart';

import 'SetPlay.dart';

class MintedMoment {
  MintedMoment(
      {this.id, this.price, this.flowSerialNumber, this.owner, this.setPlay});

  final String? id;
  final double? price;
  final int? flowSerialNumber;
  final UserD? owner;
  final SetPlay? setPlay;

  factory MintedMoment.fromMap(Map<String, dynamic> json) => MintedMoment(
      id: json["id"] == null ? null : json["id"],
      price: json["price"] == null ? null : double.parse(json["price"]),
      flowSerialNumber: json["flowSerialNumber"] == null
          ? null
          : int.parse(json["flowSerialNumber"]),
      owner: json["owner"] == null ? null : UserD.fromMap(json["owner"]),
      setPlay:
          json["setPlay"] == null ? null : SetPlay.fromMap(json["setPlay"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "flowSerialNumber": flowSerialNumber,
        "owner": owner,
        "setPlay": setPlay
      };

  @override
  String toString() {
    return """
    MintedMoment(
      id: $id,
      price: $price,
      flowSerialNumber: $flowSerialNumber,
      owner: $owner,
      setPlay: $setPlay
      )';
    """;
  }
}
