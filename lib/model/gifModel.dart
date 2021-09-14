// To parse this JSON data, do
//
//     final gif = gifFromJson(jsonString);

import 'dart:convert';

Gif gifFromJson(String str) => Gif.fromJson(json.decode(str));

String gifToJson(Gif data) => json.encode(data.toJson());

class Gif {
  Gif({
    required this.results,
    required this.next,
  });

  List<Result> results;
  String next;

  factory Gif.fromJson(Map<String, dynamic> json) => Gif(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "next": next,
      };
}

class Result {
  Result({
    required this.id,
    required this.title,
    required this.h1Title,
    required this.media,
    required this.bgColor,
    required this.created,
    required this.itemurl,
    required this.url,
    required this.tags,
    required this.flags,
    required this.shares,
    required this.hasaudio,
    required this.hascaption,
    required this.sourceId,
    this.composite,
  });

  String id;
  String title;
  String h1Title;
  List<Map<String, Media>> media;
  String bgColor;
  double created;
  String itemurl;
  String url;
  List<dynamic> tags;
  List<dynamic> flags;
  int shares;
  bool hasaudio;
  bool hascaption;
  String sourceId;
  dynamic composite;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        h1Title: json["h1_title"],
        media: List<Map<String, Media>>.from(json["media"].map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, Media>(k, Media.fromJson(v))))),
        bgColor: json["bg_color"],
        created: json["created"].toDouble(),
        itemurl: json["itemurl"],
        url: json["url"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        flags: List<dynamic>.from(json["flags"].map((x) => x)),
        shares: json["shares"],
        hasaudio: json["hasaudio"],
        hascaption: json["hascaption"],
        sourceId: json["source_id"],
        composite: json["composite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "h1_title": h1Title,
        "media": List<dynamic>.from(media.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "bg_color": bgColor,
        "created": created,
        "itemurl": itemurl,
        "url": url,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "flags": List<dynamic>.from(flags.map((x) => x)),
        "shares": shares,
        "hasaudio": hasaudio,
        "hascaption": hascaption,
        "source_id": sourceId,
        "composite": composite,
      };
}

class Media {
  Media({
    required this.dims,
    required this.size,
    required this.preview,
    required this.url,
    required this.duration,
  });

  List<int> dims;
  int size;
  String preview;
  String url;
  double duration;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        dims: List<int>.from(json["dims"].map((x) => x)),
        size: json["size"],
        preview: json["preview"],
        url: json["url"],
        duration: 1.0,
      );

  Map<String, dynamic> toJson() => {
        "dims": List<dynamic>.from(dims.map((x) => x)),
        "size": size,
        "preview": preview,
        "url": url,
        "duration": duration == null ? null : duration,
      };
}
