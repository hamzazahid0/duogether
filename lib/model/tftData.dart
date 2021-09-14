// To parse this JSON data, do
//
//     final tftData = tftDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TftData tftDataFromJson(String str) => TftData.fromJson(json.decode(str));

String tftDataToJson(TftData data) => json.encode(data.toJson());

class TftData {
    TftData({
        required this.metadata,
        required this.info,
    });

    Metadata metadata;
    Info info;

    factory TftData.fromJson(Map<String, dynamic> json) => TftData(
        metadata: Metadata.fromJson(json["metadata"]),
        info: Info.fromJson(json["info"]),
    );

    Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "info": info.toJson(),
    };
}

class Info {
    Info({
        required this.gameDatetime,
        required this.gameLength,
        required this.gameVersion,
        required this.participants,
        required this.queueId,
        required this.tftGameType,
        required this.tftSetNumber,
    });

    int gameDatetime;
    double gameLength;
    String gameVersion;
    List<Participant> participants;
    int queueId;
    String tftGameType;
    int tftSetNumber;

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        gameDatetime: json["game_datetime"],
        gameLength: json["game_length"].toDouble(),
        gameVersion: json["game_version"],
        participants: List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x))),
        queueId: json["queue_id"],
        tftGameType: json["tft_game_type"],
        tftSetNumber: json["tft_set_number"],
    );

    Map<String, dynamic> toJson() => {
        "game_datetime": gameDatetime,
        "game_length": gameLength,
        "game_version": gameVersion,
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
        "queue_id": queueId,
        "tft_game_type": tftGameType,
        "tft_set_number": tftSetNumber,
    };
}

class Participant {
    Participant({
        required this.companion,
        required this.goldLeft,
        required this.lastRound,
        required this.level,
        required this.placement,
        required this.playersEliminated,
        required this.puuid,
        required this.timeEliminated,
        required this.totalDamageToPlayers,
        required this.traits,
        required this.units,
    });

    Companion companion;
    int goldLeft;
    int lastRound;
    int level;
    int placement;
    int playersEliminated;
    String puuid;
    double timeEliminated;
    int totalDamageToPlayers;
    List<Trait> traits;
    List<Unit> units;

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        companion: Companion.fromJson(json["companion"]),
        goldLeft: json["gold_left"],
        lastRound: json["last_round"],
        level: json["level"],
        placement: json["placement"],
        playersEliminated: json["players_eliminated"],
        puuid: json["puuid"],
        timeEliminated: json["time_eliminated"].toDouble(),
        totalDamageToPlayers: json["total_damage_to_players"],
        traits: List<Trait>.from(json["traits"].map((x) => Trait.fromJson(x))),
        units: List<Unit>.from(json["units"].map((x) => Unit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "companion": companion.toJson(),
        "gold_left": goldLeft,
        "last_round": lastRound,
        "level": level,
        "placement": placement,
        "players_eliminated": playersEliminated,
        "puuid": puuid,
        "time_eliminated": timeEliminated,
        "total_damage_to_players": totalDamageToPlayers,
        "traits": List<dynamic>.from(traits.map((x) => x.toJson())),
        "units": List<dynamic>.from(units.map((x) => x.toJson())),
    };
}

class Companion {
    Companion({
        required this.contentId,
        required this.skinId,
        required this.species,
    });

    String contentId;
    int skinId;
    String species;

    factory Companion.fromJson(Map<String, dynamic> json) => Companion(
        contentId: json["content_ID"],
        skinId: json["skin_ID"],
        species: json["species"],
    );

    Map<String, dynamic> toJson() => {
        "content_ID": contentId,
        "skin_ID": skinId,
        "species": species,
    };
}

class Trait {
    Trait({
        required this.name,
        required this.numUnits,
        required this.style,
        required this.tierCurrent,
        required this.tierTotal,
    });

    String name;
    int numUnits;
    int style;
    int tierCurrent;
    int tierTotal;

    factory Trait.fromJson(Map<String, dynamic> json) => Trait(
        name: json["name"],
        numUnits: json["num_units"],
        style: json["style"],
        tierCurrent: json["tier_current"],
        tierTotal: json["tier_total"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "num_units": numUnits,
        "style": style,
        "tier_current": tierCurrent,
        "tier_total": tierTotal,
    };
}

class Unit {
    Unit({
        required this.characterId,
        required this.items,
        required this.name,
        required this.rarity,
        required this.tier,
    });

    String characterId;
    List<int> items;
    Name? name;
    int rarity;
    int tier;

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        characterId: json["character_id"],
        items: List<int>.from(json["items"].map((x) => x)),
        name: nameValues.map[json["name"]],
        rarity: json["rarity"],
        tier: json["tier"],
    );

    Map<String, dynamic> toJson() => {
        "character_id": characterId,
        "items": List<dynamic>.from(items.map((x) => x)),
        "name": nameValues.reverse[name],
        "rarity": rarity,
        "tier": tier,
    };
}

enum Name { KHAZIX, EMPTY, SORAKA, MORGANA, VLADIMIR, WARWICK, IVERN }

final nameValues = EnumValues({
    "": Name.EMPTY,
    "Ivern": Name.IVERN,
    "Khazix": Name.KHAZIX,
    "Morgana": Name.MORGANA,
    "Soraka": Name.SORAKA,
    "Vladimir": Name.VLADIMIR,
    "Warwick": Name.WARWICK
});

class Metadata {
    Metadata({
        required this.dataVersion,
        required this.matchId,
        required this.participants,
    });

    String dataVersion;
    String matchId;
    List<String> participants;

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        dataVersion: json["data_version"],
        matchId: json["match_id"],
        participants: List<String>.from(json["participants"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data_version": dataVersion,
        "match_id": matchId,
        "participants": List<dynamic>.from(participants.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
