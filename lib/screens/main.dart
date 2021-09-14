import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_lol/dart_lol.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/api.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/cardsGetx.dart';
import 'package:gamehub/getx/filterGetx.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/getx/mainGetx.dart';
import 'package:gamehub/screens/connect.dart';
import 'package:gamehub/screens/help.dart';
import 'package:gamehub/screens/message.dart';
import 'package:gamehub/screens/messages.dart';
import 'package:gamehub/screens/profile.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Main extends StatefulWidget {
  final bool first;

  const Main({Key? key, required this.first}) : super(key: key);
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  MainGetX mainGetX = Get.find();
  FirebaseApi firebaseApi = Get.find();
  InfosGetx infosGetx = Get.find();
  FilterGetx filterGetx = Get.find();
  CardsGetx cardsGetx = Get.find();

  @override
  void initState() {
    getReady();
    getToken();
    reloadAccounts();
    listenNotifications();
    if (widget.first) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Get.to(() => Help(), transition: Transition.noTransition);
      });
    }
    super.initState();
  }

  void reloadAccounts() async {
    firebaseApi.firestore
        .collection('Users')
        .doc(firebaseApi.auth.currentUser!.uid)
        .collection('Accounts')
        .where('name', isEqualTo: 'PubG')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        String id = value.docs.first.data()['id'];
        if (value.docs.first.data()['pc']) {
          //pc
          Api().getPubg('data', true, true, id).then((stats) {
            if (stats == null) {
              return;
            }
            value.docs.first.reference.update({
              'soloKillsFpp': stats.data.attributes.gameModeStats.soloFpp.kills,
              'soloFpp': stats.data.attributes.gameModeStats.soloFpp.rankPoints,
              'soloDeathFpp':
                  stats.data.attributes.gameModeStats.soloFpp.losses,
              'duoKillsFpp': stats.data.attributes.gameModeStats.duoFpp.kills,
              'duoFpp': stats.data.attributes.gameModeStats.duoFpp.rankPoints,
              'duoDeathFpp': stats.data.attributes.gameModeStats.duoFpp.losses,
              'squadKillsFpp':
                  stats.data.attributes.gameModeStats.squadFpp.kills,
              'squadFpp':
                  stats.data.attributes.gameModeStats.squadFpp.rankPoints,
              'squadDeathFpp':
                  stats.data.attributes.gameModeStats.squadFpp.losses,
              'soloKills': stats.data.attributes.gameModeStats.solo.kills,
              'solo': stats.data.attributes.gameModeStats.solo.rankPoints,
              'soloDeath': stats.data.attributes.gameModeStats.solo.losses,
              'duoKills': stats.data.attributes.gameModeStats.duo.kills,
              'duo': stats.data.attributes.gameModeStats.duo.rankPoints,
              'duoDeath': stats.data.attributes.gameModeStats.duo.losses,
              'squadKills': stats.data.attributes.gameModeStats.squad.kills,
              'squad': stats.data.attributes.gameModeStats.squad.rankPoints,
              'squadDeath': stats.data.attributes.gameModeStats.squad.losses,
              'best': stats.data.attributes.bestRankPoint
            });
          });
        } else {
          // console
          Api().getPubg('data', false, true, id).then((stats) {
            if (stats == null) {
              return;
            }
            value.docs.first.reference.update({
              'soloKillsFpp': stats.data.attributes.gameModeStats.soloFpp.kills,
              'soloFpp': stats.data.attributes.gameModeStats.soloFpp.rankPoints,
              'soloDeathFpp':
                  stats.data.attributes.gameModeStats.soloFpp.losses,
              'duoKillsFpp': stats.data.attributes.gameModeStats.duoFpp.kills,
              'duoFpp': stats.data.attributes.gameModeStats.duoFpp.rankPoints,
              'duoDeathFpp': stats.data.attributes.gameModeStats.duoFpp.losses,
              'squadKillsFpp':
                  stats.data.attributes.gameModeStats.squadFpp.kills,
              'squadFpp':
                  stats.data.attributes.gameModeStats.squadFpp.rankPoints,
              'squadDeathFpp':
                  stats.data.attributes.gameModeStats.squadFpp.losses,
              'soloKills': stats.data.attributes.gameModeStats.solo.kills,
              'solo': stats.data.attributes.gameModeStats.solo.rankPoints,
              'soloDeath': stats.data.attributes.gameModeStats.solo.losses,
              'duoKills': stats.data.attributes.gameModeStats.duo.kills,
              'duo': stats.data.attributes.gameModeStats.duo.rankPoints,
              'duoDeath': stats.data.attributes.gameModeStats.duo.losses,
              'squadKills': stats.data.attributes.gameModeStats.squad.kills,
              'squad': stats.data.attributes.gameModeStats.squad.rankPoints,
              'squadDeath': stats.data.attributes.gameModeStats.squad.losses,
              'best': stats.data.attributes.bestRankPoint
            });
          });
        }
      }
    });

    firebaseApi.firestore
        .collection('Users')
        .doc(firebaseApi.auth.currentUser!.uid)
        .collection('Accounts')
        .where('name', isEqualTo: 'CS: GO')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        String id = value.docs.first.data()['data'];
        Api().getCSGO(id).then((player) {
          if (player == null) {
            return;
          }
          value.docs.first.reference.update({
            'name': player.playerstats.gameName,
            'kills': player.playerstats.stats[0].value,
            'deaths': player.playerstats.stats[1].value,
            'wins': player.playerstats.stats[5].value,
            'achievements': player.playerstats.achievements.length,
          });
        });
      }
    });

    firebaseApi.firestore
        .collection('Users')
        .doc(firebaseApi.auth.currentUser!.uid)
        .collection('Accounts')
        .where('name', isEqualTo: 'League of Legends')
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        String id = value.docs.first.data()['data'];
        var league = League(apiToken: Utils.token_Riot_lol, server: "tr1");
        var player = await league.getSummonerInfo(summonerName: id);
        if (player.accID == null) {
          return;
        }
        var gameStat = await league.getGameHistory(
            accountID: player.accID, summonerName: id);
        var game = await gameStat!.first.stats();
        value.docs.first.reference.update({
          'done': true,
          'data': player.summonerName,
          'level': player.level,
          'kills': game.kills,
          'deaths': game.deaths,
          'win': game.win
        });
      }
    });

    firebaseApi.firestore
        .collection('Users')
        .doc(firebaseApi.auth.currentUser!.uid)
        .collection('Accounts')
        .where('name', isEqualTo: 'Teamfight Tactics')
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        String id = value.docs.first.data()['data'];
        var player = await Api().getTftPlayer(id);
        if (player == null) {
          return;
        }
        var gameId = await Api().getTftGame(player.puuid);
        var gameData = await Api().getTftData(gameId!.first);
        value.docs.first.reference.update({
          'done': true,
          'data': player.name,
          'level': player.summonerLevel,
          'type': gameData!.info.tftGameType,
          'time': gameData.info.gameLength,
          'length': gameData.info.participants.length,
        });
      }
    });
  }

  void getReady() async {
    bool more = await Utils().checkStorage();
    var data = await firebaseApi.firestore
        .collection('Users')
        .doc(firebaseApi.auth.currentUser!.uid)
        .get();
    cardsGetx.limit.value = data.data()!['limit'];
    cardsGetx.more.value = more;

    filterGetx.generateCard();
  }

  void listenNotifications() {
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        if (value.data['type'] == 'message') {
          bool avatarIsAsset = true;

          if (value.data['avatarIsAsset'] != "true") {
            avatarIsAsset = false;
          }
          firebaseApi.pairId = value.data['pairId'];
          Get.to(
              () => Message(
                  name: value.data['name'],
                  avatar: value.data['avatar'],
                  avatarIsAsset: avatarIsAsset,
                  pairId: value.data['pairId'],
                  id: value.data['id']),
              transition: Transition.cupertino);
        }
      }
    });

    FirebaseMessaging.onMessage.listen((event) {
      if (event.data['type'] == 'message') {
        bool avatarIsAsset = true;

        if (event.data['avatarIsAsset'] != "true") {
          avatarIsAsset = false;
        }
        if (firebaseApi.pairId != event.data['pairId']) {
          Get.snackbar(event.notification!.title!, event.notification!.body!,
              backgroundColor: context.isDarkMode ? Colors.black : Colors.white,
              colorText: context.isDarkMode ? Colors.white : Colors.black,
              onTap: (item) {
            firebaseApi.pairId = event.data['pairId'];
            Get.to(
                () => Message(
                    name: event.data['name'],
                    avatar: event.data['avatar'],
                    avatarIsAsset: avatarIsAsset,
                    pairId: event.data['pairId'],
                    id: event.data['id']),
                transition: Transition.cupertino);
          });
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.data['type'] == 'message') {
        bool avatarIsAsset = true;

        if (event.data['avatarIsAsset'] != "true") {
          avatarIsAsset = false;
        }
        if (firebaseApi.pairId != event.data['pairId']) {
          firebaseApi.pairId = event.data['pairId'];
          Get.to(
              () => Message(
                  name: event.data['name'],
                  avatar: event.data['avatar'],
                  avatarIsAsset: avatarIsAsset,
                  pairId: event.data['pairId'],
                  id: event.data['id']),
              transition: Transition.cupertino);
        }
      }
    });
  }

  Future<void> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    if (token != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'token': token});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: context.isDarkMode ? Colors.black : Colors.white,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => GestureDetector(
                      child: Opacity(
                        opacity: mainGetX.navBarIndex.value == 1 ? 1 : 0.65,
                        child: Image.asset(
                          'assets/chat.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      onTap: () {
                        mainGetX.changeNavBar(1);
                      },
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Opacity(
                          opacity: mainGetX.navBarIndex.value == 0 ? 1 : 0.65,
                          child: Image.asset('assets/orta.png'),
                        ),
                        onTap: () {
                          mainGetX.changeNavBar(0);
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      child: infosGetx.avatarIsAsset.value
                          ? Opacity(
                              opacity:
                                  mainGetX.navBarIndex.value == 2 ? 1 : 0.65,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    infosGetx.avatar.value == 'assets/user.png'
                                        ? Colors.grey[200]
                                        : Colors.transparent,
                                backgroundImage:
                                    AssetImage(infosGetx.avatar.value),
                              ),
                            )
                          : Opacity(
                              opacity:
                                  mainGetX.navBarIndex.value == 2 ? 1 : 0.65,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(infosGetx.avatar.value),
                              ),
                            ),
                      onTap: () {
                        mainGetX.changeNavBar(2);
                      },
                    ),
                  ),
                ],
              ),
              color: context.isDarkMode ? Colors.grey[900] : Colors.grey[300],
              // color: mainGetX.navBarIndex.value == 0
              //     ? Colors.white
              //     : mainGetX.navBarIndex.value == 1
              //         ? Colors.white
              //         : Colors.white,
            ),
            // bottomNavigationBar: CustomNavigationBar(
            //   items: [
            //     CustomNavigationBarItem(icon: Icon(Icons.gamepad_rounded)),
            // CustomNavigationBarItem(icon: Icon(Icons.message),),
            //     CustomNavigationBarItem(icon: Icon(Icons.star)),
            //     CustomNavigationBarItem(icon: Icon(Icons.person))
            //   ],
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   selectedColor: Colors.red,
            //   strokeColor: Colors.redAccent,
            //   bubbleCurve: Curves.linearToEaseOut,
            //   scaleFactor: 0.28,
            //   onTap: (index) {
            //     mainGetX.changeNavBar(index);
            //   },
            //   currentIndex: mainGetX.navBarIndex.value,
            // ),
            body: IndexedStack(
              index: mainGetX.navBarIndex.value,
              children: [Connect(), Messages(), Profile()],
            ),
          ),
        ),
      ),
    );
  }
}
