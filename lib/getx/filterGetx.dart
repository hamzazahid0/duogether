import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/api.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/cardsGetx.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:radar_chart/radar_chart.dart' as radar;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:gamehub/model/brawlBattle.dart' as brawlBattle;
import 'package:gamehub/model/brawlPlayer.dart' as brawlPlayer;
import 'package:tcard/tcard.dart';

import 'infosGetx.dart';

class FilterGetx extends GetxController {
  var filtered = false.obs;

  var age = SfRangeValues(16.0, 51.0).obs;
  var sex = 'n'.obs;
  var game = 'Oyun seçin'.obs;
  var headpressed = false.obs;
  var headphone = false.obs;
  TCardController controller = TCardController();

  @override
  void onInit() {
    // generateCard();
    super.onInit();
  }

  resetFilter() {
    age.value = SfRangeValues(16.0, 51.0);
    sex.value = 'n';
    game.value = 'Oyun seçin';
    headpressed.value = false;
  }

  RxList<Widget> cards = <Widget>[].obs;
  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> list =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  Future<void> generateCard() async {
    CardsGetx cardsGetx = Get.find();
    if (game.value == 'Oyun seçin') {
      await FirebaseFirestore.instance
          .collection('Users')
          .where('finished', isEqualTo: true)
          // .where('ids', arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          // .limit(cardsGetx.limit.value)
          .get()
          .then((value) {
        list.value = value.docs;
        list.removeWhere((element) {
          List<dynamic> map = element.data()['ids'];
          if (map.contains(FirebaseAuth.instance.currentUser!.uid)) {
            return true;
          } else {
            return false;
          }
        });
        // ? önceki görünen idler bidaha gösterilmemesi için
        List beforeSeenId = GetStorage().read("seenIds") ?? [];
        list.removeWhere((element) {
          List<dynamic> map = element.data()['ids'];
          for (int i = 0; i < beforeSeenId.length; i++) {
            if (map.contains(beforeSeenId[i])) {
              print("silindi");
              return true;
            } else {
              return false;
            }
          }
          return false;
        });
        //?
        if (filtered.value) {
          list.removeWhere((element) {
            if (element.data()['age'] >=
                    double.parse(age.value.start.toString()).round() &&
                element.data()['age'] <=
                    double.parse(age.value.end.toString()).round()) {
              return false;
            } else {
              return true;
            }
          });
          if (sex.value != 'n') {
            list.removeWhere((element) {
              if (element.data()['sex'] == sex.value) {
                return false;
              } else {
                return true;
              }
            });
          }
          if (headpressed.value) {
            list.removeWhere((element) {
              if (element.data()['headphone'] == headphone.value) {
                return false;
              } else {
                return true;
              }
            });
          }
        }
        list.shuffle();
        print('list uzunlugu ${list.length}');
        if (list.length > cardsGetx.limit.value) {
          list = list.getRange(0, cardsGetx.limit.value).toList().obs;
        }

        int added = 0;
        try {
          list.insert(6, list[5]);
          added++;
        } catch (e) {}
        try {
          list.insert(11, list[10]);
          added++;
        } catch (e) {}
        try {
          list.insert(17, list[16]);
          added++;
        } catch (e) {}
        cards.value = List.generate(
            list.length, (index) => card(list[index].id),
            growable: true);
        if (added == 3) {
          cards.value.insert(6, adCard());
          cards.value.insert(11, adCard());
          cards.value.insert(17, adCard());
        } else if (added == 2) {
          cards.value.insert(6, adCard());
          cards.value.insert(11, adCard());
        } else if (added == 1) {
          cards.value.insert(6, adCard());
        }
        print('sdfghj');
        print(cards.length);
      });
    } else {
      print(game.value);
      await FirebaseFirestore.instance
          .collection('Users')
          .where('finished', isEqualTo: true)
          .where('games', arrayContainsAny: [game.value])
          .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
            print("value docs : " + value.docs.length.toString());
            list.value = value.docs;
            list.value.removeWhere((element) {
              List<dynamic> map = element.data()['ids'];
              if (map.contains(FirebaseAuth.instance.currentUser!.uid)) {
                print("current user silindi");
                return true;
              } else {
                return false;
              }
            });
            // ? önceki görünen idler bidaha gösterilmemesi için
            List beforeSeenId = GetStorage().read("seenIds") ?? [];
            list.value.removeWhere((element) {
              List<dynamic> map = element.data()['ids'];
              for (int i = 0; i < beforeSeenId.length; i++) {
                if (map.contains(beforeSeenId[i])) {
                  print("önceki idler silindi");
                  return true;
                } else {
                  return false;
                }
              }
              return false;
            });
            if (filtered.value) {
              list.value.removeWhere((element) {
                if (element.data()['age'] >=
                        double.parse(age.value.start.toString()).round() &&
                    element.data()['age'] <=
                        double.parse(age.value.end.toString()).round()) {
                  return false;
                } else {
                  print("age sildi");
                  return true;
                }

                // if (element.data()['age'] >=
                //     double.parse(age.value.start.toString()).round()) return false;
                // if (element.data()['age'] <=
                //     double.parse(age.value.end.toString()).round()) return false;
                // if (element.data()['sex'] == sex.value)
                //   return false;
                // else {
                //   return true;
                // }
              });
              if (sex.value != 'n') {
                list.value.removeWhere((element) {
                  if (element.data()['sex'] == sex.value) {
                    return false;
                  } else {
                    print("sex sildi");
                    return true;
                  }
                });
              }
              if (headpressed.value) {
                list.value.removeWhere((element) {
                  if (element.data()['headphone'] == headphone.value) {
                    return false;
                  } else {
                    print("headphone sildi");
                    return true;
                  }
                });
              }
            }
            // if (filtered.value) {
            //   list.removeWhere((element) {
            //     if (element.data()['age'] >=
            //             double.parse(age.value.start.toString()).round() &&
            //         element.data()['age'] <=
            //             double.parse(age.value.end.toString()).round() &&
            //         element.data()['sex'] == sex.value) {
            //       return false;
            //     } else {
            //       return true;
            //     }

            //     // if (element.data()['age'] >=
            //     //     double.parse(age.value.start.toString()).round()) return false;
            //     // if (element.data()['age'] <=
            //     //     double.parse(age.value.end.toString()).round()) return false;
            //     // if (element.data()['sex'] == sex.value)
            //     //   return false;
            //     // else {
            //     //   return true;
            //     // }
            //   });
            // }
            list.value.shuffle();
            print('list uzunlugu ${list.length}');
            if (list.value.length > cardsGetx.limit.value) {
              list.value =
                  list.value.getRange(0, cardsGetx.limit.value).toList().obs;
            }
            int added = 0;
            try {
              list.insert(6, list[5]);
              added++;
            } catch (e) {}
            try {
              list.insert(11, list[10]);
              added++;
            } catch (e) {}
            try {
              list.insert(17, list[16]);
              added++;
            } catch (e) {}

            cards.value = List.generate(
                list.length, (index) => card(list[index].id),
                growable: true);

            if (added == 3) {
              cards.value.insert(6, adCard());
              cards.value.insert(11, adCard());
              cards.value.insert(17, adCard());
            } else if (added == 2) {
              cards.value.insert(6, adCard());
              cards.value.insert(11, adCard());
            } else if (added == 1) {
              cards.value.insert(6, adCard());
            }
          });
    }
    if (controller.state != null) {
      controller.state!.reset(cards: cards.value);
    }
  }

  Widget adCard() {
    CardsGetx cardsGetx = Get.find();
    cardsGetx.loadAd();

    return Card(
      color: Get.isDarkMode ? Colors.grey[900] : Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: Get.isDarkMode ? 0 : 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.grey[200],
          child: Center(
            child: Obx(() => cardsGetx.adLoaded.value
                ? AdWidget(
                    ad: cardsGetx.ad,
                  )
                : Container()),
          ),
        ),
      ),
    );
  }

  Widget card(String id) {
    FirebaseApi firebaseApi = Get.find();
    InfosGetx infosGetx = Get.find();
    return Card(
      color: GetStorage().read("isDark") ?? false
          ? Colors.grey[900]
          : Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: GetStorage().read("isDark") ?? false ? 0 : 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.grey[200],
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: firebaseApi.firestore.collection('Users').doc(id).get(),
              builder: (context, user) {
                return user.hasData
                    ? SingleChildScrollView(
                        controller: ScrollController(),
                        physics: BouncingScrollPhysics(),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 180,
                                  child: Stack(
                                    children: [
                                      !user.data!.data()!['showLocation']
                                          ? Container()
                                          : Positioned(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: BackdropFilter(
                                                  child: Container(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    child: Text(
                                                      '${user.data!.data()!['country']}, ${user.data!.data()!['city']}',
                                                      maxLines: 4,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.roboto(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 7, sigmaY: 7),
                                                ),
                                              ),
                                              bottom: 5,
                                              right: 5,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.63,
                                            ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      image: user.data!.data()!['hasBack']
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  user.data!.data()!['back']),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: AssetImage(
                                                  user.data!.data()!['back']),
                                              fit: BoxFit.cover)),
                                ),
                                Container(
                                  width: (Get.size.width - 40),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${user.data!.data()!['name']}, ${user.data!.data()!['age']}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                                fontSize: 25),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                              child: Text(
                                                'Lvl ${user.data!.data()!['level']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Utils().getLevelColor(
                                                    user.data!
                                                        .data()!['level']),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 2,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [
                                      //     Container(
                                      //       child: Padding(
                                      //         padding: const EdgeInsets
                                      //                 .symmetric(
                                      //             horizontal: 8,
                                      //             vertical: 3),
                                      //         child: Text(
                                      //           'Lvl ${user.data!.data()!['level']}',
                                      //           style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontWeight:
                                      //                   FontWeight.bold),
                                      //         ),
                                      //       ),
                                      //       decoration: BoxDecoration(
                                      //           color: Colors.red,
                                      //           borderRadius:
                                      //               BorderRadius.circular(
                                      //                   10)),
                                      //     ),
                                      //     // SizedBox(
                                      //     //   width: 5,
                                      //     // ),
                                      //     // Text(
                                      //     //   '${user.data!.data()!['country']}, ${user.data!.data()!['city']}',
                                      //     //   textAlign: TextAlign.center,
                                      //     //   style: GoogleFonts.acme(
                                      //     //       fontSize: 15),
                                      //     // ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListView.builder(
                                      itemCount: Utils.rosettes.length,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return StreamBuilder<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: firebaseApi.firestore
                                                .collection('Users')
                                                .doc(id)
                                                .collection('Rosettes')
                                                .where('photo',
                                                    isEqualTo:
                                                        Utils.rosettes[index]
                                                            ['photo']!)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              return snapshot.hasData
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 7,
                                                          vertical: 5),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            context: context,
                                                            builder: (context) {
                                                              return Container(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          5,
                                                                      vertical:
                                                                          30),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundImage:
                                                                            AssetImage(
                                                                          'assets/rosettes/${Utils.rosettes[index]['photo']!}',
                                                                        ),
                                                                        radius:
                                                                            40,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        Utils.rosettes[index]
                                                                            [
                                                                            'name']!,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        Utils.rosettes[index]
                                                                            [
                                                                            'detail']!,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 20),
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.green,
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          child:
                                                                              InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(14),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    'Tamam',
                                                                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                width: double
                                                                    .infinity,
                                                                color: Get
                                                                        .isDarkMode
                                                                    ? Colors.grey[
                                                                        900]
                                                                    : Colors
                                                                        .white,
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Opacity(
                                                          opacity: snapshot
                                                                  .data!
                                                                  .docs
                                                                  .isEmpty
                                                              ? 0.4
                                                              : 1,
                                                          child: Image.asset(
                                                            'assets/rosettes/${Utils.rosettes[index]['photo']!}',
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            });
                                      },
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 10),
                                //   child: FutureBuilder<
                                //           QuerySnapshot<
                                //               Map<String, dynamic>>>(
                                //       future: firebaseApi.firestore
                                //           .collection('Users')
                                //           .doc(user.data!.id)
                                //           .collection('Rosettes')
                                //           .get(),
                                //       builder: (context, rosettes) {
                                //         return rosettes.hasData
                                //             ? rosettes.data!.docs.isNotEmpty
                                //                 ? Container(
                                //                     width: double.maxFinite,
                                //                     height: 50,
                                //                     decoration: BoxDecoration(
                                //                         color: Colors.white
                                //                             .withOpacity(
                                //                                 0.2),
                                //                         borderRadius:
                                //                             BorderRadius
                                //                                 .circular(
                                //                                     10)),
                                //                     child: ListView.builder(
                                //                       itemCount: rosettes
                                //                           .data!
                                //                           .docs
                                //                           .length,
                                //                       scrollDirection:
                                //                           Axis.horizontal,
                                //                       physics:
                                //                           BouncingScrollPhysics(),
                                //                       shrinkWrap: true,
                                //                       itemBuilder:
                                //                           (context, index) {
                                //                         return Padding(
                                //                           padding: const EdgeInsets
                                //                                   .symmetric(
                                //                               horizontal: 5,
                                //                               vertical: 5),
                                //                           child: Image.asset(
                                //                               'assets/rosettes/${rosettes.data!.docs[index].data()['photo']}'),
                                //                         );
                                //                       },
                                //                     ),
                                //                   )
                                //                 : Container(
                                //                     width: double.maxFinite,
                                //                     decoration: BoxDecoration(
                                //                         color: Colors.white
                                //                             .withOpacity(
                                //                                 0.2),
                                //                         borderRadius:
                                //                             BorderRadius
                                //                                 .circular(
                                //                                     10)),
                                //                     height: 40,
                                //                     child: Center(
                                //                       child: Text(
                                //                           'Hiçbir rozeti yok',
                                //                           style: GoogleFonts.acme(
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w100,
                                //                               fontSize: 20,
                                //                               color: Colors
                                //                                   .black)),
                                //                     ),
                                //                   )
                                //             : CircularPercentIndicator(
                                //                 radius: 20);
                                //       }),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        // Text(
                                        //   'Hakkımda',
                                        //   style: GoogleFonts.acme(
                                        //       fontSize: 25),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${user.data!.data()!['bio']}',
                                            textAlign: TextAlign.start,
                                            maxLines: 4,
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.2)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Oyunlar',
                                        style: GoogleFonts.roboto(fontSize: 25),
                                      )),
                                ),

                                FutureBuilder<
                                        QuerySnapshot<Map<String, dynamic>>>(
                                    future: firebaseApi.firestore
                                        .collection('Users')
                                        .doc(user.data!.id)
                                        .collection('Games')
                                        .get(),
                                    builder: (context, snapshot) {
                                      return snapshot.hasData
                                          ? snapshot.data!.docs.length != 0
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Container(
                                                      width: double.maxFinite,
                                                      height: 160,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.2)),
                                                      child: ListView.builder(
                                                        itemCount: snapshot
                                                            .data!.docs.length,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            child: AspectRatio(
                                                              aspectRatio:
                                                                  4 / 5,
                                                              child: Card(
                                                                color: Colors
                                                                    .transparent,
                                                                child: Stack(
                                                                  fit: StackFit
                                                                      .expand,
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      child: Image
                                                                          .network(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]['photo'],
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                        bottom:
                                                                            2,
                                                                        left: 2,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            snapshot.data!.docs[index]['pc']
                                                                                ? ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    child: BackdropFilter(
                                                                                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                                                      child: Container(
                                                                                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(3),
                                                                                            child: Image.asset(
                                                                                              'assets/pc.png',
                                                                                              height: 20,
                                                                                              width: 20,
                                                                                            ),
                                                                                          )),
                                                                                    ),
                                                                                  )
                                                                                : Container(),
                                                                            snapshot.data!.docs[index]['ps']
                                                                                ? SizedBox(
                                                                                    width: 2,
                                                                                  )
                                                                                : Container(),
                                                                            snapshot.data!.docs[index]['ps']
                                                                                ? ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    child: BackdropFilter(
                                                                                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                                                      child: Container(
                                                                                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(3),
                                                                                            child: Image.asset(
                                                                                              'assets/ps.png',
                                                                                              height: 20,
                                                                                              width: 20,
                                                                                            ),
                                                                                          )),
                                                                                    ),
                                                                                  )
                                                                                : Container(),
                                                                            snapshot.data!.docs[index]['mobile']
                                                                                ? SizedBox(
                                                                                    width: 2,
                                                                                  )
                                                                                : Container(),
                                                                            snapshot.data!.docs[index]['mobile']
                                                                                ? ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    child: BackdropFilter(
                                                                                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                                                      child: Container(
                                                                                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(3),
                                                                                            child: Image.asset(
                                                                                              'assets/mobil-icon.png',
                                                                                              height: 20,
                                                                                              width: 20,
                                                                                            ),
                                                                                          )),
                                                                                    ),
                                                                                  )
                                                                                : Container(),
                                                                          ],
                                                                        ))
                                                                  ],
                                                                ),
                                                                // child: Padding(
                                                                //   padding: const EdgeInsets.all(4),
                                                                //   child: Column(
                                                                //     mainAxisAlignment:
                                                                //         MainAxisAlignment.spaceBetween,
                                                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                                                //     children: [
                                                                //       Expanded(
                                                                //         child: Column(
                                                                //           mainAxisAlignment:
                                                                //               MainAxisAlignment.spaceAround,
                                                                //           children: [
                                                                //             CircleAvatar(
                                                                //               backgroundColor: Colors.white,
                                                                //             ),
                                                                //             Text(
                                                                //               'Gta 5',
                                                                //               maxLines: 2,
                                                                //               overflow: TextOverflow.ellipsis,
                                                                //               style:
                                                                //                   GoogleFonts.acme(fontSize: 18),
                                                                //             ),
                                                                //           ],
                                                                //         ),
                                                                //       ),
                                                                //       Text(
                                                                //         'Level 21',
                                                                //         maxLines: 1,
                                                                //         overflow: TextOverflow.ellipsis,
                                                                //         style: GoogleFonts.acme(fontSize: 13),
                                                                //       )
                                                                //     ],
                                                                //   ),
                                                                // ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    height: 160,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white
                                                            .withOpacity(0.2)),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            'assets/about/game.png',
                                                            height: 70,
                                                            width: 70,
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                          Text(
                                                            'Oyun eklenmedi',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 30,
                                                                color: Get.isDarkMode
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.maxFinite,
                                                height: 160,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white
                                                        .withOpacity(0.2)),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/about/game.png',
                                                        height: 70,
                                                        width: 70,
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      Text(
                                                        'Oyun eklenmedi',
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 30,
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                    }),

                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Oyun İstatistikleri',
                                        style: GoogleFonts.roboto(fontSize: 25),
                                      )),
                                ),
                                Container(
                                  height: 180,
                                  child:
                                      StreamBuilder<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>(
                                          stream: firebaseApi.firestore
                                              .collection('Users')
                                              .doc(id)
                                              .collection('Accounts')
                                              .where('done', isEqualTo: true)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            return snapshot.hasData
                                                ? snapshot.data!.docs.length ==
                                                        0
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          width:
                                                              double.maxFinite,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.2)),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  'assets/about/stat.png',
                                                                  height: 70,
                                                                  width: 70,
                                                                  color: context
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'İstatistik hesabı eklenmedi',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.roboto(
                                                                      fontSize:
                                                                          26,
                                                                      color: context.isDarkMode
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Container(
                                                            width: double
                                                                .maxFinite,
                                                            height: 80,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.2)),
                                                            child: ListView
                                                                .builder(
                                                              itemCount:
                                                                  snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              physics:
                                                                  BouncingScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()['name'] ==
                                                                    'Brawl Stars') {
                                                                  String data = snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .data()[
                                                                          'data']
                                                                      .toString();
                                                                  if (data
                                                                      .startsWith(
                                                                          "#")) {
                                                                    data = data
                                                                        .substring(
                                                                            1);
                                                                  }
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(4),
                                                                    child:
                                                                        AspectRatio(
                                                                      aspectRatio:
                                                                          7 / 4,
                                                                      child:
                                                                          Card(
                                                                        color: context.isDarkMode
                                                                            ? Colors.grey[800]
                                                                            : Colors.grey[300],
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(snapshot.data!.docs[index].data()['name'],
                                                                                  style: GoogleFonts.roboto(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                  )),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Expanded(
                                                                                  child: FutureBuilder<List<dynamic>>(
                                                                                      future: Api().getBrawlStars(data),
                                                                                      builder: (context, snapshot) {
                                                                                        brawlPlayer.BrawlPlayer? player;
                                                                                        brawlBattle.BrawlBattle? battle;
                                                                                        if (snapshot.hasData) {
                                                                                          player = snapshot.data![0];
                                                                                          battle = snapshot.data![1];
                                                                                        }
                                                                                        return !snapshot.hasData
                                                                                            ? Container(
                                                                                                child: Center(
                                                                                                  child: CircularPercentIndicator(
                                                                                                    radius: 15,
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            : Container(
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                        child: Padding(
                                                                                                      padding: EdgeInsets.all(5),
                                                                                                      child: Column(
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            player!.name,
                                                                                                            maxLines: 2,
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "Level ${player.expLevel}",
                                                                                                            style: TextStyle(
                                                                                                              color: Colors.black,
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 4,
                                                                                                          ),
                                                                                                          Text("Duo victory: ${player.duoVictories}",
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.black,
                                                                                                              )),
                                                                                                          Text("Solo victory: ${player.soloVictories}",
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.black,
                                                                                                              )),
                                                                                                          Text("3vs3 victory: ${player.the3Vs3Victories}",
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.black,
                                                                                                              )),
                                                                                                        ],
                                                                                                      ),
                                                                                                    )),
                                                                                                    Container(
                                                                                                      width: 2,
                                                                                                      height: 80,
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                        child: Padding(
                                                                                                      padding: EdgeInsets.all(5),
                                                                                                      child: Column(
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            'Last Battle',
                                                                                                            maxLines: 1,
                                                                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                                                                                          ),
                                                                                                          Text("${battle!.items.first.battle.result}",
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.black,
                                                                                                              )),
                                                                                                          SizedBox(
                                                                                                            height: 4,
                                                                                                          ),
                                                                                                          Text("Mode: ${battle.items.first.battle.mode}",
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.black,
                                                                                                              )),
                                                                                                          Text("Type: ${battle.items.first.battle.type}",
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.black,
                                                                                                              )),
                                                                                                          Text("Battle Star: ${battle.items.first.battle.starPlayer.name}",
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.black,
                                                                                                              )),
                                                                                                        ],
                                                                                                      ),
                                                                                                    )),
                                                                                                  ],
                                                                                                ),
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white.withOpacity(0.32)),
                                                                                              );
                                                                                      }))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()['name'] ==
                                                                    'PubG') {
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(4),
                                                                    child:
                                                                        AspectRatio(
                                                                      aspectRatio:
                                                                          7 / 4,
                                                                      child:
                                                                          Card(
                                                                        color: context.isDarkMode
                                                                            ? Colors.grey[800]
                                                                            : Colors.grey[300],
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(snapshot.data!.docs[index].data()['name'],
                                                                                  style: GoogleFonts.roboto(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                  )),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Expanded(
                                                                                  child: Container(
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Padding(
                                                                                      padding: EdgeInsets.all(5),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          // Text(
                                                                                          //   snapshot.data!.docs[index].data()['data'],
                                                                                          //   maxLines: 2,
                                                                                          //   textAlign: TextAlign.center,
                                                                                          //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                                                                          // ),
                                                                                          Text(
                                                                                            "${snapshot.data!.docs[index].data()['best']}",
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 4,
                                                                                          ),
                                                                                          Flexible(
                                                                                            child: Text((snapshot.data!.docs[index].data()['duoKills'] / snapshot.data!.docs[index].data()['duoDeath']).toString().length > 4 ? "Duo K/D: ${(snapshot.data!.docs[index].data()['duoKills'] / snapshot.data!.docs[index].data()['duoDeath']).toString().substring(0, 3)}" : "Duo K/D: ${(snapshot.data!.docs[index].data()['duoKills'] / snapshot.data!.docs[index].data()['duoDeath']).toString()}",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.black,
                                                                                                )),
                                                                                          ),
                                                                                          Flexible(
                                                                                            child: Text((snapshot.data!.docs[index].data()['soloKills'] / snapshot.data!.docs[index].data()['soloDeath']).toString().length > 4 ? "Solo K/D: ${(snapshot.data!.docs[index].data()['soloKills'] / snapshot.data!.docs[index].data()['soloDeath']).toString().substring(0, 3)}" : "Solo K/D: ${(snapshot.data!.docs[index].data()['soloKills'] / snapshot.data!.docs[index].data()['soloDeath']).toString()}",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.black,
                                                                                                )),
                                                                                          ),
                                                                                          Flexible(
                                                                                            child: Text((snapshot.data!.docs[index].data()['squadKills'] / snapshot.data!.docs[index].data()['squadDeath']).toString().length > 4 ? "Squad K/D: ${(snapshot.data!.docs[index].data()['squadKills'] / snapshot.data!.docs[index].data()['squadDeath']).toString().substring(0, 3)}" : "Squad K/D: ${(snapshot.data!.docs[index].data()['squadKills'] / snapshot.data!.docs[index].data()['squadDeath']).toString()}",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.black,
                                                                                                )),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )),
                                                                                    Container(
                                                                                      width: 2,
                                                                                      height: 80,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                    Expanded(
                                                                                        child: Padding(
                                                                                      padding: EdgeInsets.all(5),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Flexible(
                                                                                            child: Text((snapshot.data!.docs[index].data()['duoKillsFpp'] / snapshot.data!.docs[index].data()['duoDeathFpp']).toString().length > 4 ? "Duo Fpp K/D: ${(snapshot.data!.docs[index].data()['duoKillsFpp'] / snapshot.data!.docs[index].data()['duoDeathFpp']).toString().substring(0, 3)}" : "Duo Fpp K/D: ${(snapshot.data!.docs[index].data()['duoKillsFpp'] / snapshot.data!.docs[index].data()['duoDeathFpp']).toString()}",
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(
                                                                                                  color: Colors.black,
                                                                                                )),
                                                                                          ),
                                                                                          Flexible(
                                                                                            child: Text((snapshot.data!.docs[index].data()['soloKillsFpp'] / snapshot.data!.docs[index].data()['soloDeathFpp']).toString().length > 4 ? "Solo Fpp K/D: ${(snapshot.data!.docs[index].data()['soloKillsFpp'] / snapshot.data!.docs[index].data()['soloDeathFpp']).toString().substring(0, 3)}" : "Solo Fpp K/D: ${(snapshot.data!.docs[index].data()['soloKillsFpp'] / snapshot.data!.docs[index].data()['soloDeathFpp']).toString()}",
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(
                                                                                                  color: Colors.black,
                                                                                                )),
                                                                                          ),
                                                                                          Flexible(
                                                                                            child: Text((snapshot.data!.docs[index].data()['squadKillsFpp'] / snapshot.data!.docs[index].data()['squadDeathFpp']).toString().length > 4 ? "Squad Fpp K/D: ${(snapshot.data!.docs[index].data()['squadKillsFpp'] / snapshot.data!.docs[index].data()['squadDeathFpp']).toString().substring(0, 3)}" : "Squad Fpp K/D: ${(snapshot.data!.docs[index].data()['squadKillsFpp'] / snapshot.data!.docs[index].data()['squadDeathFpp']).toString()}",
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(
                                                                                                  color: Colors.black,
                                                                                                )),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )),
                                                                                  ],
                                                                                ),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white.withOpacity(0.32)),
                                                                              ))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()['name'] ==
                                                                    'Teamfight Tactics') {
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(4),
                                                                    child:
                                                                        AspectRatio(
                                                                      aspectRatio:
                                                                          6 / 4,
                                                                      child:
                                                                          Card(
                                                                        color: context.isDarkMode
                                                                            ? Colors.grey[800]
                                                                            : Colors.grey[300],
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text("Teamfight Tactics",
                                                                                  style: GoogleFonts.roboto(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                  )),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Expanded(
                                                                                  child: Container(
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Padding(
                                                                                      padding: EdgeInsets.all(5),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Text(
                                                                                            "Level: ${snapshot.data!.docs[index].data()['level']}",
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                          ),
                                                                                          Text("Last game",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          Text("Type: ${snapshot.data!.docs[index].data()['type']}",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          Text('Player count: ${snapshot.data!.docs[index].data()['length']}',
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          Text("Play time: ${(double.parse(snapshot.data!.docs[index].data()['time'].toString()).round() / 60).round()} min",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                        ],
                                                                                      ),
                                                                                    )),
                                                                                  ],
                                                                                ),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white.withOpacity(0.32)),
                                                                              ))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()['name'] ==
                                                                    'League of Legends') {
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(4),
                                                                    child:
                                                                        AspectRatio(
                                                                      aspectRatio:
                                                                          6 / 4,
                                                                      child:
                                                                          Card(
                                                                        color: context.isDarkMode
                                                                            ? Colors.grey[800]
                                                                            : Colors.grey[300],
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text("League of Legends",
                                                                                  style: GoogleFonts.roboto(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                  )),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Expanded(
                                                                                  child: Container(
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Padding(
                                                                                      padding: EdgeInsets.all(5),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Text(
                                                                                            "Level: ${snapshot.data!.docs[index].data()['level']}",
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                          ),
                                                                                          Text("Last game",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          Text("Kills: ${snapshot.data!.docs[index].data()['kills']}",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          Text('Deaths: ${snapshot.data!.docs[index].data()['deaths']}',
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          Text(snapshot.data!.docs[index].data()['win'] ? "Victory" : "Loss",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                        ],
                                                                                      ),
                                                                                    )),
                                                                                  ],
                                                                                ),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white.withOpacity(0.32)),
                                                                              ))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(4),
                                                                    child:
                                                                        AspectRatio(
                                                                      aspectRatio:
                                                                          6 / 4,
                                                                      child:
                                                                          Card(
                                                                        color: context.isDarkMode
                                                                            ? Colors.grey[800]
                                                                            : Colors.grey[300],
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text("CS: GO",
                                                                                  style: GoogleFonts.roboto(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                  )),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Expanded(
                                                                                  child: Container(
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Padding(
                                                                                      padding: EdgeInsets.all(5),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          // Text(
                                                                                          //   snapshot.data!.docs[index].data()['data'],
                                                                                          //   maxLines: 2,
                                                                                          //   textAlign: TextAlign.center,
                                                                                          //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                                                                          // ),
                                                                                          // SizedBox(
                                                                                          //   height: 4,
                                                                                          // ),
                                                                                          Text(
                                                                                            "Win: ${snapshot.data!.docs[index].data()['wins']}",
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                          ),
                                                                                          Text("Kills: ${snapshot.data!.docs[index].data()['kills']}",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          Text("Deaths: ${snapshot.data!.docs[index].data()['deaths']}",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          Text((snapshot.data!.docs[index].data()['kills'] / snapshot.data!.docs[index].data()['deaths']).toString().length > 4 ? "K/D: ${(snapshot.data!.docs[index].data()['kills'] / snapshot.data!.docs[index].data()['deaths']).toString().substring(0, 3)}" : "K/D: ${(snapshot.data!.docs[index].data()['kills'] / snapshot.data!.docs[index].data()['deaths']).toString()}",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          Text("Achievements: ${snapshot.data!.docs[index].data()['achievements']}",
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                        ],
                                                                                      ),
                                                                                    )),
                                                                                  ],
                                                                                ),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white.withOpacity(0.32)),
                                                                              ))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                // if (snapshot.data!.docs[index].data()['name'] == 'Brawl Stars') {
                                                                //   String data = snapshot.data!.docs[index].data()['data'].toString();
                                                                //   if (data.startsWith("#")) {
                                                                //     data = data.substring(1);
                                                                //   }
                                                                //   return Padding(
                                                                //     padding: const EdgeInsets.all(4),
                                                                //     child: AspectRatio(
                                                                //       aspectRatio: 6 / 4,
                                                                //       child: Card(
                                                                //         color: Colors.primaries[index + 2],
                                                                //         child: Padding(
                                                                //           padding: const EdgeInsets.all(8.0),
                                                                //           child: Column(
                                                                //             children: [
                                                                //               Text(snapshot.data!.docs[index].data()['name'],
                                                                //                   style: GoogleFonts.roboto(
                                                                //                     fontSize: 18,
                                                                //                     fontWeight: FontWeight.w500,
                                                                //                     color: Colors.white,
                                                                //                   )),
                                                                //               SizedBox(
                                                                //                 height: 5,
                                                                //               ),
                                                                //               Expanded(
                                                                //                   child: FutureBuilder<List<dynamic>>(
                                                                //                       future: Api().getBrawlStars(data),
                                                                //                       builder: (context, snapshot) {
                                                                //                         brawlPlayer.BrawlPlayer? player;
                                                                //                         brawlBattle.BrawlBattle? battle;
                                                                //                         if (snapshot.hasData) {
                                                                //                           player = snapshot.data![0];
                                                                //                           battle = snapshot.data![1];
                                                                //                         }
                                                                //                         return !snapshot.hasData
                                                                //                             ? Container(
                                                                //                                 child: Center(
                                                                //                                   child: CircularPercentIndicator(
                                                                //                                     radius: 15,
                                                                //                                   ),
                                                                //                                 ),
                                                                //                               )
                                                                //                             : Container(
                                                                //                                 child: Row(
                                                                //                                   children: [
                                                                //                                     Expanded(
                                                                //                                         child: Padding(
                                                                //                                       padding: EdgeInsets.all(5),
                                                                //                                       child: Column(
                                                                //                                         mainAxisAlignment: MainAxisAlignment.center,
                                                                //                                         children: [
                                                                //                                           Text(
                                                                //                                             player!.name,
                                                                //                                             maxLines: 2,
                                                                //                                             textAlign: TextAlign.center,
                                                                //                                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                                                //                                           ),
                                                                //                                           Text(
                                                                //                                             "Level ${player.expLevel}",
                                                                //                                             style: TextStyle(
                                                                //                                               color: Colors.white,
                                                                //                                             ),
                                                                //                                           ),
                                                                //                                           SizedBox(
                                                                //                                             height: 4,
                                                                //                                           ),
                                                                //                                           Text("Duo victory: ${player.duoVictories}",
                                                                //                                               style: TextStyle(
                                                                //                                                 color: Colors.white,
                                                                //                                               )),
                                                                //                                           Text("Solo victory: ${player.soloVictories}",
                                                                //                                               style: TextStyle(
                                                                //                                                 color: Colors.white,
                                                                //                                               )),
                                                                //                                           Text("3vs3 victory: ${player.the3Vs3Victories}",
                                                                //                                               style: TextStyle(
                                                                //                                                 color: Colors.white,
                                                                //                                               )),
                                                                //                                         ],
                                                                //                                       ),
                                                                //                                     )),
                                                                //                                     Container(
                                                                //                                       width: 2,
                                                                //                                       height: 80,
                                                                //                                       color: Colors.white,
                                                                //                                     ),
                                                                //                                     Expanded(
                                                                //                                         child: Padding(
                                                                //                                       padding: EdgeInsets.all(5),
                                                                //                                       child: Column(
                                                                //                                         mainAxisAlignment: MainAxisAlignment.center,
                                                                //                                         children: [
                                                                //                                           Text(
                                                                //                                             'Last Battle',
                                                                //                                             maxLines: 1,
                                                                //                                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                                                //                                           ),
                                                                //                                           Text("${battle!.items.first.battle.result}",
                                                                //                                               textAlign: TextAlign.center,
                                                                //                                               style: TextStyle(
                                                                //                                                 color: Colors.white,
                                                                //                                               )),
                                                                //                                           SizedBox(
                                                                //                                             height: 4,
                                                                //                                           ),
                                                                //                                           Text("Mode: ${battle.items.first.battle.mode}",
                                                                //                                               textAlign: TextAlign.center,
                                                                //                                               style: TextStyle(
                                                                //                                                 color: Colors.white,
                                                                //                                               )),
                                                                //                                           Text("Type: ${battle.items.first.battle.type}",
                                                                //                                               textAlign: TextAlign.center,
                                                                //                                               style: TextStyle(
                                                                //                                                 color: Colors.white,
                                                                //                                               )),
                                                                //                                           Text("Battle Star: ${battle.items.first.battle.starPlayer.name}",
                                                                //                                               textAlign: TextAlign.center,
                                                                //                                               style: TextStyle(
                                                                //                                                 color: Colors.white,
                                                                //                                               )),
                                                                //                                         ],
                                                                //                                       ),
                                                                //                                     )),
                                                                //                                   ],
                                                                //                                 ),
                                                                //                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white.withOpacity(0.32)),
                                                                //                               );
                                                                //                       }))
                                                                //             ],
                                                                //           ),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //   );
                                                                // } else if (snapshot.data!.docs[index].data()['name'] == 'PubG') {
                                                                //   return Padding(
                                                                //     padding: const EdgeInsets.all(4),
                                                                //     child: AspectRatio(
                                                                //       aspectRatio: 6 / 4,
                                                                //       child: Card(
                                                                //         color: Colors.primaries[index + 2],
                                                                //         child: Padding(
                                                                //           padding: const EdgeInsets.all(8.0),
                                                                //           child: Column(
                                                                //             children: [
                                                                //               Text(snapshot.data!.docs[index].data()['name'],
                                                                //                   style: GoogleFonts.roboto(
                                                                //                     fontSize: 18,
                                                                //                     fontWeight: FontWeight.w500,
                                                                //                     color: Colors.white,
                                                                //                   )),
                                                                //               SizedBox(
                                                                //                 height: 5,
                                                                //               ),
                                                                //               Expanded(
                                                                //                   child: Container(
                                                                //                 child: Row(
                                                                //                   children: [
                                                                //                     Expanded(
                                                                //                         child: Padding(
                                                                //                       padding: EdgeInsets.all(5),
                                                                //                       child: Column(
                                                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                                                //                         children: [
                                                                //                           Text(
                                                                //                             snapshot.data!.docs[index].data()['data'],
                                                                //                             maxLines: 2,
                                                                //                             textAlign: TextAlign.center,
                                                                //                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                                                //                           ),
                                                                //                           Text(
                                                                //                             "${snapshot.data!.docs[index].data()['best']}",
                                                                //                             style: TextStyle(
                                                                //                               color: Colors.white,
                                                                //                             ),
                                                                //                           ),
                                                                //                           SizedBox(
                                                                //                             height: 4,
                                                                //                           ),
                                                                //                           Text(
                                                                //                               "Duo K/D: ${(snapshot.data!.docs[index].data()['duoKills'] / snapshot.data!.docs[index].data()['duoDeath']).toString().substring(0, 4)}",
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                           Text(
                                                                //                               "Solo K/D: ${(snapshot.data!.docs[index].data()['soloKills'] / snapshot.data!.docs[index].data()['soloDeath']).toString().substring(0, 4)}",
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                           Text(
                                                                //                               "Squad K/D: ${(snapshot.data!.docs[index].data()['squadKills'] / snapshot.data!.docs[index].data()['squadDeath']).toString().substring(0, 4)}",
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                         ],
                                                                //                       ),
                                                                //                     )),
                                                                //                     Container(
                                                                //                       width: 2,
                                                                //                       height: 80,
                                                                //                       color: Colors.white,
                                                                //                     ),
                                                                //                     Expanded(
                                                                //                         child: Padding(
                                                                //                       padding: EdgeInsets.all(5),
                                                                //                       child: Column(
                                                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                                                //                         children: [
                                                                //                           Text(
                                                                //                               "Duo Fpp K/D: ${(snapshot.data!.docs[index].data()['duoKillsFpp'] / snapshot.data!.docs[index].data()['duoDeathFpp']).toString().substring(0, 4)}",
                                                                //                               textAlign: TextAlign.center,
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                           Text(
                                                                //                               "Solo Fpp K/D: ${(snapshot.data!.docs[index].data()['soloKillsFpp'] / snapshot.data!.docs[index].data()['soloDeathFpp']).toString().substring(0, 4)}",
                                                                //                               textAlign: TextAlign.center,
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                           Text(
                                                                //                               "Squad Fpp K/D: ${(snapshot.data!.docs[index].data()['squadKillsFpp'] / snapshot.data!.docs[index].data()['squadDeathFpp']).toString().substring(0, 4)}",
                                                                //                               textAlign: TextAlign.center,
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                         ],
                                                                //                       ),
                                                                //                     )),
                                                                //                   ],
                                                                //                 ),
                                                                //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white.withOpacity(0.32)),
                                                                //               ))
                                                                //             ],
                                                                //           ),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //   );
                                                                // } else if (snapshot.data!.docs[index].data()['name'] == 'Riot Games') {
                                                                //   return Container();
                                                                // } else {
                                                                //   return Padding(
                                                                //     padding: const EdgeInsets.all(4),
                                                                //     child: AspectRatio(
                                                                //       aspectRatio: 6 / 4,
                                                                //       child: Card(
                                                                //         color: Colors.primaries[index + 2],
                                                                //         child: Padding(
                                                                //           padding: const EdgeInsets.all(8.0),
                                                                //           child: Column(
                                                                //             children: [
                                                                //               Text("CS: GO",
                                                                //                   style: GoogleFonts.roboto(
                                                                //                     fontSize: 18,
                                                                //                     fontWeight: FontWeight.w500,
                                                                //                     color: Colors.white,
                                                                //                   )),
                                                                //               SizedBox(
                                                                //                 height: 5,
                                                                //               ),
                                                                //               Expanded(
                                                                //                   child: Container(
                                                                //                 child: Row(
                                                                //                   children: [
                                                                //                     Expanded(
                                                                //                         child: Padding(
                                                                //                       padding: EdgeInsets.all(5),
                                                                //                       child: Column(
                                                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                                                //                         children: [
                                                                //                           // Text(
                                                                //                           //   snapshot.data!.docs[index].data()['data'],
                                                                //                           //   maxLines: 2,
                                                                //                           //   textAlign: TextAlign.center,
                                                                //                           //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                                                //                           // ),
                                                                //                           // SizedBox(
                                                                //                           //   height: 4,
                                                                //                           // ),
                                                                //                           Text(
                                                                //                             "Win: ${snapshot.data!.docs[index].data()['wins']}",
                                                                //                             style: TextStyle(
                                                                //                               color: Colors.white,
                                                                //                             ),
                                                                //                           ),
                                                                //                           Text("Kills: ${snapshot.data!.docs[index].data()['kills']}",
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                           Text("Deaths: ${snapshot.data!.docs[index].data()['deaths']}",
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                           Text(
                                                                //                               "K/D: ${(snapshot.data!.docs[index].data()['kills'] / snapshot.data!.docs[index].data()['deaths']).toString().substring(0, 4)}",
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                           Text("Achievements: ${snapshot.data!.docs[index].data()['achievements']}",
                                                                //                               style: TextStyle(
                                                                //                                 color: Colors.white,
                                                                //                               )),
                                                                //                         ],
                                                                //                       ),
                                                                //                     )),
                                                                //                   ],
                                                                //                 ),
                                                                //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white.withOpacity(0.32)),
                                                                //               ))
                                                                //             ],
                                                                //           ),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //   );
                                                                // }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: double.maxFinite,
                                                      height: 80,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.2)),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/about/stat.png',
                                                              height: 70,
                                                              width: 70,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'İstatistik hesabı eklenmedi',
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 28,
                                                                  color: context
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                          }),
                                ),
                                // Container(
                                //   width: double.maxFinite,
                                //   height: 150,
                                //   color: Colors.red,
                                //   child: Center(
                                //     child: Text('Steam api'),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Sosyal Platformlar',
                                        style: GoogleFonts.roboto(fontSize: 25),
                                      )),
                                ),
                                FutureBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                  future: firebaseApi.firestore
                                      .collection('Users')
                                      .doc(user.data!.id)
                                      .collection('Social')
                                      .get(),
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Container(
                                              width: double.maxFinite,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: snapshot
                                                          .data!.docs.length ==
                                                      0
                                                  ? Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            'assets/about/social.png',
                                                            height: 40,
                                                            width: 40,
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                          Text(
                                                              'Sosyal platform eklenmedi',
                                                              style: GoogleFonts.roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      20)),
                                                        ],
                                                      ),
                                                    )
                                                  : ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: snapshot
                                                          .data!.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 5),
                                                          child: Material(
                                                            elevation: 2,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                            child: InkWell(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: Container(
                                                                child: Center(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            12,
                                                                        vertical:
                                                                            2),
                                                                    child: Row(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          backgroundImage:
                                                                              NetworkImage(
                                                                            snapshot.data!.docs[index]['icon'],
                                                                          ),
                                                                          radius:
                                                                              18,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            // Text(
                                                                            //     '${snapshot.data!.docs[index]['name']}: '),
                                                                            // Text(
                                                                            //     '${infosGetx.social[index]['name']}: '),
                                                                            // SizedBox(
                                                                            //   width: 6,
                                                                            // ),
                                                                            // Text(
                                                                            //   snapshot.data!.docs[index]['name'],
                                                                            //   style: TextStyle(fontWeight: FontWeight.bold),
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    // boxShadow: [
                                                                    //   BoxShadow(
                                                                    //       color: Colors.grey
                                                                    //           .withOpacity(0.3),
                                                                    //       blurRadius: 2,
                                                                    //       spreadRadius: 1,
                                                                    //       offset: Offset(2, 2))
                                                                    // ],
                                                                    color: Colors.transparent,
                                                                    borderRadius: BorderRadius.circular(30)),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Container(
                                                width: double.maxFinite,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/about/social.png',
                                                        height: 40,
                                                        width: 40,
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      Text(
                                                          'Sosyal platform eklenmedi',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      20)),
                                                    ],
                                                  ),
                                                )));
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Aktif olduğu saatler',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          // onTap: () async {
                                          //   TimeRange time =
                                          //       await showTimeRangePicker(
                                          //           context: context,
                                          //           padding: 50,
                                          //           strokeWidth: 8,
                                          //           fromText: 'Başlangıç',
                                          //           toText: 'Bitiş',
                                          //           handlerColor:
                                          //               Colors.green[300],
                                          //           end: TimeOfDay(
                                          //               hour: firebaseApi
                                          //                   .endHour.value,
                                          //               minute: firebaseApi
                                          //                   .endMinute.value),
                                          //           handlerRadius: 15,
                                          //           labels: [
                                          //             ClockLabel(
                                          //                 angle: 0,
                                          //                 text: '18:00'),
                                          //             ClockLabel(
                                          //                 angle: 1.55,
                                          //                 text: '00:00'),
                                          //             ClockLabel(
                                          //                 angle: 3.15,
                                          //                 text: '06:00'),
                                          //             ClockLabel(
                                          //                 angle: 4.7,
                                          //                 text: '12:00'),
                                          //           ],
                                          //           backgroundWidget:
                                          //               CircleAvatar(
                                          //             radius: 100,
                                          //             backgroundColor:
                                          //                 Colors.transparent,
                                          //             child: Padding(
                                          //               padding:
                                          //                   EdgeInsets.all(20),
                                          //               child: Image.asset(
                                          //                   'assets/orta.png'),
                                          //             ),
                                          //           ),
                                          //           ticks: 12,
                                          //           autoAdjustLabels: true,
                                          //           backgroundColor: Colors.red,
                                          //           selectedColor: Colors.green,
                                          //           disabledColor: Colors.grey,
                                          //           start: TimeOfDay(
                                          //               hour: firebaseApi
                                          //                   .startHour.value,
                                          //               minute: firebaseApi
                                          //                   .startMinute
                                          //                   .value));
                                          //   if (time != null) {
                                          //     firebaseApi.startHour.value =
                                          //         time.startTime.hour;
                                          //     firebaseApi.startMinute.value =
                                          //         time.startTime.minute;
                                          //     firebaseApi.endHour.value =
                                          //         time.endTime.hour;
                                          //     firebaseApi.endMinute.value =
                                          //         time.endTime.minute;
                                          //   }
                                          // },
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                user.data!.data()![
                                                            'startMinute'] <
                                                        10
                                                    ? '${user.data!.data()!['startHour']}:0${user.data!.data()!['startMinute']}'
                                                    : '${user.data!.data()!['startHour']}:${user.data!.data()!['startMinute']}',
                                                style: GoogleFonts.rationale(
                                                    fontSize: 27,
                                                    color: Color.fromRGBO(
                                                        165, 255, 23, 1)),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.cyan),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blueGrey[900]),
                                          ),
                                        ),
                                        Text(
                                          ' - ',
                                          style: GoogleFonts.rationale(
                                              fontSize: 30),
                                        ),
                                        GestureDetector(
                                          // onTap: () async {
                                          //   TimeRange time =
                                          //       await showTimeRangePicker(
                                          //           context: context,
                                          //           padding: 50,
                                          //           strokeWidth: 8,
                                          //           fromText: 'Başlangıç',
                                          //           toText: 'Bitiş',
                                          //           handlerColor:
                                          //               Colors.green[300],
                                          //           end: TimeOfDay(
                                          //               hour: firebaseApi
                                          //                   .endHour.value,
                                          //               minute: firebaseApi
                                          //                   .endMinute.value),
                                          //           handlerRadius: 15,
                                          //           labels: [
                                          //             ClockLabel(
                                          //                 angle: 0,
                                          //                 text: '18:00'),
                                          //             ClockLabel(
                                          //                 angle: 1.55,
                                          //                 text: '00:00'),
                                          //             ClockLabel(
                                          //                 angle: 3.15,
                                          //                 text: '06:00'),
                                          //             ClockLabel(
                                          //                 angle: 4.7,
                                          //                 text: '12:00'),
                                          //           ],
                                          //           backgroundWidget:
                                          //               CircleAvatar(
                                          //             radius: 100,
                                          //             backgroundColor:
                                          //                 Colors.transparent,
                                          //             child: Padding(
                                          //               padding:
                                          //                   EdgeInsets.all(20),
                                          //               child: Image.asset(
                                          //                   'assets/orta.png'),
                                          //             ),
                                          //           ),
                                          //           ticks: 12,
                                          //           autoAdjustLabels: true,
                                          //           backgroundColor: Colors.red,
                                          //           selectedColor: Colors.green,
                                          //           disabledColor: Colors.grey,
                                          //           start: TimeOfDay(
                                          //               hour: firebaseApi
                                          //                   .startHour.value,
                                          //               minute: firebaseApi
                                          //                   .startMinute
                                          //                   .value));
                                          //   if (time != null) {
                                          //     firebaseApi.startHour.value =
                                          //         time.startTime.hour;
                                          //     firebaseApi.startMinute.value =
                                          //         time.startTime.minute;
                                          //     firebaseApi.endHour.value =
                                          //         time.endTime.hour;
                                          //     firebaseApi.endMinute.value =
                                          //         time.endTime.minute;
                                          //   }
                                          // },
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                user.data!.data()![
                                                            'endMinute'] <
                                                        10
                                                    ? '${user.data!.data()!['endHour']}:0${user.data!.data()!['endMinute']}'
                                                    : '${user.data!.data()!['endHour']}:${user.data!.data()!['endMinute']}',
                                                style: GoogleFonts.rationale(
                                                    fontSize: 27,
                                                    color: Color.fromRGBO(
                                                        165, 255, 23, 1)),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.cyan),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blueGrey[900]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                FutureBuilder<int>(
                                    future: Utils().calculatePercentage(
                                        id, firebaseApi.auth.currentUser!.uid),
                                    builder: (context, snapshot) {
                                      return snapshot.hasData
                                          ? SizedBox(
                                              width: 122,
                                              height: 105,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child:
                                                        infosGetx.avatarIsAsset
                                                                .value
                                                            ? CircleAvatar(
                                                                radius: 33,
                                                                backgroundColor: user.data!.data()![
                                                                            'avatar'] ==
                                                                        'assets/user.png'
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .transparent,
                                                                backgroundImage:
                                                                    AssetImage(infosGetx
                                                                        .avatar
                                                                        .value),
                                                              )
                                                            : CircleAvatar(
                                                                radius: 33,
                                                                backgroundColor: user.data!.data()![
                                                                            'avatar'] ==
                                                                        'assets/user.png'
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .transparent,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        infosGetx
                                                                            .avatar
                                                                            .value),
                                                              ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child:
                                                        user.data!.data()![
                                                                'avatarIsAsset']
                                                            ? CircleAvatar(
                                                                radius: 33,
                                                                backgroundColor: user.data!.data()![
                                                                            'avatar'] ==
                                                                        'assets/user.png'
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .transparent,
                                                                backgroundImage:
                                                                    AssetImage(user
                                                                            .data!
                                                                            .data()![
                                                                        'avatar']),
                                                              )
                                                            : CircleAvatar(
                                                                radius: 33,
                                                                backgroundColor: user.data!.data()![
                                                                            'avatar'] ==
                                                                        'assets/user.png'
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .transparent,
                                                                backgroundImage:
                                                                    NetworkImage(user
                                                                            .data!
                                                                            .data()![
                                                                        'avatar']),
                                                              ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 30),
                                                      child: Container(
                                                        child: CircleAvatar(
                                                          radius: 28,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .blue[900],
                                                            radius: 26,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              radius: 24,
                                                              child: Center(
                                                                child: Text(
                                                                  '${snapshot.data}%',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                              .blue[
                                                                          900]),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          // Column(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.center,
                                          //     children: [
                                          //       Text(
                                          //         'Uyum',
                                          //         style: GoogleFonts
                                          //             .josefinSans(
                                          //                 fontSize: 25,
                                          //                 fontWeight:
                                          //                     FontWeight
                                          //                         .bold),
                                          //       ),
                                          //       SizedBox(
                                          //         height: 2,
                                          //       ),
                                          //       Text(
                                          //         '${snapshot.data} %',
                                          //         style: GoogleFonts
                                          //             .josefinSans(
                                          //                 fontSize: 27,
                                          //                 fontWeight:
                                          //                     FontWeight
                                          //                         .bold),
                                          //       )
                                          //     ],
                                          //   )
                                          : CircularPercentIndicator(
                                              radius: 20);
                                    }),
                                SizedBox(
                                  height: 5,
                                )
                                // Padding(
                                //   padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                                //   child: Container(
                                //     width: double.infinity,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.symmetric(
                                //                 horizontal: 10),
                                //             child: Text(
                                //               'Bos zamanimda:',
                                //               style: GoogleFonts.acme(fontSize: 17),
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             height: 5,
                                //           ),
                                //           Container(
                                //             child: Wrap(
                                //               runSpacing: 7,
                                //               children: List.generate(3, (index) {
                                //                 return ClipRRect(
                                //                   borderRadius:
                                //                       BorderRadius.circular(30),
                                //                   child: BackdropFilter(
                                //                     filter: ImageFilter.blur(
                                //                         sigmaX: 5, sigmaY: 5),
                                //                     child: Padding(
                                //                       padding: const EdgeInsets
                                //                           .symmetric(horizontal: 3),
                                //                       child: Container(
                                //                         child: Padding(
                                //                           padding: const EdgeInsets
                                //                                   .symmetric(
                                //                               horizontal: 17,
                                //                               vertical: 7),
                                //                           child: Text(
                                //                               'Kitap okuyorum'),
                                //                         ),
                                //                         decoration: BoxDecoration(
                                //                             color: Colors.white
                                //                                 .withOpacity(0.3),
                                //                             borderRadius:
                                //                                 BorderRadius
                                //                                     .circular(30)),
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 );
                                //               }),
                                //             ),
                                //           ),
                                //           // SizedBox(
                                //           //   height: 10,
                                //           // ),

                                //           // Container(
                                //           //   height: 30,
                                //           //   child: ListView.builder(
                                //           //     itemCount: 3,
                                //           //     physics: BouncingScrollPhysics(),
                                //           //     shrinkWrap: true,
                                //           //     scrollDirection: Axis.horizontal,
                                //           //     itemBuilder: (context, index) {
                                //           //       return Padding(
                                //           //         padding: const EdgeInsets.symmetric(
                                //           //             horizontal: 3),
                                //           //         child: Container(
                                //           //           child: Center(
                                //           //               child: Padding(
                                //           //             padding: const EdgeInsets.symmetric(
                                //           //                 horizontal: 15),
                                //           //             child: Text('Kitap okuyorum'),
                                //           //           )),
                                //           //           decoration: BoxDecoration(
                                //           //               color:
                                //           //                   Colors.white.withOpacity(0.5),
                                //           //               borderRadius:
                                //           //                   BorderRadius.circular(30)),
                                //           //         ),
                                //           //       );
                                //           //     },
                                //           //   ),
                                //           // )
                                //         ],
                                //       ),
                                //     ),
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(30)),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Container(
                                //     width: double.infinity,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           Padding(
                                //             padding:
                                //                 const EdgeInsets.symmetric(horizontal: 10),
                                //             child: Text(
                                //               'Oyunlarım:',
                                //               style: GoogleFonts.acme(fontSize: 17),
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             height: 5,
                                //           ),
                                //           Container(
                                //             height: 80,
                                //             child: Wrap(
                                //               runSpacing: 7,
                                //               children: List.generate(3, (index) {
                                //                 return ClipRRect(
                                //                   borderRadius: BorderRadius.circular(30),
                                //                   child: BackdropFilter(
                                //                     filter: ImageFilter.blur(
                                //                         sigmaX: 5, sigmaY: 5),
                                //                     child: Padding(
                                //                       padding: const EdgeInsets.symmetric(
                                //                           horizontal: 3),
                                //                       child: Container(
                                //                         child: Padding(
                                //                           padding:
                                //                               const EdgeInsets.symmetric(
                                //                                   horizontal: 17,
                                //                                   vertical: 7),
                                //                           child: Row(
                                //                             mainAxisSize: MainAxisSize.min,
                                //                             children: [
                                //                               CircleAvatar(
                                //                                 backgroundColor: Colors.red,
                                //                                 radius: 15,
                                //                               ),
                                //                               SizedBox(
                                //                                 width: 5,
                                //                               ),
                                //                               Text(
                                //                                 'GTA 5',
                                //                                 style:
                                //                                     TextStyle(fontSize: 15),
                                //                               ),
                                //                             ],
                                //                           ),
                                //                         ),
                                //                         decoration: BoxDecoration(
                                //                             color: Colors.white
                                //                                 .withOpacity(0.3),
                                //                             borderRadius:
                                //                                 BorderRadius.circular(30)),
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 );
                                //               }),
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             height: 10,
                                //           ),

                                //           // Container(
                                //           //   height: 30,
                                //           //   child: ListView.builder(
                                //           //     itemCount: 3,
                                //           //     physics: BouncingScrollPhysics(),
                                //           //     shrinkWrap: true,
                                //           //     scrollDirection: Axis.horizontal,
                                //           //     itemBuilder: (context, index) {
                                //           //       return Padding(
                                //           //         padding: const EdgeInsets.symmetric(
                                //           //             horizontal: 3),
                                //           //         child: Container(
                                //           //           child: Center(
                                //           //               child: Padding(
                                //           //             padding: const EdgeInsets.symmetric(
                                //           //                 horizontal: 15),
                                //           //             child: Text('Kitap okuyorum'),
                                //           //           )),
                                //           //           decoration: BoxDecoration(
                                //           //               color:
                                //           //                   Colors.white.withOpacity(0.5),
                                //           //               borderRadius:
                                //           //                   BorderRadius.circular(30)),
                                //           //         ),
                                //           //       );
                                //           //     },
                                //           //   ),
                                //           // )
                                //         ],
                                //       ),
                                //     ),
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(30)),
                                //   ),
                                // )
                              ],
                            ),
                            Positioned(
                              top: 50,
                              right: 0,
                              left: 0,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  user.data!.data()!['avatarIsAsset']
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundColor:
                                              user.data!.data()!['avatar'] ==
                                                      'assets/user.png'
                                                  ? Colors.white
                                                  : Colors.transparent,
                                          backgroundImage: AssetImage(
                                              user.data!.data()!['avatar']),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundColor:
                                              user.data!.data()!['avatar'] ==
                                                      'assets/user.png'
                                                  ? Colors.white
                                                  : Colors.transparent,
                                          backgroundImage: NetworkImage(
                                              user.data!.data()!['avatar']),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                      height: 150,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/covers/level-${user.data!.data()!['cover']}.png'))),
                                    ),
                                  )
                                ],
                              ),
                              // child: Container(
                              //   decoration: BoxDecoration(
                              //       image: DecorationImage(
                              //           image: AssetImage('assets/10.png'))),
                              //   child: CircleAvatar(
                              //     radius: 50,
                              //     backgroundColor: Colors.red,
                              //   ),
                              // ),
                            ),
                            // Positioned(
                            //     top: 160,
                            //     left: 10,
                            //     child: Container(
                            //       height: (Get.size.width - 50) / 3,
                            //       width: (Get.size.width - 120) / 3,
                            //       child: GridView(
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.all(6),
                            //               child: Image.asset('assets/medal.png'),
                            //             ),
                            //             Padding(
                            //               padding: const EdgeInsets.all(6),
                            //               child: Image.asset('assets/medal.png'),
                            //             ),
                            //             Padding(
                            //               padding: const EdgeInsets.all(6),
                            //               child: Image.asset('assets/medal.png'),
                            //             ),
                            //           ],
                            //           gridDelegate:
                            //               SliverGridDelegateWithFixedCrossAxisCount(
                            //                   crossAxisCount: 2)),
                            //     )),
                            Positioned(
                                top: 10,
                                right: 10,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      color: Colors.white.withOpacity(0.6),
                                      height: 37,
                                      width: 117,
                                      // width: (Get.size.width - 80),
                                      child: ListView(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          user.data!.data()!['pc']
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
                                          user.data!.data()!['ps']
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
                                          user.data!.data()!['mobile']
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
                                      ),
                                    ),
                                  ),
                                )),
                            Positioned(
                              child: user.data!.data()!['headphone']
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Container(
                                          color: Colors.white.withOpacity(0.6),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/headset.png',
                                                  height: 25,
                                                  width: 25,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Sesli')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Container(
                                          color: Colors.white.withOpacity(0.6),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/chat.png',
                                                  height: 25,
                                                  width: 25,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Mesajlaşma')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              top: 10,
                              left: 10,
                            ),
                            // Positioned(
                            //   child: GestureDetector(
                            //     child: Icon(Icons.settings),
                            //     onTap: () {
                            //       Get.to(() => Settings());
                            //     },
                            //   ),
                            //   top: 10,
                            //   right: 10,
                            // )
                          ],
                        ),
                      )
                    : CircularPercentIndicator(radius: 30);
              }),
        ),
      ),
    );
  }
}
