class byPower {
  byPower({this.min, this.max});

  final String? min;
  final String? max;

  factory byPower.fromMap(Map<String, dynamic> json) => byPower(
      min: json["min"] == null ? null : json["min"],
      max: json["max"] == null ? null : json["max"]);

  Map<String, dynamic> toMap() => {
        "min": min,
        "max": max,
      };

  @override
  String toString() {
    return """
    byPower(
      min: $min,
      max: $max,
      )';
    """;
  }
}
