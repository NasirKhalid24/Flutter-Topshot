class Tag {
  Tag({this.id, this.title, this.visible, this.level});

  final String? title;
  final String? id;
  final bool? visible;
  final String? level;

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
      id: json["id"] == null ? null : json["id"],
      title: json["title"] == null ? null : json["title"],
      visible: json["visible"] == null ? null : json["visible"],
      level: json["level"] == null ? null : json["level"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "visible": visible,
        "level": level,
      };

  @override
  String toString() {
    return """
    Tag(
      id: $id,
      title: $title,
      visible: $visible,
      level: $level
      )';
    """;
  }
}
