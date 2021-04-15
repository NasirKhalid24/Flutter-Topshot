import 'package:topshot_scan/models/Quarters.dart';

class Stats {
  Stats(
      {this.playerID,
      this.playerName,
      this.primaryPosition,
      this.currentTeamId,
      this.dateOfMoment,
      this.jerseyNumber,
      this.awayTeamName,
      this.awayTeamScore,
      this.homeTeamName,
      this.playCategory,
      this.teamAtMomentNbaId,
      this.homeTeamScore,
      this.totalYearsExperience,
      this.height,
      this.weight,
      this.currentTeam,
      this.birthplace,
      this.birthdate,
      this.nbaSeason,
      this.awayTeamNbaId,
      this.draftYear,
      this.draftRound,
      this.draftSelection,
      this.homeTeamNbaId,
      this.draftTeam,
      this.draftTeamNbaId,
      this.homeTeamScoresByQuarter,
      this.awayTeamScoresByQuarter,
      this.teamAtMoment});

  final int? playerID;
  final String? playerName;
  final String? primaryPosition;
  final String? currentTeamId;
  final DateTime? dateOfMoment;
  final int? jerseyNumber;
  final String? awayTeamName;
  final int? awayTeamScore;
  final String? playCategory;
  final String? teamAtMoment;
  final int? teamAtMomentNbaId;
  final String? draftTeamNbaId;
  final String? homeTeamName;
  final int? homeTeamScore;
  final int? totalYearsExperience;
  final double? height;
  final double? weight;
  final String? birthplace;
  final String? currentTeam;
  final DateTime? birthdate;
  final String? draftTeam;
  final int? awayTeamNbaId;
  final int? homeTeamNbaId;
  final int? draftYear;
  final String? nbaSeason;
  final String? draftRound;
  final String? draftSelection;
  final List<dynamic>? homeTeamScoresByQuarter;
  final List<dynamic>? awayTeamScoresByQuarter;

  factory Stats.fromMap(Map<String, dynamic> json) => Stats(
      playerID: json["playerID"] == null ? null : int.parse(json["playerID"]),
      playerName: json["playerName"] == null ? null : json["playerName"],
      primaryPosition:
          json["primaryPosition"] == null ? null : json["primaryPosition"],
      currentTeamId:
          json["currentTeamId"] == null ? null : json["currentTeamId"],
      dateOfMoment: json["dateOfMoment"] == null
          ? null
          : DateTime.parse(json["dateOfMoment"]),
      birthdate:
          json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
      jerseyNumber:
          json["jerseyNumber"] == null ? null : int.parse(json["jerseyNumber"]),
      awayTeamName: json["awayTeamName"] == null ? null : json["awayTeamName"],
      awayTeamScore:
          json["awayTeamScore"] == null ? null : json["awayTeamScore"],
      playCategory: json["playCategory"] == null ? null : json["playCategory"],
      teamAtMomentNbaId: json["teamAtMomentNbaId"] == null
          ? null
          : int.parse(json["teamAtMomentNbaId"]),
      draftRound: json["draftRound"] == null ? null : json["draftRound"],
      homeTeamName: json["homeTeamName"] == null ? null : json["homeTeamName"],
      homeTeamScore:
          json["homeTeamScore"] == null ? null : json["homeTeamScore"],
      totalYearsExperience: json["totalYearsExperience"] == null
          ? null
          : int.parse(json["totalYearsExperience"]),
      height: json["height"] == null ? null : json["height"].toDouble(),
      weight: json["weight"] == null ? null : json["weight"].toDouble(),
      awayTeamNbaId: json["awayTeamNbaId"] == null
          ? null
          : int.parse(json["awayTeamNbaId"]),
      draftTeamNbaId:
          json["draftTeamNbaId"] == null ? null : json["draftTeamNbaId"],
      homeTeamNbaId: json["homeTeamNbaId"] == null
          ? null
          : int.parse(json["homeTeamNbaId"]),
      draftSelection:
          json["draftSelection"] == null ? null : json["draftSelection"],
      currentTeam: json["currentTeam"] == null ? null : json["currentTeam"],
      draftYear: json["draftYear"] == null ? null : json["draftYear"],
      draftTeam: json["draftTeam"] == null ? null : json["draftTeam"],
      nbaSeason: json["nbaSeason"] == null ? null : json["nbaSeason"],
      birthplace: json["birthplace"] == null ? null : json["birthplace"],
      homeTeamScoresByQuarter:
          json["homeTeamScoresByQuarter"]?["quarterScores"] == null
              ? []
              : json["homeTeamScoresByQuarter"]["quarterScores"]
                  .map((element) => Quarters.fromMap(element))
                  .toList(),
      awayTeamScoresByQuarter:
          json["awayTeamScoresByQuarter"]?["quarterScores"] == null
              ? []
              : json["awayTeamScoresByQuarter"]["quarterScores"]
                  .map((element) => Quarters.fromMap(element))
                  .toList(),
      teamAtMoment: json["teamAtMoment"] == null ? null : json["teamAtMoment"]);

  Map<String, dynamic> toMap() => {
        "playerID": playerID,
        "playerName": playerName,
        "primaryPosition": primaryPosition,
        "currentTeamId": currentTeamId,
        "dateOfMoment": dateOfMoment,
        "jerseyNumber": jerseyNumber,
        "awayTeamName": awayTeamName,
        "awayTeamScore": awayTeamScore,
        "playCategory": playCategory,
        "teamAtMoment": teamAtMoment,
        "teamAtMomentNbaId": teamAtMomentNbaId,
        "homeTeamName": homeTeamName,
        "homeTeamScore": homeTeamScore,
        "height": height,
        "weight": weight,
        "totalYearsExperience": totalYearsExperience,
        "currentTeam": currentTeam,
        "birthplace": birthplace,
        "birthdate": birthdate,
        "awayTeamNbaId": awayTeamNbaId,
        "draftYear": draftYear,
        "nbaSeason": nbaSeason,
        "draftRound": draftRound,
        "draftSelection": draftSelection,
        "homeTeamNbaId": homeTeamNbaId,
        "draftTeam": draftTeam,
        "draftTeamNbaId": draftTeamNbaId,
        "homeTeamScoresByQuarter": homeTeamScoresByQuarter,
        "awayTeamScoresByQuarter": awayTeamScoresByQuarter
      };

  @override
  String toString() {
    return """
    Stats(
      playerID: $playerID,
      playerName: $playerName,
      primaryPosition: $primaryPosition,
      currentTeamId: $currentTeamId,
      dateOfMoment: $dateOfMoment,
      jerseyNumber: $jerseyNumber,
      awayTeamName: $awayTeamName,
      awayTeamScore: $awayTeamScore,
      playCategory: $playCategory,
      teamAtMoment: $teamAtMoment,
      teamAtMomentNbaId: $teamAtMomentNbaId,
      homeTeamName: $homeTeamName,
      homeTeamScore: $homeTeamScore,
      height: $height,
      weight: $weight,
      totalYearsExperience: $totalYearsExperience,
      currentTeam: $currentTeam,
      birthplace: $birthplace,
      birthdate: $birthdate,
      awayTeamNbaId: $awayTeamNbaId,
      draftYear: $draftYear,
      nbaSeason: $nbaSeason,
      draftRound: $draftRound,
      draftSelection: $draftSelection,
      homeTeamNbaId: $homeTeamNbaId,
      draftTeam: $draftTeam,
      draftTeamNbaId: $draftTeamNbaId,
      homeTeamScoresByQuarter: $homeTeamScoresByQuarter,
      awayTeamScoresByQuarter: $awayTeamScoresByQuarter
      )';
    """;
  }
}
