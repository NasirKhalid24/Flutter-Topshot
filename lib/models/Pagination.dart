class Pagination {
  Pagination({this.cursor, this.direction, this.limit});

  final String? cursor;
  final String? direction;
  final int? limit;

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
      cursor: json["cursor"] == null ? "" : json["cursor"],
      direction: json["direction"] == null ? "RIGHT" : json["direction"],
      limit: json["limit"] == null ? 12 : 12);

  Map<String, dynamic> toMap() =>
      {"cursor": cursor, "direction": direction, "limit": limit};

  @override
  String toString() {
    return """
    Pagination(
      cursor: $cursor,
      direction: $direction,
      limit: $limit
      )';
    """;
  }
}
