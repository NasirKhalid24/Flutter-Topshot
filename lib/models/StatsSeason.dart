class StatsSeason {
  StatsSeason({
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

  final double? blocks;
  final double? points;
  final double? steals;
  final double? assists;
  final String? minutes;
  final double? rebounds;
  final double? turnovers;
  final double? plusMinus;
  final double? flagrantFouls;
  final double? personalFouls;
  final double? technicalFouls;
  final double? twoPointsMade;
  final double? blockedAttempts;
  final double? fieldGoalsMade;
  final double? freeThrowsMade;
  final double? threePointsMade;
  final double? defensiveRebounds;
  final double? offensiveRebounds;
  final double? pointsOffTurnovers;
  final double? twoPointsAttempted;
  final double? assistTurnoverRatio;
  final double? fieldGoalsAttempted;
  final double? freeThrowsAttempted;
  final double? twoPointsPercentage;
  final double? fieldGoalsPercentage;
  final double? freeThrowsPercentage;
  final double? threePointsAttempted;
  final double? threePointsPercentage;

  factory StatsSeason.fromMap(Map<String, dynamic> json) => StatsSeason(
        blocks: json["blocks"] == null ? null : json["blocks"].toDouble(),
        points: json["points"] == null ? null : json["points"].toDouble(),
        steals: json["steals"] == null ? null : json["steals"].toDouble(),
        assists: json["assists"] == null ? null : json["assists"].toDouble(),
        minutes: json["minutes"] == null ? null : json["minutes"],
        rebounds: json["rebounds"] == null ? null : json["rebounds"].toDouble(),
        turnovers:
            json["turnovers"] == null ? null : json["turnovers"].toDouble(),
        plusMinus:
            json["plusMinus"] == null ? null : json["plusMinus"].toDouble(),
        flagrantFouls: json["flagrantFouls"] == null
            ? null
            : json["flagrantFouls"].toDouble(),
        personalFouls: json["personalFouls"] == null
            ? null
            : json["personalFouls"].toDouble(),
        technicalFouls: json["technicalFouls"] == null
            ? null
            : json["technicalFouls"].toDouble(),
        twoPointsMade: json["twoPointsMade"] == null
            ? null
            : json["twoPointsMade"].toDouble(),
        blockedAttempts: json["blockedAttempts"] == null
            ? null
            : json["blockedAttempts"].toDouble(),
        fieldGoalsMade: json["fieldGoalsMade"] == null
            ? null
            : json["fieldGoalsMade"].toDouble(),
        freeThrowsMade: json["freeThrowsMade"] == null
            ? null
            : json["freeThrowsMade"].toDouble(),
        threePointsMade: json["threePointsMade"] == null
            ? null
            : json["threePointsMade"].toDouble(),
        defensiveRebounds: json["defensiveRebounds"] == null
            ? null
            : json["defensiveRebounds"].toDouble(),
        offensiveRebounds: json["offensiveRebounds"] == null
            ? null
            : json["offensiveRebounds"].toDouble(),
        pointsOffTurnovers: json["pointsOffTurnovers"] == null
            ? null
            : json["pointsOffTurnovers"].toDouble(),
        twoPointsAttempted: json["twoPointsAttempted"] == null
            ? null
            : json["twoPointsAttempted"].toDouble(),
        assistTurnoverRatio: json["assistTurnoverRatio"] == null
            ? null
            : json["assistTurnoverRatio"].toDouble(),
        fieldGoalsAttempted: json["fieldGoalsAttempted"] == null
            ? null
            : json["fieldGoalsAttempted"].toDouble(),
        freeThrowsAttempted: json["freeThrowsAttempted"] == null
            ? null
            : json["freeThrowsAttempted"].toDouble(),
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
            : json["threePointsAttempted"].toDouble(),
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
    StatsSeason(
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
