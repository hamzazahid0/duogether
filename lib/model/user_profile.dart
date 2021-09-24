class Profil {
  final String userId;
  final bool showLocation;
  final String country;
  final String city;
  final bool hasBack, avatarIsAsset, pc, ps, mobile, headphone;
  final String back;
  final String name, bio, avatar;
  final int age, level, startMinute, startHour, endMinute, endHour;
  final int cover;
  final int limit;

  Profil({
    required this.userId,
    required this.showLocation,
    required this.country,
    required this.city,
    required this.hasBack,
    required this.back,
    required this.name,
    required this.age,
    required this.level,
    required this.bio,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.avatar,
    required this.avatarIsAsset,
    required this.cover,
    required this.headphone,
    required this.mobile,
    required this.pc,
    required this.ps,
    required this.limit,
  });

  factory Profil.fromJson(String id, Map json) {
    return Profil(
      userId: id,
      name: json["name"],
      country: json["country"],
      showLocation: json["showLocation"],
      city: json["city"],
      hasBack: json["hasBack"],
      back: json["back"],
      age: json["age"],
      level: json["level"],
      bio: json["bio"],
      startHour: json["startHour"],
      startMinute: json["startMinute"],
      endMinute: json["endMinute"],
      endHour: json["endHour"],
      avatar: json["avatar"],
      avatarIsAsset: json["avatarIsAsset"],
      cover: json["cover"],
      headphone: json["headphone"],
      mobile: json["mobile"],
      pc: json["pc"],
      ps: json["ps"],
      limit: json["limit"],
    );
  }
}
