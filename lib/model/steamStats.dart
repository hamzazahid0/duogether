// To parse this JSON data, do
//
//     final steamStats = steamStatsFromJson(jsonString);

import 'dart:convert';

SteamStats steamStatsFromJson(String str) => SteamStats.fromJson(json.decode(str));

String steamStatsToJson(SteamStats data) => json.encode(data.toJson());

class SteamStats {
  SteamStats({
    required this.playerstats,
  });

  Playerstats playerstats;

  factory SteamStats.fromJson(Map<String, dynamic> json) => SteamStats(
        playerstats: Playerstats.fromJson(json["playerstats"]),
      );

  Map<String, dynamic> toJson() => {
        "playerstats": playerstats.toJson(),
      };
}

class Playerstats {
  Playerstats({
    required this.steamId,
    required this.gameName,
    required this.stats,
    required this.achievements,
  });

  String steamId;
  String gameName;
  List<Stat> stats;
  List<Achievement> achievements;

  factory Playerstats.fromJson(Map<String, dynamic> json) => Playerstats(
        steamId: json["steamID"],
        gameName: json["gameName"],
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        achievements: List<Achievement>.from(json["achievements"].map((x) => Achievement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "steamID": steamId,
        "gameName": gameName,
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "achievements": List<dynamic>.from(achievements.map((x) => x.toJson())),
      };
}

class Achievement {
  Achievement({
    required this.name,
    required this.achieved,
  });

  String name;
  int achieved;

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        name: json["name"],
        achieved: json["achieved"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "achieved": achieved,
      };
}

class Stat {
  Stat({
    required this.name,
    required this.value,
  });

  String name;
  int value;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
