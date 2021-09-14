// To parse this JSON data, do
//
//     final brawlPlayer = brawlPlayerFromJson(jsonString);

import 'dart:convert';

BrawlPlayer brawlPlayerFromJson(String str) =>
    BrawlPlayer.fromJson(json.decode(str));

String brawlPlayerToJson(BrawlPlayer data) => json.encode(data.toJson());

class BrawlPlayer {
  BrawlPlayer({
    required this.tag,
    required this.name,
    required this.icon,
    required this.trophies,
    required this.highestTrophies,
    required this.expLevel,
    required this.expPoints,
    required this.isQualifiedFromChampionshipChallenge,
    required this.the3Vs3Victories,
    required this.soloVictories,
    required this.duoVictories,
    required this.bestRoboRumbleTime,
    required this.bestTimeAsBigBrawler,
    required this.club,
    required this.brawlers,
  });

  String tag;
  String name;
  Icon icon;
  int trophies;
  int highestTrophies;
  int expLevel;
  int expPoints;
  bool isQualifiedFromChampionshipChallenge;
  int the3Vs3Victories;
  int soloVictories;
  int duoVictories;
  int bestRoboRumbleTime;
  int bestTimeAsBigBrawler;
  Club club;
  List<Brawler> brawlers;

  factory BrawlPlayer.fromJson(Map<String, dynamic> json) => BrawlPlayer(
        tag: json["tag"],
        name: json["name"],
        icon: Icon.fromJson(json["icon"]),
        trophies: json["trophies"],
        highestTrophies: json["highestTrophies"],
        expLevel: json["expLevel"],
        expPoints: json["expPoints"],
        isQualifiedFromChampionshipChallenge:
            json["isQualifiedFromChampionshipChallenge"],
        the3Vs3Victories: json["3vs3Victories"],
        soloVictories: json["soloVictories"],
        duoVictories: json["duoVictories"],
        bestRoboRumbleTime: json["bestRoboRumbleTime"],
        bestTimeAsBigBrawler: json["bestTimeAsBigBrawler"],
        club: Club.fromJson(json["club"]),
        brawlers: List<Brawler>.from(
            json["brawlers"].map((x) => Brawler.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "name": name,
        "icon": icon.toJson(),
        "trophies": trophies,
        "highestTrophies": highestTrophies,
        "expLevel": expLevel,
        "expPoints": expPoints,
        "isQualifiedFromChampionshipChallenge":
            isQualifiedFromChampionshipChallenge,
        "3vs3Victories": the3Vs3Victories,
        "soloVictories": soloVictories,
        "duoVictories": duoVictories,
        "bestRoboRumbleTime": bestRoboRumbleTime,
        "bestTimeAsBigBrawler": bestTimeAsBigBrawler,
        "club": club.toJson(),
        "brawlers": List<dynamic>.from(brawlers.map((x) => x.toJson())),
      };
}

class Brawler {
  Brawler({
    required this.id,
    required this.name,
    required this.power,
    required this.rank,
    required this.trophies,
    required this.highestTrophies,
    required this.starPowers,
    required this.gadgets,
  });

  int id;
  String name;
  int power;
  int rank;
  int trophies;
  int highestTrophies;
  List<dynamic> starPowers;
  List<dynamic> gadgets;

  factory Brawler.fromJson(Map<String, dynamic> json) => Brawler(
        id: json["id"],
        name: json["name"],
        power: json["power"],
        rank: json["rank"],
        trophies: json["trophies"],
        highestTrophies: json["highestTrophies"],
        starPowers: List<dynamic>.from(json["starPowers"].map((x) => x)),
        gadgets: List<dynamic>.from(json["gadgets"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "power": power,
        "rank": rank,
        "trophies": trophies,
        "highestTrophies": highestTrophies,
        "starPowers": List<dynamic>.from(starPowers.map((x) => x)),
        "gadgets": List<dynamic>.from(gadgets.map((x) => x)),
      };
}

class Club {
  Club();

  factory Club.fromJson(Map<String, dynamic> json) => Club();

  Map<String, dynamic> toJson() => {};
}

class Icon {
  Icon({
    required this.id,
  });

  int id;

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
