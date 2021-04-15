import 'package:topshot_scan/models/StatsGame.dart';
import 'package:topshot_scan/models/StatsSeason.dart';

import 'Stats.dart';
import 'Tag.dart';

class Play {
  Play(
      {this.description,
      this.id,
      this.stats,
      this.tags,
      this.statsPlayerGameScores,
      this.statsPlayerSeasonAverageScores});

  final String? description;
  final String? id;
  final Stats? stats;
  final List<Tag>? tags;
  final StatsGame? statsPlayerGameScores;
  final StatsSeason? statsPlayerSeasonAverageScores;

  factory Play.fromMap(Map<String, dynamic> json) => Play(
      description: json["description"] == null ? null : json["description"],
      id: json["id"] == null ? null : json["id"],
      stats: json["stats"] == null
          ? Stats.fromMap({})
          : Stats.fromMap(json["stats"]),
      statsPlayerGameScores: json["statsPlayerGameScores"] == null
          ? StatsGame.fromMap({})
          : StatsGame.fromMap(json["statsPlayerGameScores"]),
      statsPlayerSeasonAverageScores:
          json["statsPlayerSeasonAverageScores"] == null
              ? StatsSeason.fromMap({})
              : StatsSeason.fromMap(json["statsPlayerSeasonAverageScores"]),
      tags: json["tags"] == null
          ? []
          : json["tags"].map<Tag>((e) => Tag.fromMap(e)).toList()!);

  Map<String, dynamic> toMap() => {
        "description": description,
        "id": id,
        "stats": stats,
        "tags": tags,
        "statsPlayerGameScores": statsPlayerGameScores,
        "statsPlayerSeasonAverageScores": statsPlayerSeasonAverageScores,
      };

  @override
  String toString() {
    return """
    Play(
      description: $description,
      id: $id,
      stats: $stats,
      tags: $tags,
      statsPlayerGameScores: $statsPlayerGameScores,
      statsPlayerSeasonAverageScores: $statsPlayerSeasonAverageScores
      )';
    """;
  }
}
