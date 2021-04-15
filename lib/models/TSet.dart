class TSet {
  TSet(
      {this.id,
      this.flowName,
      this.setVisualId,
      this.flowSeriesNumber,
      this.assetPath});

  final String? id;
  final String? flowName;
  final String? setVisualId;
  final int? flowSeriesNumber;
  final String? assetPath;

  factory TSet.fromMap(Map<String, dynamic> json) => TSet(
      id: json["id"] == null ? null : json["id"],
      flowName: json["flowName"] == null ? null : json["flowName"],
      setVisualId: json["setVisualId"] == null ? null : json["setVisualId"],
      flowSeriesNumber:
          json["flowSeriesNumber"] == null ? null : json["flowSeriesNumber"],
      assetPath: json["assetPath"] == null ? null : json["assetPath"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "flowName": flowName,
        "setVisualId": setVisualId,
        "flowSeriesNumber": flowSeriesNumber,
        "assetPath": assetPath
      };

  @override
  String toString() {
    return """
    Set(
      id: $id,
      flowName: $flowName,
      setVisualId: $setVisualId,
      flowSeriesNumber: $flowSeriesNumber,
      assetPath: $assetPath
      )';
    """;
  }
}
