class Quarters {
  Quarters({this.type, this.number, this.sequence, this.points});

  final String? type;
  final int? number;
  final int? sequence;
  final int? points;

  factory Quarters.fromMap(Map<String, dynamic> json) => Quarters(
      type: json["type"] == null ? null : json["type"],
      number: json["number"] == null ? null : json["number"],
      sequence: json["sequence"] == null ? null : json["sequence"],
      points: json["points"] == null ? null : json["points"]);

  Map<String, dynamic> toMap() => {
        "type": type,
        "number": number,
        "sequence": sequence,
        "points": points,
      };

  @override
  String toString() {
    return """
    Quarters(
      type: $type,
      number: $number,
      sequence: $sequence,
      points: $points,
      )';
    """;
  }
}
