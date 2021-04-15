class PriceRange {
  PriceRange({this.min, this.max});

  final double? min;
  final double? max;

  factory PriceRange.fromMap(Map<String, dynamic> json) => PriceRange(
      min: json["min"] == null ? null : double.parse(json["min"]),
      max: json["max"] == null ? null : double.parse(json["max"]));

  Map<String, dynamic> toMap() => {
        "min": min,
        "max": max,
      };

  @override
  String toString() {
    return """
    PriceRange(
      min: $min,
      max: $max,
      )';
    """;
  }
}
