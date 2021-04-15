import 'MintedMoment.dart';

class MomentListing {
  MomentListing({
    this.id,
    this.mintedmoment,
  });

  final String? id;
  final MintedMoment? mintedmoment;

  factory MomentListing.fromMap(Map<String, dynamic> json) => MomentListing(
      id: json["id"] == null ? null : json["id"],
      mintedmoment:
          json["moment"] == null ? null : MintedMoment.fromMap(json["moment"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "mintedmoment": mintedmoment,
      };

  @override
  String toString() {
    return """
    MomentListing(
      id: $id,
      mintedmoment: $mintedmoment,
      )';
    """;
  }
}
