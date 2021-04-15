class byPrice {
  byPrice({this.min, this.max});

  final String? min;
  final String? max;

  factory byPrice.fromMap(Map<String, dynamic> json) => byPrice(
      min: json["min"] == null ? null : json["min"],
      max: json["max"] == null ? null : json["max"]);

  Map<String, dynamic> toMap() => {
        "min": min,
        "max": max,
      };

  @override
  String toString() {
    return """
    byPrice(
      min: $min,
      max: $max,
      )';
    """;
  }
}
