// To parse this JSON data, do
//
//     final tftPlayer = tftPlayerFromJson(jsonString);

import 'dart:convert';

TftPlayer tftPlayerFromJson(String str) => TftPlayer.fromJson(json.decode(str));

String tftPlayerToJson(TftPlayer data) => json.encode(data.toJson());

class TftPlayer {
    TftPlayer({
        required this.id,
        required this.accountId,
        required this.puuid,
        required this.name,
        required this.profileIconId,
        required this.revisionDate,
        required this.summonerLevel,
    });

    String id;
    String accountId;
    String puuid;
    String name;
    int profileIconId;
    int revisionDate;
    int summonerLevel;

    factory TftPlayer.fromJson(Map<String, dynamic> json) => TftPlayer(
        id: json["id"],
        accountId: json["accountId"],
        puuid: json["puuid"],
        name: json["name"],
        profileIconId: json["profileIconId"],
        revisionDate: json["revisionDate"],
        summonerLevel: json["summonerLevel"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "accountId": accountId,
        "puuid": puuid,
        "name": name,
        "profileIconId": profileIconId,
        "revisionDate": revisionDate,
        "summonerLevel": summonerLevel,
    };
}

List<String> tftGameFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String tftGameToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

