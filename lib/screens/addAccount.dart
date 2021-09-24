import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/api.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/addAccountGetx.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:dart_lol/dart_lol.dart';
import 'package:gamehub/model/brawlBattle.dart' as brawlBattle;
import 'package:gamehub/model/brawlPlayer.dart' as brawlPlayer;
import 'package:photo_view/photo_view.dart';

import 'newLevel.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  FirebaseApi firebaseApi = Get.find();
  InfosGetx infosGetx = Get.find();
  AddAccountGetx addAccountGetx = Get.put(AddAccountGetx());
  TextEditingController text = TextEditingController();

  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Colors.grey[900],
        title: Text('Oyun hesabı seçiniz'),
        centerTitle: true,
      ),
      body: Container(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firebaseApi.firestore
                  .collection('Users')
                  .doc(firebaseApi.auth.currentUser!.uid)
                  .collection('Accounts')
                  .snapshots(),
              builder: (context, mydata) {
                return !mydata.hasData
                    ? Container()
                    : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: firebaseApi.firestore
                            .collection('Accounts')
                            .where('enabled', isEqualTo: true)
                            .get(),
                        builder: (context, snapshot) {
                          List<QueryDocumentSnapshot<Map<String, dynamic>>>
                              list = [];
                          if (snapshot.hasData) {
                            list = snapshot.data!.docs;
                            // list.remove(mydata.data!.docs);
                            List<String> myaccounts = [];
                            mydata.data!.docs.forEach((element) {
                              if (element.data()['name'] == 'ValveTestApp260') {
                                myaccounts.add('CS: GO');
                              } else {
                                myaccounts.add(element.data()['name']);
                              }
                            });
                            list.removeWhere((element) {
                              if (myaccounts.contains(element.data()['name'])) {
                                return true;
                              } else {
                                return false;
                              }
                            });
                          }
                          return snapshot.hasData
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: list.length == 0
                                          ? Center(
                                              child: Text(
                                                'Tüm istatistikleri paylaştınız',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 30,
                                                    color: context.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            )
                                          : GridView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount: list.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 1,
                                                      crossAxisCount: 2),
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(7),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        useRootNavigator: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return Scaffold(
                                                            resizeToAvoidBottomInset:
                                                                true,
                                                                
                                                            body: Container(
                                                              decoration: BoxDecoration(
                                                                  color: context
                                                                          .isDarkMode
                                                                      ? Colors.grey[
                                                                          900]
                                                                      : Colors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              20))),
                                                              child: Center(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  physics:BouncingScrollPhysics(),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Image
                                                                          .network(
                                                                        list[index]
                                                                            .data()['icon'],
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            100,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      Text(
                                                                        list[index]
                                                                            .data()['name'],
                                                                        style: GoogleFonts.roboto(
                                                                            fontSize:
                                                                                25),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 20),
                                                                        child:
                                                                            Text(
                                                                          list[index]
                                                                              .data()['help'],
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.roboto(fontSize: 17),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 40),
                                                                                child: TextField(
                                                                                  controller: text,
                                                                                  cursorColor: Colors.black,
                                                                                  cursorRadius: Radius.circular(10),
                                                                                  maxLines: 1,
                                                                                  scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 40.0),
                                                                                  textAlign: TextAlign.center,
                                                                                  decoration: InputDecoration(hintText: list[index].data()['hint'], focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.black, width: 2)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.black, width: 2))),
                                                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            list[index].data()['name'] == 'PubG' || list[index].data()['name'] == 'CS: GO' || list[index].data()['name'] == 'League of Legends' || list[index].data()['name'] == 'Teamfight Tactics'
                                                                                ? IconButton(
                                                                                    onPressed: () {
                                                                                      showModal(
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return Scaffold(
                                                                                            appBar: AppBar(
                                                                                              backgroundColor: Colors.transparent,
                                                                                              elevation: 0,
                                                                                            ),
                                                                                            extendBodyBehindAppBar: true,
                                                                                            body: PhotoView(
                                                                                                imageProvider: list[index].data()['name'] == 'League of Legends' || list[index].data()['name'] == 'Teamfight Tactics'
                                                                                                    ? AssetImage('assets/helps/lol.png')
                                                                                                    : list[index].data()['name'] == 'CS: GO'
                                                                                                        ? AssetImage('assets/helps/csgo.png')
                                                                                                        : list[index].data()['name'] == 'PubG'
                                                                                                            ? AssetImage('assets/helps/pubg.png')
                                                                                                            : AssetImage('assets/helps/lol.png')),
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    icon: Icon(Icons.help))
                                                                                : Container(),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      list[index]
                                                                              .data()['hasTwoPlatform']
                                                                          ? Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 70),
                                                                              child: Obx(
                                                                                () => Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          addAccountGetx.pc.value = true;
                                                                                        },
                                                                                        child: Container(
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            'PC',
                                                                                            style: TextStyle(
                                                                                                color: addAccountGetx.pc.value
                                                                                                    ? Colors.white
                                                                                                    : context.isDarkMode
                                                                                                        ? Colors.white
                                                                                                        : Colors.black,
                                                                                                fontSize: 20),
                                                                                          )),
                                                                                          decoration: BoxDecoration(
                                                                                              color: addAccountGetx.pc.value
                                                                                                  ? Colors.green
                                                                                                  : context.isDarkMode
                                                                                                      ? Colors.grey[900]
                                                                                                      : Colors.grey[200],
                                                                                              borderRadius: BorderRadius.horizontal(left: Radius.circular(20))),
                                                                                          height: 50,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          addAccountGetx.pc.value = false;
                                                                                        },
                                                                                        child: Container(
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            'PS',
                                                                                            style: TextStyle(
                                                                                                color: !addAccountGetx.pc.value
                                                                                                    ? Colors.white
                                                                                                    : context.isDarkMode
                                                                                                        ? Colors.white
                                                                                                        : Colors.black,
                                                                                                fontSize: 20),
                                                                                          )),
                                                                                          decoration: BoxDecoration(
                                                                                              color: !addAccountGetx.pc.value
                                                                                                  ? Colors.green
                                                                                                  : context.isDarkMode
                                                                                                      ? Colors.grey[900]
                                                                                                      : Colors.grey[200],
                                                                                              borderRadius: BorderRadius.horizontal(right: Radius.circular(20))),
                                                                                          height: 50,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 40),
                                                                        child:
                                                                            Obx(
                                                                          () =>
                                                                              Material(
                                                                            color:
                                                                                Colors.blue,
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            child:
                                                                                InkWell(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              onTap: addAccountGetx.loading.value
                                                                                  ? null
                                                                                  : () async {
                                                                                      if (text.text.isEmpty) {
                                                                                        return;
                                                                                      }
                                                                                      addAccountGetx.loading.value = true;
                                                                                      await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').add({
                                                                                        'icon': list[index].data()['icon'],
                                                                                        'name': list[index].data()['name'],
                                                                                        'data': text.text,
                                                                                        'done': false
                                                                                      });
                                                                                      if (list[index].data()['name'] == 'Brawl Stars') {
                                                                                        //Brawl Stars
                                                                                        String data;
                                                                                        if (text.text.startsWith("#")) {
                                                                                          data = text.text.substring(1);
                                                                                        } else {
                                                                                          data = text.text;
                                                                                        }
                                                                                        text.text = '';

                                                                                        Api().getBrawlStars(data).then((value) {
                                                                                          if (value[0] == null || value[1] == null) {
                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) async {
                                                                                              await value.docs.first.reference.delete();
                                                                                              addAccountGetx.loading.value = false;
                                                                                              Get.snackbar('Hesap geçerli değil', 'Lütfen geçerli hesap giriniz');
                                                                                            });
                                                                                            return;
                                                                                          } else {
                                                                                            addAccountGetx.loading.value = false;
                                                                                            Get.back();
                                                                                            brawlPlayer.BrawlPlayer? player = value[0];
                                                                                            brawlBattle.BrawlBattle? battle = value[1];
                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) {
                                                                                              value.docs.first.reference.update({
                                                                                                'done': true,
                                                                                                'id': player!.tag,
                                                                                                'level': player.expLevel,
                                                                                                'duo': player.duoVictories,
                                                                                                'solo': player.soloVictories,
                                                                                                'vs': player.the3Vs3Victories,
                                                                                                'mode': battle!.items.first.battle.mode,
                                                                                                'result': battle.items.first.battle.result,
                                                                                                'type': battle.items.first.battle.type,
                                                                                                'star': battle.items.first.battle.starPlayer
                                                                                              });
                                                                                            });
                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.senincizginyapma['name']!).get().then((value) async {
                                                                                              if (value.docs.isEmpty) {
                                                                                                Get.snackbar('Başarı kazandın', Utils.senincizginyapma['name']!,
                                                                                                    icon: Padding(
                                                                                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                      child: Icon(
                                                                                                        Icons.emoji_events_outlined,
                                                                                                        size: 35,
                                                                                                      ),
                                                                                                    ));
                                                                                                firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                                  'name': Utils.senincizginyapma['name']!,
                                                                                                  'photo': Utils.senincizginyapma['photo']!,
                                                                                                });
                                                                                                await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                                                                                  int exp = value.data()!['exp'];
                                                                                                  int level = value.data()!['level'];
                                                                                                  int newExp = exp + 100;
                                                                                                  int newLevel = Utils().getLevel(newExp);
                                                                                                  await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'exp': newExp});
                                                                                                  if (level != newLevel) {
                                                                                                    //yeni seviyye
                                                                                                    await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'level': newLevel});
                                                                                                    Get.to(() => NewLevel(level: newLevel));
                                                                                                  }
                                                                                                });
                                                                                              }
                                                                                            });
                                                                                          }
                                                                                        });
                                                                                      } else if (list[index].data()['name'] == 'PubG') {
                                                                                        //PubG
                                                                                        String data = text.text;
                                                                                        text.text = '';

                                                                                        if (addAccountGetx.pc.value) {
                                                                                          //pc
                                                                                          Api().getPubg(data, true, false, 'id').then((stats) {
                                                                                            if (stats == null) {
                                                                                              firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) async {
                                                                                                await value.docs.first.reference.delete();
                                                                                                addAccountGetx.loading.value = false;
                                                                                                Get.snackbar('Hesap geçerli değil', 'Lütfen geçerli hesap giriniz');
                                                                                              });
                                                                                              return;
                                                                                            } else {
                                                                                              addAccountGetx.loading.value = false;
                                                                                              Get.back();
                                                                                              firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) {
                                                                                                // stats!
                                                                                                //     .data
                                                                                                //     .attributes
                                                                                                //     .bestRankPoint;
                                                                                                value.docs.first.reference.update({
                                                                                                  'done': true,
                                                                                                  'soloKillsFpp': stats.data.attributes.gameModeStats.soloFpp.kills,
                                                                                                  'soloFpp': stats.data.attributes.gameModeStats.soloFpp.rankPoints,
                                                                                                  'soloDeathFpp': stats.data.attributes.gameModeStats.soloFpp.losses,
                                                                                                  'duoKillsFpp': stats.data.attributes.gameModeStats.duoFpp.kills,
                                                                                                  'duoFpp': stats.data.attributes.gameModeStats.duoFpp.rankPoints,
                                                                                                  'duoDeathFpp': stats.data.attributes.gameModeStats.duoFpp.losses,
                                                                                                  'squadKillsFpp': stats.data.attributes.gameModeStats.squadFpp.kills,
                                                                                                  'squadFpp': stats.data.attributes.gameModeStats.squadFpp.rankPoints,
                                                                                                  'squadDeathFpp': stats.data.attributes.gameModeStats.squadFpp.losses,
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
                                                                                              firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.senincizginyapma['name']!).get().then((value) async {
                                                                                                if (value.docs.isEmpty) {
                                                                                                  Get.snackbar('Başarı kazandın', Utils.senincizginyapma['name']!,
                                                                                                      icon: Padding(
                                                                                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                        child: Icon(
                                                                                                          Icons.emoji_events_outlined,
                                                                                                          size: 35,
                                                                                                        ),
                                                                                                      ));
                                                                                                  firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                                    'name': Utils.senincizginyapma['name']!,
                                                                                                    'photo': Utils.senincizginyapma['photo']!,
                                                                                                  });
                                                                                                  await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                                                                                    int exp = value.data()!['exp'];
                                                                                                    int level = value.data()!['level'];
                                                                                                    int newExp = exp + 100;
                                                                                                    int newLevel = Utils().getLevel(newExp);
                                                                                                    await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'exp': newExp});
                                                                                                    if (level != newLevel) {
                                                                                                      //yeni seviyye
                                                                                                      await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'level': newLevel});
                                                                                                      Get.to(() => NewLevel(level: newLevel));
                                                                                                    }
                                                                                                  });
                                                                                                }
                                                                                              });
                                                                                            }
                                                                                          });
                                                                                        } else {
                                                                                          // console
                                                                                          Api().getPubg(data, false, false, 'id').then((stats) {
                                                                                            if (stats == null) {
                                                                                              firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) async {
                                                                                                await value.docs.first.reference.delete();
                                                                                                addAccountGetx.loading.value = false;
                                                                                                Get.snackbar('Hesap geçerli değil', 'Lütfen geçerli hesap giriniz');
                                                                                              });
                                                                                              return;
                                                                                            } else {
                                                                                              addAccountGetx.loading.value = false;
                                                                                              Get.back();
                                                                                              firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) {
                                                                                                // stats!
                                                                                                //     .data
                                                                                                //     .attributes
                                                                                                //     .bestRankPoint;
                                                                                                value.docs.first.reference.update({
                                                                                                  'done': true,
                                                                                                  'soloKillsFpp': stats.data.attributes.gameModeStats.soloFpp.kills,
                                                                                                  'soloFpp': stats.data.attributes.gameModeStats.soloFpp.rankPoints,
                                                                                                  'soloDeathFpp': stats.data.attributes.gameModeStats.soloFpp.losses,
                                                                                                  'duoKillsFpp': stats.data.attributes.gameModeStats.duoFpp.kills,
                                                                                                  'duoFpp': stats.data.attributes.gameModeStats.duoFpp.rankPoints,
                                                                                                  'duoDeathFpp': stats.data.attributes.gameModeStats.duoFpp.losses,
                                                                                                  'squadKillsFpp': stats.data.attributes.gameModeStats.squadFpp.kills,
                                                                                                  'squadFpp': stats.data.attributes.gameModeStats.squadFpp.rankPoints,
                                                                                                  'squadDeathFpp': stats.data.attributes.gameModeStats.squadFpp.losses,
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
                                                                                              firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.senincizginyapma['name']!).get().then((value) async {
                                                                                                if (value.docs.isEmpty) {
                                                                                                  Get.snackbar('Başarı kazandın', Utils.senincizginyapma['name']!,
                                                                                                      icon: Padding(
                                                                                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                        child: Icon(
                                                                                                          Icons.emoji_events_outlined,
                                                                                                          size: 35,
                                                                                                        ),
                                                                                                      ));
                                                                                                  firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                                    'name': Utils.senincizginyapma['name']!,
                                                                                                    'photo': Utils.senincizginyapma['photo']!,
                                                                                                  });
                                                                                                  await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                                                                                    int exp = value.data()!['exp'];
                                                                                                    int level = value.data()!['level'];
                                                                                                    int newExp = exp + 100;
                                                                                                    int newLevel = Utils().getLevel(newExp);
                                                                                                    await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'exp': newExp});
                                                                                                    if (level != newLevel) {
                                                                                                      //yeni seviyye
                                                                                                      await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'level': newLevel});
                                                                                                      Get.to(() => NewLevel(level: newLevel));
                                                                                                    }
                                                                                                  });
                                                                                                }
                                                                                              });
                                                                                            }
                                                                                          });
                                                                                        }
                                                                                      } else if (list[index].data()['name'] == 'Riot Games') {
                                                                                        //Riot Games
                                                                                      } else if (list[index].data()['name'] == 'CS: GO') {
                                                                                        // CS: GO
                                                                                        String data = text.text;
                                                                                        text.text = '';

                                                                                        Api().getCSGO(data).then((player) {
                                                                                          if (player == null) {
                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) async {
                                                                                              print('delete');
                                                                                              await value.docs.first.reference.delete();
                                                                                              addAccountGetx.loading.value = false;
                                                                                              Get.snackbar('Hesap geçerli değil', 'Lütfen geçerli hesap giriniz');
                                                                                            });
                                                                                            return;
                                                                                          } else {
                                                                                            addAccountGetx.loading.value = false;
                                                                                            Get.back();
                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) {
                                                                                              value.docs.first.reference.update({
                                                                                                'done': true,
                                                                                                'name': player.playerstats.gameName,
                                                                                                'data': data,
                                                                                                'kills': player.playerstats.stats[0].value,
                                                                                                'deaths': player.playerstats.stats[1].value,
                                                                                                'wins': player.playerstats.stats[5].value,
                                                                                                'achievements': player.playerstats.achievements.length,
                                                                                              });
                                                                                            });
                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.senincizginyapma['name']!).get().then((value) async {
                                                                                              if (value.docs.isEmpty) {
                                                                                                Get.snackbar('Başarı kazandın', Utils.senincizginyapma['name']!,
                                                                                                    icon: Padding(
                                                                                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                      child: Icon(
                                                                                                        Icons.emoji_events_outlined,
                                                                                                        size: 35,
                                                                                                      ),
                                                                                                    ));
                                                                                                firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                                  'name': Utils.senincizginyapma['name']!,
                                                                                                  'photo': Utils.senincizginyapma['photo']!,
                                                                                                });
                                                                                                await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                                                                                  int exp = value.data()!['exp'];
                                                                                                  int level = value.data()!['level'];
                                                                                                  int newExp = exp + 100;
                                                                                                  int newLevel = Utils().getLevel(newExp);
                                                                                                  await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'exp': newExp});
                                                                                                  if (level != newLevel) {
                                                                                                    //yeni seviyye
                                                                                                    await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'level': newLevel});
                                                                                                    Get.to(() => NewLevel(level: newLevel));
                                                                                                  }
                                                                                                });
                                                                                              }
                                                                                            });
                                                                                          }
                                                                                        });
                                                                                      } else if (list[index].data()['name'] == 'League of Legends') {
                                                                                        String data = text.text;
                                                                                        print(data);
                                                                                        text.text = '';
                                                                                        var league = League(apiToken: Utils.token_Riot_lol, server: "tr1");
                                                                                        var player = await league.getSummonerInfo(summonerName: data);
                                                                                        if (player.accID == null) {
                                                                                          firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) async {
                                                                                            print('delete');
                                                                                            await value.docs.first.reference.delete();
                                                                                            addAccountGetx.loading.value = false;
                                                                                            Get.snackbar('Hesap geçerli değil', 'Lütfen geçerli hesap giriniz');
                                                                                          });
                                                                                          return;
                                                                                        }
                                                                                        var gameStat = await league.getGameHistory(accountID: player.accID, summonerName: data);
                                                                                        var game = await gameStat!.first.stats();
                                                                                        addAccountGetx.loading.value = false;
                                                                                        Get.back();
                                                                                        firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) {
                                                                                          value.docs.first.reference.update({
                                                                                            'done': true,
                                                                                            'data': player.summonerName,
                                                                                            'level': player.level,
                                                                                            'kills': game.kills,
                                                                                            'deaths': game.deaths,
                                                                                            'win': game.win
                                                                                          });
                                                                                        });
                                                                                        firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.senincizginyapma['name']!).get().then((value) async {
                                                                                          if (value.docs.isEmpty) {
                                                                                            Get.snackbar('Başarı kazandın', Utils.senincizginyapma['name']!,
                                                                                                icon: Padding(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                  child: Icon(
                                                                                                    Icons.emoji_events_outlined,
                                                                                                    size: 35,
                                                                                                  ),
                                                                                                ));
                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                              'name': Utils.senincizginyapma['name']!,
                                                                                              'photo': Utils.senincizginyapma['photo']!,
                                                                                            });
                                                                                            await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                                                                              int exp = value.data()!['exp'];
                                                                                              int level = value.data()!['level'];
                                                                                              int newExp = exp + 100;
                                                                                              int newLevel = Utils().getLevel(newExp);
                                                                                              await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'exp': newExp});
                                                                                              if (level != newLevel) {
                                                                                                //yeni seviyye
                                                                                                await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                                  'level': newLevel
                                                                                                });
                                                                                                Get.to(() => NewLevel(level: newLevel));
                                                                                              }
                                                                                            });
                                                                                          }
                                                                                        });
                                                                                      } else if (list[index].data()['name'] == 'Teamfight Tactics') {
                                                                                        String data = text.text;
                                                                                        print(data);
                                                                                        text.text = '';
                                                                                        var player = await Api().getTftPlayer(data);
                                                                                        if (player == null) {
                                                                                          firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) async {
                                                                                            print('delete');
                                                                                            await value.docs.first.reference.delete();
                                                                                            addAccountGetx.loading.value = false;
                                                                                            Get.snackbar('Hesap geçerli değil', 'Lütfen geçerli hesap giriniz');
                                                                                          });
                                                                                          return;
                                                                                        }
                                                                                        var gameId = await Api().getTftGame(player.puuid);
                                                                                        var gameData = await Api().getTftData(gameId!.first);
                                                                                        addAccountGetx.loading.value = false;
                                                                                        Get.back();
                                                                                        firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Accounts').where('name', isEqualTo: list[index].data()['name']).get().then((value) {
                                                                                          value.docs.first.reference.update({
                                                                                            'done': true,
                                                                                            'data': player.name,
                                                                                            'level': player.summonerLevel,
                                                                                            'type': gameData!.info.tftGameType,
                                                                                            'time': gameData.info.gameLength,
                                                                                            'length': gameData.info.participants.length,
                                                                                          });
                                                                                        });
                                                                                        firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.senincizginyapma['name']!).get().then((value) async {
                                                                                          if (value.docs.isEmpty) {
                                                                                            Get.snackbar('Başarı kazandın', Utils.senincizginyapma['name']!,
                                                                                                icon: Padding(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                  child: Icon(
                                                                                                    Icons.emoji_events_outlined,
                                                                                                    size: 35,
                                                                                                  ),
                                                                                                ));
                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                              'name': Utils.senincizginyapma['name']!,
                                                                                              'photo': Utils.senincizginyapma['photo']!,
                                                                                            });
                                                                                            await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                                                                              int exp = value.data()!['exp'];
                                                                                              int level = value.data()!['level'];
                                                                                              int newExp = exp + 100;
                                                                                              int newLevel = Utils().getLevel(newExp);
                                                                                              await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'exp': newExp});
                                                                                              if (level != newLevel) {
                                                                                                //yeni seviyye
                                                                                                await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                                  'level': newLevel
                                                                                                });
                                                                                                Get.to(() => NewLevel(level: newLevel));
                                                                                              }
                                                                                            });
                                                                                          }
                                                                                        });
                                                                                      }
                                                                                    },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(18),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    addAccountGetx.loading.value
                                                                                        ? CircularProgressIndicator(
                                                                                            color: Colors.white,
                                                                                          )
                                                                                        : Text(
                                                                                            'Ekle',
                                                                                            style: TextStyle(fontSize: 22, color: Colors.white),
                                                                                          )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            50,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(30),
                                                            child: Image.network(
                                                                list[index]
                                                                        .data()[
                                                                    'icon']),
                                                          )),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            child: Text(
                                                              list[index]
                                                                      .data()[
                                                                  'name'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          22),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.grey[900]
                                                              : Colors
                                                                  .grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: CircularPercentIndicator(radius: 40),
                                );
                        },
                      );
              }),
        ),
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
