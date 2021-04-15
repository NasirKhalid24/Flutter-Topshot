import 'Tag.dart';

class SetPlay {
  SetPlay({this.id, this.circulationCount, this.flowRetired, this.tags});

  final String? id;
  final int? circulationCount;
  final bool? flowRetired;
  final List<Tag>? tags;

  factory SetPlay.fromMap(Map<String, dynamic> json) => SetPlay(
      id: json["id"] == null ? null : json["id"],
      flowRetired: json["flowRetired"] == null ? null : json["flowRetired"],
      circulationCount:
          json["circulationCount"] == null ? null : json["circulationCount"],
      tags: json["tags"] == null
          ? null
          : json["tags"].map<Tag>((e) => Tag.fromMap(e)).toList()!);

  Map<String, dynamic> toMap() => {
        "id": id,
        "flowRetired": flowRetired,
        "circulationCount": circulationCount,
        "tags": tags
      };

  @override
  String toString() {
    return """
    SetPlay(
      id: $id,
      flowRetired: $flowRetired,
      circulationCount: $circulationCount,
      tags: $tags
      )';
    """;
  }
}
