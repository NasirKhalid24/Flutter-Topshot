class byCreatedAt {
  byCreatedAt({this.start, this.end});

  final String? start;
  final String? end;

  factory byCreatedAt.fromMap(Map<String, dynamic> json) => byCreatedAt(
      start: json["start"] == null
          ? null
          : json["start"].toString() + "T12:00:00.000Z",
      end: json["end"] == null
          ? null
          : json["end"].toString() + "T14:59:59.000Z");

  Map<String, dynamic> toMap() => {
        "start": start,
        "end": end,
      };

  @override
  String toString() {
    return """
    byCreatedAt(
      start: $start,
      end: $end,
      )';
    """;
  }
}
