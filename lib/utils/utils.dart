import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/screens/daysInRow.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Utils {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'duo', // id
      'Duogether Bildirimleri', // title
      'Bildirim gelmesi için gerekli', // description
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
      enableLights: true);

  //ca-app-pub-1891862173368472~4151425749 - Admob id

//Real id
  static const String banner_id = 'ca-app-pub-1891862173368472/7027380806';
  static const String ad_id =
      'ca-app-pub-1891862173368472/8037210142'; //reward ad id

//sample id
  // static const String banner_id = 'ca-app-pub-3940256099942544/6300978111';
// * discord linki
  static const discordLink = "https://discord.gg/a6NbHSh4b7";
  static const String token_Brawl =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjA4Yzc1N2U4LTYwZjMtNDA4My1hZTQ3LTExMjFkYTIxNDU0MSIsImlhdCI6MTYyNTQ4MjE2OCwic3ViIjoiZGV2ZWxvcGVyLzFlNDM0YmFhLTQ0NjctMjRmMC1hMmNmLTcwZDU4NTgxZjBiMCIsInNjb3BlcyI6WyJicmF3bHN0YXJzIl0sImxpbWl0cyI6W3sidGllciI6ImRldmVsb3Blci9zaWx2ZXIiLCJ0eXBlIjoidGhyb3R0bGluZyJ9LHsiY2lkcnMiOlsiMzcuMjYuMjUuNzIiXSwidHlwZSI6ImNsaWVudCJ9XX0.gBZD8ym_09z9cOmn_EM9UoSmCKRRh4KOIuZlFP9a1GaXGJ3hyxXpDVNcu6eF7HvaCh3JUTLFs0oYAbgK574KZA';

  static const String token_Pubg =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJkMTE4OTQ5MC1iZWRlLTAxMzktNjA1OC0wZGFlNWFkMzM0ZjQiLCJpc3MiOiJnYW1lbG9ja2VyIiwiaWF0IjoxNjI1MzkzNzg3LCJwdWIiOiJibHVlaG9sZSIsInRpdGxlIjoicHViZyIsImFwcCI6ImR1b2dldGhlciJ9.kGm8IWHme1sXgw6QyVKl-loRbxNpgtHPhwpEYob2k8I';

  static const String token_Steam = 'D3C2086C4EB9D1657D3A4AFDCBF60C2B';
  static const String token_Riot_lol =
      'RGAPI-ab3491a9-2122-4fe4-9451-bbb6a73cf7ed';
  static const String token_Riot_tft =
      'RGAPI-6ff570c6-cd6b-4e5d-a575-61e56b2c25e2';

  static const List avatars = [
    'erkek-1@2x.png',
    'erkek-2@2x.png',
    'erkek-3@2x.png',
    'erkek-4@2x.png',
    'erkek-5@2x.png',
    'erkek-6@2x.png',
    'erkek-7@2x.png',
    'erkek-8@2x.png',
    'erkek-9@2x.png',
    'erkek-10@2x.png',
    'erkek-11@2x.png',
    'erkek-12@2x.png',
    'kadın-1@2x.png',
    'kadın-2@2x.png',
    'kadın-3@2x.png',
    'kadın-4@2x.png',
    'kadın-5@2x.png',
    'kadın-6@2x.png',
    'kadın-7@2x.png',
    'kadın-8@2x.png',
    'kadın-9@2x.png',
    'kadın-10@2x.png',
    'kadın-11@2x.png',
    'kadın-12@2x.png',
  ];
  static const List avatars2 = [
    '2-seviye-erkek1@2x.png',
    '2-seviye-erkek2@2x.png',
    '2-seviye-erkek3@2x.png',
    '2-seviye-erkek4@2x.png',
    '2-seviye-erkek5@2x.png',
    '2-seviye-erkek6@2x.png',
    '2-seviye-erkek7@2x.png',
    '2-seviye-erkek8@2x.png',
    '2-seviye-erkek9@2x.png',
    '2-seviye-erkek10@2x.png',
    '2-seviye-erkek11@2x.png',
    '2-seviye-erkek12@2x.png',
    '2-seviye-kadin1@2x.png',
    '2-seviye-kadin2@2x.png',
    '2-seviye-kadin3@2x.png',
    '2-seviye-kadin4@2x.png',
    '2-seviye-kadin5@2x.png',
    '2-seviye-kadin6@2x.png',
    '2-seviye-kadin7@2x.png',
    '2-seviye-kadin8@2x.png',
    '2-seviye-kadin9@2x.png',
    '2-seviye-kadin10@2x.png',
    '2-seviye-kadin11@2x.png',
    '2-seviye-kadin12@2x.png',
  ];
  static const List avatars3 = [
    '3-seviye-erkek1@2x.png',
    '3-seviye-erkek2@2x.png',
    '3-seviye-erkek3@2x.png',
    '3-seviye-erkek4@2x.png',
    '3-seviye-erkek5@2x.png',
    '3-seviye-erkek6@2x.png',
    '3-seviye-erkek7@2x.png',
    '3-seviye-erkek8@2x.png',
    '3-seviye-erkek9@2x.png',
    '3-seviye-erkek10@2x.png',
    '3-seviye-erkek11@2x.png',
    '3-seviye-erkek12@2x.png',
    '3-seviye-kadin1@2x.png',
    '3-seviye-kadin2@2x.png',
    '3-seviye-kadin3@2x.png',
    '3-seviye-kadin4@2x.png',
    '3-seviye-kadin5@2x.png',
    '3-seviye-kadin6@2x.png',
    '3-seviye-kadin7@2x.png',
    '3-seviye-kadin8@2x.png',
    '3-seviye-kadin9@2x.png',
    '3-seviye-kadin10@2x.png',
    '3-seviye-kadin11@2x.png',
    '3-seviye-kadin12@2x.png',
  ];

  static const List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.yellow,
    Colors.green
  ];

  static const List<String> colorNames = [
    'red',
    'orange',
    'blue',
    'purple',
    'yellow',
    'green',
  ];

  static const List<String> words = [
    'Baban böyle pasta yapmayı nereden öğrendi?',
    'Hangi tarz müzik dinlersin?',
    'Oynadığın ilk oyun neydi?',
    'Oyun içi para harcama konusunda ne düşünüyorsun?',
    'Oyun oynarken hile kullanır mısın?',
    'Grafikler senin için ne kadar önemli?',
    'E-spor maçlarını izler misin?',
    'Twitch yayıncılarını izler misin?',
    'Mobil oyunlar mı? Pc oyunları mı?',
    'Hangi oyun karakteri ile bir gün geçirmek isterdin?',
    'Hangi tür film/dizi izlersin?',
    'Unutamadığın bir oyun sahnesi var mı?',
    'Masaüstü mü? Dizüstü mü?',
    'Konsol mu? Bilgisayar mı?',
    'Xbox mı? Playstation mı?',
    'Hangi oyun evreninde yaşamak isterdin?',
    'Hayatın bir oyun olsa adı ne olurdu?',
    'Bir süper kahraman olsan, hangi karakteri tercih ederdin?',
    'Çizgi roman sever misin?',
    'Anime izlemekten hoşlanır mısın?',
    'En sevdiğin dizi ne?',
    'En sevdiğin film ne?',
    'Bütün gününü bir oyun ile geçirsen, bu hangi oyun olurdu?',
    'Hiç daha önce bir oyunda sinirlenip Alt-F4 çektin mi?',
    'Oyun müzikleri senin için ne kadar önemli?',
    'Adını bir nick ile değiştirebilsen, bu ne olurdu?',
    'Hangi oyun karakterinin silahına/özel gücüne sahip olmak isterdin?'
  ];

  static const List<Map<String, String>> rosettes = [
    beslevelrozeti,
    ilkeslesme,
    oyunekleme,
    populeruye,
    resimekleme,
    senincizginyapma,
    sosyalmedyapaylasma,
    bestduo,
  ];

  static const Map<String, String> beslevelrozeti = {
    'photo': '5-level-rozeti.png',
    'detail': "Sosyal medya hesabını profiline ekle",
    'name': 'Arkadaş Canlısı'
  };

  static const Map<String, String> ilkeslesme = {
    'photo': 'ilk-eslesme.png',
    'detail': 'İlk eşleşme. İlk duonu bul',
    'name': 'İlkler her zaman özeldir.'
  };
  static const Map<String, String> oyunekleme = {
    'photo': 'oyun-ekleme.png',
    'detail': 'Profiline 10 oyun ekle',
    'name': 'Gerçek Oyuncu'
  };
  static const Map<String, String> populeruye = {
    'photo': 'populer.png',
    'detail': 'Yakıyorsun. 10 kişiyle eşleş',
    'name': 'Yakıyorsun. Aranılan Duo sensin'
  };
  static const Map<String, String> resimekleme = {
    'photo': 'resim-ekleme.png',
    'detail': '',
    'name': 'Avatarını değiştir'
  };
  static const Map<String, String> senincizginyapma = {
    'photo': 'senin-cizgin-yapma.png',
    'detail': 'Oyun istatistiklerini ekle',
    'name': "MVP"
  };
  static const Map<String, String> sosyalmedyapaylasma = {
    'photo': 'sosyal-medya-paylasma.png',
    'detail': 'Sosyal Medyada bizi paylaş',
    'name': 'Sosyal Medya Fenomeni'
  };
  static const Map<String, String> bestduo = {
    'photo': 'star-us3.png',
    'detail': "Bizi market üzerinde puanla",
    'name': 'Best Duo'
  };

  static const String noSuchUser =
      '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.';

  static const String alreadyHave =
      '[firebase_auth/email-already-in-use] The email address is already in use by another account.';

  static const String nouser =
      '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The User may have been deleted.';

  static const String blocked =
      '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.';

  static const String gifKey = '6J86ZFDUUL09';

  Future<int> calculatePercentage(String id, String myID) async {
    int value = 0;
    var myData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(myID)
        .collection('Questions')
        .get();
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection('Questions')
        .get();

    if (data.docs.isEmpty || myData.docs.isEmpty) {
      return value;
    } else {
      if (data.docs.first.get('questionAdded') &&
          myData.docs.first.get('questionAdded')) {
        //
        if (data.docs.first.get('duygusal') &&
            myData.docs.first.get('duygusal')) {
          value = value + 10;
        }
        if (data.docs.first.get('fevri') && myData.docs.first.get('fevri')) {
          value = value + 10;
        }
        if (data.docs.first.get('hirsli') && myData.docs.first.get('hirsli')) {
          value = value + 10;
        }
        if (data.docs.first.get('karamsar') &&
            myData.docs.first.get('karamsar')) {
          value = value + 10;
        }
        if (data.docs.first.get('kuralci') &&
            myData.docs.first.get('kuralci')) {
          value = value + 10;
        }
        if (data.docs.first.get('merakli') &&
            myData.docs.first.get('merakli')) {
          value = value + 10;
        }
        if (data.docs.first.get('neseli') && myData.docs.first.get('neseli')) {
          value = value + 10;
        }
        if (data.docs.first.get('sosyal') && myData.docs.first.get('sosyal')) {
          value = value + 10;
        }
        if (data.docs.first.get('utangac') &&
            myData.docs.first.get('utangac')) {
          value = value + 10;
        }
        if (data.docs.first.get('q1') == myData.docs.first.get('q1')) {
          value = value + 20;
        }
        if (data.docs.first.get('q2') == myData.docs.first.get('q2')) {
          value = value + 20;
        }
        if (data.docs.first.get('q3') == myData.docs.first.get('q3')) {
          value = value + 20;
        }

        //
        return value;
      } else {
        return value;
      }
    }
  }

  Future<bool> checkStorage() async {
    bool more = false;
    if (GetStorage().hasData('date')) {
      var memory = DateTime.parse(GetStorage().read<String>('date')!);
      var time = DateTime.now().subtract(Duration(days: 1));
      print(memory);
      print(time);
      var diffirence = DateTime.now().difference(memory);
      diffirence.compareTo(Duration(days: 1));
      bool sameDay = diffirence.compareTo(Duration(days: 1)).isNegative;
      bool nextDay = diffirence.compareTo(Duration(days: 2)).isNegative;
      print(sameDay);
      if (nextDay && !sameDay) {
        print('oldu');
        GetStorage().write("likeCount", 1);
        GetStorage().write("boughtExtra", false);
        GetStorage().write('date', DateTime.now().toIso8601String());
        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) async {
          int daysInRow = value.data()!['daysInRow'];
          int maxDays = value.data()!['maxDays'];
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'daysInRow': daysInRow + 1});
          if (daysInRow + 1 > maxDays) {
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({'maxDays': daysInRow + 1});
          }
          if (daysInRow + 1 < 11) {
            Get.to(() => DaysInRow(days: daysInRow + 1),
                transition: Transition.fadeIn);
          }
        });
        //succes
        more = true;
      } else if (sameDay) {
        //same day
        more = false;
        print('same day');
      } else {
        GetStorage().write('date', DateTime.now().toIso8601String());
        print('da');
        more = true;
      }
    } else {
      GetStorage().write('date', DateTime.now().toIso8601String());
      print('da2');
      more = true;
    }
    return more;
  }

  Color getLevelColor(int level) {
    Color color = Color(0xFFff5757);
    switch (level) {
      case 1:
        color = Color(0xFFff5757);
        break;
      case 2:
        color = Color(0xFFcb6ce6);
        break;
      case 3:
        color = Color(0xFF5e17eb);
        break;
      case 4:
        color = Color(0xFF03989e);
        break;
      case 5:
        color = Color(0xFF5ce1e6);
        break;
      case 6:
        color = Color(0xFF38b6ff);
        break;
      case 7:
        color = Color(0xFF004aad);
        break;
      case 8:
        color = Color(0xFF7ed957);
        break;
      case 9:
        color = Color(0xFFffde59);
        break;
      case 10:
        color = Color(0xFFff914d);
        break;
      default:
    }
    return color;
  }

  String getGameTime(DateTime time) {
    String data;
    if (time.year < DateTime.now().year) {
      if (time.month <= DateTime.now().month) {
        if (DateTime.now().month - time.month == 0) {
          data = '${DateTime.now().year - time.year} Yıl';
        } else {
          data =
              '${DateTime.now().year - time.year} Yıl ${DateTime.now().month - time.month} Ay';
        }
      } else {
        if (DateTime.now().year - time.year == 1) {
          data = '${DateTime.now().month + (12 - time.month)} Ay';
        } else {
          data =
              '${DateTime.now().year - time.year - 1} Yıl ${DateTime.now().month + (12 - time.month)} Ay';
        }
      }
    } else {
      data = '${DateTime.now().month - time.month} Ay';
    }
    if (data == '0 Ay') {
      data = '1 Aydan az';
    }
    return data;
  }

  int getLevel(int exp) {
    int level = 1;
    if (exp > 899) {
      level = 10;
    } else if (exp > 799) {
      level = 9;
    } else if (exp > 699) {
      level = 8;
    } else if (exp > 599) {
      level = 7;
    } else if (exp > 499) {
      level = 6;
    } else if (exp > 399) {
      level = 5;
    } else if (exp > 299) {
      level = 4;
    } else if (exp > 199) {
      level = 3;
    } else if (exp > 99) {
      level = 2;
    } else if (exp > 0) {
      level = 1;
    }
    return level;
  }
}
