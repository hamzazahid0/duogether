import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/searchGameGetx.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'newLevel.dart';

class AddGame extends StatefulWidget {
  const AddGame({Key? key}) : super(key: key);

  @override
  _AddGameState createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  SearchGameGetx searchGameGetx = Get.find();
  FirebaseApi firebaseApi = Get.find();
  TextEditingController nick = TextEditingController();
  TextEditingController level = TextEditingController();
  @override
  Widget build(BuildContext context) {
    searchGameGetx.getGames();
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.grey[200],
      body: Obx(
        () => SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: Column(
                    children: searchGameGetx.games.map((game) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: context.isDarkMode
                              ? Colors.grey[900]
                              : Colors.white,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                context: context,
                                builder: (context) {
                                  searchGameGetx.pc.value = false;
                                  searchGameGetx.mobile.value = false;
                                  searchGameGetx.ps.value = false;
                                  return StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      stream: firebaseApi.firestore
                                          .collection('Users')
                                          .doc(
                                              firebaseApi.auth.currentUser!.uid)
                                          .collection('Games')
                                          .where('name',
                                              isEqualTo: game.data()['name'])
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Obx(
                                                    () =>
                                                        snapshot.data!.docs
                                                                .isEmpty
                                                            ? Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors.grey[
                                                                            300],
                                                                    backgroundImage: NetworkImage(game.data()['photo'] ==
                                                                            null
                                                                        ? ''
                                                                        : game.data()[
                                                                            'photo']),
                                                                    radius: 50,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    game.data()[
                                                                        'name'],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  // SizedBox(
                                                                  //   height: 15,
                                                                  // ),
                                                                  // Padding(
                                                                  //   padding:
                                                                  //       EdgeInsets.only(bottom: 2),
                                                                  //   // MediaQuery.of(context)
                                                                  //   //     .viewInsets
                                                                  //   //     .bottom),
                                                                  //   child: TextField(
                                                                  //     cursorColor: Colors.black,
                                                                  //     cursorRadius:
                                                                  //         Radius.circular(10),
                                                                  //     maxLines: 1,
                                                                  //     scrollPadding: EdgeInsets.zero,
                                                                  //     textAlign: TextAlign.center,
                                                                  //     controller: nick,
                                                                  //     decoration: InputDecoration(
                                                                  //         hintText: 'Oyuniçi isminiz',
                                                                  //         focusedBorder:
                                                                  //             OutlineInputBorder(
                                                                  //                 borderRadius:
                                                                  //                     BorderRadius
                                                                  //                         .circular(
                                                                  //                             20),
                                                                  //                 borderSide:
                                                                  //                     BorderSide(
                                                                  //                         color: Colors
                                                                  //                             .black,
                                                                  //                         width: 2)),
                                                                  //         border: OutlineInputBorder(
                                                                  //             borderRadius:
                                                                  //                 BorderRadius
                                                                  //                     .circular(20),
                                                                  //             borderSide: BorderSide(
                                                                  //                 color: Colors.black,
                                                                  //                 width: 2))),
                                                                  //     style: TextStyle(
                                                                  //         fontSize: 17,
                                                                  //         fontWeight:
                                                                  //             FontWeight.bold),
                                                                  //   ),
                                                                  // ),
                                                                  // SizedBox(
                                                                  //   height: 10,
                                                                  // ),
                                                                  // Padding(
                                                                  //   padding: EdgeInsets.only(
                                                                  //       bottom: 2, left: 0, right: 0),
                                                                  //   // MediaQuery.of(context)
                                                                  //   //     .viewInsets
                                                                  //   //     .bottom),
                                                                  //   child: TextField(
                                                                  //     controller: level,
                                                                  //     cursorColor: Colors.black,
                                                                  //     cursorRadius:
                                                                  //         Radius.circular(10),
                                                                  //     maxLines: 1,
                                                                  //     scrollPadding: EdgeInsets.zero,
                                                                  //     textAlign: TextAlign.center,
                                                                  //     keyboardType:
                                                                  //         TextInputType.number,
                                                                  //     decoration: InputDecoration(
                                                                  //         hintText:
                                                                  //             'Oyuniçi seviyyeniz',
                                                                  //         focusedBorder:
                                                                  //             OutlineInputBorder(
                                                                  //                 borderRadius:
                                                                  //                     BorderRadius
                                                                  //                         .circular(
                                                                  //                             20),
                                                                  //                 borderSide:
                                                                  //                     BorderSide(
                                                                  //                         color: Colors
                                                                  //                             .black,
                                                                  //                         width: 2)),
                                                                  //         border: OutlineInputBorder(
                                                                  //             borderRadius:
                                                                  //                 BorderRadius
                                                                  //                     .circular(20),
                                                                  //             borderSide: BorderSide(
                                                                  //                 color: Colors.black,
                                                                  //                 width: 2))),
                                                                  //     style: TextStyle(
                                                                  //         fontSize: 17,
                                                                  //         fontWeight:
                                                                  //             FontWeight.bold),
                                                                  //   ),
                                                                  // ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      game.data()[
                                                                              'pc']
                                                                          ? Flexible(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Material(
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                  color: searchGameGetx.pc.value
                                                                                      ? Colors.green
                                                                                      : context.isDarkMode
                                                                                          ? Colors.black
                                                                                          : Colors.grey[200],
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      searchGameGetx.pc.value = !searchGameGetx.pc.value;
                                                                                    },
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                    child: Center(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(17),
                                                                                        child: Text(
                                                                                          'PC',
                                                                                          style: searchGameGetx.pc.value ? TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold) : TextStyle(fontSize: 20),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              flex: 1,
                                                                            )
                                                                          : Container(),
                                                                      game.data()[
                                                                              'ps']
                                                                          ? Flexible(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Material(
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                  color: searchGameGetx.ps.value
                                                                                      ? Colors.green
                                                                                      : context.isDarkMode
                                                                                          ? Colors.black
                                                                                          : Colors.grey[200],
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      searchGameGetx.ps.value = !searchGameGetx.ps.value;
                                                                                    },
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                    child: Center(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(17),
                                                                                        child: Text(
                                                                                          'PS',
                                                                                          style: searchGameGetx.ps.value ? TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold) : TextStyle(fontSize: 20),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              flex: 1,
                                                                            )
                                                                          : Container(),
                                                                      game.data()[
                                                                              'mobile']
                                                                          ? Flexible(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Material(
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                  color: searchGameGetx.mobile.value
                                                                                      ? Colors.green
                                                                                      : context.isDarkMode
                                                                                          ? Colors.black
                                                                                          : Colors.grey[200],
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      searchGameGetx.mobile.value = !searchGameGetx.mobile.value;
                                                                                    },
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                    child: Center(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(17),
                                                                                        child: Text(
                                                                                          'Mobil',
                                                                                          style: searchGameGetx.mobile.value ? TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold) : TextStyle(fontSize: 20),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              flex: 1,
                                                                            )
                                                                          : Container()
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            40),
                                                                    child:
                                                                        Material(
                                                                      color: searchGameGetx.pc.value ||
                                                                              searchGameGetx.ps.value ||
                                                                              searchGameGetx.mobile.value
                                                                          ? Colors.blue
                                                                          : context.isDarkMode
                                                                              ? Colors.grey[700]
                                                                              : Colors.grey[200],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        onTap: searchGameGetx.pc.value ||
                                                                                searchGameGetx.ps.value ||
                                                                                searchGameGetx.mobile.value
                                                                            ? () async {
                                                                                bool pc = searchGameGetx.pc.value;
                                                                                bool ps = searchGameGetx.ps.value;
                                                                                bool mob = searchGameGetx.mobile.value;
                                                                                Get.back();
                                                                                await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                  'games': FieldValue.arrayUnion([
                                                                                    game.data()['name']
                                                                                  ])
                                                                                });
                                                                                await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Games').add({
                                                                                  'id': game.id,
                                                                                  'name': game.data()['name'],
                                                                                  'photo': game.data()['photo'],
                                                                                  'level': level.text,
                                                                                  'nickname': nick.text,
                                                                                  'pc': pc,
                                                                                  'ps': ps,
                                                                                  'yellow': game.data()['yellow'],
                                                                                  'red': game.data()['red'],
                                                                                  'green': game.data()['green'],
                                                                                  'purple': game.data()['purple'],
                                                                                  'orange': game.data()['orange'],
                                                                                  'blue': game.data()['blue'],
                                                                                  'hasLevels': game.data()['hasLevels'],
                                                                                  'hasStats': game.data()['hasStats'],
                                                                                  'mobile': mob,
                                                                                });
                                                                                nick.text = '';
                                                                                level.text = '';
                                                                                searchGameGetx.pc.value = false;
                                                                                searchGameGetx.ps.value = false;
                                                                                searchGameGetx.mobile.value = false;

                                                                                firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Games').get().then((value) {
                                                                                  if (value.docs.length > 9) {
                                                                                    firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.oyunekleme['name']!).get().then((value) async {
                                                                                      if (value.docs.isEmpty) {
                                                                                        Get.snackbar('Başarı kazandın', Utils.oyunekleme['name']!,
                                                                                            icon: Padding(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                              child: Icon(
                                                                                                Icons.emoji_events_outlined,
                                                                                                size: 35,
                                                                                              ),
                                                                                            ));
                                                                                        await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                          'name': Utils.oyunekleme['name']!,
                                                                                          'photo': Utils.oyunekleme['photo']!,
                                                                                        });
                                                                                        await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                                                                          int exp = value.data()!['exp'];
                                                                                          int level = value.data()!['level'];
                                                                                          int newExp = exp + 100;
                                                                                          int newLevel = Utils().getLevel(newExp);
                                                                                          await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                            'exp': newExp
                                                                                          });
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
                                                                                });
                                                                              }
                                                                            : null,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(18),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                'Ekle',
                                                                                style: TextStyle(
                                                                                    fontSize: 22,
                                                                                    color: searchGameGetx.pc.value || searchGameGetx.ps.value || searchGameGetx.mobile.value
                                                                                        ? Colors.white
                                                                                        : context.isDarkMode
                                                                                            ? Colors.white
                                                                                            : Colors.black,
                                                                                    fontWeight: searchGameGetx.pc.value || searchGameGetx.ps.value || searchGameGetx.mobile.value ? FontWeight.bold : FontWeight.normal),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom: MediaQuery.of(context)
                                                                            .viewInsets
                                                                            .bottom),
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            : Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors.grey[
                                                                            300],
                                                                    backgroundImage: NetworkImage(game.data()['photo'] ==
                                                                            null
                                                                        ? ''
                                                                        : game.data()[
                                                                            'photo']),
                                                                    radius: 50,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    game.data()[
                                                                        'name'],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines: searchGameGetx
                                                                            .mobile
                                                                            .value
                                                                        ? 2
                                                                        : 2,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 40,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            40),
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        onTap:
                                                                            () async {
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Users')
                                                                              .doc(firebaseApi.auth.currentUser!.uid)
                                                                              .collection('Games')
                                                                              .doc(snapshot.data!.docs.first.id)
                                                                              .delete();
                                                                          Get.back();
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(18),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                'Oyunu kaldır',
                                                                                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom: MediaQuery.of(context)
                                                                            .viewInsets
                                                                            .bottom),
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: context.isDarkMode
                                                        ? Colors.grey[900]
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20))),
                                              )
                                            : Container(
                                                height: 338,
                                                child: Center(
                                                  child: SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              );
                                      });
                                },
                              );
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: NetworkImage(
                                        game.data()['photo'] == null
                                            ? ''
                                            : game.data()['photo']),
                                    radius: 35,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              game.data()['name'],
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            game.data()['pc']
                                                ? Image.asset(
                                                    'assets/pc.png',
                                                    height: 30,
                                                    width: 30,
                                                  )
                                                : Opacity(
                                                    opacity: 0.3,
                                                    child: Image.asset(
                                                      'assets/pc.png',
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            game.data()['ps']
                                                ? Image.asset(
                                                    'assets/ps.png',
                                                    height: 30,
                                                    width: 30,
                                                  )
                                                : Opacity(
                                                    opacity: 0.3,
                                                    child: Image.asset(
                                                      'assets/ps.png',
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            game.data()['mobile']
                                                ? Image.asset(
                                                    'assets/mobil-icon.png',
                                                    height: 30,
                                                    width: 30,
                                                  )
                                                : Opacity(
                                                    opacity: 0.3,
                                                    child: Image.asset(
                                                      'assets/mobil-icon.png',
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              FloatingSearchBar(
                height: 56,
                scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
                transitionDuration: const Duration(milliseconds: 400),
                transitionCurve: Curves.linear,
                borderRadius: BorderRadius.circular(15),
                transition: CircularFloatingSearchBarTransition(),
                physics: const BouncingScrollPhysics(),
                axisAlignment: 0.0,
                openAxisAlignment: 0.0,
                onQueryChanged: (text) {
                  searchGameGetx.searchGame(text);
                },
                // width: 600,
                debounceDelay: const Duration(milliseconds: 400),
                hint: 'Oyun ara',
                builder: (context, transition) {
                  return Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Material(
                        color: context.isDarkMode ? Colors.black : Colors.white,
                        elevation: 4.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: searchGameGetx.search.map((game) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20),
                                color: context.isDarkMode
                                    ? Colors.grey[900]
                                    : Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20))),
                                      context: context,
                                      builder: (context) {
                                        searchGameGetx.pc.value = false;
                                        searchGameGetx.mobile.value = false;
                                        searchGameGetx.ps.value = false;
                                        return StreamBuilder<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: firebaseApi.firestore
                                                .collection('Users')
                                                .doc(firebaseApi
                                                    .auth.currentUser!.uid)
                                                .collection('Games')
                                                .where('name',
                                                    isEqualTo:
                                                        game.data()['name'])
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              return snapshot.hasData
                                                  ? Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Obx(
                                                          () =>
                                                              snapshot
                                                                      .data!
                                                                      .docs
                                                                      .isEmpty
                                                                  ? Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundColor:
                                                                              Colors.grey[300],
                                                                          backgroundImage: NetworkImage(game.data()['photo'] == null
                                                                              ? ''
                                                                              : game.data()['photo']),
                                                                          radius:
                                                                              50,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          game.data()[
                                                                              'name'],
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          maxLines:
                                                                              2,
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        // SizedBox(
                                                                        //   height: 15,
                                                                        // ),
                                                                        // Padding(
                                                                        //   padding:
                                                                        //       EdgeInsets.only(bottom: 2),
                                                                        //   // MediaQuery.of(context)
                                                                        //   //     .viewInsets
                                                                        //   //     .bottom),
                                                                        //   child: TextField(
                                                                        //     cursorColor: Colors.black,
                                                                        //     cursorRadius:
                                                                        //         Radius.circular(10),
                                                                        //     maxLines: 1,
                                                                        //     scrollPadding: EdgeInsets.zero,
                                                                        //     textAlign: TextAlign.center,
                                                                        //     controller: nick,
                                                                        //     decoration: InputDecoration(
                                                                        //         hintText: 'Oyuniçi isminiz',
                                                                        //         focusedBorder:
                                                                        //             OutlineInputBorder(
                                                                        //                 borderRadius:
                                                                        //                     BorderRadius
                                                                        //                         .circular(
                                                                        //                             20),
                                                                        //                 borderSide:
                                                                        //                     BorderSide(
                                                                        //                         color: Colors
                                                                        //                             .black,
                                                                        //                         width: 2)),
                                                                        //         border: OutlineInputBorder(
                                                                        //             borderRadius:
                                                                        //                 BorderRadius
                                                                        //                     .circular(20),
                                                                        //             borderSide: BorderSide(
                                                                        //                 color: Colors.black,
                                                                        //                 width: 2))),
                                                                        //     style: TextStyle(
                                                                        //         fontSize: 17,
                                                                        //         fontWeight:
                                                                        //             FontWeight.bold),
                                                                        //   ),
                                                                        // ),
                                                                        // SizedBox(
                                                                        //   height: 10,
                                                                        // ),
                                                                        // Padding(
                                                                        //   padding: EdgeInsets.only(
                                                                        //       bottom: 2, left: 0, right: 0),
                                                                        //   // MediaQuery.of(context)
                                                                        //   //     .viewInsets
                                                                        //   //     .bottom),
                                                                        //   child: TextField(
                                                                        //     controller: level,
                                                                        //     cursorColor: Colors.black,
                                                                        //     cursorRadius:
                                                                        //         Radius.circular(10),
                                                                        //     maxLines: 1,
                                                                        //     scrollPadding: EdgeInsets.zero,
                                                                        //     textAlign: TextAlign.center,
                                                                        //     keyboardType:
                                                                        //         TextInputType.number,
                                                                        //     decoration: InputDecoration(
                                                                        //         hintText:
                                                                        //             'Oyuniçi seviyyeniz',
                                                                        //         focusedBorder:
                                                                        //             OutlineInputBorder(
                                                                        //                 borderRadius:
                                                                        //                     BorderRadius
                                                                        //                         .circular(
                                                                        //                             20),
                                                                        //                 borderSide:
                                                                        //                     BorderSide(
                                                                        //                         color: Colors
                                                                        //                             .black,
                                                                        //                         width: 2)),
                                                                        //         border: OutlineInputBorder(
                                                                        //             borderRadius:
                                                                        //                 BorderRadius
                                                                        //                     .circular(20),
                                                                        //             borderSide: BorderSide(
                                                                        //                 color: Colors.black,
                                                                        //                 width: 2))),
                                                                        //     style: TextStyle(
                                                                        //         fontSize: 17,
                                                                        //         fontWeight:
                                                                        //             FontWeight.bold),
                                                                        //   ),
                                                                        // ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            game.data()['pc']
                                                                                ? Flexible(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Material(
                                                                                        borderRadius: BorderRadius.circular(15),
                                                                                        color: searchGameGetx.pc.value
                                                                                            ? Colors.green
                                                                                            : context.isDarkMode
                                                                                                ? Colors.black
                                                                                                : Colors.grey[200],
                                                                                        child: InkWell(
                                                                                          onTap: () {
                                                                                            searchGameGetx.pc.value = !searchGameGetx.pc.value;
                                                                                          },
                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                          child: Center(
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(17),
                                                                                              child: Text(
                                                                                                'PC',
                                                                                                style: searchGameGetx.pc.value ? TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold) : TextStyle(fontSize: 20),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    flex: 1,
                                                                                  )
                                                                                : Container(),
                                                                            game.data()['ps']
                                                                                ? Flexible(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Material(
                                                                                        borderRadius: BorderRadius.circular(15),
                                                                                        color: searchGameGetx.ps.value
                                                                                            ? Colors.green
                                                                                            : context.isDarkMode
                                                                                                ? Colors.black
                                                                                                : Colors.grey[200],
                                                                                        child: InkWell(
                                                                                          onTap: () {
                                                                                            searchGameGetx.ps.value = !searchGameGetx.ps.value;
                                                                                          },
                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                          child: Center(
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(17),
                                                                                              child: Text(
                                                                                                'PS',
                                                                                                style: searchGameGetx.ps.value ? TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold) : TextStyle(fontSize: 20),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    flex: 1,
                                                                                  )
                                                                                : Container(),
                                                                            game.data()['mobile']
                                                                                ? Flexible(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Material(
                                                                                        borderRadius: BorderRadius.circular(15),
                                                                                        color: searchGameGetx.mobile.value
                                                                                            ? Colors.green
                                                                                            : context.isDarkMode
                                                                                                ? Colors.black
                                                                                                : Colors.grey[200],
                                                                                        child: InkWell(
                                                                                          onTap: () {
                                                                                            searchGameGetx.mobile.value = !searchGameGetx.mobile.value;
                                                                                          },
                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                          child: Center(
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(17),
                                                                                              child: Text(
                                                                                                'Mobil',
                                                                                                style: searchGameGetx.mobile.value ? TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold) : TextStyle(fontSize: 20),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    flex: 1,
                                                                                  )
                                                                                : Container()
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 40),
                                                                          child:
                                                                              Material(
                                                                            color: searchGameGetx.pc.value || searchGameGetx.ps.value || searchGameGetx.mobile.value
                                                                                ? Colors.blue
                                                                                : context.isDarkMode
                                                                                    ? Colors.grey[700]
                                                                                    : Colors.grey[200],
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            child:
                                                                                InkWell(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              onTap: searchGameGetx.pc.value || searchGameGetx.ps.value || searchGameGetx.mobile.value
                                                                                  ? () async {
                                                                                      Get.back();
                                                                                      await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                        'games': FieldValue.arrayUnion([
                                                                                          game.data()['name']
                                                                                        ])
                                                                                      });
                                                                                      await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Games').add({
                                                                                        'id': game.id,
                                                                                        'name': game.data()['name'],
                                                                                        'photo': game.data()['photo'],
                                                                                        'level': level.text,
                                                                                        'nickname': nick.text,
                                                                                        'yellow': game.data()['yellow'],
                                                                                        'red': game.data()['red'],
                                                                                        'green': game.data()['green'],
                                                                                        'blue': game.data()['blue'],
                                                                                        'purple': game.data()['purple'],
                                                                                        'orange': game.data()['orange'],
                                                                                        'hasLevels': game.data()['hasLevels'],
                                                                                        'hasStats': game.data()['hasStats'],
                                                                                        'pc': searchGameGetx.pc.value,
                                                                                        'ps': searchGameGetx.ps.value,
                                                                                        'mobile': searchGameGetx.mobile.value,
                                                                                      });
                                                                                      nick.text = '';
                                                                                      level.text = '';
                                                                                      searchGameGetx.pc.value = false;
                                                                                      searchGameGetx.ps.value = false;
                                                                                      searchGameGetx.mobile.value = false;

                                                                                      firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Games').get().then((value) {
                                                                                        if (value.docs.length > 9) {
                                                                                          firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.oyunekleme['name']!).get().then((value) async {
                                                                                            if (value.docs.isEmpty) {
                                                                                              Get.snackbar('Başarı kazandın', Utils.oyunekleme['name']!,
                                                                                                  icon: Padding(
                                                                                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                    child: Icon(
                                                                                                      Icons.emoji_events_outlined,
                                                                                                      size: 35,
                                                                                                    ),
                                                                                                  ));
                                                                                              await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                                'name': Utils.oyunekleme['name']!,
                                                                                                'photo': Utils.oyunekleme['photo']!,
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
                                                                                  : null,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(18),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      'Ekle',
                                                                                      style: TextStyle(
                                                                                          fontSize: 22,
                                                                                          color: searchGameGetx.pc.value || searchGameGetx.ps.value || searchGameGetx.mobile.value
                                                                                              ? Colors.white
                                                                                              : context.isDarkMode
                                                                                                  ? Colors.white
                                                                                                  : Colors.black,
                                                                                          fontWeight: searchGameGetx.pc.value || searchGameGetx.ps.value || searchGameGetx.mobile.value ? FontWeight.bold : FontWeight.normal),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundColor:
                                                                              Colors.grey[300],
                                                                          backgroundImage: NetworkImage(game.data()['photo'] == null
                                                                              ? ''
                                                                              : game.data()['photo']),
                                                                          radius:
                                                                              50,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          game.data()[
                                                                              'name'],
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          maxLines: searchGameGetx.mobile.value
                                                                              ? 2
                                                                              : 2,
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 40),
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                                Colors.red,
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            child:
                                                                                InkWell(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              onTap: () async {
                                                                                await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Games').doc(snapshot.data!.docs.first.id).delete();
                                                                                Get.back();
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(18),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      'Oyunu kaldır',
                                                                                      style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.grey[900]
                                                              : Colors.white,
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          20))),
                                                    )
                                                  : Container(
                                                      height: 338,
                                                      child: Center(
                                                        child: SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                            });
                                      },
                                    );
                                    // showModalBottomSheet(
                                    //   isScrollControlled: true,
                                    //   shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.vertical(
                                    //           top: Radius.circular(20))),
                                    //   context: context,
                                    //   builder: (context) {
                                    //     searchGameGetx.pc.value = false;
                                    //     searchGameGetx.mobile.value = false;
                                    //     searchGameGetx.ps.value = false;
                                    //     return Container(
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.all(15),
                                    //         child: Obx(
                                    //           () => Column(
                                    //             mainAxisSize: MainAxisSize.min,
                                    //             children: [
                                    //               CircleAvatar(
                                    //                 backgroundColor:
                                    //                     Colors.grey[300],
                                    //                 backgroundImage:
                                    //                     NetworkImage(game
                                    //                                     .data()[
                                    //                                 'photo'] ==
                                    //                             null
                                    //                         ? ''
                                    //                         : game.data()[
                                    //                             'photo']),
                                    //                 radius: 50,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Text(
                                    //                 game.data()['name'],
                                    //                 textAlign: TextAlign.center,
                                    //                 maxLines: 2,
                                    //                 style: TextStyle(
                                    //                     fontSize: 20,
                                    //                     fontWeight:
                                    //                         FontWeight.bold),
                                    //               ),
                                    //               // SizedBox(
                                    //               //   height: 15,
                                    //               // ),
                                    //               // Padding(
                                    //               //   padding: EdgeInsets.only(
                                    //               //       bottom: 2),
                                    //               //   // MediaQuery.of(context)
                                    //               //   //     .viewInsets
                                    //               //   //     .bottom),
                                    //               //   child: TextField(
                                    //               //     cursorColor: Colors.black,
                                    //               //     cursorRadius:
                                    //               //         Radius.circular(10),
                                    //               //     maxLines: 1,
                                    //               //     scrollPadding:
                                    //               //         EdgeInsets.zero,
                                    //               //     textAlign:
                                    //               //         TextAlign.center,
                                    //               //     controller: nick,
                                    //               //     decoration: InputDecoration(
                                    //               //         hintText:
                                    //               //             'Oyuniçi isminiz',
                                    //               //         focusedBorder: OutlineInputBorder(
                                    //               //             borderRadius:
                                    //               //                 BorderRadius
                                    //               //                     .circular(
                                    //               //                         20),
                                    //               //             borderSide: BorderSide(
                                    //               //                 color: Colors
                                    //               //                     .black,
                                    //               //                 width: 2)),
                                    //               //         border: OutlineInputBorder(
                                    //               //             borderRadius:
                                    //               //                 BorderRadius
                                    //               //                     .circular(
                                    //               //                         20),
                                    //               //             borderSide: BorderSide(
                                    //               //                 color: Colors
                                    //               //                     .black,
                                    //               //                 width: 2))),
                                    //               //     style: TextStyle(
                                    //               //         fontSize: 17,
                                    //               //         fontWeight:
                                    //               //             FontWeight.bold),
                                    //               //   ),
                                    //               // ),
                                    //               // SizedBox(
                                    //               //   height: 10,
                                    //               // ),
                                    //               // Padding(
                                    //               //   padding: EdgeInsets.only(
                                    //               //       bottom: 2,
                                    //               //       left: 0,
                                    //               //       right: 0),
                                    //               //   // MediaQuery.of(context)
                                    //               //   //     .viewInsets
                                    //               //   //     .bottom),
                                    //               //   child: TextField(
                                    //               //     controller: level,
                                    //               //     cursorColor: Colors.black,
                                    //               //     cursorRadius:
                                    //               //         Radius.circular(10),
                                    //               //     maxLines: 1,
                                    //               //     scrollPadding:
                                    //               //         EdgeInsets.zero,
                                    //               //     textAlign:
                                    //               //         TextAlign.center,
                                    //               //     keyboardType:
                                    //               //         TextInputType.number,
                                    //               //     decoration: InputDecoration(
                                    //               //         hintText:
                                    //               //             'Oyuniçi seviyyeniz',
                                    //               //         focusedBorder: OutlineInputBorder(
                                    //               //             borderRadius:
                                    //               //                 BorderRadius
                                    //               //                     .circular(
                                    //               //                         20),
                                    //               //             borderSide: BorderSide(
                                    //               //                 color: Colors
                                    //               //                     .black,
                                    //               //                 width: 2)),
                                    //               //         border: OutlineInputBorder(
                                    //               //             borderRadius:
                                    //               //                 BorderRadius
                                    //               //                     .circular(
                                    //               //                         20),
                                    //               //             borderSide: BorderSide(
                                    //               //                 color: Colors
                                    //               //                     .black,
                                    //               //                 width: 2))),
                                    //               //     style: TextStyle(
                                    //               //         fontSize: 17,
                                    //               //         fontWeight:
                                    //               //             FontWeight.bold),
                                    //               //   ),
                                    //               // ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Row(
                                    //                 children: [
                                    //                   game.data()['pc']
                                    //                       ? Flexible(
                                    //                           child: Padding(
                                    //                             padding:
                                    //                                 const EdgeInsets
                                    //                                         .all(
                                    //                                     8.0),
                                    //                             child: Material(
                                    //                               borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                           15),
                                    //                               color: searchGameGetx
                                    //                                       .pc
                                    //                                       .value
                                    //                                   ? Colors
                                    //                                       .green
                                    //                                   : Colors.grey[
                                    //                                       200],
                                    //                               child:
                                    //                                   InkWell(
                                    //                                 onTap: () {
                                    //                                   searchGameGetx
                                    //                                           .pc
                                    //                                           .value =
                                    //                                       !searchGameGetx
                                    //                                           .pc
                                    //                                           .value;
                                    //                                 },
                                    //                                 borderRadius:
                                    //                                     BorderRadius.circular(
                                    //                                         15),
                                    //                                 child:
                                    //                                     Center(
                                    //                                   child:
                                    //                                       Padding(
                                    //                                     padding:
                                    //                                         const EdgeInsets.all(17),
                                    //                                     child:
                                    //                                         Text(
                                    //                                       'PC',
                                    //                                       style: searchGameGetx.pc.value
                                    //                                           ? TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold)
                                    //                                           : TextStyle(fontSize: 20),
                                    //                                     ),
                                    //                                   ),
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                           flex: 1,
                                    //                         )
                                    //                       : Container(),
                                    //                   game.data()['ps']
                                    //                       ? Flexible(
                                    //                           child: Padding(
                                    //                             padding:
                                    //                                 const EdgeInsets
                                    //                                         .all(
                                    //                                     8.0),
                                    //                             child: Material(
                                    //                               borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                           15),
                                    //                               color: searchGameGetx
                                    //                                       .ps
                                    //                                       .value
                                    //                                   ? Colors
                                    //                                       .green
                                    //                                   : Colors.grey[
                                    //                                       200],
                                    //                               child:
                                    //                                   InkWell(
                                    //                                 onTap: () {
                                    //                                   searchGameGetx
                                    //                                           .ps
                                    //                                           .value =
                                    //                                       !searchGameGetx
                                    //                                           .ps
                                    //                                           .value;
                                    //                                 },
                                    //                                 borderRadius:
                                    //                                     BorderRadius.circular(
                                    //                                         15),
                                    //                                 child:
                                    //                                     Center(
                                    //                                   child:
                                    //                                       Padding(
                                    //                                     padding:
                                    //                                         const EdgeInsets.all(17),
                                    //                                     child:
                                    //                                         Text(
                                    //                                       'PS',
                                    //                                       style: searchGameGetx.ps.value
                                    //                                           ? TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold)
                                    //                                           : TextStyle(fontSize: 20),
                                    //                                     ),
                                    //                                   ),
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                           flex: 1,
                                    //                         )
                                    //                       : Container(),
                                    //                   game.data()['mobile']
                                    //                       ? Flexible(
                                    //                           child: Padding(
                                    //                             padding:
                                    //                                 const EdgeInsets
                                    //                                         .all(
                                    //                                     8.0),
                                    //                             child: Material(
                                    //                               borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                           15),
                                    //                               color: searchGameGetx
                                    //                                       .mobile
                                    //                                       .value
                                    //                                   ? Colors
                                    //                                       .green
                                    //                                   : Colors.grey[
                                    //                                       200],
                                    //                               child:
                                    //                                   InkWell(
                                    //                                 onTap: () {
                                    //                                   searchGameGetx
                                    //                                           .mobile
                                    //                                           .value =
                                    //                                       !searchGameGetx
                                    //                                           .mobile
                                    //                                           .value;
                                    //                                 },
                                    //                                 borderRadius:
                                    //                                     BorderRadius.circular(
                                    //                                         15),
                                    //                                 child:
                                    //                                     Center(
                                    //                                   child:
                                    //                                       Padding(
                                    //                                     padding:
                                    //                                         const EdgeInsets.all(17),
                                    //                                     child:
                                    //                                         Text(
                                    //                                       'Mobil',
                                    //                                       style: searchGameGetx.mobile.value
                                    //                                           ? TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold)
                                    //                                           : TextStyle(fontSize: 20),
                                    //                                     ),
                                    //                                   ),
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                           flex: 1,
                                    //                         )
                                    //                       : Container()
                                    //                 ],
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Padding(
                                    //                 padding: const EdgeInsets
                                    //                         .symmetric(
                                    //                     horizontal: 40),
                                    //                 child: Material(
                                    //                   color: searchGameGetx
                                    //                               .pc.value ||
                                    //                           searchGameGetx
                                    //                               .ps.value ||
                                    //                           searchGameGetx
                                    //                               .mobile.value
                                    //                       ? Colors.blue
                                    //                       : Colors.grey[200],
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           15),
                                    //                   child: InkWell(
                                    //                     borderRadius:
                                    //                         BorderRadius
                                    //                             .circular(15),
                                    //                     onTap:
                                    //                         searchGameGetx.pc
                                    //                                     .value ||
                                    //                                 searchGameGetx
                                    //                                     .ps
                                    //                                     .value ||
                                    //                                 searchGameGetx
                                    //                                     .mobile
                                    //                                     .value
                                    //                             ? () async {
                                    //                                 Get.back();
                                    //                                 await firebaseApi
                                    //                                     .firestore
                                    //                                     .collection(
                                    //                                         'Users')
                                    //                                     .doc(firebaseApi
                                    //                                         .auth
                                    //                                         .currentUser!
                                    //                                         .uid)
                                    //                                     .update({
                                    //                                   'games':
                                    //                                       FieldValue
                                    //                                           .arrayUnion([
                                    //                                     game.data()[
                                    //                                         'name']
                                    //                                   ])
                                    //                                 });
                                    //                                 await firebaseApi
                                    //                                     .firestore
                                    //                                     .collection(
                                    //                                         'Users')
                                    //                                     .doc(firebaseApi
                                    //                                         .auth
                                    //                                         .currentUser!
                                    //                                         .uid)
                                    //                                     .collection(
                                    //                                         'Games')
                                    //                                     .add({
                                    //                                   'id': game
                                    //                                       .id,
                                    //                                   'name': game
                                    //                                           .data()[
                                    //                                       'name'],
                                    //                                   'photo': game
                                    //                                           .data()[
                                    //                                       'photo'],
                                    //                                   'level': level
                                    //                                       .text,
                                    //                                   'nickname':
                                    //                                       nick.text,
                                    //                                   'pc': searchGameGetx
                                    //                                       .pc
                                    //                                       .value,
                                    //                                   'ps': searchGameGetx
                                    //                                       .ps
                                    //                                       .value,
                                    //                                   'mobile': searchGameGetx
                                    //                                       .mobile
                                    //                                       .value,
                                    //                                 });
                                    //                                 nick.text =
                                    //                                     '';
                                    //                                 level.text =
                                    //                                     '';
                                    //                                 searchGameGetx
                                    //                                         .pc
                                    //                                         .value =
                                    //                                     false;
                                    //                                 searchGameGetx
                                    //                                         .ps
                                    //                                         .value =
                                    //                                     false;
                                    //                                 searchGameGetx
                                    //                                     .mobile
                                    //                                     .value = false;

                                    //                                 firebaseApi
                                    //                                     .firestore
                                    //                                     .collection(
                                    //                                         'Users')
                                    //                                     .doc(firebaseApi
                                    //                                         .auth
                                    //                                         .currentUser!
                                    //                                         .uid)
                                    //                                     .collection(
                                    //                                         'Games')
                                    //                                     .get()
                                    //                                     .then(
                                    //                                         (value) {
                                    //                                   if (value
                                    //                                           .docs
                                    //                                           .length >
                                    //                                       9) {
                                    //                                     firebaseApi
                                    //                                         .firestore
                                    //                                         .collection(
                                    //                                             'Users')
                                    //                                         .doc(firebaseApi
                                    //                                             .auth.currentUser!.uid)
                                    //                                         .collection(
                                    //                                             'Rosettes')
                                    //                                         .where('name',
                                    //                                             isEqualTo: Utils.oyunekleme['name']!)
                                    //                                         .get()
                                    //                                         .then((value) async {
                                    //                                       if (value
                                    //                                           .docs
                                    //                                           .isEmpty) {
                                    //                                         Get.snackbar('Başarı kazandın',
                                    //                                             Utils.oyunekleme['name']!,
                                    //                                             icon: Padding(
                                    //                                               padding: const EdgeInsets.symmetric(horizontal: 5),
                                    //                                               child: Icon(
                                    //                                                 Icons.emoji_events_outlined,
                                    //                                                 size: 35,
                                    //                                               ),
                                    //                                             ));
                                    //                                         await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                    //                                           'name': Utils.oyunekleme['name']!,
                                    //                                           'photo': Utils.oyunekleme['photo']!,
                                    //                                         });
                                    //                                         await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                    //                                           int exp = value.data()!['exp'];
                                    //                                           int level = value.data()!['level'];
                                    //                                           int newExp = exp + 250;
                                    //                                           int newLevel = Utils().getLevel(newExp);
                                    //                                           await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                    //                                             'exp': newExp
                                    //                                           });
                                    //                                           if (level != newLevel) {
                                    //                                             //yeni seviyye
                                    //                                             await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                    //                                               'level': newLevel
                                    //                                             });
                                    //                                             Get.to(() => NewLevel(level: newLevel));
                                    //                                           }
                                    //                                         });
                                    //                                       }
                                    //                                     });
                                    //                                   }
                                    //                                 });
                                    //                               }
                                    //                             : null,
                                    //                     child: Padding(
                                    //                       padding:
                                    //                           const EdgeInsets
                                    //                               .all(18),
                                    //                       child: Row(
                                    //                         mainAxisAlignment:
                                    //                             MainAxisAlignment
                                    //                                 .center,
                                    //                         children: [
                                    //                           Text(
                                    //                             'Ekle',
                                    //                             style: TextStyle(
                                    //                                 fontSize:
                                    //                                     22,
                                    //                                 color: searchGameGetx.pc.value ||
                                    //                                         searchGameGetx
                                    //                                             .ps.value ||
                                    //                                         searchGameGetx
                                    //                                             .mobile.value
                                    //                                     ? Colors
                                    //                                         .white
                                    //                                     : Colors
                                    //                                         .black,
                                    //                                 fontWeight: searchGameGetx.pc.value ||
                                    //                                         searchGameGetx
                                    //                                             .ps.value ||
                                    //                                         searchGameGetx
                                    //                                             .mobile.value
                                    //                                     ? FontWeight
                                    //                                         .bold
                                    //                                     : FontWeight
                                    //                                         .normal),
                                    //                           )
                                    //                         ],
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               Padding(
                                    //                 padding: EdgeInsets.only(
                                    //                     bottom: MediaQuery.of(
                                    //                             context)
                                    //                         .viewInsets
                                    //                         .bottom),
                                    //                 child: SizedBox(
                                    //                   height: 20,
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       decoration: BoxDecoration(
                                    //           color: context.isDarkMode
                                    //               ? Colors.grey[900]
                                    //               : Colors.white,
                                    //           borderRadius:
                                    //               BorderRadius.vertical(
                                    //                   top:
                                    //                       Radius.circular(20))),
                                    //     );
                                    //   },
                                    // );
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.grey[300],
                                          backgroundImage: NetworkImage(
                                              game.data()['photo'] == null
                                                  ? ''
                                                  : game.data()['photo']),
                                          radius: 35,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    game.data()['name'],
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  game.data()['pc']
                                                      ? Image.asset(
                                                          'assets/pc.png',
                                                          height: 30,
                                                          width: 30,
                                                        )
                                                      : Opacity(
                                                          opacity: 0.3,
                                                          child: Image.asset(
                                                            'assets/pc.png',
                                                            height: 30,
                                                            width: 30,
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  game.data()['ps']
                                                      ? Image.asset(
                                                          'assets/ps.png',
                                                          height: 30,
                                                          width: 30,
                                                        )
                                                      : Opacity(
                                                          opacity: 0.3,
                                                          child: Image.asset(
                                                            'assets/ps.png',
                                                            height: 30,
                                                            width: 30,
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  game.data()['mobile']
                                                      ? Image.asset(
                                                          'assets/mobil-icon.png',
                                                          height: 30,
                                                          width: 30,
                                                        )
                                                      : Opacity(
                                                          opacity: 0.3,
                                                          child: Image.asset(
                                                            'assets/mobil-icon.png',
                                                            height: 30,
                                                            width: 30,
                                                          ),
                                                        ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
