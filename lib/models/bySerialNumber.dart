class bySerialNumber {
  bySerialNumber({this.min, this.max});

  final int? min;
  final int? max;

  factory bySerialNumber.fromMap(Map<String, dynamic> json) => bySerialNumber(
      min: json["min"] == null ? null : json["min"],
      max: json["max"] == null ? null : json["max"]);

  Map<String, dynamic> toMap() => {
        "min": min,
        "max": max,
      };

  @override
  String toString() {
    return """
    bySerialNumber(
      min: $min,
      max: $max,
      )';
    """;
  }
}
