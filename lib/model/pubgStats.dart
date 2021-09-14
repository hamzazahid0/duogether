// To parse this JSON data, do
//
//     final pubgStats = pubgStatsFromJson(jsonString);

import 'dart:convert';

PubgStats pubgStatsFromJson(String str) => PubgStats.fromJson(json.decode(str));

String pubgStatsToJson(PubgStats data) => json.encode(data.toJson());

class PubgStats {
  PubgStats({
    required this.data,
    required this.links,
    required this.meta,
  });

  PubgStatsData data;
  Links links;
  Meta meta;

  factory PubgStats.fromJson(Map<String, dynamic> json) => PubgStats(
        data: PubgStatsData.fromJson(json["data"]),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class PubgStatsData {
  PubgStatsData({
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  String type;
  Attributes attributes;
  Relationships relationships;

  factory PubgStatsData.fromJson(Map<String, dynamic> json) => PubgStatsData(
        type: json["type"],
        attributes: Attributes.fromJson(json["attributes"]),
        relationships: Relationships.fromJson(json["relationships"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "attributes": attributes.toJson(),
        "relationships": relationships.toJson(),
      };
}

class Attributes {
  Attributes({
    required this.gameModeStats,
    required this.bestRankPoint,
  });

  GameModeStats gameModeStats;
  double bestRankPoint;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        gameModeStats: GameModeStats.fromJson(json["gameModeStats"]),
        bestRankPoint: json["bestRankPoint"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "gameModeStats": gameModeStats.toJson(),
        "bestRankPoint": bestRankPoint,
      };
}

class GameModeStats {
  GameModeStats({
    required this.duo,
    required this.duoFpp,
    required this.solo,
    required this.soloFpp,
    required this.squad,
    required this.squadFpp,
  });

  Duo duo;
  Duo duoFpp;
  Duo solo;
  Duo soloFpp;
  Duo squad;
  Duo squadFpp;

  factory GameModeStats.fromJson(Map<String, dynamic> json) => GameModeStats(
        duo: Duo.fromJson(json["duo"]),
        duoFpp: Duo.fromJson(json["duo-fpp"]),
        solo: Duo.fromJson(json["solo"]),
        soloFpp: Duo.fromJson(json["solo-fpp"]),
        squad: Duo.fromJson(json["squad"]),
        squadFpp: Duo.fromJson(json["squad-fpp"]),
      );

  Map<String, dynamic> toJson() => {
        "duo": duo.toJson(),
        "duo-fpp": duoFpp.toJson(),
        "solo": solo.toJson(),
        "solo-fpp": soloFpp.toJson(),
        "squad": squad.toJson(),
        "squad-fpp": squadFpp.toJson(),
      };
}

class Duo {
  Duo({
    required this.assists,
    required this.boosts,
    required this.dBnOs,
    required this.dailyKills,
    required this.dailyWins,
    required this.damageDealt,
    required this.days,
    required this.headshotKills,
    required this.heals,
    required this.killPoints,
    required this.kills,
    required this.longestKill,
    required this.longestTimeSurvived,
    required this.losses,
    required this.maxKillStreaks,
    required this.mostSurvivalTime,
    required this.rankPoints,
    required this.rankPointsTitle,
    required this.revives,
    required this.rideDistance,
    required this.roadKills,
    required this.roundMostKills,
    required this.roundsPlayed,
    required this.suicides,
    required this.swimDistance,
    required this.teamKills,
    required this.timeSurvived,
    required this.top10S,
    required this.vehicleDestroys,
    required this.walkDistance,
    required this.weaponsAcquired,
    required this.weeklyKills,
    required this.weeklyWins,
    required this.winPoints,
    required this.wins,
  });

  int assists;
  int boosts;
  int dBnOs;
  int dailyKills;
  int dailyWins;
  double damageDealt;
  int days;
  int headshotKills;
  int heals;
  int killPoints;
  int kills;
  double longestKill;
  double longestTimeSurvived;
  int losses;
  int maxKillStreaks;
  double mostSurvivalTime;
  double rankPoints;
  String rankPointsTitle;
  int revives;
  double rideDistance;
  int roadKills;
  int roundMostKills;
  int roundsPlayed;
  int suicides;
  double swimDistance;
  int teamKills;
  double timeSurvived;
  int top10S;
  int vehicleDestroys;
  double walkDistance;
  int weaponsAcquired;
  int weeklyKills;
  int weeklyWins;
  int winPoints;
  int wins;

  factory Duo.fromJson(Map<String, dynamic> json) => Duo(
        assists: json["assists"],
        boosts: json["boosts"],
        dBnOs: json["dBNOs"],
        dailyKills: json["dailyKills"],
        dailyWins: json["dailyWins"],
        damageDealt: json["damageDealt"].toDouble(),
        days: json["days"],
        headshotKills: json["headshotKills"],
        heals: json["heals"],
        killPoints: json["killPoints"],
        kills: json["kills"],
        longestKill: json["longestKill"].toDouble(),
        longestTimeSurvived: json["longestTimeSurvived"].toDouble(),
        losses: json["losses"],
        maxKillStreaks: json["maxKillStreaks"],
        mostSurvivalTime: json["mostSurvivalTime"].toDouble(),
        rankPoints: json["rankPoints"].toDouble(),
        rankPointsTitle: json["rankPointsTitle"],
        revives: json["revives"],
        rideDistance: json["rideDistance"].toDouble(),
        roadKills: json["roadKills"],
        roundMostKills: json["roundMostKills"],
        roundsPlayed: json["roundsPlayed"],
        suicides: json["suicides"],
        swimDistance: json["swimDistance"].toDouble(),
        teamKills: json["teamKills"],
        timeSurvived: json["timeSurvived"].toDouble(),
        top10S: json["top10s"],
        vehicleDestroys: json["vehicleDestroys"],
        walkDistance: json["walkDistance"].toDouble(),
        weaponsAcquired: json["weaponsAcquired"],
        weeklyKills: json["weeklyKills"],
        weeklyWins: json["weeklyWins"],
        winPoints: json["winPoints"],
        wins: json["wins"],
      );

  Map<String, dynamic> toJson() => {
        "assists": assists,
        "boosts": boosts,
        "dBNOs": dBnOs,
        "dailyKills": dailyKills,
        "dailyWins": dailyWins,
        "damageDealt": damageDealt,
        "days": days,
        "headshotKills": headshotKills,
        "heals": heals,
        "killPoints": killPoints,
        "kills": kills,
        "longestKill": longestKill,
        "longestTimeSurvived": longestTimeSurvived,
        "losses": losses,
        "maxKillStreaks": maxKillStreaks,
        "mostSurvivalTime": mostSurvivalTime,
        "rankPoints": rankPoints,
        "rankPointsTitle": rankPointsTitle,
        "revives": revives,
        "rideDistance": rideDistance,
        "roadKills": roadKills,
        "roundMostKills": roundMostKills,
        "roundsPlayed": roundsPlayed,
        "suicides": suicides,
        "swimDistance": swimDistance,
        "teamKills": teamKills,
        "timeSurvived": timeSurvived,
        "top10s": top10S,
        "vehicleDestroys": vehicleDestroys,
        "walkDistance": walkDistance,
        "weaponsAcquired": weaponsAcquired,
        "weeklyKills": weeklyKills,
        "weeklyWins": weeklyWins,
        "winPoints": winPoints,
        "wins": wins,
      };
}

class Relationships {
  Relationships({
    required this.matchesSquadFpp,
    required this.season,
    required this.player,
    required this.matchesSolo,
    required this.matchesSoloFpp,
    required this.matchesDuo,
    required this.matchesDuoFpp,
    required this.matchesSquad,
  });

  Matches matchesSquadFpp;
  Player season;
  Player player;
  Matches matchesSolo;
  Matches matchesSoloFpp;
  Matches matchesDuo;
  Matches matchesDuoFpp;
  Matches matchesSquad;

  factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        matchesSquadFpp: Matches.fromJson(json["matchesSquadFPP"]),
        season: Player.fromJson(json["season"]),
        player: Player.fromJson(json["player"]),
        matchesSolo: Matches.fromJson(json["matchesSolo"]),
        matchesSoloFpp: Matches.fromJson(json["matchesSoloFPP"]),
        matchesDuo: Matches.fromJson(json["matchesDuo"]),
        matchesDuoFpp: Matches.fromJson(json["matchesDuoFPP"]),
        matchesSquad: Matches.fromJson(json["matchesSquad"]),
      );

  Map<String, dynamic> toJson() => {
        "matchesSquadFPP": matchesSquadFpp.toJson(),
        "season": season.toJson(),
        "player": player.toJson(),
        "matchesSolo": matchesSolo.toJson(),
        "matchesSoloFPP": matchesSoloFpp.toJson(),
        "matchesDuo": matchesDuo.toJson(),
        "matchesDuoFPP": matchesDuoFpp.toJson(),
        "matchesSquad": matchesSquad.toJson(),
      };
}

class Matches {
  Matches({
    required this.data,
  });

  List<dynamic> data;

  factory Matches.fromJson(Map<String, dynamic> json) => Matches(
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}

class Player {
  Player({
    required this.data,
  });

  PlayerData data;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        data: PlayerData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class PlayerData {
  PlayerData({
    required this.type,
    required this.id,
  });

  String type;
  String id;

  factory PlayerData.fromJson(Map<String, dynamic> json) => PlayerData(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}

class Links {
  Links({
    required this.self,
  });

  String self;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
