import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamehub/model/brawlBattle.dart';
import 'package:gamehub/model/brawlPlayer.dart';
import 'package:gamehub/model/gifModel.dart';
import 'package:gamehub/model/pubgPlayer.dart';
import 'package:gamehub/model/pubgStats.dart';
import 'package:gamehub/model/steamStats.dart';
import 'package:gamehub/model/tftData.dart';
import 'package:gamehub/model/tftPlayer.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class Api {
  Future<Gif?> getGifs(String search) async {
    int limit = 50;
    Gif? gif;
    var url = Uri.parse('https://g.tenor.com/v1/search?q=$search&key=${Utils.gifKey}&limit=$limit');

    var response = await get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      gif = Gif.fromJson(jsonDecode(json));
      return gif;
    } else {
      Get.snackbar('Hata', 'Hata kodu: ${response.statusCode}');
      return gif;
    }
  }

  Future<List<dynamic>> getBrawlStars(String data) async {
    var url1 = Uri.parse('https://api.brawlstars.com/v1/players/%23$data');
    var url2 = Uri.parse('https://api.brawlstars.com/v1/players/%23$data/battlelog');
    BrawlPlayer? player;
    BrawlBattle? battle;
    var response1 = await get(url1, headers: {"Authorization": "Bearer ${Utils.token_Brawl}", "Accept": "application/json"});
    var response2 = await get(url2, headers: {"Authorization": "Bearer ${Utils.token_Brawl}", "Accept": "application/json"});

    if (response1.statusCode == 200) {
      var json1 = response1.body;
      player = BrawlPlayer.fromJson(jsonDecode(json1));
    } else {
      Get.snackbar('Hata', 'Hata kodu: ${response1.statusCode}');
    }
    if (response2.statusCode == 200) {
      var json2 = response2.body;
      battle = BrawlBattle.fromJson(jsonDecode(json2));
    } else {
      Get.snackbar('Hata', 'Hata kodu: ${response2.statusCode}');
    }

    return [player, battle];
  }

  Future<PubgStats?> getPubg(String name, bool steam, bool hasId, String id) async {
    PubgStats? pubgStats;
    if (steam) {
      if (hasId) {
        var urlForStats = Uri.parse('https://api.pubg.com/shards/steam/players/$id/seasons/lifetime?filter[gamepad]=false');
        var response2 = await get(urlForStats, headers: {"accept": "application/vnd.api+json", "Authorization": "Bearer ${Utils.token_Pubg}"});

        pubgStats = PubgStats.fromJson(jsonDecode(response2.body));
        return pubgStats;
      } else {
        var urlForId = Uri.parse('https://api.pubg.com/shards/steam/players?filter[playerNames]=$name');

        var response1 = await get(urlForId, headers: {"accept": "application/vnd.api+json", "Authorization": "Bearer ${Utils.token_Pubg}"});

        if (response1.statusCode == 200) {
          var player = PubgPlayer.fromJson(jsonDecode(response1.body));
          String id = player.data.first.id;
          print(id);

          // GetStorage().write('pubgPlayer', id);
          // GetStorage().write('pubgPC', true);
          try {
            FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Accounts').where('name', isEqualTo: 'PubG').get().then((value) {
              try {
                value.docs.first.reference.update({'id': id, 'pc': true});
              } catch (e) {}
            });
          } catch (e) {}

          var urlForStats = Uri.parse('https://api.pubg.com/shards/steam/players/$id/seasons/lifetime?filter[gamepad]=false');
          var response2 = await get(urlForStats, headers: {"accept": "application/vnd.api+json", "Authorization": "Bearer ${Utils.token_Pubg}"});

          pubgStats = PubgStats.fromJson(jsonDecode(response2.body));
          return pubgStats;
        } else {
          print('sdfdgsdfgsdfgsd');
          print(response1.statusCode);
          return pubgStats;
        }
      }
    } else {
      if (hasId) {
        var urlForStats = Uri.parse('https://api.pubg.com/shards/psn/players/$id/seasons/lifetime?filter[gamepad]=true');
        var response2 = await get(urlForStats, headers: {"accept": "application/vnd.api+json", "Authorization": "Bearer ${Utils.token_Pubg}"});

        pubgStats = PubgStats.fromJson(jsonDecode(response2.body));
        return pubgStats;
      } else {
        var urlForId = Uri.parse('https://api.pubg.com/shards/psn/players?filter[playerNames]=$name');

        var response1 = await get(urlForId, headers: {"accept": "application/vnd.api+json", "Authorization": "Bearer ${Utils.token_Pubg}"});

        if (response1.statusCode == 200) {
          var player = PubgPlayer.fromJson(jsonDecode(response1.body));
          String id = player.data.first.id;
          print(id);

          // GetStorage().write('pubgPlayer', id);
          // GetStorage().write('pubgPC', false);

          try {
            FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Accounts').where('name', isEqualTo: 'PubG').get().then((value) {
              try {
                value.docs.first.reference.update({'id': id, 'pc': false});
              } catch (e) {}
            });
          } catch (e) {}

          var urlForStats = Uri.parse('https://api.pubg.com/shards/psn/players/$id/seasons/lifetime?filter[gamepad]=true');
          var response2 = await get(urlForStats, headers: {"accept": "application/vnd.api+json", "Authorization": "Bearer ${Utils.token_Pubg}"});

          pubgStats = PubgStats.fromJson(jsonDecode(response2.body));
          return pubgStats;
        } else {
          print(response1.statusCode);
          return pubgStats;
        }
      }
    }
  }

  Future<SteamStats?> getCSGO(String id) async {
    var url = Uri.parse('https://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v2?key=${Utils.token_Steam}&steamid=$id&appid=730');
    SteamStats? steamStats;
    var response = await get(url);

    if (response.statusCode == 200) {
      print('sdfdsfsdfdsfds');
      steamStats = SteamStats.fromJson(jsonDecode(response.body));
      return steamStats;
    } else {
      print(response.statusCode);
      print('cvbcvbcxvzbxcvb');
      return steamStats;
    }
  }

    Future<TftPlayer?> getTftPlayer(String name) async {
    var url = Uri.parse('https://tr1.api.riotgames.com/tft/summoner/v1/summoners/by-name/$name?api_key=${Utils.token_Riot_tft}');
    TftPlayer? tftPlayer;
    var response = await get(url);

    if (response.statusCode == 200) {
      print('sdfdsfsdfdsfds');
      tftPlayer = TftPlayer.fromJson(jsonDecode(response.body));
      return tftPlayer;
    } else {
      print(response.statusCode);
      print('cvbcvbcxvzbxcvb');
      return tftPlayer;
    }
  }

      Future<List<dynamic>?> getTftGame(String id) async {
    var url = Uri.parse('https://europe.api.riotgames.com/tft/match/v1/matches/by-puuid/$id/ids?count=1&api_key=${Utils.token_Riot_tft}');
    List<dynamic> tftGame;
    var response = await get(url);

    if (response.statusCode == 200) {
      print('sdfdsfsdfdsfds');
      // tftGame = tftGameFromJson(jsonDecode(response.body));
      tftGame = jsonDecode(response.body);
      return tftGame;
    } else {
      print(response.statusCode);
      print('cvbcvbcxvzbxcvb');
      return ['tftGame'];
    }
  }
       Future<TftData?> getTftData(String id) async {
    var url = Uri.parse('https://europe.api.riotgames.com/tft/match/v1/matches/$id?api_key=${Utils.token_Riot_tft}');
    TftData? tftGame;
    var response = await get(url);

    if (response.statusCode == 200) {
      print('sdfdsfsdfdsfds');
      tftGame = TftData.fromJson(jsonDecode(response.body));
      return tftGame;
    } else {
      print(response.statusCode);
      print('cvbcvbcxvzbxcvb');
      return tftGame;
    }
  }





}
