class StatsGame {
  StatsGame({
    this.blocks,
    this.points,
    this.steals,
    this.assists,
    this.minutes,
    this.rebounds,
    this.turnovers,
    this.plusMinus,
    this.flagrantFouls,
    this.personalFouls,
    this.playerPosition,
    this.technicalFouls,
    this.twoPointsMade,
    this.blockedAttempts,
    this.fieldGoalsMade,
    this.freeThrowsMade,
    this.threePointsMade,
    this.defensiveRebounds,
    this.offensiveRebounds,
    this.pointsOffTurnovers,
    this.twoPointsAttempted,
    this.assistTurnoverRatio,
    this.fieldGoalsAttempted,
    this.freeThrowsAttempted,
    this.twoPointsPercentage,
    this.fieldGoalsPercentage,
    this.freeThrowsPercentage,
    this.threePointsAttempted,
    this.threePointsPercentage,
  });

  final int? blocks;
  final int? points;
  final int? steals;
  final int? assists;
  final String? minutes;
  final int? rebounds;
  final int? turnovers;
  final int? plusMinus;
  final int? flagrantFouls;
  final int? personalFouls;
  final String? playerPosition;
  final int? technicalFouls;
  final int? twoPointsMade;
  final int? blockedAttempts;
  final int? fieldGoalsMade;
  final int? freeThrowsMade;
  final int? threePointsMade;
  final int? defensiveRebounds;
  final int? offensiveRebounds;
  final int? pointsOffTurnovers;
  final int? twoPointsAttempted;
  final double? assistTurnoverRatio;
  final int? fieldGoalsAttempted;
  final int? freeThrowsAttempted;
  final double? twoPointsPercentage;
  final double? fieldGoalsPercentage;
  final double? freeThrowsPercentage;
  final int? threePointsAttempted;
  final double? threePointsPercentage;

  factory StatsGame.fromMap(Map<String, dynamic> json) => StatsGame(
        blocks: json["blocks"] == null ? null : json["blocks"],
        points: json["points"] == null ? null : json["points"],
        steals: json["steals"] == null ? null : json["steals"],
        assists: json["assists"] == null ? null : json["assists"],
        minutes: json["minutes"] == null ? null : json["minutes"],
        rebounds: json["rebounds"] == null ? null : json["rebounds"],
        turnovers: json["turnovers"] == null ? null : json["turnovers"],
        plusMinus: json["plusMinus"] == null ? null : json["plusMinus"],
        flagrantFouls:
            json["flagrantFouls"] == null ? null : json["flagrantFouls"],
        personalFouls:
            json["personalFouls"] == null ? null : json["personalFouls"],
        playerPosition:
            json["playerPosition"] == null ? null : json["playerPosition"],
        technicalFouls:
            json["technicalFouls"] == null ? null : json["technicalFouls"],
        twoPointsMade:
            json["twoPointsMade"] == null ? null : json["twoPointsMade"],
        blockedAttempts:
            json["blockedAttempts"] == null ? null : json["blockedAttempts"],
        fieldGoalsMade:
            json["fieldGoalsMade"] == null ? null : json["fieldGoalsMade"],
        freeThrowsMade:
            json["freeThrowsMade"] == null ? null : json["freeThrowsMade"],
        threePointsMade:
            json["threePointsMade"] == null ? null : json["threePointsMade"],
        defensiveRebounds: json["defensiveRebounds"] == null
            ? null
            : json["defensiveRebounds"],
        offensiveRebounds: json["offensiveRebounds"] == null
            ? null
            : json["offensiveRebounds"],
        pointsOffTurnovers: json["pointsOffTurnovers"] == null
            ? null
            : json["pointsOffTurnovers"],
        twoPointsAttempted: json["twoPointsAttempted"] == null
            ? null
            : json["twoPointsAttempted"],
        assistTurnoverRatio: json["assistTurnoverRatio"] == null
            ? null
            : json["assistTurnoverRatio"].toDouble(),
        fieldGoalsAttempted: json["fieldGoalsAttempted"] == null
            ? null
            : json["fieldGoalsAttempted"],
        freeThrowsAttempted: json["freeThrowsAttempted"] == null
            ? null
            : json["freeThrowsAttempted"],
        twoPointsPercentage: json["twoPointsPercentage"] == null
            ? null
            : json["twoPointsPercentage"].toDouble(),
        fieldGoalsPercentage: json["fieldGoalsPercentage"] == null
            ? null
            : json["fieldGoalsPercentage"].toDouble(),
        freeThrowsPercentage: json["freeThrowsPercentage"] == null
            ? null
            : json["freeThrowsPercentage"].toDouble(),
        threePointsAttempted: json["threePointsAttempted"] == null
            ? null
            : json["threePointsAttempted"],
        threePointsPercentage: json["threePointsPercentage"] == null
            ? null
            : json["threePointsPercentage"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "blocks": blocks,
        "points": points,
        "steals": steals,
        "assists": assists,
        "minutes": minutes,
        "rebounds": rebounds,
        "turnovers": turnovers,
        "plusMinus": plusMinus,
        "flagrantFouls": flagrantFouls,
        "personalFouls": personalFouls,
        "playerPosition": playerPosition,
        "technicalFouls": technicalFouls,
        "twoPointsMade": twoPointsMade,
        "blockedAttempts": blockedAttempts,
        "fieldGoalsMade": fieldGoalsMade,
        "freeThrowsMade": freeThrowsMade,
        "threePointsMade": threePointsMade,
        "defensiveRebounds": defensiveRebounds,
        "offensiveRebounds": offensiveRebounds,
        "pointsOffTurnovers": pointsOffTurnovers,
        "twoPointsAttempted": twoPointsAttempted,
        "assistTurnoverRatio": assistTurnoverRatio,
        "fieldGoalsAttempted": fieldGoalsAttempted,
        "freeThrowsAttempted": freeThrowsAttempted,
        "twoPointsPercentage": twoPointsPercentage,
        "fieldGoalsPercentage": fieldGoalsPercentage,
        "freeThrowsPercentage": freeThrowsPercentage,
        "threePointsAttempted": threePointsAttempted,
        "threePointsPercentage": threePointsPercentage,
      };

  @override
  String toString() {
    return """
    StatsGame(
      blocks: $blocks,
      points: $points,
      steals: $steals,
      assists: $assists,
      minutes: $minutes,
      rebounds: $rebounds,
      turnovers: $turnovers,
      plusMinus: $plusMinus,
      flagrantFouls: $flagrantFouls,
      personalFouls: $personalFouls,
      playerPosition: $playerPosition,
      technicalFouls: $technicalFouls,
      twoPointsMade: $twoPointsMade,
      blockedAttempts: $blockedAttempts,
      fieldGoalsMade: $fieldGoalsMade,
      freeThrowsMade: $freeThrowsMade,
      threePointsMade: $threePointsMade,
      defensiveRebounds: $defensiveRebounds,
      offensiveRebounds: $offensiveRebounds,
      pointsOffTurnovers: $pointsOffTurnovers,
      twoPointsAttempted: $twoPointsAttempted,
      assistTurnoverRatio: $assistTurnoverRatio,
      fieldGoalsAttempted: $fieldGoalsAttempted,
      freeThrowsAttempted: $freeThrowsAttempted,
      twoPointsPercentage: $twoPointsPercentage,
      fieldGoalsPercentage: $fieldGoalsPercentage,
      freeThrowsPercentage: $freeThrowsPercentage,
      threePointsAttempted: $threePointsAttempted,
      threePointsPercentage: $threePointsPercentage,
      )';
    """;
  }
}
