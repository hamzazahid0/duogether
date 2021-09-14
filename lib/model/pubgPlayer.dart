// To parse this JSON data, do
//
//     final pubgPlayer = pubgPlayerFromJson(jsonString);

import 'dart:convert';

PubgPlayer pubgPlayerFromJson(String str) =>
    PubgPlayer.fromJson(json.decode(str));

String pubgPlayerToJson(PubgPlayer data) => json.encode(data.toJson());

class PubgPlayer {
  PubgPlayer({
    required this.data,
    // required this.links,
    // required this.meta,
  });

  List<PubgPlayerDatum> data;
  // PubgPlayerLinks links;
  // Meta meta;

  factory PubgPlayer.fromJson(Map<String, dynamic> json) => PubgPlayer(
        data: List<PubgPlayerDatum>.from(
            json["data"].map((x) => PubgPlayerDatum.fromJson(x))),
        // links: PubgPlayerLinks.fromJson(json["links"]),
        // meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "links": links.toJson(),
        // "meta": meta.toJson(),
      };
}

class PubgPlayerDatum {
  PubgPlayerDatum({
    required this.type,
    required this.id,
    // required this.attributes,
    // required this.relationships,
    // required this.links,
  });

  String type;
  String id;
  // Attributes attributes;
  // Relationships relationships;
  // DatumLinks links;

  factory PubgPlayerDatum.fromJson(Map<String, dynamic> json) =>
      PubgPlayerDatum(
        type: json["type"],
        id: json["id"],
        // attributes: Attributes.fromJson(json["attributes"]),
        // relationships: Relationships.fromJson(json["relationships"]),
        // links: DatumLinks.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        // "attributes": attributes.toJson(),
        // "relationships": relationships.toJson(),
        // "links": links.toJson(),
      };
}

// class Attributes {
//   Attributes({
//     required this.stats,
//     required this.titleId,
//     required this.shardId,
//     required this.patchVersion,
//     required this.name,
//   });

//   dynamic stats;
//   String titleId;
//   String shardId;
//   String patchVersion;
//   String name;

//   factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
//         stats: json["stats"],
//         titleId: json["titleId"],
//         shardId: json["shardId"],
//         patchVersion: json["patchVersion"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "stats": stats,
//         "titleId": titleId,
//         "shardId": shardId,
//         "patchVersion": patchVersion,
//         "name": name,
//       };
// }

// class DatumLinks {
//   DatumLinks({
//     required this.schema,
//     required this.self,
//   });

//   String schema;
//   String self;

//   factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
//         schema: json["schema"],
//         self: json["self"],
//       );

//   Map<String, dynamic> toJson() => {
//         "schema": schema,
//         "self": self,
//       };
// }

// class Relationships {
//   Relationships({
//     required this.assets,
//     required this.matches,
//   });

//   Assets assets;
//   Assets matches;

//   factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
//         assets: Assets.fromJson(json["assets"]),
//         matches: Assets.fromJson(json["matches"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "assets": assets.toJson(),
//         "matches": matches.toJson(),
//       };
// }

// class Assets {
//   Assets({
//     required this.data,
//   });

//   List<AssetsDatum> data;

//   factory Assets.fromJson(Map<String, dynamic> json) => Assets(
//         data: List<AssetsDatum>.from(
//             json["data"].map((x) => AssetsDatum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class AssetsDatum {
//   AssetsDatum({
//     required this.type,
//     required this.id,
//   });

//   Type? type;
//   String id;

//   factory AssetsDatum.fromJson(Map<String, dynamic> json) => AssetsDatum(
//         type: typeValues.map[json["type"]],
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "type": typeValues.reverse[type],
//         "id": id,
//       };
// }

// enum Type { MATCH }

// final typeValues = EnumValues({"match": Type.MATCH});

// class PubgPlayerLinks {
//   PubgPlayerLinks({
//     required this.self,
//   });

//   String self;

//   factory PubgPlayerLinks.fromJson(Map<String, dynamic> json) =>
//       PubgPlayerLinks(
//         self: json["self"],
//       );

//   Map<String, dynamic> toJson() => {
//         "self": self,
//       };
// }

// class Meta {
//   Meta();

//   factory Meta.fromJson(Map<String, dynamic> json) => Meta();

//   Map<String, dynamic> toJson() => {};
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
