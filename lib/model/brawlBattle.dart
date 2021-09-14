// To parse this JSON data, do
//
//     final brawlBattle = brawlBattleFromJson(jsonString);

import 'dart:convert';

BrawlBattle brawlBattleFromJson(String str) =>
    BrawlBattle.fromJson(json.decode(str));

String brawlBattleToJson(BrawlBattle data) => json.encode(data.toJson());

class BrawlBattle {
  BrawlBattle({
    required this.items,
    required this.paging,
  });

  List<Item> items;
  Paging paging;

  factory BrawlBattle.fromJson(Map<String, dynamic> json) => BrawlBattle(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        paging: Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "paging": paging.toJson(),
      };
}

class Item {
  Item({
    required this.battleTime,
    required this.event,
    required this.battle,
  });

  String battleTime;
  Event event;
  Battle battle;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        battleTime: json["battleTime"],
        event: Event.fromJson(json["event"]),
        battle: Battle.fromJson(json["battle"]),
      );

  Map<String, dynamic> toJson() => {
        "battleTime": battleTime,
        "event": event.toJson(),
        "battle": battle.toJson(),
      };
}

class Battle {
  Battle({
    required this.mode,
    required this.type,
    required this.result,
    required this.duration,
    required this.trophyChange,
    required this.starPlayer,
    required this.teams,
  });

  String mode;
  String type;
  String result;
  int duration;
  int trophyChange;
  StarPlayer starPlayer;
  List<List<StarPlayer>> teams;

  factory Battle.fromJson(Map<String, dynamic> json) => Battle(
        mode: json["mode"],
        type: json["type"],
        result: json["result"],
        duration: json["duration"],
        trophyChange: json["trophyChange"],
        starPlayer: StarPlayer.fromJson(json["starPlayer"]),
        teams: List<List<StarPlayer>>.from(json["teams"].map((x) =>
            List<StarPlayer>.from(x.map((x) => StarPlayer.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "type": type,
        "result": result,
        "duration": duration,
        "trophyChange": trophyChange,
        "starPlayer": starPlayer.toJson(),
        "teams": List<dynamic>.from(
            teams.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class StarPlayer {
  StarPlayer({
    required this.tag,
    required this.name,
    required this.brawler,
  });

  String tag;
  String name;
  Brawler brawler;

  factory StarPlayer.fromJson(Map<String, dynamic> json) => StarPlayer(
        tag: json["tag"],
        name: json["name"],
        brawler: Brawler.fromJson(json["brawler"]),
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "name": name,
        "brawler": brawler.toJson(),
      };
}

class Brawler {
  Brawler({
    required this.id,
    required this.name,
    required this.power,
    required this.trophies,
  });

  int id;
  String name;
  int power;
  int trophies;

  factory Brawler.fromJson(Map<String, dynamic> json) => Brawler(
        id: json["id"],
        name: json["name"],
        power: json["power"],
        trophies: json["trophies"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "power": power,
        "trophies": trophies,
      };
}

class Event {
  Event({
    required this.id,
    required this.mode,
    required this.map,
  });

  int id;
  String mode;
  String map;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        mode: json["mode"],
        map: json["map"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mode": mode,
        "map": map,
      };
}

class Paging {
  Paging({
    required this.cursors,
  });

  Cursors cursors;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        cursors: Cursors.fromJson(json["cursors"]),
      );

  Map<String, dynamic> toJson() => {
        "cursors": cursors.toJson(),
      };
}

class Cursors {
  Cursors();

  factory Cursors.fromJson(Map<String, dynamic> json) => Cursors();

  Map<String, dynamic> toJson() => {};
}
