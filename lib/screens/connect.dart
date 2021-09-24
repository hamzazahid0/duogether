import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/cardsGetx.dart';
import 'package:gamehub/getx/filterGetx.dart';
import 'package:gamehub/screens/filter.dart';
import 'package:gamehub/screens/paired.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcard/tcard.dart';

class Connect extends StatefulWidget {
  @override
  _ConnectState createState() => _ConnectState();
}

TCardController controller = TCardController();

class _ConnectState extends State<Connect> {
  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];
    FirebaseApi firebaseApi = Get.find();
    CardsGetx cardsGetx = Get.find();
    FilterGetx filterGetx = Get.find();
    bool pressed = false;
    var padding = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        leading: Obx(
          () => Opacity(
            opacity:
                cardsGetx.ended.value || cardsGetx.limit.value == 0 ? 0.4 : 1,
            child: IconButton(
                onPressed: cardsGetx.ended.value || cardsGetx.limit.value == 0
                    ? null
                    : () {
                        Get.bottomSheet(
                            Container(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.7),
                              color: context.isDarkMode
                                  ? Colors.grey[900]
                                  : Colors.white,
                              child: FutureBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                  future: firebaseApi.firestore
                                      .collection('Users')
                                      // ignore: invalid_use_of_protected_member
                                      .doc(filterGetx
                                          .list.value[controller.index].id)
                                      .get(),
                                  builder: (context, user) {
                                    return user.hasData
                                        ? Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                user.data!.data()![
                                                        'avatarIsAsset']
                                                    ? CircleAvatar(
                                                        radius: 50,
                                                        backgroundColor: user
                                                                        .data!
                                                                        .data()![
                                                                    'avatar'] ==
                                                                'assets/user.png'
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent,
                                                        backgroundImage:
                                                            AssetImage(user
                                                                    .data!
                                                                    .data()![
                                                                'avatar']),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 50,
                                                        backgroundColor: user
                                                                        .data!
                                                                        .data()![
                                                                    'avatar'] ==
                                                                'assets/user.png'
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent,
                                                        backgroundImage:
                                                            NetworkImage(user
                                                                    .data!
                                                                    .data()![
                                                                'avatar']),
                                                      ),
                                               const SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Text(
                                                    '${user.data!.data()!['name']} kişisini uygunsuz hakkında metnine göre rapor et',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Material(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await firebaseApi
                                                          .firestore
                                                          .collection('Reports')
                                                          .add({
                                                        'from': firebaseApi.auth
                                                            .currentUser!.uid,
                                                        'to': user.data!.id,
                                                        'time': DateTime.now(),
                                                        'reason':
                                                            'Uygunsuz hakkında metni'
                                                      });
                                                      Get.back();
                                                      Get.snackbar(
                                                          'Kullanıcı şikayet edildi',
                                                          'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                          colorText:
                                                              Colors.black);
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              'Şikayet et',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      'Geri',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 20,
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))
                                              ],
                                            ),
                                          )
                                        : Center(
                                            child: SizedBox(
                                              child:
                                                  CircularProgressIndicator(),
                                              height: 60,
                                              width: 60,
                                            ),
                                          );
                                  }),
                            ),
                            isScrollControlled: true);
                      },
                icon: Icon(
                  Icons.campaign_outlined,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                )),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/orta.png',
              height: 40,
              width: 60,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Duogether',
              style: GoogleFonts.roboto(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
                onPressed: () {
                  Get.to(
                      () => FilterPage(
                            controller: controller,
                          ),
                      transition: Transition.fadeIn);
                },
                icon: Icon(
                  filterGetx.filtered.value
                      ? Icons.filter_alt_rounded
                      : Icons.filter_alt_outlined,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                )),
          )
        ],
        backgroundColor: context.isDarkMode ? Colors.grey[900] : Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Obx(
        () => Container(
            color: context.isDarkMode ? Colors.black : Colors.white,
            child: cardsGetx.ended.value || cardsGetx.limit.value == 0
                ? !cardsGetx.getBoughtExtraLimit &&
                        filterGetx.game.value == 'Oyun seçin'
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/6.png',
                                height: 80,
                                width: 80,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Günlük kaydırma kaydırma hakkınız doldu',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Material(
                                color: Color.fromRGBO(0, 117, 247, 1),
                                borderRadius: BorderRadius.circular(40),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(40),
                                  onTap: () async {
                                    firebaseApi.showAd(cardsGetx, () {
                                      cardsGetx.limit.value = 20;
                                      filterGetx.generateCard();
                                      cardsGetx.ended.value = false;
                                      cardsGetx.more.value = true;
                                      cardsGetx.setBoughtExtraLimit= true;
                                      GetStorage().write("boughtExtra", true);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.smart_display_outlined,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Daha fazla göster",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/6.png',
                                height: 80,
                                width: 80,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                filterGetx.game.value == "Oyun seçin"
                                    ? 'Kaydırabileceğin Duo profili kalmadı'
                                    : "Bu özelliklere sahip oyuncu kalmadı.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                : filterGetx.cards.length != 0
                    ? Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 45 + padding, 0, 0),
                            child: Builder(
                              builder: (context) {
                                // if (controller.state != null) {
                                //   controller.state!
                                //       .reset(cards: filterGetx.cards);
                                // }
                                if (controller.state != null) {
                                  filterGetx.controller = controller;
                                }
                                return TCard(
                                  controller: controller,
                                  onForward: (index, info) async {
                                    int index = controller.index - 1;
                                    print("index : $index");
                                    if (index == 6 ||
                                        index == 11 ||
                                        index == 17) {
                                      print("reklam");
                                      return;
                                    }
                                    cardsGetx.decreaseLimit();
                                    List beforeSeenIds =
                                        GetStorage().read("seenIds") ?? [];

                                    beforeSeenIds
                                        .add(filterGetx.list.value[index].id);
                                    GetStorage()
                                        .write("seenIds", beforeSeenIds);
                                    print("before : $beforeSeenIds");

                                    firebaseApi.firestore
                                        .collection('Users')
                                        .doc(firebaseApi.auth.currentUser!.uid)
                                        .update(
                                            {'limit': cardsGetx.limit.value});
                                    print(cardsGetx.limit.value);
                                    if (info.direction == SwipDirection.Right) {
                                      pressed = true;
                                      cardsGetx.pair();
                                      int index = controller.index - 1;
                                      // ignore: invalid_use_of_protected_member
                                      list = filterGetx.list.value;
                                      Future.delayed(
                                          Duration(milliseconds: 400), () {
                                        pressed = false;
                                      });
                                      QuerySnapshot<Map<String, dynamic>> data =
                                          await firebaseApi.firestore
                                              .collection('Pairs')
                                              .where('to',
                                                  isEqualTo: firebaseApi
                                                      .auth.currentUser!.uid)
                                              .where('from',
                                                  isEqualTo: list[index].id)
                                              .get();
                                      if (data.docs.isNotEmpty) {
                                        await firebaseApi.firestore
                                            .collection('Users')
                                            .doc(
                                              list[index].id,
                                            )
                                            .update({
                                          'ids': FieldValue.arrayUnion([
                                            firebaseApi.auth.currentUser!.uid
                                          ])
                                        });
                                        //eslesdin
                                        await firebaseApi.firestore
                                            .collection('Pairs')
                                            .doc(data.docs.first.id)
                                            .update({'paired': true});
                                        Get.to(
                                            () => Paired(
                                                  name: list[index]['name'],
                                                  id: list[index].id,
                                                  avatar: list[index]['avatar'],
                                                  avatarIsAsset: list[index]
                                                      ['avatarIsAsset'],
                                                  age: list[index]['age'],
                                                  pairId: data.docs.first.id,
                                                ),
                                            transition:
                                                Transition.noTransition);
                                        //Get navigate
                                      } else {
                                        print(
                                            firebaseApi.auth.currentUser!.uid);
                                        print(list[index].id);
                                        await firebaseApi.firestore
                                            .collection('Users')
                                            .doc(
                                              list[index].id,
                                            )
                                            .update({
                                          'ids': FieldValue.arrayUnion([
                                            firebaseApi.auth.currentUser!.uid
                                          ])
                                        });
                                        //ilk tiklama
                                        await firebaseApi.firestore
                                            .collection('Pairs')
                                            .add({
                                          'paired': false,
                                          'visible': false,
                                          'to': list[index].id,
                                          'from':
                                              firebaseApi.auth.currentUser!.uid,
                                          'hasMessage': false,
                                          'lastMessage': '',
                                          firebaseApi.auth.currentUser!.uid:
                                              false,
                                          list[index].id: false,
                                          'date': DateTime.now(),
                                          'members': [
                                            firebaseApi.auth.currentUser!.uid,
                                            list[index].id
                                          ]
                                        });
                                      }
                                    } else {
                                      cardsGetx.no();
                                    }
                                  },
                                  onEnd: () {
                                    cardsGetx.ended.value = true;
                                  },
                                  lockYAxis: true,
                                  delaySlideFor: 400,
                                  slideSpeed: 15,
                                  cards: filterGetx.cards,
                                  size: Get.size,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            //! alttaki onay butonları
                            bottom: 8,
                            right: 0,
                            left: 0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Container(
                                //   height: 60,
                                //   width: 60,
                                //   child: Material(
                                //     color: Colors.transparent,
                                //     elevation: 0,
                                //     borderRadius: BorderRadius.circular(90),
                                //     child: InkWell(
                                //       radius: 30,
                                //       borderRadius: BorderRadius.circular(90),
                                //       onTap: () {},
                                //       child: Image.asset('assets/no.png'),
                                //     ),
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    controller.forward(
                                        direction: SwipDirection.Left);
                                  },
                                  child: Obx(
                                    () => CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/no.png'),
                                      radius: cardsGetx.noSize.value,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (!pressed) {
                                      // print('yesssss');
                                      // cardsGetx.pair();
                                      // pressed = true;
                                      // int index = controller.index;
                                      // // ignore: invalid_use_of_protected_member
                                      // list = filterGetx.list.value;
                                      // // print(controller.index);
                                      // // 5 = listin uzunlugu - 1
                                      // // if (controller.index == 5) {
                                      // //   print('bitti');
                                      // // }
                                      controller.forward(
                                          direction: SwipDirection.Right);
                                      Future.delayed(
                                          Duration(milliseconds: 400), () {
                                        pressed = false;
                                      });

                                      // QuerySnapshot<Map<String, dynamic>> data =
                                      //     await firebaseApi.firestore
                                      //         .collection('Pairs')
                                      //         .where('to',
                                      //             isEqualTo: firebaseApi
                                      //                 .auth.currentUser!.uid)
                                      //         .where('from',
                                      //             isEqualTo: list[index].id)
                                      //         .get();
                                      // if (data.docs.isNotEmpty) {
                                      //   await firebaseApi.firestore
                                      //       .collection('Users')
                                      //       .doc(
                                      //         list[index].id,
                                      //       )
                                      //       .update({
                                      //     'ids': FieldValue.arrayUnion([
                                      //       firebaseApi.auth.currentUser!.uid
                                      //     ])
                                      //   });
                                      //   //eslesdin
                                      //   await firebaseApi.firestore
                                      //       .collection('Pairs')
                                      //       .doc(data.docs.first.id)
                                      //       .update({'paired': true});
                                      //   Get.to(
                                      //       () => Paired(
                                      //             name: list[index]['name'],
                                      //             id: list[index].id,
                                      //             avatar: list[index]['avatar'],
                                      //             avatarIsAsset: list[index]
                                      //                 ['avatarIsAsset'],
                                      //             age: list[index]['age'],
                                      //             pairId: data.docs.first.id,
                                      //           ),
                                      //       transition:
                                      //           Transition.noTransition);
                                      //   //Get navigate
                                      // } else {
                                      //   print(
                                      //       firebaseApi.auth.currentUser!.uid);
                                      //   print(list[index].id);
                                      //   await firebaseApi.firestore
                                      //       .collection('Users')
                                      //       .doc(
                                      //         list[index].id,
                                      //       )
                                      //       .update({
                                      //     'ids': FieldValue.arrayUnion([
                                      //       firebaseApi.auth.currentUser!.uid
                                      //     ])
                                      //   });
                                      //   //ilk tiklama
                                      //   await firebaseApi.firestore
                                      //       .collection('Pairs')
                                      //       .add({
                                      //     'paired': false,
                                      //     'visible': false,
                                      //     'to': list[index].id,
                                      //     'from':
                                      //         firebaseApi.auth.currentUser!.uid,
                                      //     'hasMessage': false,
                                      //     'lastMessage': '',
                                      //     firebaseApi.auth.currentUser!.uid:
                                      //         false,
                                      //     list[index].id: false,
                                      //     'date': DateTime.now(),
                                      //     'members': [
                                      //       firebaseApi.auth.currentUser!.uid,
                                      //       list[index].id
                                      //     ]
                                      //   });
                                      // }
                                    } else {
                                      print('noooo');
                                    }
                                  },
                                  child: Obx(
                                    () => CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/yes.png'),
                                      radius: cardsGetx.yesSize.value,
                                    ),
                                  ),
                                )
                                // FloatingActionButton(
                                //   onPressed: () {},
                                //   elevation: 1,
                                //   backgroundColor: Colors.redAccent,
                                //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                //   child: Image.asset('assets/no.png'),
                                // ),
                                // FloatingActionButton(
                                //   onPressed: () {
                                //     controller.forward();
                                //   },
                                //   elevation: 0,
                                //   backgroundColor: Colors.transparent,
                                //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                //   child: Image.asset(
                                //     'assets/yes.png',
                                //     width: 70,
                                //     height: 70,
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/6.png',
                                height: 80,
                                width: 80,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                filterGetx.game.value == "Oyun seçin"
                                    ? 'Kaydırabileceğin Duo profili kalmadı'
                                    : "Bu özelliklere sahip oyuncu kalmadı",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )),
      ),
    );
  }

  // Widget card(String id) {
  //   FirebaseApi firebaseApi = Get.find();
  //   InfosGetx infosGetx = Get.find();
  //   return Card(
  //     color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //     elevation: context.isDarkMode ? 0 : 10,
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(30),
  //       child: Container(
  //         color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
  //         // decoration: BoxDecoration(
  //         //     gradient: LinearGradient(colors: [
  //         //   Color(0xFFffe259),
  //         //   Color(0xFFffa751),
  //         // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
  //         child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
  //             future: firebaseApi.firestore.collection('Users').doc(id).get(),
  //             builder: (context, user) {
  //               return user.hasData
  //                   ? Stack(
  //                       clipBehavior: Clip.antiAliasWithSaveLayer,
  //                       children: [
  //                         SingleChildScrollView(
  //                           physics: BouncingScrollPhysics(),
  //                           child: Stack(
  //                             children: [
  //                               Column(
  //                                 children: [
  //                                   Container(
  //                                     height: 180,
  //                                     child: Stack(
  //                                       children: [
  //                                         Positioned(
  //                                           child: ClipRRect(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(5),
  //                                             child: BackdropFilter(
  //                                               child: Container(
  //                                                 color: Colors.white
  //                                                     .withOpacity(0.6),
  //                                                 child: Text(
  //                                                   '${user.data!.data()!['country']}, ${user.data!.data()!['city']}',
  //                                                   maxLines: 4,
  //                                                   textAlign: TextAlign.center,
  //                                                   style: GoogleFonts.roboto(
  //                                                       color: Colors.black,
  //                                                       fontSize: 14),
  //                                                 ),
  //                                               ),
  //                                               filter: ImageFilter.blur(
  //                                                   sigmaX: 7, sigmaY: 7),
  //                                             ),
  //                                           ),
  //                                           bottom: 5,
  //                                           left: 5,
  //                                           right: MediaQuery.of(context)
  //                                                   .size
  //                                                   .width *
  //                                               0.63,
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     decoration: BoxDecoration(
  //                                         color: Colors.amber,
  //                                         image: user.data!.data()!['hasBack']
  //                                             ? DecorationImage(
  //                                                 image: NetworkImage(user.data!
  //                                                     .data()!['back']),
  //                                                 fit: BoxFit.cover)
  //                                             : DecorationImage(
  //                                                 image: AssetImage(
  //                                                     'assets/gta5back.jpg'),
  //                                                 fit: BoxFit.cover)),
  //                                   ),
  //                                   Container(
  //                                     width: (Get.size.width - 40),
  //                                     child: Column(
  //                                       children: [
  //                                         SizedBox(
  //                                           height: 15,
  //                                         ),
  //                                         Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.center,
  //                                           children: [
  //                                             Text(
  //                                               '${user.data!.data()!['name']}, ${user.data!.data()!['age']}',
  //                                               textAlign: TextAlign.center,
  //                                               style: GoogleFonts.roboto(
  //                                                   fontSize: 25),
  //                                             ),
  //                                             SizedBox(
  //                                               width: 5,
  //                                             ),
  //                                             Container(
  //                                               child: Padding(
  //                                                 padding: const EdgeInsets
  //                                                         .symmetric(
  //                                                     horizontal: 8,
  //                                                     vertical: 3),
  //                                                 child: Text(
  //                                                   'Lvl ${user.data!.data()!['level']}',
  //                                                   style: TextStyle(
  //                                                       color: Colors.white,
  //                                                       fontWeight:
  //                                                           FontWeight.bold),
  //                                                 ),
  //                                               ),
  //                                               decoration: BoxDecoration(
  //                                                   color: Colors.red,
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           10)),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         // SizedBox(
  //                                         //   height: 2,
  //                                         // ),
  //                                         // Row(
  //                                         //   mainAxisAlignment:
  //                                         //       MainAxisAlignment.center,
  //                                         //   children: [
  //                                         //     Container(
  //                                         //       child: Padding(
  //                                         //         padding: const EdgeInsets
  //                                         //                 .symmetric(
  //                                         //             horizontal: 8,
  //                                         //             vertical: 3),
  //                                         //         child: Text(
  //                                         //           'Lvl ${user.data!.data()!['level']}',
  //                                         //           style: TextStyle(
  //                                         //               color: Colors.white,
  //                                         //               fontWeight:
  //                                         //                   FontWeight.bold),
  //                                         //         ),
  //                                         //       ),
  //                                         //       decoration: BoxDecoration(
  //                                         //           color: Colors.red,
  //                                         //           borderRadius:
  //                                         //               BorderRadius.circular(
  //                                         //                   10)),
  //                                         //     ),
  //                                         //     // SizedBox(
  //                                         //     //   width: 5,
  //                                         //     // ),
  //                                         //     // Text(
  //                                         //     //   '${user.data!.data()!['country']}, ${user.data!.data()!['city']}',
  //                                         //     //   textAlign: TextAlign.center,
  //                                         //     //   style: GoogleFonts.acme(
  //                                         //     //       fontSize: 15),
  //                                         //     // ),
  //                                         //   ],
  //                                         // ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.symmetric(
  //                                         horizontal: 10),
  //                                     child: Container(
  //                                       width: double.maxFinite,
  //                                       height: 50,
  //                                       decoration: BoxDecoration(
  //                                           color:
  //                                               Colors.white.withOpacity(0.2),
  //                                           borderRadius:
  //                                               BorderRadius.circular(10)),
  //                                       child: ListView.builder(
  //                                         itemCount: Utils.rosettes.length,
  //                                         scrollDirection: Axis.horizontal,
  //                                         physics: BouncingScrollPhysics(),
  //                                         shrinkWrap: true,
  //                                         itemBuilder: (context, index) {
  //                                           return StreamBuilder<
  //                                                   QuerySnapshot<
  //                                                       Map<String, dynamic>>>(
  //                                               stream: firebaseApi.firestore
  //                                                   .collection('Users')
  //                                                   .doc(firebaseApi
  //                                                       .auth.currentUser!.uid)
  //                                                   .collection('Rosettes')
  //                                                   .where('photo',
  //                                                       isEqualTo: Utils
  //                                                               .rosettes[index]
  //                                                           ['photo']!)
  //                                                   .snapshots(),
  //                                               builder: (context, snapshot) {
  //                                                 return snapshot.hasData
  //                                                     ? Padding(
  //                                                         padding:
  //                                                             const EdgeInsets
  //                                                                     .symmetric(
  //                                                                 horizontal: 7,
  //                                                                 vertical: 5),
  //                                                         child:
  //                                                             GestureDetector(
  //                                                           onTap: () {
  //                                                             showModalBottomSheet(
  //                                                               context:
  //                                                                   context,
  //                                                               builder:
  //                                                                   (context) {
  //                                                                 return Container(
  //                                                                   child:
  //                                                                       Padding(
  //                                                                     padding: const EdgeInsets
  //                                                                             .symmetric(
  //                                                                         horizontal:
  //                                                                             5,
  //                                                                         vertical:
  //                                                                             30),
  //                                                                     child:
  //                                                                         Column(
  //                                                                       children: [
  //                                                                         CircleAvatar(
  //                                                                           backgroundImage:
  //                                                                               AssetImage(
  //                                                                             'assets/rosettes/${Utils.rosettes[index]['photo']!}',
  //                                                                           ),
  //                                                                           radius:
  //                                                                               40,
  //                                                                         ),
  //                                                                         SizedBox(
  //                                                                           height:
  //                                                                               10,
  //                                                                         ),
  //                                                                         Text(
  //                                                                           Utils.rosettes[index]['name']!,
  //                                                                           textAlign:
  //                                                                               TextAlign.center,
  //                                                                           style:
  //                                                                               TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //                                                                         ),
  //                                                                         SizedBox(
  //                                                                           height:
  //                                                                               10,
  //                                                                         ),
  //                                                                         Text(
  //                                                                           Utils.rosettes[index]['detail']!,
  //                                                                           textAlign:
  //                                                                               TextAlign.center,
  //                                                                           style:
  //                                                                               TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
  //                                                                         )
  //                                                                       ],
  //                                                                     ),
  //                                                                   ),
  //                                                                   height: 300,
  //                                                                   width: double
  //                                                                       .infinity,
  //                                                                   color: Get
  //                                                                           .isDarkMode
  //                                                                       ? Colors.grey[
  //                                                                           900]
  //                                                                       : Colors
  //                                                                           .white,
  //                                                                 );
  //                                                               },
  //                                                             );
  //                                                           },
  //                                                           child: Opacity(
  //                                                             opacity: snapshot
  //                                                                     .data!
  //                                                                     .docs
  //                                                                     .isEmpty
  //                                                                 ? 0.4
  //                                                                 : 1,
  //                                                             child:
  //                                                                 Image.asset(
  //                                                               'assets/rosettes/${Utils.rosettes[index]['photo']!}',
  //                                                             ),
  //                                                           ),
  //                                                         ),
  //                                                       )
  //                                                     : Container();
  //                                               });
  //                                         },
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   // Padding(
  //                                   //   padding: const EdgeInsets.symmetric(
  //                                   //       horizontal: 10),
  //                                   //   child: FutureBuilder<
  //                                   //           QuerySnapshot<
  //                                   //               Map<String, dynamic>>>(
  //                                   //       future: firebaseApi.firestore
  //                                   //           .collection('Users')
  //                                   //           .doc(user.data!.id)
  //                                   //           .collection('Rosettes')
  //                                   //           .get(),
  //                                   //       builder: (context, rosettes) {
  //                                   //         return rosettes.hasData
  //                                   //             ? rosettes.data!.docs.isNotEmpty
  //                                   //                 ? Container(
  //                                   //                     width: double.maxFinite,
  //                                   //                     height: 50,
  //                                   //                     decoration: BoxDecoration(
  //                                   //                         color: Colors.white
  //                                   //                             .withOpacity(
  //                                   //                                 0.2),
  //                                   //                         borderRadius:
  //                                   //                             BorderRadius
  //                                   //                                 .circular(
  //                                   //                                     10)),
  //                                   //                     child: ListView.builder(
  //                                   //                       itemCount: rosettes
  //                                   //                           .data!
  //                                   //                           .docs
  //                                   //                           .length,
  //                                   //                       scrollDirection:
  //                                   //                           Axis.horizontal,
  //                                   //                       physics:
  //                                   //                           BouncingScrollPhysics(),
  //                                   //                       shrinkWrap: true,
  //                                   //                       itemBuilder:
  //                                   //                           (context, index) {
  //                                   //                         return Padding(
  //                                   //                           padding: const EdgeInsets
  //                                   //                                   .symmetric(
  //                                   //                               horizontal: 5,
  //                                   //                               vertical: 5),
  //                                   //                           child: Image.asset(
  //                                   //                               'assets/rosettes/${rosettes.data!.docs[index].data()['photo']}'),
  //                                   //                         );
  //                                   //                       },
  //                                   //                     ),
  //                                   //                   )
  //                                   //                 : Container(
  //                                   //                     width: double.maxFinite,
  //                                   //                     decoration: BoxDecoration(
  //                                   //                         color: Colors.white
  //                                   //                             .withOpacity(
  //                                   //                                 0.2),
  //                                   //                         borderRadius:
  //                                   //                             BorderRadius
  //                                   //                                 .circular(
  //                                   //                                     10)),
  //                                   //                     height: 40,
  //                                   //                     child: Center(
  //                                   //                       child: Text(
  //                                   //                           'Hiçbir rozeti yok',
  //                                   //                           style: GoogleFonts.acme(
  //                                   //                               fontWeight:
  //                                   //                                   FontWeight
  //                                   //                                       .w100,
  //                                   //                               fontSize: 20,
  //                                   //                               color: Colors
  //                                   //                                   .black)),
  //                                   //                     ),
  //                                   //                   )
  //                                   //             : CircularPercentIndicator(
  //                                   //                 radius: 20);
  //                                   //       }),
  //                                   // ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.all(10),
  //                                     child: Container(
  //                                       child: Column(
  //                                         children: [
  //                                           // Text(
  //                                           //   'Hakkımda',
  //                                           //   style: GoogleFonts.acme(
  //                                           //       fontSize: 25),
  //                                           // ),
  //                                           Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(8.0),
  //                                             child: Text(
  //                                               '${user.data!.data()!['bio']}',
  //                                               textAlign: TextAlign.start,
  //                                               maxLines: 4,
  //                                               style: TextStyle(fontSize: 17),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       decoration: BoxDecoration(
  //                                           borderRadius:
  //                                               BorderRadius.circular(10),
  //                                           color:
  //                                               Colors.white.withOpacity(0.2)),
  //                                     ),
  //                                   ),
  //                                   FutureBuilder<
  //                                           QuerySnapshot<
  //                                               Map<String, dynamic>>>(
  //                                       future: firebaseApi.firestore
  //                                           .collection('Users')
  //                                           .doc(user.data!.id)
  //                                           .collection('Games')
  //                                           .get(),
  //                                       builder: (context, snapshot) {
  //                                         return snapshot.hasData
  //                                             ? snapshot.data!.docs.length != 0
  //                                                 ? Container(
  //                                                     width: double.maxFinite,
  //                                                     height: 160,
  //                                                     color: Colors.transparent,
  //                                                     child: ListView.builder(
  //                                                       itemCount: snapshot
  //                                                           .data!.docs.length,
  //                                                       scrollDirection:
  //                                                           Axis.horizontal,
  //                                                       physics:
  //                                                           BouncingScrollPhysics(),
  //                                                       shrinkWrap: true,
  //                                                       itemBuilder:
  //                                                           (context, index) {
  //                                                         return Padding(
  //                                                           padding:
  //                                                               const EdgeInsets
  //                                                                   .all(4),
  //                                                           child: AspectRatio(
  //                                                             aspectRatio:
  //                                                                 4 / 5,
  //                                                             child: Card(
  //                                                               color: Colors
  //                                                                   .transparent,
  //                                                               child: Stack(
  //                                                                 fit: StackFit
  //                                                                     .expand,
  //                                                                 children: [
  //                                                                   ClipRRect(
  //                                                                     borderRadius:
  //                                                                         BorderRadius.circular(
  //                                                                             5),
  //                                                                     child: Image
  //                                                                         .network(
  //                                                                       snapshot
  //                                                                           .data!
  //                                                                           .docs[index]['photo'],
  //                                                                       fit: BoxFit
  //                                                                           .cover,
  //                                                                     ),
  //                                                                   ),
  //                                                                   Positioned(
  //                                                                       bottom:
  //                                                                           2,
  //                                                                       left: 2,
  //                                                                       child:
  //                                                                           Row(
  //                                                                         children: [
  //                                                                           snapshot.data!.docs[index]['pc']
  //                                                                               ? ClipRRect(
  //                                                                                   borderRadius: BorderRadius.circular(5),
  //                                                                                   child: BackdropFilter(
  //                                                                                     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
  //                                                                                     child: Container(
  //                                                                                         decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
  //                                                                                         child: Padding(
  //                                                                                           padding: const EdgeInsets.all(3),
  //                                                                                           child: Image.asset(
  //                                                                                             'assets/pc.png',
  //                                                                                             height: 20,
  //                                                                                             width: 20,
  //                                                                                           ),
  //                                                                                         )),
  //                                                                                   ),
  //                                                                                 )
  //                                                                               : Container(),
  //                                                                           snapshot.data!.docs[index]['ps']
  //                                                                               ? SizedBox(
  //                                                                                   width: 2,
  //                                                                                 )
  //                                                                               : Container(),
  //                                                                           snapshot.data!.docs[index]['ps']
  //                                                                               ? ClipRRect(
  //                                                                                   borderRadius: BorderRadius.circular(5),
  //                                                                                   child: BackdropFilter(
  //                                                                                     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
  //                                                                                     child: Container(
  //                                                                                         decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
  //                                                                                         child: Padding(
  //                                                                                           padding: const EdgeInsets.all(3),
  //                                                                                           child: Image.asset(
  //                                                                                             'assets/ps.png',
  //                                                                                             height: 20,
  //                                                                                             width: 20,
  //                                                                                           ),
  //                                                                                         )),
  //                                                                                   ),
  //                                                                                 )
  //                                                                               : Container(),
  //                                                                           snapshot.data!.docs[index]['mobile']
  //                                                                               ? SizedBox(
  //                                                                                   width: 2,
  //                                                                                 )
  //                                                                               : Container(),
  //                                                                           snapshot.data!.docs[index]['mobile']
  //                                                                               ? ClipRRect(
  //                                                                                   borderRadius: BorderRadius.circular(5),
  //                                                                                   child: BackdropFilter(
  //                                                                                     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
  //                                                                                     child: Container(
  //                                                                                         decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
  //                                                                                         child: Padding(
  //                                                                                           padding: const EdgeInsets.all(3),
  //                                                                                           child: Image.asset(
  //                                                                                             'assets/mobil-icon.png',
  //                                                                                             height: 20,
  //                                                                                             width: 20,
  //                                                                                           ),
  //                                                                                         )),
  //                                                                                   ),
  //                                                                                 )
  //                                                                               : Container(),
  //                                                                         ],
  //                                                                       ))
  //                                                                 ],
  //                                                               ),
  //                                                               // child: Padding(
  //                                                               //   padding: const EdgeInsets.all(4),
  //                                                               //   child: Column(
  //                                                               //     mainAxisAlignment:
  //                                                               //         MainAxisAlignment.spaceBetween,
  //                                                               //     crossAxisAlignment: CrossAxisAlignment.center,
  //                                                               //     children: [
  //                                                               //       Expanded(
  //                                                               //         child: Column(
  //                                                               //           mainAxisAlignment:
  //                                                               //               MainAxisAlignment.spaceAround,
  //                                                               //           children: [
  //                                                               //             CircleAvatar(
  //                                                               //               backgroundColor: Colors.white,
  //                                                               //             ),
  //                                                               //             Text(
  //                                                               //               'Gta 5',
  //                                                               //               maxLines: 2,
  //                                                               //               overflow: TextOverflow.ellipsis,
  //                                                               //               style:
  //                                                               //                   GoogleFonts.acme(fontSize: 18),
  //                                                               //             ),
  //                                                               //           ],
  //                                                               //         ),
  //                                                               //       ),
  //                                                               //       Text(
  //                                                               //         'Level 21',
  //                                                               //         maxLines: 1,
  //                                                               //         overflow: TextOverflow.ellipsis,
  //                                                               //         style: GoogleFonts.acme(fontSize: 13),
  //                                                               //       )
  //                                                               //     ],
  //                                                               //   ),
  //                                                               // ),
  //                                                             ),
  //                                                           ),
  //                                                         );
  //                                                       },
  //                                                     ),
  //                                                   )
  //                                                 : Container(
  //                                                     width: double.maxFinite,
  //                                                     height: 80,
  //                                                     color: Colors.transparent,
  //                                                     child: Center(
  //                                                       child: Text(
  //                                                         'Oyun eklenmedi',
  //                                                         style: GoogleFonts.roboto(
  //                                                             fontSize: 30,
  //                                                             color: Get
  //                                                                     .isDarkMode
  //                                                                 ? Colors.white
  //                                                                 : Colors
  //                                                                     .black),
  //                                                       ),
  //                                                     ),
  //                                                   )
  //                                             : Container(
  //                                                 width: double.maxFinite,
  //                                                 height: 80,
  //                                                 color: Colors.transparent,
  //                                                 child: Center(
  //                                                   child: Text(
  //                                                     'Oyun eklenmedi',
  //                                                     style: GoogleFonts.roboto(
  //                                                         fontSize: 30,
  //                                                         color: Colors.black),
  //                                                   ),
  //                                                 ),
  //                                               );
  //                                       }),

  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   Container(
  //                                     width: double.maxFinite,
  //                                     height: 150,
  //                                     color: Colors.red,
  //                                     child: Center(
  //                                       child: Text('Steam api'),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 10,
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.symmetric(
  //                                         horizontal: 10),
  //                                     child: Container(
  //                                       width: double.maxFinite,
  //                                       height: 50,
  //                                       decoration: BoxDecoration(
  //                                           color:
  //                                               Colors.white.withOpacity(0.2),
  //                                           borderRadius:
  //                                               BorderRadius.circular(10)),
  //                                       child: FutureBuilder<
  //                                           QuerySnapshot<
  //                                               Map<String, dynamic>>>(
  //                                         future: firebaseApi.firestore
  //                                             .collection('Users')
  //                                             .doc(user.data!.id)
  //                                             .collection('Social')
  //                                             .get(),
  //                                         builder: (context, snapshot) {
  //                                           return snapshot.hasData
  //                                               ? snapshot.data!.docs.length !=
  //                                                       0
  //                                                   ? ListView.builder(
  //                                                       scrollDirection:
  //                                                           Axis.horizontal,
  //                                                       itemCount: snapshot
  //                                                           .data!.docs.length,
  //                                                       itemBuilder:
  //                                                           (context, index) {
  //                                                         return Padding(
  //                                                           padding:
  //                                                               const EdgeInsets
  //                                                                       .symmetric(
  //                                                                   horizontal:
  //                                                                       8,
  //                                                                   vertical:
  //                                                                       5),
  //                                                           child: Material(
  //                                                             elevation: 2,
  //                                                             borderRadius:
  //                                                                 BorderRadius
  //                                                                     .circular(
  //                                                                         30),
  //                                                             color:
  //                                                                 Colors.white,
  //                                                             child: InkWell(
  //                                                               borderRadius:
  //                                                                   BorderRadius
  //                                                                       .circular(
  //                                                                           30),
  //                                                               child:
  //                                                                   Container(
  //                                                                 child: Center(
  //                                                                   child:
  //                                                                       Padding(
  //                                                                     padding: const EdgeInsets
  //                                                                             .symmetric(
  //                                                                         horizontal:
  //                                                                             12,
  //                                                                         vertical:
  //                                                                             3),
  //                                                                     child:
  //                                                                         Row(
  //                                                                       children: [
  //                                                                         CircleAvatar(
  //                                                                           backgroundColor:
  //                                                                               Colors.transparent,
  //                                                                           backgroundImage:
  //                                                                               NetworkImage(
  //                                                                             snapshot.data!.docs[index]['icon'],
  //                                                                           ),
  //                                                                           radius:
  //                                                                               15,
  //                                                                         ),
  //                                                                         SizedBox(
  //                                                                           width:
  //                                                                               4,
  //                                                                         ),
  //                                                                         Row(
  //                                                                           children: [
  //                                                                             Text(
  //                                                                               '${snapshot.data!.docs[index]['name']}',
  //                                                                               style: TextStyle(fontWeight: FontWeight.bold),
  //                                                                             ),
  //                                                                             // Text(
  //                                                                             //   snapshot.data!.docs[index]['data'],
  //                                                                             //   style: TextStyle(fontWeight: FontWeight.bold),
  //                                                                             // ),
  //                                                                           ],
  //                                                                         ),
  //                                                                       ],
  //                                                                     ),
  //                                                                   ),
  //                                                                 ),
  //                                                                 decoration: BoxDecoration(
  //                                                                     // boxShadow: [
  //                                                                     //   BoxShadow(
  //                                                                     //       color: Colors.grey
  //                                                                     //           .withOpacity(0.3),
  //                                                                     //       blurRadius: 2,
  //                                                                     //       spreadRadius: 1,
  //                                                                     //       offset: Offset(2, 2))
  //                                                                     // ],
  //                                                                     color: Colors.transparent,
  //                                                                     borderRadius: BorderRadius.circular(30)),
  //                                                               ),
  //                                                             ),
  //                                                           ),
  //                                                         );
  //                                                       },
  //                                                     )
  //                                                   : Center(
  //                                                       child: Text(
  //                                                         'Sosyal bağlantısı yok',
  //                                                         style: TextStyle(
  //                                                             fontSize: 20,
  //                                                             color: Get
  //                                                                     .isDarkMode
  //                                                                 ? Colors.white
  //                                                                 : Colors
  //                                                                     .black),
  //                                                       ),
  //                                                     )
  //                                               : Container();
  //                                         },
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 20,
  //                                   ),
  //                                   Text(
  //                                     'Aktif olduğu saatler',
  //                                     style: GoogleFonts.josefinSans(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 22),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 4,
  //                                   ),
  //                                   Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: [
  //                                       Row(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.center,
  //                                         children: [
  //                                           GestureDetector(
  //                                             // onTap: () async {
  //                                             //   TimeRange time =
  //                                             //       await showTimeRangePicker(
  //                                             //           context: context,
  //                                             //           padding: 50,
  //                                             //           strokeWidth: 8,
  //                                             //           fromText: 'Başlangıç',
  //                                             //           toText: 'Bitiş',
  //                                             //           handlerColor:
  //                                             //               Colors.green[300],
  //                                             //           end: TimeOfDay(
  //                                             //               hour: firebaseApi
  //                                             //                   .endHour.value,
  //                                             //               minute: firebaseApi
  //                                             //                   .endMinute.value),
  //                                             //           handlerRadius: 15,
  //                                             //           labels: [
  //                                             //             ClockLabel(
  //                                             //                 angle: 0,
  //                                             //                 text: '18:00'),
  //                                             //             ClockLabel(
  //                                             //                 angle: 1.55,
  //                                             //                 text: '00:00'),
  //                                             //             ClockLabel(
  //                                             //                 angle: 3.15,
  //                                             //                 text: '06:00'),
  //                                             //             ClockLabel(
  //                                             //                 angle: 4.7,
  //                                             //                 text: '12:00'),
  //                                             //           ],
  //                                             //           backgroundWidget:
  //                                             //               CircleAvatar(
  //                                             //             radius: 100,
  //                                             //             backgroundColor:
  //                                             //                 Colors.transparent,
  //                                             //             child: Padding(
  //                                             //               padding:
  //                                             //                   EdgeInsets.all(20),
  //                                             //               child: Image.asset(
  //                                             //                   'assets/orta.png'),
  //                                             //             ),
  //                                             //           ),
  //                                             //           ticks: 12,
  //                                             //           autoAdjustLabels: true,
  //                                             //           backgroundColor: Colors.red,
  //                                             //           selectedColor: Colors.green,
  //                                             //           disabledColor: Colors.grey,
  //                                             //           start: TimeOfDay(
  //                                             //               hour: firebaseApi
  //                                             //                   .startHour.value,
  //                                             //               minute: firebaseApi
  //                                             //                   .startMinute
  //                                             //                   .value));
  //                                             //   if (time != null) {
  //                                             //     firebaseApi.startHour.value =
  //                                             //         time.startTime.hour;
  //                                             //     firebaseApi.startMinute.value =
  //                                             //         time.startTime.minute;
  //                                             //     firebaseApi.endHour.value =
  //                                             //         time.endTime.hour;
  //                                             //     firebaseApi.endMinute.value =
  //                                             //         time.endTime.minute;
  //                                             //   }
  //                                             // },
  //                                             child: Container(
  //                                               child: Padding(
  //                                                 padding:
  //                                                     const EdgeInsets.all(10),
  //                                                 child: Text(
  //                                                   user.data!.data()![
  //                                                               'startMinute'] <
  //                                                           10
  //                                                       ? '${user.data!.data()!['startHour']}:0${user.data!.data()!['startMinute']}'
  //                                                       : '${user.data!.data()!['startHour']}:${user.data!.data()!['startMinute']}',
  //                                                   style:
  //                                                       GoogleFonts.rationale(
  //                                                           fontSize: 27,
  //                                                           color:
  //                                                               Color.fromRGBO(
  //                                                                   165,
  //                                                                   255,
  //                                                                   23,
  //                                                                   1)),
  //                                                 ),
  //                                               ),
  //                                               decoration: BoxDecoration(
  //                                                   border: Border.all(
  //                                                       color: Colors.cyan),
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           10),
  //                                                   color:
  //                                                       Colors.blueGrey[900]),
  //                                             ),
  //                                           ),
  //                                           Text(
  //                                             ' - ',
  //                                             style: GoogleFonts.rationale(
  //                                                 fontSize: 30),
  //                                           ),
  //                                           GestureDetector(
  //                                             // onTap: () async {
  //                                             //   TimeRange time =
  //                                             //       await showTimeRangePicker(
  //                                             //           context: context,
  //                                             //           padding: 50,
  //                                             //           strokeWidth: 8,
  //                                             //           fromText: 'Başlangıç',
  //                                             //           toText: 'Bitiş',
  //                                             //           handlerColor:
  //                                             //               Colors.green[300],
  //                                             //           end: TimeOfDay(
  //                                             //               hour: firebaseApi
  //                                             //                   .endHour.value,
  //                                             //               minute: firebaseApi
  //                                             //                   .endMinute.value),
  //                                             //           handlerRadius: 15,
  //                                             //           labels: [
  //                                             //             ClockLabel(
  //                                             //                 angle: 0,
  //                                             //                 text: '18:00'),
  //                                             //             ClockLabel(
  //                                             //                 angle: 1.55,
  //                                             //                 text: '00:00'),
  //                                             //             ClockLabel(
  //                                             //                 angle: 3.15,
  //                                             //                 text: '06:00'),
  //                                             //             ClockLabel(
  //                                             //                 angle: 4.7,
  //                                             //                 text: '12:00'),
  //                                             //           ],
  //                                             //           backgroundWidget:
  //                                             //               CircleAvatar(
  //                                             //             radius: 100,
  //                                             //             backgroundColor:
  //                                             //                 Colors.transparent,
  //                                             //             child: Padding(
  //                                             //               padding:
  //                                             //                   EdgeInsets.all(20),
  //                                             //               child: Image.asset(
  //                                             //                   'assets/orta.png'),
  //                                             //             ),
  //                                             //           ),
  //                                             //           ticks: 12,
  //                                             //           autoAdjustLabels: true,
  //                                             //           backgroundColor: Colors.red,
  //                                             //           selectedColor: Colors.green,
  //                                             //           disabledColor: Colors.grey,
  //                                             //           start: TimeOfDay(
  //                                             //               hour: firebaseApi
  //                                             //                   .startHour.value,
  //                                             //               minute: firebaseApi
  //                                             //                   .startMinute
  //                                             //                   .value));
  //                                             //   if (time != null) {
  //                                             //     firebaseApi.startHour.value =
  //                                             //         time.startTime.hour;
  //                                             //     firebaseApi.startMinute.value =
  //                                             //         time.startTime.minute;
  //                                             //     firebaseApi.endHour.value =
  //                                             //         time.endTime.hour;
  //                                             //     firebaseApi.endMinute.value =
  //                                             //         time.endTime.minute;
  //                                             //   }
  //                                             // },
  //                                             child: Container(
  //                                               child: Padding(
  //                                                 padding:
  //                                                     const EdgeInsets.all(10),
  //                                                 child: Text(
  //                                                   user.data!.data()![
  //                                                               'endMinute'] <
  //                                                           10
  //                                                       ? '${user.data!.data()!['endHour']}:0${user.data!.data()!['endMinute']}'
  //                                                       : '${user.data!.data()!['endHour']}:${user.data!.data()!['endMinute']}',
  //                                                   style:
  //                                                       GoogleFonts.rationale(
  //                                                           fontSize: 27,
  //                                                           color:
  //                                                               Color.fromRGBO(
  //                                                                   165,
  //                                                                   255,
  //                                                                   23,
  //                                                                   1)),
  //                                                 ),
  //                                               ),
  //                                               decoration: BoxDecoration(
  //                                                   border: Border.all(
  //                                                       color: Colors.cyan),
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           10),
  //                                                   color:
  //                                                       Colors.blueGrey[900]),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   SizedBox(
  //                                     height: 15,
  //                                   ),
  //                                   FutureBuilder<int>(
  //                                       future: Utils().calculatePercentage(id,
  //                                           firebaseApi.auth.currentUser!.uid),
  //                                       builder: (context, snapshot) {
  //                                         return snapshot.hasData
  //                                             ? SizedBox(
  //                                                 width: 122,
  //                                                 height: 105,
  //                                                 child: Stack(
  //                                                   children: [
  //                                                     Positioned(
  //                                                       top: 0,
  //                                                       left: 0,
  //                                                       child: infosGetx
  //                                                               .avatarIsAsset
  //                                                               .value
  //                                                           ? CircleAvatar(
  //                                                               radius: 33,
  //                                                               backgroundImage:
  //                                                                   AssetImage(infosGetx
  //                                                                       .avatar
  //                                                                       .value),
  //                                                             )
  //                                                           : CircleAvatar(
  //                                                               radius: 33,
  //                                                               backgroundImage:
  //                                                                   NetworkImage(
  //                                                                       infosGetx
  //                                                                           .avatar
  //                                                                           .value),
  //                                                             ),
  //                                                     ),
  //                                                     Positioned(
  //                                                       top: 0,
  //                                                       right: 0,
  //                                                       child: user.data!
  //                                                                   .data()![
  //                                                               'avatarIsAsset']
  //                                                           ? CircleAvatar(
  //                                                               radius: 33,
  //                                                               backgroundColor:
  //                                                                   Colors
  //                                                                       .transparent,
  //                                                               backgroundImage:
  //                                                                   AssetImage(user
  //                                                                           .data!
  //                                                                           .data()![
  //                                                                       'avatar']),
  //                                                             )
  //                                                           : CircleAvatar(
  //                                                               radius: 33,
  //                                                               backgroundColor:
  //                                                                   Colors
  //                                                                       .transparent,
  //                                                               backgroundImage:
  //                                                                   NetworkImage(user
  //                                                                           .data!
  //                                                                           .data()![
  //                                                                       'avatar']),
  //                                                             ),
  //                                                     ),
  //                                                     Positioned(
  //                                                       bottom: 0,
  //                                                       left: 0,
  //                                                       right: 0,
  //                                                       child: Padding(
  //                                                         padding:
  //                                                             const EdgeInsets
  //                                                                     .only(
  //                                                                 top: 30),
  //                                                         child: Container(
  //                                                           child: CircleAvatar(
  //                                                             radius: 28,
  //                                                             backgroundColor:
  //                                                                 Colors.white,
  //                                                             child:
  //                                                                 CircleAvatar(
  //                                                               backgroundColor:
  //                                                                   Colors.blue[
  //                                                                       900],
  //                                                               radius: 26,
  //                                                               child:
  //                                                                   CircleAvatar(
  //                                                                 backgroundColor:
  //                                                                     Colors
  //                                                                         .white,
  //                                                                 radius: 24,
  //                                                                 child: Center(
  //                                                                   child: Text(
  //                                                                     '${snapshot.data}%',
  //                                                                     style: TextStyle(
  //                                                                         fontWeight: FontWeight
  //                                                                             .bold,
  //                                                                         color:
  //                                                                             Colors.blue[900]),
  //                                                                   ),
  //                                                                 ),
  //                                                               ),
  //                                                             ),
  //                                                           ),
  //                                                         ),
  //                                                       ),
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               )
  //                                             // Column(
  //                                             //     mainAxisAlignment:
  //                                             //         MainAxisAlignment.center,
  //                                             //     children: [
  //                                             //       Text(
  //                                             //         'Uyum',
  //                                             //         style: GoogleFonts
  //                                             //             .josefinSans(
  //                                             //                 fontSize: 25,
  //                                             //                 fontWeight:
  //                                             //                     FontWeight
  //                                             //                         .bold),
  //                                             //       ),
  //                                             //       SizedBox(
  //                                             //         height: 2,
  //                                             //       ),
  //                                             //       Text(
  //                                             //         '${snapshot.data} %',
  //                                             //         style: GoogleFonts
  //                                             //             .josefinSans(
  //                                             //                 fontSize: 27,
  //                                             //                 fontWeight:
  //                                             //                     FontWeight
  //                                             //                         .bold),
  //                                             //       )
  //                                             //     ],
  //                                             //   )
  //                                             : CircularPercentIndicator(
  //                                                 radius: 20);
  //                                       }),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   )
  //                                   // Padding(
  //                                   //   padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
  //                                   //   child: Container(
  //                                   //     width: double.infinity,
  //                                   //     child: Padding(
  //                                   //       padding: const EdgeInsets.all(8.0),
  //                                   //       child: Column(
  //                                   //         mainAxisAlignment: MainAxisAlignment.start,
  //                                   //         crossAxisAlignment:
  //                                   //             CrossAxisAlignment.start,
  //                                   //         children: [
  //                                   //           Padding(
  //                                   //             padding: const EdgeInsets.symmetric(
  //                                   //                 horizontal: 10),
  //                                   //             child: Text(
  //                                   //               'Bos zamanimda:',
  //                                   //               style: GoogleFonts.acme(fontSize: 17),
  //                                   //             ),
  //                                   //           ),
  //                                   //           SizedBox(
  //                                   //             height: 5,
  //                                   //           ),
  //                                   //           Container(
  //                                   //             child: Wrap(
  //                                   //               runSpacing: 7,
  //                                   //               children: List.generate(3, (index) {
  //                                   //                 return ClipRRect(
  //                                   //                   borderRadius:
  //                                   //                       BorderRadius.circular(30),
  //                                   //                   child: BackdropFilter(
  //                                   //                     filter: ImageFilter.blur(
  //                                   //                         sigmaX: 5, sigmaY: 5),
  //                                   //                     child: Padding(
  //                                   //                       padding: const EdgeInsets
  //                                   //                           .symmetric(horizontal: 3),
  //                                   //                       child: Container(
  //                                   //                         child: Padding(
  //                                   //                           padding: const EdgeInsets
  //                                   //                                   .symmetric(
  //                                   //                               horizontal: 17,
  //                                   //                               vertical: 7),
  //                                   //                           child: Text(
  //                                   //                               'Kitap okuyorum'),
  //                                   //                         ),
  //                                   //                         decoration: BoxDecoration(
  //                                   //                             color: Colors.white
  //                                   //                                 .withOpacity(0.3),
  //                                   //                             borderRadius:
  //                                   //                                 BorderRadius
  //                                   //                                     .circular(30)),
  //                                   //                       ),
  //                                   //                     ),
  //                                   //                   ),
  //                                   //                 );
  //                                   //               }),
  //                                   //             ),
  //                                   //           ),
  //                                   //           // SizedBox(
  //                                   //           //   height: 10,
  //                                   //           // ),

  //                                   //           // Container(
  //                                   //           //   height: 30,
  //                                   //           //   child: ListView.builder(
  //                                   //           //     itemCount: 3,
  //                                   //           //     physics: BouncingScrollPhysics(),
  //                                   //           //     shrinkWrap: true,
  //                                   //           //     scrollDirection: Axis.horizontal,
  //                                   //           //     itemBuilder: (context, index) {
  //                                   //           //       return Padding(
  //                                   //           //         padding: const EdgeInsets.symmetric(
  //                                   //           //             horizontal: 3),
  //                                   //           //         child: Container(
  //                                   //           //           child: Center(
  //                                   //           //               child: Padding(
  //                                   //           //             padding: const EdgeInsets.symmetric(
  //                                   //           //                 horizontal: 15),
  //                                   //           //             child: Text('Kitap okuyorum'),
  //                                   //           //           )),
  //                                   //           //           decoration: BoxDecoration(
  //                                   //           //               color:
  //                                   //           //                   Colors.white.withOpacity(0.5),
  //                                   //           //               borderRadius:
  //                                   //           //                   BorderRadius.circular(30)),
  //                                   //           //         ),
  //                                   //           //       );
  //                                   //           //     },
  //                                   //           //   ),
  //                                   //           // )
  //                                   //         ],
  //                                   //       ),
  //                                   //     ),
  //                                   //     decoration: BoxDecoration(
  //                                   //         borderRadius: BorderRadius.circular(30)),
  //                                   //   ),
  //                                   // ),
  //                                   // Padding(
  //                                   //   padding: const EdgeInsets.all(8.0),
  //                                   //   child: Container(
  //                                   //     width: double.infinity,
  //                                   //     child: Padding(
  //                                   //       padding: const EdgeInsets.all(8.0),
  //                                   //       child: Column(
  //                                   //         mainAxisAlignment: MainAxisAlignment.start,
  //                                   //         crossAxisAlignment: CrossAxisAlignment.start,
  //                                   //         children: [
  //                                   //           Padding(
  //                                   //             padding:
  //                                   //                 const EdgeInsets.symmetric(horizontal: 10),
  //                                   //             child: Text(
  //                                   //               'Oyunlarım:',
  //                                   //               style: GoogleFonts.acme(fontSize: 17),
  //                                   //             ),
  //                                   //           ),
  //                                   //           SizedBox(
  //                                   //             height: 5,
  //                                   //           ),
  //                                   //           Container(
  //                                   //             height: 80,
  //                                   //             child: Wrap(
  //                                   //               runSpacing: 7,
  //                                   //               children: List.generate(3, (index) {
  //                                   //                 return ClipRRect(
  //                                   //                   borderRadius: BorderRadius.circular(30),
  //                                   //                   child: BackdropFilter(
  //                                   //                     filter: ImageFilter.blur(
  //                                   //                         sigmaX: 5, sigmaY: 5),
  //                                   //                     child: Padding(
  //                                   //                       padding: const EdgeInsets.symmetric(
  //                                   //                           horizontal: 3),
  //                                   //                       child: Container(
  //                                   //                         child: Padding(
  //                                   //                           padding:
  //                                   //                               const EdgeInsets.symmetric(
  //                                   //                                   horizontal: 17,
  //                                   //                                   vertical: 7),
  //                                   //                           child: Row(
  //                                   //                             mainAxisSize: MainAxisSize.min,
  //                                   //                             children: [
  //                                   //                               CircleAvatar(
  //                                   //                                 backgroundColor: Colors.red,
  //                                   //                                 radius: 15,
  //                                   //                               ),
  //                                   //                               SizedBox(
  //                                   //                                 width: 5,
  //                                   //                               ),
  //                                   //                               Text(
  //                                   //                                 'GTA 5',
  //                                   //                                 style:
  //                                   //                                     TextStyle(fontSize: 15),
  //                                   //                               ),
  //                                   //                             ],
  //                                   //                           ),
  //                                   //                         ),
  //                                   //                         decoration: BoxDecoration(
  //                                   //                             color: Colors.white
  //                                   //                                 .withOpacity(0.3),
  //                                   //                             borderRadius:
  //                                   //                                 BorderRadius.circular(30)),
  //                                   //                       ),
  //                                   //                     ),
  //                                   //                   ),
  //                                   //                 );
  //                                   //               }),
  //                                   //             ),
  //                                   //           ),
  //                                   //           SizedBox(
  //                                   //             height: 10,
  //                                   //           ),

  //                                   //           // Container(
  //                                   //           //   height: 30,
  //                                   //           //   child: ListView.builder(
  //                                   //           //     itemCount: 3,
  //                                   //           //     physics: BouncingScrollPhysics(),
  //                                   //           //     shrinkWrap: true,
  //                                   //           //     scrollDirection: Axis.horizontal,
  //                                   //           //     itemBuilder: (context, index) {
  //                                   //           //       return Padding(
  //                                   //           //         padding: const EdgeInsets.symmetric(
  //                                   //           //             horizontal: 3),
  //                                   //           //         child: Container(
  //                                   //           //           child: Center(
  //                                   //           //               child: Padding(
  //                                   //           //             padding: const EdgeInsets.symmetric(
  //                                   //           //                 horizontal: 15),
  //                                   //           //             child: Text('Kitap okuyorum'),
  //                                   //           //           )),
  //                                   //           //           decoration: BoxDecoration(
  //                                   //           //               color:
  //                                   //           //                   Colors.white.withOpacity(0.5),
  //                                   //           //               borderRadius:
  //                                   //           //                   BorderRadius.circular(30)),
  //                                   //           //         ),
  //                                   //           //       );
  //                                   //           //     },
  //                                   //           //   ),
  //                                   //           // )
  //                                   //         ],
  //                                   //       ),
  //                                   //     ),
  //                                   //     decoration: BoxDecoration(
  //                                   //         borderRadius: BorderRadius.circular(30)),
  //                                   //   ),
  //                                   // )
  //                                 ],
  //                               ),
  //                               Positioned(
  //                                 top: 50,
  //                                 right: 0,
  //                                 left: 0,
  //                                 child: Stack(
  //                                   alignment: AlignmentDirectional.center,
  //                                   children: [
  //                                     user.data!.data()!['avatarIsAsset']
  //                                         ? CircleAvatar(
  //                                             radius: 50,
  //                                             backgroundColor:
  //                                                 Colors.transparent,
  //                                             backgroundImage: AssetImage(
  //                                                 user.data!.data()!['avatar']),
  //                                           )
  //                                         : CircleAvatar(
  //                                             radius: 50,
  //                                             backgroundColor:
  //                                                 Colors.transparent,
  //                                             backgroundImage: NetworkImage(
  //                                                 user.data!.data()!['avatar']),
  //                                           ),
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(top: 20),
  //                                       child: Container(
  //                                         height: 150,
  //                                         width: 130,
  //                                         decoration: BoxDecoration(
  //                                             image: DecorationImage(
  //                                                 image: AssetImage(
  //                                                     'assets/covers/level-${user.data!.data()!['cover']}.png'))),
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                                 // child: Container(
  //                                 //   decoration: BoxDecoration(
  //                                 //       image: DecorationImage(
  //                                 //           image: AssetImage('assets/10.png'))),
  //                                 //   child: CircleAvatar(
  //                                 //     radius: 50,
  //                                 //     backgroundColor: Colors.red,
  //                                 //   ),
  //                                 // ),
  //                               ),
  //                               // Positioned(
  //                               //     top: 160,
  //                               //     left: 10,
  //                               //     child: Container(
  //                               //       height: (Get.size.width - 50) / 3,
  //                               //       width: (Get.size.width - 120) / 3,
  //                               //       child: GridView(
  //                               //           children: [
  //                               //             Padding(
  //                               //               padding: const EdgeInsets.all(6),
  //                               //               child: Image.asset('assets/medal.png'),
  //                               //             ),
  //                               //             Padding(
  //                               //               padding: const EdgeInsets.all(6),
  //                               //               child: Image.asset('assets/medal.png'),
  //                               //             ),
  //                               //             Padding(
  //                               //               padding: const EdgeInsets.all(6),
  //                               //               child: Image.asset('assets/medal.png'),
  //                               //             ),
  //                               //           ],
  //                               //           gridDelegate:
  //                               //               SliverGridDelegateWithFixedCrossAxisCount(
  //                               //                   crossAxisCount: 2)),
  //                               //     )),
  //                               Positioned(
  //                                   top: 10,
  //                                   right: 10,
  //                                   child: Container(
  //                                     height: 30,
  //                                     width: 110,
  //                                     // width: (Get.size.width - 80),
  //                                     child: ListView(
  //                                       reverse: true,
  //                                       scrollDirection: Axis.horizontal,
  //                                       children: [
  //                                         user.data!.data()!['pc']
  //                                             ? Image.asset(
  //                                                 'assets/pc.png',
  //                                                 height: 30,
  //                                                 width: 30,
  //                                               )
  //                                             : Opacity(
  //                                                 opacity: 0.3,
  //                                                 child: Image.asset(
  //                                                   'assets/pc.png',
  //                                                   height: 30,
  //                                                   width: 30,
  //                                                 ),
  //                                               ),
  //                                         SizedBox(
  //                                           width: 10,
  //                                         ),
  //                                         user.data!.data()!['ps']
  //                                             ? Image.asset(
  //                                                 'assets/ps.png',
  //                                                 height: 30,
  //                                                 width: 30,
  //                                               )
  //                                             : Opacity(
  //                                                 opacity: 0.3,
  //                                                 child: Image.asset(
  //                                                   'assets/ps.png',
  //                                                   height: 30,
  //                                                   width: 30,
  //                                                 ),
  //                                               ),
  //                                         SizedBox(
  //                                           width: 10,
  //                                         ),
  //                                         user.data!.data()!['mobile']
  //                                             ? Image.asset(
  //                                                 'assets/mobil-icon.png',
  //                                                 height: 30,
  //                                                 width: 30,
  //                                               )
  //                                             : Opacity(
  //                                                 opacity: 0.3,
  //                                                 child: Image.asset(
  //                                                   'assets/mobil-icon.png',
  //                                                   height: 30,
  //                                                   width: 30,
  //                                                 ),
  //                                               ),
  //                                       ],
  //                                     ),
  //                                   )),
  //                               Positioned(
  //                                 child: user.data!.data()!['headphone']
  //                                     ? Image.asset(
  //                                         'assets/headset.png',
  //                                         height: 30,
  //                                         width: 30,
  //                                       )
  //                                     : Opacity(
  //                                         opacity: 0.3,
  //                                         child: Image.asset(
  //                                           'assets/headset.png',
  //                                           height: 30,
  //                                           width: 30,
  //                                         ),
  //                                       ),
  //                                 top: 10,
  //                                 left: 10,
  //                               ),
  //                               // Positioned(
  //                               //   child: GestureDetector(
  //                               //     child: Icon(Icons.settings),
  //                               //     onTap: () {
  //                               //       Get.to(() => Settings());
  //                               //     },
  //                               //   ),
  //                               //   top: 10,
  //                               //   right: 10,
  //                               // )
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   : CircularPercentIndicator(radius: 30);
  //             }),
  //       ),
  //     ),
  //   );
  // }
}

// class UserCard extends StatelessWidget {
//   final String id;
//   FirebaseApi firebaseApi = Get.find();

//   UserCard({Key? key, required this.id}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.blueGrey[200],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//       elevation: 5,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(30),
//         child: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [
//             Color(0xFFffe259),
//             Color(0xFFffa751),
//           ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//           child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//               future: firebaseApi.firestore.collection('Users').doc(id).get(),
//               builder: (context, user) {
//                 return user.hasData
//                     ? Stack(
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         children: [
//                           SingleChildScrollView(
//                             physics: BouncingScrollPhysics(),
//                             child: Stack(
//                               children: [
//                                 Column(
//                                   children: [
//                                     Container(
//                                       height: 180,
//                                       decoration: BoxDecoration(
//                                           color: Colors.amber,
//                                           image: user.data!.data()!['hasBack']
//                                               ? DecorationImage(
//                                                   image: NetworkImage(user.data!
//                                                       .data()!['back']),
//                                                   fit: BoxFit.cover)
//                                               : DecorationImage(
//                                                   image: AssetImage(
//                                                       'assets/gta5back.jpg'),
//                                                   fit: BoxFit.cover)),
//                                     ),
//                                     Container(
//                                       width: (Get.size.width - 40),
//                                       child: Column(
//                                         children: [
//                                           SizedBox(
//                                             height: 15,
//                                           ),
//                                           Text(
//                                             '${user.data!.data()!['name']}, ${user.data!.data()!['age']}',
//                                             textAlign: TextAlign.center,
//                                             style:
//                                                 GoogleFonts.acme(fontSize: 25),
//                                           ),
//                                           SizedBox(
//                                             height: 2,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 child: Padding(
//                                                   padding: const EdgeInsets
//                                                           .symmetric(
//                                                       horizontal: 8,
//                                                       vertical: 3),
//                                                   child: Text(
//                                                     'Lvl ${user.data!.data()!['level']}',
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                 ),
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.red,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10)),
//                                               ),
//                                               SizedBox(
//                                                 width: 5,
//                                               ),
//                                               Text(
//                                                 '${user.data!.data()!['country']}, ${user.data!.data()!['city']}',
//                                                 textAlign: TextAlign.center,
//                                                 style: GoogleFonts.acme(
//                                                     fontSize: 15),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10),
//                                       child: FutureBuilder<
//                                               QuerySnapshot<
//                                                   Map<String, dynamic>>>(
//                                           future: firebaseApi.firestore
//                                               .collection('Users')
//                                               .doc(firebaseApi
//                                                   .auth.currentUser!.uid)
//                                               .collection('Rosettes')
//                                               .get(),
//                                           builder: (context, rosettes) {
//                                             return rosettes.hasData
//                                                 ? rosettes.data!.docs.isNotEmpty
//                                                     ? Container(
//                                                         width: double.maxFinite,
//                                                         height: 50,
//                                                         decoration: BoxDecoration(
//                                                             color: Colors.white
//                                                                 .withOpacity(
//                                                                     0.2),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10)),
//                                                         child: ListView.builder(
//                                                           itemCount: rosettes
//                                                               .data!
//                                                               .docs
//                                                               .length,
//                                                           scrollDirection:
//                                                               Axis.horizontal,
//                                                           physics:
//                                                               BouncingScrollPhysics(),
//                                                           shrinkWrap: true,
//                                                           itemBuilder:
//                                                               (context, index) {
//                                                             return Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       20,
//                                                                   vertical: 5),
//                                                               child: Image.asset(
//                                                                   'assets/rosettes/${rosettes.data!.docs[index].data()['photo']}'),
//                                                             );
//                                                           },
//                                                         ),
//                                                       )
//                                                     : Container(
//                                                         width: double.maxFinite,
//                                                         decoration: BoxDecoration(
//                                                             color: Colors.white
//                                                                 .withOpacity(
//                                                                     0.2),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10)),
//                                                         height: 40,
//                                                         child: Center(
//                                                           child: Text(
//                                                               'Hiçbir rozeti yok',
//                                                               style: GoogleFonts.acme(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w100,
//                                                                   fontSize: 20,
//                                                                   color: Colors
//                                                                       .black)),
//                                                         ),
//                                                       )
//                                                 : CircularPercentIndicator(
//                                                     radius: 20);
//                                           }),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(10),
//                                       child: Container(
//                                         child: Column(
//                                           children: [
//                                             // Text(
//                                             //   'Hakkımda',
//                                             //   style: GoogleFonts.acme(
//                                             //       fontSize: 25),
//                                             // ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Text(
//                                                 '${user.data!.data()!['bio']}',
//                                                 textAlign: TextAlign.center,
//                                                 maxLines: 4,
//                                                 style: TextStyle(fontSize: 17),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             color:
//                                                 Colors.white.withOpacity(0.2)),
//                                       ),
//                                     ),
//                                     FutureBuilder<
//                                             QuerySnapshot<
//                                                 Map<String, dynamic>>>(
//                                         future: firebaseApi.firestore
//                                             .collection('Users')
//                                             .doc(firebaseApi
//                                                 .auth.currentUser!.uid)
//                                             .collection('Games')
//                                             .get(),
//                                         builder: (context, snapshot) {
//                                           return snapshot.hasData
//                                               ? snapshot.data!.docs.length != 0
//                                                   ? Container(
//                                                       width: double.maxFinite,
//                                                       height: 160,
//                                                       color: Colors.transparent,
//                                                       child: ListView.builder(
//                                                         itemCount: snapshot
//                                                             .data!.docs.length,
//                                                         scrollDirection:
//                                                             Axis.horizontal,
//                                                         physics:
//                                                             BouncingScrollPhysics(),
//                                                         shrinkWrap: true,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           return Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(4),
//                                                             child: AspectRatio(
//                                                               aspectRatio:
//                                                                   4 / 5,
//                                                               child: Card(
//                                                                 color: Colors
//                                                                     .transparent,
//                                                                 child: Stack(
//                                                                   fit: StackFit
//                                                                       .expand,
//                                                                   children: [
//                                                                     ClipRRect(
//                                                                       borderRadius:
//                                                                           BorderRadius.circular(
//                                                                               5),
//                                                                       child: Image
//                                                                           .network(
//                                                                         snapshot
//                                                                             .data!
//                                                                             .docs[index]['photo'],
//                                                                         fit: BoxFit
//                                                                             .cover,
//                                                                       ),
//                                                                     ),
//                                                                     Positioned(
//                                                                         bottom:
//                                                                             2,
//                                                                         left: 2,
//                                                                         child:
//                                                                             Row(
//                                                                           children: [
//                                                                             snapshot.data!.docs[index]['pc']
//                                                                                 ? ClipRRect(
//                                                                                     borderRadius: BorderRadius.circular(5),
//                                                                                     child: BackdropFilter(
//                                                                                       filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//                                                                                       child: Container(
//                                                                                           decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
//                                                                                           child: Padding(
//                                                                                             padding: const EdgeInsets.all(3),
//                                                                                             child: Image.asset(
//                                                                                               'assets/pc.png',
//                                                                                               height: 20,
//                                                                                               width: 20,
//                                                                                             ),
//                                                                                           )),
//                                                                                     ),
//                                                                                   )
//                                                                                 : Container(),
//                                                                             snapshot.data!.docs[index]['ps']
//                                                                                 ? SizedBox(
//                                                                                     width: 2,
//                                                                                   )
//                                                                                 : Container(),
//                                                                             snapshot.data!.docs[index]['ps']
//                                                                                 ? ClipRRect(
//                                                                                     borderRadius: BorderRadius.circular(5),
//                                                                                     child: BackdropFilter(
//                                                                                       filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//                                                                                       child: Container(
//                                                                                           decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
//                                                                                           child: Padding(
//                                                                                             padding: const EdgeInsets.all(3),
//                                                                                             child: Image.asset(
//                                                                                               'assets/ps.png',
//                                                                                               height: 20,
//                                                                                               width: 20,
//                                                                                             ),
//                                                                                           )),
//                                                                                     ),
//                                                                                   )
//                                                                                 : Container(),
//                                                                             snapshot.data!.docs[index]['mobile']
//                                                                                 ? SizedBox(
//                                                                                     width: 2,
//                                                                                   )
//                                                                                 : Container(),
//                                                                             snapshot.data!.docs[index]['mobile']
//                                                                                 ? ClipRRect(
//                                                                                     borderRadius: BorderRadius.circular(5),
//                                                                                     child: BackdropFilter(
//                                                                                       filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//                                                                                       child: Container(
//                                                                                           decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
//                                                                                           child: Padding(
//                                                                                             padding: const EdgeInsets.all(3),
//                                                                                             child: Image.asset(
//                                                                                               'assets/mobil-icon.png',
//                                                                                               height: 20,
//                                                                                               width: 20,
//                                                                                             ),
//                                                                                           )),
//                                                                                     ),
//                                                                                   )
//                                                                                 : Container(),
//                                                                           ],
//                                                                         ))
//                                                                   ],
//                                                                 ),
//                                                                 // child: Padding(
//                                                                 //   padding: const EdgeInsets.all(4),
//                                                                 //   child: Column(
//                                                                 //     mainAxisAlignment:
//                                                                 //         MainAxisAlignment.spaceBetween,
//                                                                 //     crossAxisAlignment: CrossAxisAlignment.center,
//                                                                 //     children: [
//                                                                 //       Expanded(
//                                                                 //         child: Column(
//                                                                 //           mainAxisAlignment:
//                                                                 //               MainAxisAlignment.spaceAround,
//                                                                 //           children: [
//                                                                 //             CircleAvatar(
//                                                                 //               backgroundColor: Colors.white,
//                                                                 //             ),
//                                                                 //             Text(
//                                                                 //               'Gta 5',
//                                                                 //               maxLines: 2,
//                                                                 //               overflow: TextOverflow.ellipsis,
//                                                                 //               style:
//                                                                 //                   GoogleFonts.acme(fontSize: 18),
//                                                                 //             ),
//                                                                 //           ],
//                                                                 //         ),
//                                                                 //       ),
//                                                                 //       Text(
//                                                                 //         'Level 21',
//                                                                 //         maxLines: 1,
//                                                                 //         overflow: TextOverflow.ellipsis,
//                                                                 //         style: GoogleFonts.acme(fontSize: 13),
//                                                                 //       )
//                                                                 //     ],
//                                                                 //   ),
//                                                                 // ),
//                                                               ),
//                                                             ),
//                                                           );
//                                                         },
//                                                       ),
//                                                     )
//                                                   : Container(
//                                                       width: double.maxFinite,
//                                                       height: 80,
//                                                       color: Colors.transparent,
//                                                       child: Center(
//                                                         child: Text(
//                                                           'Oyun eklenmedi',
//                                                           style:
//                                                               GoogleFonts.acme(
//                                                                   fontSize: 30,
//                                                                   color: Colors
//                                                                       .black),
//                                                         ),
//                                                       ),
//                                                     )
//                                               : Container(
//                                                   width: double.maxFinite,
//                                                   height: 80,
//                                                   color: Colors.transparent,
//                                                   child: Center(
//                                                     child: Text(
//                                                       'Oyun eklenmedi',
//                                                       style: GoogleFonts.acme(
//                                                           fontSize: 30,
//                                                           color: Colors.black),
//                                                     ),
//                                                   ),
//                                                 );
//                                         }),

//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Container(
//                                       width: double.maxFinite,
//                                       height: 150,
//                                       color: Colors.red,
//                                       child: Center(
//                                         child: Text('Steam api'),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10),
//                                       child: Container(
//                                         width: double.maxFinite,
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                             color:
//                                                 Colors.white.withOpacity(0.2),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: FutureBuilder<
//                                             QuerySnapshot<
//                                                 Map<String, dynamic>>>(
//                                           future: firebaseApi.firestore
//                                               .collection('Users')
//                                               .doc(firebaseApi
//                                                   .auth.currentUser!.uid)
//                                               .collection('Social')
//                                               .get(),
//                                           builder: (context, snapshot) {
//                                             return snapshot.hasData
//                                                 ? snapshot.data!.docs.length !=
//                                                         0
//                                                     ? ListView.builder(
//                                                         scrollDirection:
//                                                             Axis.horizontal,
//                                                         itemCount: snapshot
//                                                             .data!.docs.length,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           return Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                         .symmetric(
//                                                                     horizontal:
//                                                                         8,
//                                                                     vertical:
//                                                                         5),
//                                                             child: Material(
//                                                               elevation: 2,
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           30),
//                                                               color:
//                                                                   Colors.white,
//                                                               child: InkWell(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             30),
//                                                                 child:
//                                                                     Container(
//                                                                   child: Center(
//                                                                     child:
//                                                                         Padding(
//                                                                       padding: const EdgeInsets
//                                                                               .symmetric(
//                                                                           horizontal:
//                                                                               12,
//                                                                           vertical:
//                                                                               2),
//                                                                       child:
//                                                                           Row(
//                                                                         children: [
//                                                                           CircleAvatar(
//                                                                             backgroundColor:
//                                                                                 Colors.transparent,
//                                                                             backgroundImage:
//                                                                                 NetworkImage(
//                                                                               snapshot.data!.docs[index]['icon'],
//                                                                             ),
//                                                                             radius:
//                                                                                 15,
//                                                                           ),
//                                                                           Row(
//                                                                             children: [
//                                                                               Text(
//                                                                                 '${snapshot.data!.docs[index]['name']}',
//                                                                                 style: TextStyle(fontWeight: FontWeight.bold),
//                                                                               ),
//                                                                               // Text(
//                                                                               //   snapshot.data!.docs[index]['data'],
//                                                                               //   style: TextStyle(fontWeight: FontWeight.bold),
//                                                                               // ),
//                                                                             ],
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   decoration: BoxDecoration(
//                                                                       // boxShadow: [
//                                                                       //   BoxShadow(
//                                                                       //       color: Colors.grey
//                                                                       //           .withOpacity(0.3),
//                                                                       //       blurRadius: 2,
//                                                                       //       spreadRadius: 1,
//                                                                       //       offset: Offset(2, 2))
//                                                                       // ],
//                                                                       color: Colors.transparent,
//                                                                       borderRadius: BorderRadius.circular(30)),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           );
//                                                         },
//                                                       )
//                                                     : Center(
//                                                         child: Text(
//                                                           'Sosyal bağlantısı yok',
//                                                           style: TextStyle(
//                                                               fontSize: 20,
//                                                               color:
//                                                                   Colors.black),
//                                                         ),
//                                                       )
//                                                 : Container();
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             GestureDetector(
//                                               // onTap: () async {
//                                               //   TimeRange time =
//                                               //       await showTimeRangePicker(
//                                               //           context: context,
//                                               //           padding: 50,
//                                               //           strokeWidth: 8,
//                                               //           fromText: 'Başlangıç',
//                                               //           toText: 'Bitiş',
//                                               //           handlerColor:
//                                               //               Colors.green[300],
//                                               //           end: TimeOfDay(
//                                               //               hour: firebaseApi
//                                               //                   .endHour.value,
//                                               //               minute: firebaseApi
//                                               //                   .endMinute.value),
//                                               //           handlerRadius: 15,
//                                               //           labels: [
//                                               //             ClockLabel(
//                                               //                 angle: 0,
//                                               //                 text: '18:00'),
//                                               //             ClockLabel(
//                                               //                 angle: 1.55,
//                                               //                 text: '00:00'),
//                                               //             ClockLabel(
//                                               //                 angle: 3.15,
//                                               //                 text: '06:00'),
//                                               //             ClockLabel(
//                                               //                 angle: 4.7,
//                                               //                 text: '12:00'),
//                                               //           ],
//                                               //           backgroundWidget:
//                                               //               CircleAvatar(
//                                               //             radius: 100,
//                                               //             backgroundColor:
//                                               //                 Colors.transparent,
//                                               //             child: Padding(
//                                               //               padding:
//                                               //                   EdgeInsets.all(20),
//                                               //               child: Image.asset(
//                                               //                   'assets/orta.png'),
//                                               //             ),
//                                               //           ),
//                                               //           ticks: 12,
//                                               //           autoAdjustLabels: true,
//                                               //           backgroundColor: Colors.red,
//                                               //           selectedColor: Colors.green,
//                                               //           disabledColor: Colors.grey,
//                                               //           start: TimeOfDay(
//                                               //               hour: firebaseApi
//                                               //                   .startHour.value,
//                                               //               minute: firebaseApi
//                                               //                   .startMinute
//                                               //                   .value));
//                                               //   if (time != null) {
//                                               //     firebaseApi.startHour.value =
//                                               //         time.startTime.hour;
//                                               //     firebaseApi.startMinute.value =
//                                               //         time.startTime.minute;
//                                               //     firebaseApi.endHour.value =
//                                               //         time.endTime.hour;
//                                               //     firebaseApi.endMinute.value =
//                                               //         time.endTime.minute;
//                                               //   }
//                                               // },
//                                               child: Container(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(10),
//                                                   child: Text(
//                                                     user.data!.data()![
//                                                                 'startMinute'] <
//                                                             10
//                                                         ? '${user.data!.data()!['startHour']}:0${user.data!.data()!['startMinute']}'
//                                                         : '${user.data!.data()!['startHour']}:${user.data!.data()!['startMinute']}',
//                                                     style:
//                                                         GoogleFonts.rationale(
//                                                             fontSize: 27,
//                                                             color:
//                                                                 Color.fromRGBO(
//                                                                     165,
//                                                                     255,
//                                                                     23,
//                                                                     1)),
//                                                   ),
//                                                 ),
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color: Colors.cyan),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     color:
//                                                         Colors.blueGrey[900]),
//                                               ),
//                                             ),
//                                             Text(
//                                               ' - ',
//                                               style: GoogleFonts.rationale(
//                                                   fontSize: 30),
//                                             ),
//                                             GestureDetector(
//                                               // onTap: () async {
//                                               //   TimeRange time =
//                                               //       await showTimeRangePicker(
//                                               //           context: context,
//                                               //           padding: 50,
//                                               //           strokeWidth: 8,
//                                               //           fromText: 'Başlangıç',
//                                               //           toText: 'Bitiş',
//                                               //           handlerColor:
//                                               //               Colors.green[300],
//                                               //           end: TimeOfDay(
//                                               //               hour: firebaseApi
//                                               //                   .endHour.value,
//                                               //               minute: firebaseApi
//                                               //                   .endMinute.value),
//                                               //           handlerRadius: 15,
//                                               //           labels: [
//                                               //             ClockLabel(
//                                               //                 angle: 0,
//                                               //                 text: '18:00'),
//                                               //             ClockLabel(
//                                               //                 angle: 1.55,
//                                               //                 text: '00:00'),
//                                               //             ClockLabel(
//                                               //                 angle: 3.15,
//                                               //                 text: '06:00'),
//                                               //             ClockLabel(
//                                               //                 angle: 4.7,
//                                               //                 text: '12:00'),
//                                               //           ],
//                                               //           backgroundWidget:
//                                               //               CircleAvatar(
//                                               //             radius: 100,
//                                               //             backgroundColor:
//                                               //                 Colors.transparent,
//                                               //             child: Padding(
//                                               //               padding:
//                                               //                   EdgeInsets.all(20),
//                                               //               child: Image.asset(
//                                               //                   'assets/orta.png'),
//                                               //             ),
//                                               //           ),
//                                               //           ticks: 12,
//                                               //           autoAdjustLabels: true,
//                                               //           backgroundColor: Colors.red,
//                                               //           selectedColor: Colors.green,
//                                               //           disabledColor: Colors.grey,
//                                               //           start: TimeOfDay(
//                                               //               hour: firebaseApi
//                                               //                   .startHour.value,
//                                               //               minute: firebaseApi
//                                               //                   .startMinute
//                                               //                   .value));
//                                               //   if (time != null) {
//                                               //     firebaseApi.startHour.value =
//                                               //         time.startTime.hour;
//                                               //     firebaseApi.startMinute.value =
//                                               //         time.startTime.minute;
//                                               //     firebaseApi.endHour.value =
//                                               //         time.endTime.hour;
//                                               //     firebaseApi.endMinute.value =
//                                               //         time.endTime.minute;
//                                               //   }
//                                               // },
//                                               child: Container(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(10),
//                                                   child: Text(
//                                                     user.data!.data()![
//                                                                 'endMinute'] <
//                                                             10
//                                                         ? '${user.data!.data()!['endHour']}:0${user.data!.data()!['endMinute']}'
//                                                         : '${user.data!.data()!['endHour']}:${user.data!.data()!['endMinute']}',
//                                                     style:
//                                                         GoogleFonts.rationale(
//                                                             fontSize: 27,
//                                                             color:
//                                                                 Color.fromRGBO(
//                                                                     165,
//                                                                     255,
//                                                                     23,
//                                                                     1)),
//                                                   ),
//                                                 ),
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color: Colors.cyan),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     color:
//                                                         Colors.blueGrey[900]),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 70,
//                                     )
//                                     // Padding(
//                                     //   padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
//                                     //   child: Container(
//                                     //     width: double.infinity,
//                                     //     child: Padding(
//                                     //       padding: const EdgeInsets.all(8.0),
//                                     //       child: Column(
//                                     //         mainAxisAlignment: MainAxisAlignment.start,
//                                     //         crossAxisAlignment:
//                                     //             CrossAxisAlignment.start,
//                                     //         children: [
//                                     //           Padding(
//                                     //             padding: const EdgeInsets.symmetric(
//                                     //                 horizontal: 10),
//                                     //             child: Text(
//                                     //               'Bos zamanimda:',
//                                     //               style: GoogleFonts.acme(fontSize: 17),
//                                     //             ),
//                                     //           ),
//                                     //           SizedBox(
//                                     //             height: 5,
//                                     //           ),
//                                     //           Container(
//                                     //             child: Wrap(
//                                     //               runSpacing: 7,
//                                     //               children: List.generate(3, (index) {
//                                     //                 return ClipRRect(
//                                     //                   borderRadius:
//                                     //                       BorderRadius.circular(30),
//                                     //                   child: BackdropFilter(
//                                     //                     filter: ImageFilter.blur(
//                                     //                         sigmaX: 5, sigmaY: 5),
//                                     //                     child: Padding(
//                                     //                       padding: const EdgeInsets
//                                     //                           .symmetric(horizontal: 3),
//                                     //                       child: Container(
//                                     //                         child: Padding(
//                                     //                           padding: const EdgeInsets
//                                     //                                   .symmetric(
//                                     //                               horizontal: 17,
//                                     //                               vertical: 7),
//                                     //                           child: Text(
//                                     //                               'Kitap okuyorum'),
//                                     //                         ),
//                                     //                         decoration: BoxDecoration(
//                                     //                             color: Colors.white
//                                     //                                 .withOpacity(0.3),
//                                     //                             borderRadius:
//                                     //                                 BorderRadius
//                                     //                                     .circular(30)),
//                                     //                       ),
//                                     //                     ),
//                                     //                   ),
//                                     //                 );
//                                     //               }),
//                                     //             ),
//                                     //           ),
//                                     //           // SizedBox(
//                                     //           //   height: 10,
//                                     //           // ),

//                                     //           // Container(
//                                     //           //   height: 30,
//                                     //           //   child: ListView.builder(
//                                     //           //     itemCount: 3,
//                                     //           //     physics: BouncingScrollPhysics(),
//                                     //           //     shrinkWrap: true,
//                                     //           //     scrollDirection: Axis.horizontal,
//                                     //           //     itemBuilder: (context, index) {
//                                     //           //       return Padding(
//                                     //           //         padding: const EdgeInsets.symmetric(
//                                     //           //             horizontal: 3),
//                                     //           //         child: Container(
//                                     //           //           child: Center(
//                                     //           //               child: Padding(
//                                     //           //             padding: const EdgeInsets.symmetric(
//                                     //           //                 horizontal: 15),
//                                     //           //             child: Text('Kitap okuyorum'),
//                                     //           //           )),
//                                     //           //           decoration: BoxDecoration(
//                                     //           //               color:
//                                     //           //                   Colors.white.withOpacity(0.5),
//                                     //           //               borderRadius:
//                                     //           //                   BorderRadius.circular(30)),
//                                     //           //         ),
//                                     //           //       );
//                                     //           //     },
//                                     //           //   ),
//                                     //           // )
//                                     //         ],
//                                     //       ),
//                                     //     ),
//                                     //     decoration: BoxDecoration(
//                                     //         borderRadius: BorderRadius.circular(30)),
//                                     //   ),
//                                     // ),
//                                     // Padding(
//                                     //   padding: const EdgeInsets.all(8.0),
//                                     //   child: Container(
//                                     //     width: double.infinity,
//                                     //     child: Padding(
//                                     //       padding: const EdgeInsets.all(8.0),
//                                     //       child: Column(
//                                     //         mainAxisAlignment: MainAxisAlignment.start,
//                                     //         crossAxisAlignment: CrossAxisAlignment.start,
//                                     //         children: [
//                                     //           Padding(
//                                     //             padding:
//                                     //                 const EdgeInsets.symmetric(horizontal: 10),
//                                     //             child: Text(
//                                     //               'Oyunlarım:',
//                                     //               style: GoogleFonts.acme(fontSize: 17),
//                                     //             ),
//                                     //           ),
//                                     //           SizedBox(
//                                     //             height: 5,
//                                     //           ),
//                                     //           Container(
//                                     //             height: 80,
//                                     //             child: Wrap(
//                                     //               runSpacing: 7,
//                                     //               children: List.generate(3, (index) {
//                                     //                 return ClipRRect(
//                                     //                   borderRadius: BorderRadius.circular(30),
//                                     //                   child: BackdropFilter(
//                                     //                     filter: ImageFilter.blur(
//                                     //                         sigmaX: 5, sigmaY: 5),
//                                     //                     child: Padding(
//                                     //                       padding: const EdgeInsets.symmetric(
//                                     //                           horizontal: 3),
//                                     //                       child: Container(
//                                     //                         child: Padding(
//                                     //                           padding:
//                                     //                               const EdgeInsets.symmetric(
//                                     //                                   horizontal: 17,
//                                     //                                   vertical: 7),
//                                     //                           child: Row(
//                                     //                             mainAxisSize: MainAxisSize.min,
//                                     //                             children: [
//                                     //                               CircleAvatar(
//                                     //                                 backgroundColor: Colors.red,
//                                     //                                 radius: 15,
//                                     //                               ),
//                                     //                               SizedBox(
//                                     //                                 width: 5,
//                                     //                               ),
//                                     //                               Text(
//                                     //                                 'GTA 5',
//                                     //                                 style:
//                                     //                                     TextStyle(fontSize: 15),
//                                     //                               ),
//                                     //                             ],
//                                     //                           ),
//                                     //                         ),
//                                     //                         decoration: BoxDecoration(
//                                     //                             color: Colors.white
//                                     //                                 .withOpacity(0.3),
//                                     //                             borderRadius:
//                                     //                                 BorderRadius.circular(30)),
//                                     //                       ),
//                                     //                     ),
//                                     //                   ),
//                                     //                 );
//                                     //               }),
//                                     //             ),
//                                     //           ),
//                                     //           SizedBox(
//                                     //             height: 10,
//                                     //           ),

//                                     //           // Container(
//                                     //           //   height: 30,
//                                     //           //   child: ListView.builder(
//                                     //           //     itemCount: 3,
//                                     //           //     physics: BouncingScrollPhysics(),
//                                     //           //     shrinkWrap: true,
//                                     //           //     scrollDirection: Axis.horizontal,
//                                     //           //     itemBuilder: (context, index) {
//                                     //           //       return Padding(
//                                     //           //         padding: const EdgeInsets.symmetric(
//                                     //           //             horizontal: 3),
//                                     //           //         child: Container(
//                                     //           //           child: Center(
//                                     //           //               child: Padding(
//                                     //           //             padding: const EdgeInsets.symmetric(
//                                     //           //                 horizontal: 15),
//                                     //           //             child: Text('Kitap okuyorum'),
//                                     //           //           )),
//                                     //           //           decoration: BoxDecoration(
//                                     //           //               color:
//                                     //           //                   Colors.white.withOpacity(0.5),
//                                     //           //               borderRadius:
//                                     //           //                   BorderRadius.circular(30)),
//                                     //           //         ),
//                                     //           //       );
//                                     //           //     },
//                                     //           //   ),
//                                     //           // )
//                                     //         ],
//                                     //       ),
//                                     //     ),
//                                     //     decoration: BoxDecoration(
//                                     //         borderRadius: BorderRadius.circular(30)),
//                                     //   ),
//                                     // )
//                                   ],
//                                 ),
//                                 Positioned(
//                                   top: 50,
//                                   right: 0,
//                                   left: 0,
//                                   child: Stack(
//                                     alignment: AlignmentDirectional.center,
//                                     children: [
//                                       user.data!.data()!['avatarIsAsset']
//                                           ? CircleAvatar(
//                                               radius: 50,
//                                               backgroundColor:
//                                                   Colors.transparent,
//                                               backgroundImage: AssetImage(
//                                                   user.data!.data()!['avatar']),
//                                             )
//                                           : CircleAvatar(
//                                               radius: 50,
//                                               backgroundColor:
//                                                   Colors.transparent,
//                                               backgroundImage: NetworkImage(
//                                                   user.data!.data()!['avatar']),
//                                             ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: 20),
//                                         child: Container(
//                                           height: 150,
//                                           width: 130,
//                                           decoration: BoxDecoration(
//                                               image: DecorationImage(
//                                                   image: AssetImage(
//                                                       'assets/covers/level-${user.data!.data()!['level']}.png'))),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   // child: Container(
//                                   //   decoration: BoxDecoration(
//                                   //       image: DecorationImage(
//                                   //           image: AssetImage('assets/10.png'))),
//                                   //   child: CircleAvatar(
//                                   //     radius: 50,
//                                   //     backgroundColor: Colors.red,
//                                   //   ),
//                                   // ),
//                                 ),
//                                 // Positioned(
//                                 //     top: 160,
//                                 //     left: 10,
//                                 //     child: Container(
//                                 //       height: (Get.size.width - 50) / 3,
//                                 //       width: (Get.size.width - 120) / 3,
//                                 //       child: GridView(
//                                 //           children: [
//                                 //             Padding(
//                                 //               padding: const EdgeInsets.all(6),
//                                 //               child: Image.asset('assets/medal.png'),
//                                 //             ),
//                                 //             Padding(
//                                 //               padding: const EdgeInsets.all(6),
//                                 //               child: Image.asset('assets/medal.png'),
//                                 //             ),
//                                 //             Padding(
//                                 //               padding: const EdgeInsets.all(6),
//                                 //               child: Image.asset('assets/medal.png'),
//                                 //             ),
//                                 //           ],
//                                 //           gridDelegate:
//                                 //               SliverGridDelegateWithFixedCrossAxisCount(
//                                 //                   crossAxisCount: 2)),
//                                 //     )),
//                                 Positioned(
//                                     top: 10,
//                                     right: 10,
//                                     child: Container(
//                                       height: 30,
//                                       width: 110,
//                                       // width: (Get.size.width - 80),
//                                       child: ListView(
//                                         reverse: true,
//                                         scrollDirection: Axis.horizontal,
//                                         children: [
//                                           user.data!.data()!['pc']
//                                               ? Image.asset(
//                                                   'assets/pc.png',
//                                                   height: 30,
//                                                   width: 30,
//                                                 )
//                                               : Opacity(
//                                                   opacity: 0.3,
//                                                   child: Image.asset(
//                                                     'assets/pc.png',
//                                                     height: 30,
//                                                     width: 30,
//                                                   ),
//                                                 ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           user.data!.data()!['ps']
//                                               ? Image.asset(
//                                                   'assets/ps.png',
//                                                   height: 30,
//                                                   width: 30,
//                                                 )
//                                               : Opacity(
//                                                   opacity: 0.3,
//                                                   child: Image.asset(
//                                                     'assets/ps.png',
//                                                     height: 30,
//                                                     width: 30,
//                                                   ),
//                                                 ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           user.data!.data()!['mobile']
//                                               ? Image.asset(
//                                                   'assets/mobil-icon.png',
//                                                   height: 30,
//                                                   width: 30,
//                                                 )
//                                               : Opacity(
//                                                   opacity: 0.3,
//                                                   child: Image.asset(
//                                                     'assets/mobil-icon.png',
//                                                     height: 30,
//                                                     width: 30,
//                                                   ),
//                                                 ),
//                                         ],
//                                       ),
//                                     )),
//                                 Positioned(
//                                   child: user.data!.data()!['headphone']
//                                       ? Image.asset(
//                                           'assets/headset.png',
//                                           height: 30,
//                                           width: 30,
//                                         )
//                                       : Opacity(
//                                           opacity: 0.3,
//                                           child: Image.asset(
//                                             'assets/headset.png',
//                                             height: 30,
//                                             width: 30,
//                                           ),
//                                         ),
//                                   top: 10,
//                                   left: 10,
//                                 ),
//                                 // Positioned(
//                                 //   child: GestureDetector(
//                                 //     child: Icon(Icons.settings),
//                                 //     onTap: () {
//                                 //       Get.to(() => Settings());
//                                 //     },
//                                 //   ),
//                                 //   top: 10,
//                                 //   right: 10,
//                                 // )
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     : CircularPercentIndicator(radius: 30);
//               }),
//         ),
//       ),
//     );
//   }
// }
