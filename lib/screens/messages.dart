import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/filterGetx.dart';
import 'package:gamehub/screens/message.dart';
import 'package:gamehub/screens/newLevel.dart';
import 'package:gamehub/screens/paired.dart';
import 'package:gamehub/screens/userprofile.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  FirebaseApi firebaseApi = Get.find();
  FilterGetx filterGetx = Get.find();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: AppBar(
              // primary: false,
              brightness:
                  context.isDarkMode ? Brightness.dark : Brightness.light,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              centerTitle: true,
              bottom: TabBar(
                labelColor:
                    context.isDarkMode ? Colors.white : Colors.grey[900],
                unselectedLabelColor: Colors.grey,
                labelStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 18.5),
                unselectedLabelStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 17),
                indicatorColor: Colors.transparent,
                indicatorWeight: 3,
                labelPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                tabs: [
                  // Tab(
                  //   iconMargin: EdgeInsets.zero,
                  //   // text: 'Mesajlar',
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //         width: 2,
                  //         height: 20,
                  //         color: Colors.transparent,
                  //       ),
                  //       Center(
                  //         child: Container(
                  //           child: Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 vertical: 8, horizontal: 12),
                  //             child: Text('Mesajlar'),
                  //           ),
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(20),
                  //               color: Colors.grey[200]),
                  //         ),
                  //       ),
                  //       Container(
                  //         width: 2,
                  //         height: 30,
                  //         color: Colors.transparent,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Text('Mesajlar'),
                  Tab(
                    iconMargin: EdgeInsets.zero,
                    // text: 'Mesajlar',
                    child: Container(
                      width: double.maxFinite,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Text(
                            'Mesajlar',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: context.isDarkMode
                              ? LinearGradient(
                                  colors: [
                                      Colors.grey[700]!, Colors.grey[800]!,
                                      // Colors.grey.withOpacity(0.15),
                                      // Colors.grey.withOpacity(0.10),
                                      // Colors.grey.withOpacity(0.05),
                                    ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight)
                              : LinearGradient(
                                  colors: [
                                      Color(0xFFdfe9f3),
                                      Colors.grey[100]!,
                                      // Colors.grey.withOpacity(0.15),
                                      // Colors.grey.withOpacity(0.10),
                                      // Colors.grey.withOpacity(0.05),
                                    ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight)),
                    ),
                  ),
                  Tab(
                    iconMargin: EdgeInsets.zero,
                    // text: 'Mesajlar',
                    child: Container(
                      width: double.maxFinite,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Text(
                            'Beğeniler',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: context.isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[100]!
                          // gradient: context.isDarkMode
                          //     ? LinearGradient(
                          //         colors: [
                          //             Colors.grey[700]!, Colors.grey[800]!,
                          //             // Colors.grey.withOpacity(0.15),
                          //             // Colors.grey.withOpacity(0.10),
                          //             // Colors.grey.withOpacity(0.05),
                          //           ],
                          //         begin: Alignment.centerLeft,
                          //         end: Alignment.centerRight)
                          //     : LinearGradient(
                          //         colors: [
                          //             Colors.grey[100]!, Color(0xFFdfe9f3),
                          //             // Colors.grey.withOpacity(0.15),
                          //             // Colors.grey.withOpacity(0.10),
                          //             // Colors.grey.withOpacity(0.05),
                          //           ],
                          //         begin: Alignment.centerLeft,
                          //         end: Alignment.centerRight)
                          ),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     // Container(
                      //     //   width: 2,
                      //     //   height: 30,
                      //     //   color: Colors.transparent,
                      //     // ),
                      //     Expanded(
                      //       child: Container(
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               vertical: 8, horizontal: 12),
                      //           child: Text('Seni beğenenler'),
                      //         ),
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20),
                      //             color: Colors.grey[200]),
                      //       ),
                      //     ),
                      //     // Container(
                      //     //   width: 2,
                      //     //   height: 30,
                      //     //   color: Colors.transparent,
                      //     // ),
                      //   ],
                      // ),
                    ),
                  ),
                  Tab(
                    iconMargin: EdgeInsets.zero,
                    // text: 'Mesajlar',
                    child: Container(
                      width: double.maxFinite,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Text(
                            'Popüler',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: context.isDarkMode
                              ? LinearGradient(
                                  colors: [
                                      Colors.grey[800]!, Colors.grey[700]!,
                                      // Colors.grey.withOpacity(0.15),
                                      // Colors.grey.withOpacity(0.10),
                                      // Colors.grey.withOpacity(0.05),
                                    ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight)
                              : LinearGradient(
                                  colors: [
                                      Colors.grey[100]!, Color(0xFFdfe9f3),
                                      // Colors.grey.withOpacity(0.15),
                                      // Colors.grey.withOpacity(0.10),
                                      // Colors.grey.withOpacity(0.05),
                                    ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight)),
                      // child: Row(
                    ),
                  ),
                  // Tab(
                  //   iconMargin: EdgeInsets.zero,
                  //   // text: 'Mesajlar',
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //         width: 2,
                  //         height: 30,
                  //         color: Colors.transparent,
                  //       ),
                  //       Center(
                  //         child: Container(
                  //           child: Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 vertical: 8, horizontal: 12),
                  //             child: Text('Populer Duolar'),
                  //           ),
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(20),
                  //               color: Colors.grey[200]),
                  //         ),
                  //       ),
                  //       Container(
                  //         width: 2,
                  //         height: 30,
                  //         color: Colors.transparent,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              backgroundColor:
                  context.isDarkMode ? Colors.grey[900] : Colors.white,
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
              // toolbarHeight: 100,
              // title: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       // height: 50,
              //       child: Center(
              //           child: Text('DuoGether',
              //               style: GoogleFonts.acme(
              //                   fontSize: 25, color: Colors.black))),
              //     ),
              //     // Container(
              //     //   height: 50,
              //     //   child: TabBar(
              //     //     labelColor: Colors.black,
              //     //     indicatorColor: Colors.grey,
              //     //     indicatorWeight: 3,
              //     //     labelPadding:
              //     //         EdgeInsets.symmetric(horizontal: 0, vertical: 2),
              //     //     tabs: [
              //     //       Tab(
              //     //         iconMargin: EdgeInsets.zero,
              //     //         // text: 'Mesajlar',
              //     //         child: Row(
              //     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     //           children: [
              //     //             Container(
              //     //               width: 2,
              //     //               height: 20,
              //     //               color: Colors.transparent,
              //     //             ),
              //     //             Center(
              //     //               child: Text('Mesajlar'),
              //     //             ),
              //     //             Container(
              //     //               width: 2,
              //     //               height: 30,
              //     //               color: Colors.grey,
              //     //             ),
              //     //           ],
              //     //         ),
              //     //       ),
              //     //       // Text('Mesajlar'),
              //     //       Tab(
              //     //         text: 'Seni beğenenler',
              //     //       ),
              //     //       Tab(
              //     //         iconMargin: EdgeInsets.zero,
              //     //         // text: 'Mesajlar',
              //     //         child: Row(
              //     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     //           children: [
              //     //             Container(
              //     //               width: 2,
              //     //               height: 30,
              //     //               color: Colors.grey,
              //     //             ),
              //     //             Center(
              //     //               child: Text('Populer Duolar'),
              //     //             ),
              //     //             Container(
              //     //               width: 2,
              //     //               height: 30,
              //     //               color: Colors.transparent,
              //     //             ),
              //     //           ],
              //     //         ),
              //     //       ),
              //     //     ],
              //     //   ),
              //     // )
              //   ],
              // ),
            ),
          ),
        ),
        body: Container(
          decoration: context.isDarkMode
              ? BoxDecoration(color: Colors.black)
              : BoxDecoration(
                  gradient: LinearGradient(colors: [
                  Color(0xFFffffff), Color(0xFFdfe9f3),
                  // Colors.grey.withOpacity(0.15),
                  // Colors.grey.withOpacity(0.10),
                  // Colors.grey.withOpacity(0.05),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          child: Column(
            children: [
              // TabBar(
              //   labelColor: Colors.black,
              //   indicatorColor: Colors.grey,
              //   indicatorWeight: 3,
              //   labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
              //   tabs: [
              //     Tab(
              //       iconMargin: EdgeInsets.zero,
              //       // text: 'Mesajlar',
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             width: 2,
              //             height: 20,
              //             color: Colors.transparent,
              //           ),
              //           Center(
              //             child: Text('Mesajlar'),
              //           ),
              //           Container(
              //             width: 2,
              //             height: 30,
              //             color: Colors.grey,
              //           ),
              //         ],
              //       ),
              //     ),
              //     // Text('Mesajlar'),
              //     Tab(
              //       text: 'Seni beğenenler',
              //     ),
              //     Tab(
              //       iconMargin: EdgeInsets.zero,
              //       // text: 'Mesajlar',
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             width: 2,
              //             height: 30,
              //             color: Colors.grey,
              //           ),
              //           Center(
              //             child: Text('Populer Duolar'),
              //           ),
              //           Container(
              //             width: 2,
              //             height: 30,
              //             color: Colors.transparent,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              Expanded(
                child: TabBarView(physics: BouncingScrollPhysics(), children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110 + MediaQuery.of(context).padding.top,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: context.isDarkMode
                                    ? Colors.grey[100]!.withOpacity(0.15)
                                    : Colors.grey[100]!.withOpacity(0.7)),
                            height: 110,
                            child: StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                stream: firebaseApi.firestore
                                    .collection('Pairs')
                                    .where('paired', isEqualTo: true)
                                    .where('hasMessage', isEqualTo: false)
                                    .where('members',
                                        arrayContains:
                                            firebaseApi.auth.currentUser!.uid)
                                    // .where('to',
                                    //     isEqualTo:
                                    //         firebaseApi.auth.currentUser!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.docs.isNotEmpty) {
                                      if (firebaseApi.first) {
                                        firebaseApi.first = false;
                                        firebaseApi.firestore
                                            .collection('Users')
                                            .doc(firebaseApi
                                                .auth.currentUser!.uid)
                                            .collection('Rosettes')
                                            .where('name',
                                                isEqualTo:
                                                    Utils.ilkeslesme['name']!)
                                            .get()
                                            .then((value) async {
                                          if (value.docs.isEmpty) {
                                            Get.snackbar('Başarı kazandın',
                                                Utils.ilkeslesme['name']!,
                                                icon: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Icon(
                                                    Icons.emoji_events_outlined,
                                                    size: 35,
                                                  ),
                                                ));
                                            await firebaseApi.firestore
                                                .collection('Users')
                                                .doc(firebaseApi
                                                    .auth.currentUser!.uid)
                                                .collection('Rosettes')
                                                .add({
                                              'name': Utils.ilkeslesme['name']!,
                                              'photo':
                                                  Utils.ilkeslesme['photo']!,
                                            });
                                            await firebaseApi.firestore
                                                .collection('Users')
                                                .doc(firebaseApi
                                                    .auth.currentUser!.uid)
                                                .get()
                                                .then((value) async {
                                              int exp = value.data()!['exp'];
                                              int level =
                                                  value.data()!['level'];
                                              int newExp = exp + 100;
                                              int newLevel =
                                                  Utils().getLevel(newExp);
                                              await firebaseApi.firestore
                                                  .collection('Users')
                                                  .doc(firebaseApi
                                                      .auth.currentUser!.uid)
                                                  .update({'exp': newExp});
                                              if (level != newLevel) {
                                                //yeni seviyye
                                                await firebaseApi.firestore
                                                    .collection('Users')
                                                    .doc(firebaseApi
                                                        .auth.currentUser!.uid)
                                                    .update(
                                                        {'level': newLevel});
                                                Get.to(() =>
                                                    NewLevel(level: newLevel));
                                              }
                                            });
                                          }
                                        });
                                      }
                                      if (snapshot.data!.docs.length > 9) {
                                        if (firebaseApi.tens) {
                                          firebaseApi.tens = false;
                                          firebaseApi.firestore
                                              .collection('Users')
                                              .doc(firebaseApi
                                                  .auth.currentUser!.uid)
                                              .collection('Rosettes')
                                              .where('name',
                                                  isEqualTo:
                                                      Utils.populeruye['name']!)
                                              .get()
                                              .then((value) async {
                                            if (value.docs.isEmpty) {
                                              Get.snackbar('Başarı kazandın',
                                                  Utils.populeruye['name']!,
                                                  icon: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Icon(
                                                      Icons
                                                          .emoji_events_outlined,
                                                      size: 35,
                                                    ),
                                                  ));
                                              await firebaseApi.firestore
                                                  .collection('Users')
                                                  .doc(firebaseApi
                                                      .auth.currentUser!.uid)
                                                  .collection('Rosettes')
                                                  .add({
                                                'name':
                                                    Utils.populeruye['name']!,
                                                'photo':
                                                    Utils.populeruye['photo']!,
                                              });
                                              await firebaseApi.firestore
                                                  .collection('Users')
                                                  .doc(firebaseApi
                                                      .auth.currentUser!.uid)
                                                  .get()
                                                  .then((value) async {
                                                int exp = value.data()!['exp'];
                                                int level =
                                                    value.data()!['level'];
                                                int newExp = exp + 200;
                                                int newLevel =
                                                    Utils().getLevel(newExp);
                                                await firebaseApi.firestore
                                                    .collection('Users')
                                                    .doc(firebaseApi
                                                        .auth.currentUser!.uid)
                                                    .update({'exp': newExp});
                                                if (level != newLevel) {
                                                  //yeni seviyye
                                                  await firebaseApi.firestore
                                                      .collection('Users')
                                                      .doc(firebaseApi.auth
                                                          .currentUser!.uid)
                                                      .update(
                                                          {'level': newLevel});
                                                  Get.to(() => NewLevel(
                                                      level: newLevel));
                                                }
                                              });
                                            }
                                          });
                                        }
                                      }
                                    }
                                  }
                                  return snapshot.hasData
                                      ? snapshot.data!.docs.length != 0
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: ListView.separated(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                cacheExtent:
                                                    snapshot.data!.docs.length *
                                                        100,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Container();
                                                  // return Padding(
                                                  //   padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                                                  //   child: Container(
                                                  //     width: 1.5,
                                                  //     color: Colors.grey[300],
                                                  //   ),
                                                  // );
                                                },
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  List<dynamic> m = snapshot
                                                      .data!.docs[index]
                                                      .data()['members'];
                                                  m.remove(firebaseApi
                                                      .auth.currentUser!.uid);
                                                  print(m.length);
                                                  print(m.first);
                                                  return FutureBuilder<
                                                          DocumentSnapshot<
                                                              Map<String,
                                                                  dynamic>>>(
                                                      future: firebaseApi
                                                          .firestore
                                                          .collection('Users')
                                                          .doc(m.first)
                                                          .get(),
                                                      builder: (context, user) {
                                                        return user.hasData
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  firebaseApi
                                                                          .pairId =
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id;
                                                                  Get.to(
                                                                      () =>
                                                                          Message(
                                                                            avatar:
                                                                                user.data!.data()!['avatar'],
                                                                            avatarIsAsset:
                                                                                user.data!.data()!['avatarIsAsset'],
                                                                            id: m.first,
                                                                            name:
                                                                                user.data!.data()!['name'],
                                                                            pairId:
                                                                                snapshot.data!.docs[index].id,
                                                                          ),
                                                                      transition:
                                                                          Transition
                                                                              .cupertino);
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5),
                                                                      child:
                                                                          // user.data!.data()!['avatarIsAsset'] ??
                                                                          true
                                                                              ? CircleAvatar(
                                                                                  radius: 35,
                                                                                  backgroundColor: user.data!.data()!['avatar'] == 'assets/user.png' ? Colors.white : Colors.transparent,
                                                                                  backgroundImage: AssetImage(user.data!.data()!['avatar']),
                                                                                )
                                                                              : CircleAvatar(
                                                                                  radius: 35,
                                                                                  backgroundColor: user.data!.data()!['avatar'] == 'assets/user.png' ? Colors.white : Colors.transparent,
                                                                                  backgroundImage: NetworkImage(user.data!.data()!['avatar']),
                                                                                ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Text(
                                                                      user.data!.data()!['name'].toString().length >
                                                                              8
                                                                          ? "${user.data!.data()!['name'].toString().substring(0, 7)}..."
                                                                          : user
                                                                              .data!
                                                                              .data()!['name'],
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : Container();
                                                      });
                                                },
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                'Yeni eşleşme yok',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 30,
                                                    color: context.isDarkMode
                                                        ? Colors.white
                                                        : Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                      : CircularPercentIndicator(radius: 20);
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                                color: context.isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Container(
                              // height: 90,
                              child: StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  stream: firebaseApi.firestore
                                      .collection('Pairs')
                                      .where('paired', isEqualTo: true)
                                      .where('hasMessage', isEqualTo: true)
                                      .where('members',
                                          arrayContains:
                                              firebaseApi.auth.currentUser!.uid)
                                      .orderBy('lastDate', descending: true)
                                      // .where('to',
                                      //     isEqualTo: firebaseApi
                                      //         .auth.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data!.docs.length);
                                    }
                                    return snapshot.hasData
                                        ? snapshot.data!.docs.length != 0
                                            ? ListView.separated(
                                                padding: EdgeInsets.zero,
                                                cacheExtent:
                                                    snapshot.data!.docs.length *
                                                        200,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    child: Container(
                                                      height: 2,
                                                      decoration: BoxDecoration(
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.grey[900]
                                                              : Colors
                                                                  .grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                    ),
                                                  );
                                                },
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  List<dynamic> m = snapshot
                                                      .data!.docs[index]
                                                      .data()['members'];
                                                  m.remove(firebaseApi
                                                      .auth.currentUser!.uid);
                                                  print(m.first);
                                                  return StreamBuilder<
                                                          DocumentSnapshot<
                                                              Map<String,
                                                                  dynamic>>>(
                                                      stream: firebaseApi
                                                          .firestore
                                                          .collection('Users')
                                                          .doc(m.first)
                                                          .snapshots(),
                                                      builder: (context, user) {
                                                        return user.hasData
                                                            ? Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        5),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    firebaseApi
                                                                            .pairId =
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .id;
                                                                    Get.to(
                                                                        () =>
                                                                            Message(
                                                                              avatar: user.data!.data()!['avatar'],
                                                                              avatarIsAsset: user.data!.data()!['avatarIsAsset'],
                                                                              id: m.first,
                                                                              name: user.data!.data()!['name'],
                                                                              pairId: snapshot.data!.docs[index].id,
                                                                            ),
                                                                        transition:
                                                                            Transition.cupertino);
                                                                  },
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.all(10),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            user.data!.data()!['avatarIsAsset']
                                                                                ? CircleAvatar(
                                                                                    radius: 30,
                                                                                    backgroundColor: user.data!.data()!['avatar'] == 'assets/user.png' ? Colors.white : Colors.transparent,
                                                                                    backgroundImage: AssetImage(user.data!.data()!['avatar']),
                                                                                  )
                                                                                : CircleAvatar(
                                                                                    radius: 30,
                                                                                    backgroundColor: user.data!.data()!['avatar'] == 'assets/user.png' ? Colors.white : Colors.transparent,
                                                                                    backgroundImage: NetworkImage(user.data!.data()!['avatar']),
                                                                                  ),
                                                                            SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                            Expanded(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        user.data!.data()!['name'],
                                                                                        style: TextStyle(fontSize: 22, color: context.isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 8,
                                                                                      ),
                                                                                      snapshot.data!.docs[index]['lastSender'] != firebaseApi.auth.currentUser!.uid && snapshot.data!.docs[index]['new']
                                                                                          ? CircleAvatar(
                                                                                              radius: 4,
                                                                                              backgroundColor: Colors.red,
                                                                                            )
                                                                                          : Container()
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 4,
                                                                                  ),
                                                                                  Text(snapshot.data!.docs[index].data()['lastMessage'], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 17, color: context.isDarkMode ? Colors.grey[100] : Colors.grey[900]))
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                20),
                                                                            color: context.isDarkMode
                                                                                ? Colors.white.withOpacity(0.1)
                                                                                : Colors.white.withOpacity(0.3)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : Container();
                                                      });
                                                },
                                              )
                                            : Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      child: Image.asset(
                                                          'assets/message.png'),
                                                      height: 80,
                                                      width: 80,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Henüz bir mesajınız yok',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              )
                                        : Container();
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: firebaseApi.firestore
                          .collection('Pairs')
                          .where('paired', isEqualTo: false)
                          .where('to',
                              isEqualTo: firebaseApi.auth.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? snapshot.data!.docs.length != 0
                                ? GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 5 / 7,
                                    ),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      List<dynamic> m = snapshot
                                          .data!.docs[index]
                                          .data()['members'];
                                      m.remove(
                                          firebaseApi.auth.currentUser!.uid);
                                      return FutureBuilder<
                                              DocumentSnapshot<
                                                  Map<String, dynamic>>>(
                                          future: firebaseApi.firestore
                                              .collection('Users')
                                              .doc(m.first)
                                              .get(),
                                          builder: (context, user) {
                                            return user.hasData
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (snapshot.data!
                                                                  .docs[index]
                                                                  .data()[
                                                              'visible']) {
                                                            Get.to(
                                                                () => UserProfile(
                                                                    userId: user
                                                                        .data!
                                                                        .id),
                                                                transition:
                                                                    Transition
                                                                        .cupertino);
                                                          } else {
                                                            RewardedAd.load(
                                                                adUnitId:
                                                                    Utils.ad_id,
                                                                request:
                                                                    AdRequest(),
                                                                rewardedAdLoadCallback:
                                                                    RewardedAdLoadCallback(
                                                                        onAdLoaded:
                                                                            (add) {
                                                                          add.show(onUserEarnedReward:
                                                                              (add, item) {
                                                                            //give reward
                                                                            firebaseApi.firestore.collection('Pairs').doc(snapshot.data!.docs[index].id).update({
                                                                              'visible': true
                                                                            });
                                                                          });
                                                                        },
                                                                        onAdFailedToLoad:
                                                                            (add) {}));
                                                          }
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            snapshot.data!
                                                                        .docs[index]
                                                                        .data()[
                                                                    'visible']
                                                                ? Container(
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 120,
                                                                              width: double.maxFinite,
                                                                              child: user.data!.data()!['hasBack']
                                                                                  ? Image.asset(
                                                                                      user.data!.data()!['back'],
                                                                                      fit: BoxFit.cover,
                                                                                    )
                                                                                  : Image.asset(
                                                                                      user.data!.data()!['back'],
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                            ),
                                                                            Container(
                                                                              // width: (Get.size.width - 120) / 3,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            height: 15,
                                                                                          ),
                                                                                          Text(
                                                                                            '${user.data!.data()!['name']}, ${user.data!.data()!['age']}',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 2,
                                                                                          ),
                                                                                          Container(
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                                                              child: Text(
                                                                                                'Lvl ${user.data!.data()!['level']}',
                                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                            ),
                                                                                            decoration: BoxDecoration(color: Utils().getLevelColor(user.data!.data()!['level']), borderRadius: BorderRadius.circular(10)),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 4,
                                                                                          ),
                                                                                          !user.data!.data()!['showLocation']
                                                                                              ? Container()
                                                                                              : Text(
                                                                                                  '${user.data!.data()!['country']},\n${user.data!.data()!['city']}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: GoogleFonts.roboto(fontSize: 13, color: Colors.white),
                                                                                                ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Positioned(
                                                                          top:
                                                                              60,
                                                                          left:
                                                                              0,
                                                                          right:
                                                                              0,
                                                                          child:
                                                                              Stack(
                                                                            alignment:
                                                                                AlignmentDirectional.center,
                                                                            children: [
                                                                              user.data!.data()!['avatarIsAsset']
                                                                                  ? CircleAvatar(
                                                                                      radius: 25,
                                                                                      backgroundColor: user.data!.data()!['avatar'] == 'assets/user.png' ? Colors.white : Colors.transparent,
                                                                                      backgroundImage: AssetImage(user.data!.data()!['avatar']),
                                                                                    )
                                                                                  : CircleAvatar(
                                                                                      radius: 25,
                                                                                      backgroundColor: user.data!.data()!['avatar'] == 'assets/user.png' ? Colors.white : Colors.transparent,
                                                                                      backgroundImage: NetworkImage(user.data!.data()!['avatar']),
                                                                                    ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 15),
                                                                                child: Container(
                                                                                  height: 80,
                                                                                  width: 60,
                                                                                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/covers/level-${user.data!.data()!['cover']}.png'))),
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
                                                                        Positioned(
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              var data = await firebaseApi.firestore.collection('Pairs').where('from', isEqualTo: user.data!.id).where('to', isEqualTo: firebaseApi.auth.currentUser!.uid).get();
                                                                              if (data.docs.isNotEmpty) {
                                                                                print('Old');
                                                                                snapshot.data!.docs[index].reference.delete();
                                                                                return;
                                                                              }
                                                                              print('New');
                                                                              await firebaseApi.firestore.collection('Pairs').doc(snapshot.data!.docs[index].id).update({
                                                                                'paired': true
                                                                              });
                                                                              await firebaseApi.firestore
                                                                                  .collection('Users')
                                                                                  .doc(
                                                                                    user.data!.id,
                                                                                  )
                                                                                  .update({
                                                                                'ids': FieldValue.arrayUnion([
                                                                                  firebaseApi.auth.currentUser!.uid
                                                                                ])
                                                                              });
                                                                              filterGetx.generateCard();
                                                                              Get.to(
                                                                                  () => Paired(
                                                                                        name: user.data!.data()!['name'],
                                                                                        id: user.data!.id,
                                                                                        avatar: user.data!.data()!['avatar'],
                                                                                        avatarIsAsset: user.data!.data()!['avatarIsAsset'],
                                                                                        age: user.data!.data()!['age'],
                                                                                        pairId: snapshot.data!.docs[index].id,
                                                                                      ),
                                                                                  transition: Transition.noTransition);
                                                                            },
                                                                            child:
                                                                                CircleAvatar(
                                                                              backgroundColor: Colors.transparent,
                                                                              backgroundImage: AssetImage('assets/yes.png'),
                                                                              radius: 20,
                                                                            ),
                                                                          ),
                                                                          bottom:
                                                                              5,
                                                                          right:
                                                                              5,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20),
                                                                        color: Colors
                                                                            .grey[900]),
                                                                  )
                                                                : ImageFiltered(
                                                                    imageFilter: ImageFilter.blur(
                                                                        sigmaX:
                                                                            10,
                                                                        sigmaY:
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 120,
                                                                                width: double.maxFinite,
                                                                                child: user.data!.data()!['hasBack']
                                                                                    ? Image.asset(
                                                                                        user.data!.data()!['back'],
                                                                                        fit: BoxFit.cover,
                                                                                      )
                                                                                    : Image.asset(
                                                                                        user.data!.data()!['back'],
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                              ),
                                                                              Container(
                                                                                // width: (Get.size.width - 120) / 3,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                                                                  child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height: 15,
                                                                                            ),
                                                                                            Text(
                                                                                              '${user.data!.data()!['name']}, ${user.data!.data()!['age']}',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 2,
                                                                                            ),
                                                                                            Container(
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                                                                child: Text(
                                                                                                  'Lvl ${user.data!.data()!['level']}',
                                                                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                                ),
                                                                                              ),
                                                                                              decoration: BoxDecoration(color: Utils().getLevelColor(user.data!.data()!['level']), borderRadius: BorderRadius.circular(10)),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 4,
                                                                                            ),
                                                                                            !user.data!.data()!['showLocation']
                                                                                                ? Container()
                                                                                                : Text(
                                                                                                    '${user.data!.data()!['country']},\n${user.data!.data()!['city']}',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: GoogleFonts.roboto(fontSize: 13, color: Colors.white),
                                                                                                  ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Positioned(
                                                                            top:
                                                                                60,
                                                                            left:
                                                                                0,
                                                                            right:
                                                                                0,
                                                                            child:
                                                                                Stack(
                                                                              alignment: AlignmentDirectional.center,
                                                                              children: [
                                                                                user.data!.data()!['avatarIsAsset']
                                                                                    ? CircleAvatar(
                                                                                        radius: 25,
                                                                                        backgroundColor: user.data!.data()!['avatar'] == 'assets/user.png' ? Colors.white : Colors.transparent,
                                                                                        backgroundImage: AssetImage(user.data!.data()!['avatar']),
                                                                                      )
                                                                                    : CircleAvatar(
                                                                                        radius: 25,
                                                                                        backgroundColor: user.data!.data()!['avatar'] == 'assets/user.png' ? Colors.white : Colors.transparent,
                                                                                        backgroundImage: NetworkImage(user.data!.data()!['avatar']),
                                                                                      ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top: 15),
                                                                                  child: Container(
                                                                                    height: 80,
                                                                                    width: 60,
                                                                                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/covers/level-${user.data!.data()!['cover']}.png'))),
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
                                                                          Positioned(
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () async {
                                                                                var data = await firebaseApi.firestore.collection('Pairs').where('members', arrayContains: user.data!.id).where('members', arrayContains: firebaseApi.auth.currentUser!.uid).get();
                                                                                if (data.docs.isNotEmpty) {
                                                                                  print('Old');
                                                                                  snapshot.data!.docs[index].reference.delete();
                                                                                  return;
                                                                                }
                                                                                print('New');
                                                                                await firebaseApi.firestore.collection('Pairs').doc(snapshot.data!.docs[index].id).update({
                                                                                  'paired': true
                                                                                });
                                                                                await firebaseApi.firestore
                                                                                    .collection('Users')
                                                                                    .doc(
                                                                                      user.data!.id,
                                                                                    )
                                                                                    .update({
                                                                                  'ids': FieldValue.arrayUnion([
                                                                                    firebaseApi.auth.currentUser!.uid
                                                                                  ])
                                                                                });
                                                                                filterGetx.generateCard();
                                                                                Get.to(
                                                                                    () => Paired(
                                                                                          name: user.data!.data()!['name'],
                                                                                          id: user.data!.id,
                                                                                          avatar: user.data!.data()!['avatar'],
                                                                                          avatarIsAsset: user.data!.data()!['avatarIsAsset'],
                                                                                          age: user.data!.data()!['age'],
                                                                                          pairId: snapshot.data!.docs[index].id,
                                                                                        ),
                                                                                    transition: Transition.noTransition);
                                                                              },
                                                                              child: CircleAvatar(
                                                                                backgroundColor: Colors.transparent,
                                                                                backgroundImage: AssetImage('assets/yes.png'),
                                                                                radius: 20,
                                                                              ),
                                                                            ),
                                                                            bottom:
                                                                                5,
                                                                            right:
                                                                                5,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          color:
                                                                              Colors.grey[900]),
                                                                    ),
                                                                  ),
                                                            snapshot.data!
                                                                        .docs[index]
                                                                        .data()[
                                                                    'visible']
                                                                ? Container()
                                                                : Center(
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            'assets/lock.png',
                                                                            color:
                                                                                Colors.white,
                                                                            height:
                                                                                100,
                                                                            width:
                                                                                100,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                15,
                                                                          ),
                                                                          Text(
                                                                            'Kilidi açmak için reklam izleyin',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                GoogleFonts.josefinSans(color: Colors.white, fontSize: 25),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Center(
                                                    child:
                                                        CircularPercentIndicator(
                                                            radius: 20),
                                                  );
                                          });
                                    },
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/8.png',
                                          height: 80,
                                          width: 80,
                                          color: context.isDarkMode
                                              ? Colors.white
                                              : Colors.grey[900],
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text('Beğeni yok',
                                            style: GoogleFonts.roboto(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )
                            : Center(
                                child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator()));
                      }),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: firebaseApi.firestore
                          .collection('Users')
                          .where('finished', isEqualTo: true)
                          .where('id',
                              isNotEqualTo: firebaseApi.auth.currentUser!.uid)
                          .where('showInPopular', isEqualTo: true)
                          .limit(5)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? snapshot.data!.docs.length == 0
                                ? Center(
                                    child: Text('Tekrar yine gelin',
                                        style: GoogleFonts.roboto(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold)),
                                  )
                                : GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 5 / 7,
                                    ),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      List<dynamic> ids = snapshot
                                          .data!.docs[index]
                                          .data()['ids'];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  () => UserProfile(
                                                      userId: snapshot.data!
                                                          .docs[index].id),
                                                  transition:
                                                      Transition.cupertino);
                                            },
                                            child: Container(
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 120,
                                                        width: double.maxFinite,
                                                        child: snapshot.data!
                                                                    .docs[index]
                                                                    .data()[
                                                                'hasBack']
                                                            ? Image.asset(
                                                                snapshot.data!
                                                                    .docs[index]
                                                                    .data()['back'],
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                snapshot.data!
                                                                    .docs[index]
                                                                    .data()['back'],
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                      Container(
                                                        // width: (Get.size.width - 120) / 3,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 2,
                                                                  horizontal:
                                                                      5),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Text(
                                                                      '${snapshot.data!.docs[index].data()['name']}, ${snapshot.data!.docs[index].data()['age']}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                8,
                                                                            vertical:
                                                                                3),
                                                                        child:
                                                                            Text(
                                                                          'Lvl ${snapshot.data!.docs[index].data()['level']}',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                          color: Utils().getLevelColor(snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .data()['level']),
                                                                          borderRadius: BorderRadius.circular(10)),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 4,
                                                                    ),
                                                                    !snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .data()['showLocation']
                                                                        ? Container()
                                                                        : Text(
                                                                            '${snapshot.data!.docs[index].data()['country']},\n${snapshot.data!.docs[index].data()['city']}',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                GoogleFonts.roboto(fontSize: 13, color: Colors.white),
                                                                          ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      )
                                                    ],
                                                  ),
                                                  Positioned(
                                                    top: 60,
                                                    left: 0,
                                                    right: 0,
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      children: [
                                                        snapshot.data!
                                                                    .docs[index]
                                                                    .data()[
                                                                'avatarIsAsset']
                                                            ? CircleAvatar(
                                                                radius: 25,
                                                                backgroundColor: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .data()['avatar'] ==
                                                                        'assets/user.png'
                                                                    ? Colors.white
                                                                    : Colors.transparent,
                                                                backgroundImage:
                                                                    AssetImage(snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()['avatar']),
                                                              )
                                                            : CircleAvatar(
                                                                radius: 25,
                                                                backgroundColor: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .data()['avatar'] ==
                                                                        'assets/user.png'
                                                                    ? Colors.white
                                                                    : Colors.transparent,
                                                                backgroundImage:
                                                                    NetworkImage(snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()['avatar']),
                                                              ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15),
                                                          child: Container(
                                                            height: 80,
                                                            width: 60,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/covers/level-${snapshot.data!.docs[index].data()['cover']}.png'))),
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
                                                  !ids.contains(firebaseApi.auth
                                                          .currentUser!.uid)
                                                      ? Positioned(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              QuerySnapshot<
                                                                  Map<String,
                                                                      dynamic>> data = await firebaseApi
                                                                  .firestore
                                                                  .collection(
                                                                      'Pairs')
                                                                  .where('to',
                                                                      isEqualTo: firebaseApi
                                                                          .auth
                                                                          .currentUser!
                                                                          .uid)
                                                                  .where('from',
                                                                      isEqualTo: snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id)
                                                                  .get();
                                                              if (data.docs
                                                                  .isNotEmpty) {
                                                                await firebaseApi
                                                                    .firestore
                                                                    .collection(
                                                                        'Users')
                                                                    .doc(
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id,
                                                                    )
                                                                    .update({
                                                                  'ids': FieldValue
                                                                      .arrayUnion([
                                                                    firebaseApi
                                                                        .auth
                                                                        .currentUser!
                                                                        .uid
                                                                  ])
                                                                });
                                                                //eslesdin
                                                                await firebaseApi
                                                                    .firestore
                                                                    .collection(
                                                                        'Pairs')
                                                                    .doc(data
                                                                        .docs
                                                                        .first
                                                                        .id)
                                                                    .update({
                                                                  'paired': true
                                                                });
                                                                filterGetx
                                                                    .generateCard();
                                                                Get.to(
                                                                    () =>
                                                                        Paired(
                                                                          name: snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .data()['name'],
                                                                          id: snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .id,
                                                                          avatar: snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .data()['avatar'],
                                                                          avatarIsAsset: snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .data()['avatarIsAsset'],
                                                                          age: snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .data()['age'],
                                                                          pairId: data
                                                                              .docs
                                                                              .first
                                                                              .id,
                                                                        ),
                                                                    transition:
                                                                        Transition
                                                                            .noTransition);
                                                                //Get navigate
                                                              } else {
                                                                await firebaseApi
                                                                    .firestore
                                                                    .collection(
                                                                        'Users')
                                                                    .doc(
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id,
                                                                    )
                                                                    .update({
                                                                  'ids': FieldValue
                                                                      .arrayUnion([
                                                                    firebaseApi
                                                                        .auth
                                                                        .currentUser!
                                                                        .uid
                                                                  ])
                                                                });
                                                                //ilk tiklama
                                                                await firebaseApi
                                                                    .firestore
                                                                    .collection(
                                                                        'Pairs')
                                                                    .add({
                                                                  'paired':
                                                                      false,
                                                                  'visible':
                                                                      false,
                                                                  'to': snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id,
                                                                  'from': firebaseApi
                                                                      .auth
                                                                      .currentUser!
                                                                      .uid,
                                                                  'hasMessage':
                                                                      false,
                                                                  'lastMessage':
                                                                      '',
                                                                  firebaseApi
                                                                      .auth
                                                                      .currentUser!
                                                                      .uid: false,
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id: false,
                                                                  'date':
                                                                      DateTime
                                                                          .now(),
                                                                  'members': [
                                                                    firebaseApi
                                                                        .auth
                                                                        .currentUser!
                                                                        .uid,
                                                                    snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id
                                                                  ]
                                                                });
                                                                filterGetx
                                                                    .generateCard();
                                                              }
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'assets/yes.png'),
                                                              radius: 20,
                                                            ),
                                                          ),
                                                          bottom: 5,
                                                          right: 5,
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[900]),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                            : Center(
                                child: Text('Tekrar yine gelin',
                                    style: GoogleFonts.roboto(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold)),
                              );
                      }),
                  // GridView.builder(
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     childAspectRatio: 6 / 7,
                  //   ),
                  //   itemCount: 10,
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(20),
                  //         child: Container(
                  //           child: Stack(
                  //             children: [
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Expanded(
                  //                     child: Image.asset(
                  //                       'assets/gta5back.jpg',
                  //                       fit: BoxFit.cover,
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     // width: (Get.size.width - 120) / 3,
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.symmetric(
                  //                           vertical: 2, horizontal: 5),
                  //                       child: Row(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.end,
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                         children: [
                  //                           Expanded(
                  //                             child: Column(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               children: [
                  //                                 SizedBox(
                  //                                   height: 15,
                  //                                 ),
                  //                                 Text(
                  //                                   'Mehmet, 24',
                  //                                   textAlign: TextAlign.center,
                  //                                   style: GoogleFonts.acme(
                  //                                       fontSize: 20),
                  //                                 ),
                  //                                 SizedBox(
                  //                                   height: 2,
                  //                                 ),
                  //                                 Container(
                  //                                   child: Padding(
                  //                                     padding: const EdgeInsets
                  //                                             .symmetric(
                  //                                         horizontal: 8,
                  //                                         vertical: 3),
                  //                                     child: Text(
                  //                                       'Level 10',
                  //                                       style: TextStyle(
                  //                                           color: Colors.white,
                  //                                           fontWeight:
                  //                                               FontWeight
                  //                                                   .bold),
                  //                                     ),
                  //                                   ),
                  //                                   decoration: BoxDecoration(
                  //                                       color: Colors.red,
                  //                                       borderRadius:
                  //                                           BorderRadius
                  //                                               .circular(10)),
                  //                                 ),
                  //                                 SizedBox(
                  //                                   height: 4,
                  //                                 ),
                  //                                 Text(
                  //                                   'Turkey,\nIstanbul',
                  //                                   textAlign: TextAlign.start,
                  //                                   style: GoogleFonts.acme(
                  //                                       fontSize: 13),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                           GestureDetector(
                  //                             onTap: () {
                  //                               print('da');
                  //                             },
                  //                             child: CircleAvatar(
                  //                               backgroundColor:
                  //                                   Colors.transparent,
                  //                               backgroundImage: AssetImage(
                  //                                   'assets/yes.png'),
                  //                               radius: 25,
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 5,
                  //                   )
                  //                 ],
                  //               ),
                  //               Positioned(
                  //                 top: 40,
                  //                 left: 10,
                  //                 child: Stack(
                  //                   alignment: AlignmentDirectional.center,
                  //                   children: [
                  //                     CircleAvatar(
                  //                       radius: 25,
                  //                       backgroundColor: Colors.transparent,
                  //                       backgroundImage: AssetImage(
                  //                           'assets/avatars/kadın-4@2x.png'),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.only(top: 15),
                  //                       child: Container(
                  //                         height: 80,
                  //                         width: 60,
                  //                         decoration: BoxDecoration(
                  //                             image: DecorationImage(
                  //                                 image: AssetImage(
                  //                                     'assets/covers/level-10.png'))),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 // child: Container(
                  //                 //   decoration: BoxDecoration(
                  //                 //       image: DecorationImage(
                  //                 //           image: AssetImage('assets/10.png'))),
                  //                 //   child: CircleAvatar(
                  //                 //     radius: 50,
                  //                 //     backgroundColor: Colors.red,
                  //                 //   ),
                  //                 // ),
                  //               ),
                  //             ],
                  //           ),
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(20),
                  //               gradient: LinearGradient(
                  //                   begin: Alignment.topLeft,
                  //                   end: Alignment.bottomRight,
                  //                   colors: [
                  //                     Colors.red,
                  //                     Colors.redAccent,
                  //                     Colors.red
                  //                   ])),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // Container(
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(20),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               padding: EdgeInsets.all(10),
                  //               child: Row(
                  //                 children: [
                  //                   CircleAvatar(
                  //                     radius: 30,
                  //                     backgroundColor: Colors.orange,
                  //                     child: Icon(
                  //                       Icons.live_tv_rounded,
                  //                       size: 30,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 20,
                  //                   ),
                  //                   Expanded(
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Text(
                  //                           'Kilitli',
                  //                           style: TextStyle(
                  //                               fontSize: 22,
                  //                               color: Colors.white,
                  //                               fontWeight: FontWeight.bold),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 4,
                  //                         ),
                  //                         Text('Görmek için reklam izleyin',
                  //                             style: TextStyle(
                  //                                 fontSize: 17,
                  //                                 color: Colors.white))
                  //                       ],
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(20),
                  //                   color: Colors.redAccent),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Stack(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //       child: TCard(
                  //         lockYAxis: true,
                  //         delaySlideFor: 200,
                  //         cards: [card()],
                  //         size: MediaQuery.of(context).size,
                  //       ),
                  //     ),
                  //     Positioned(
                  //       bottom: 10,
                  //       right: 0,
                  //       left: 0,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           // Container(
                  //           //   height: 60,
                  //           //   width: 60,
                  //           //   child: Material(
                  //           //     color: Colors.transparent,
                  //           //     elevation: 0,
                  //           //     borderRadius: BorderRadius.circular(90),
                  //           //     child: InkWell(
                  //           //       radius: 30,
                  //           //       borderRadius: BorderRadius.circular(90),
                  //           //       onTap: () {},
                  //           //       child: Image.asset('assets/no.png'),
                  //           //     ),
                  //           //   ),
                  //           // ),
                  //           GestureDetector(
                  //             onTap: () {
                  //               print('net');
                  //               controller.forward();
                  //             },
                  //             child: CircleAvatar(
                  //               backgroundColor: Colors.transparent,
                  //               backgroundImage: AssetImage('assets/no.png'),
                  //               radius: 40,
                  //             ),
                  //           ),
                  //           GestureDetector(
                  //             onTap: () {
                  //               print('da');
                  //               print(controller.index);
                  //               controller.forward();
                  //             },
                  //             child: CircleAvatar(
                  //               backgroundColor: Colors.transparent,
                  //               backgroundImage: AssetImage('assets/yes.png'),
                  //               radius: 40,
                  //             ),
                  //           )
                  //           // FloatingActionButton(
                  //           //   onPressed: () {},
                  //           //   elevation: 1,
                  //           //   backgroundColor: Colors.redAccent,
                  //           //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //           //   child: Image.asset('assets/no.png'),
                  //           // ),
                  //           // FloatingActionButton(
                  //           //   onPressed: () {
                  //           //     controller.forward();
                  //           //   },
                  //           //   elevation: 0,
                  //           //   backgroundColor: Colors.transparent,
                  //           //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //           //   child: Image.asset(
                  //           //     'assets/yes.png',
                  //           //     width: 70,
                  //           //     height: 70,
                  //           //   ),
                  //           // ),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget card() {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(20),
  //     child: Container(
  //       child: Stack(
  //         clipBehavior: Clip.antiAliasWithSaveLayer,
  //         children: [
  //           SingleChildScrollView(
  //             physics: BouncingScrollPhysics(),
  //             child: Stack(
  //               children: [
  //                 Column(
  //                   children: [
  //                     Container(
  //                       height: 140,
  //                       decoration: BoxDecoration(
  //                           image: DecorationImage(
  //                               image: AssetImage('assets/gta5back.jpg'),
  //                               fit: BoxFit.cover),
  //                           color: Colors.amber,
  //                           borderRadius: BorderRadius.vertical(
  //                               top: Radius.circular(20))),
  //                     ),
  //                     Container(
  //                       width: (Get.size.width - 120) / 3,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 35,
  //                           ),
  //                           Text(
  //                             'Emre',
  //                             textAlign: TextAlign.center,
  //                             style: GoogleFonts.acme(fontSize: 25),
  //                           ),
  //                           SizedBox(
  //                             height: 2,
  //                           ),
  //                           Container(
  //                             child: Padding(
  //                               padding: const EdgeInsets.symmetric(
  //                                   horizontal: 8, vertical: 3),
  //                               child: Text(
  //                                 'Level 10',
  //                                 style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                             ),
  //                             decoration: BoxDecoration(
  //                                 color: Colors.red,
  //                                 borderRadius: BorderRadius.circular(10)),
  //                           ),
  //                           SizedBox(
  //                             height: 4,
  //                           ),
  //                           Text(
  //                             'Turkey, Istanbul\n28',
  //                             textAlign: TextAlign.center,
  //                             style: GoogleFonts.acme(fontSize: 13),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Container(
  //                       width: double.maxFinite,
  //                       height: 120,
  //                       color: Colors.red.withOpacity(0.15),
  //                       child: ListView.builder(
  //                         itemCount: 10,
  //                         scrollDirection: Axis.horizontal,
  //                         physics: BouncingScrollPhysics(),
  //                         shrinkWrap: true,
  //                         itemBuilder: (context, index) {
  //                           return Padding(
  //                             padding: const EdgeInsets.all(4),
  //                             child: AspectRatio(
  //                               aspectRatio: 4 / 5,
  //                               child: Card(
  //                                 color: Colors.transparent,
  //                                 child: Stack(
  //                                   fit: StackFit.expand,
  //                                   children: [
  //                                     ClipRRect(
  //                                       borderRadius: BorderRadius.circular(5),
  //                                       child: Image.asset(
  //                                         'assets/rdr2.jpeg',
  //                                         fit: BoxFit.cover,
  //                                       ),
  //                                     ),
  //                                     Positioned(
  //                                         bottom: 2,
  //                                         left: 2,
  //                                         child: ClipRRect(
  //                                           borderRadius:
  //                                               BorderRadius.circular(5),
  //                                           child: BackdropFilter(
  //                                             filter: ImageFilter.blur(
  //                                                 sigmaX: 2, sigmaY: 2),
  //                                             child: Container(
  //                                                 decoration: BoxDecoration(
  //                                                     color: Colors.white
  //                                                         .withOpacity(0.3),
  //                                                     borderRadius:
  //                                                         BorderRadius.circular(
  //                                                             5)),
  //                                                 child: Padding(
  //                                                   padding:
  //                                                       const EdgeInsets.all(3),
  //                                                   child: Image.asset(
  //                                                     'assets/pc.png',
  //                                                     height: 20,
  //                                                     width: 20,
  //                                                   ),
  //                                                 )),
  //                                           ),
  //                                         ))
  //                                   ],
  //                                 ),
  //                                 // child: Padding(
  //                                 //   padding: const EdgeInsets.all(4),
  //                                 //   child: Column(
  //                                 //     mainAxisAlignment:
  //                                 //         MainAxisAlignment.spaceBetween,
  //                                 //     crossAxisAlignment: CrossAxisAlignment.center,
  //                                 //     children: [
  //                                 //       Expanded(
  //                                 //         child: Column(
  //                                 //           mainAxisAlignment:
  //                                 //               MainAxisAlignment.spaceAround,
  //                                 //           children: [
  //                                 //             CircleAvatar(
  //                                 //               backgroundColor: Colors.white,
  //                                 //             ),
  //                                 //             Text(
  //                                 //               'Gta 5',
  //                                 //               maxLines: 2,
  //                                 //               overflow: TextOverflow.ellipsis,
  //                                 //               style:
  //                                 //                   GoogleFonts.acme(fontSize: 18),
  //                                 //             ),
  //                                 //           ],
  //                                 //         ),
  //                                 //       ),
  //                                 //       Text(
  //                                 //         'Level 21',
  //                                 //         maxLines: 1,
  //                                 //         overflow: TextOverflow.ellipsis,
  //                                 //         style: GoogleFonts.acme(fontSize: 13),
  //                                 //       )
  //                                 //     ],
  //                                 //   ),
  //                                 // ),
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Container(
  //                       width: double.maxFinite,
  //                       height: 150,
  //                       color: Colors.red,
  //                       child: Center(
  //                         child: Text('Steam api'),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         CircleAvatar(
  //                           backgroundColor: Colors.red,
  //                           radius: 30,
  //                         ),
  //                         Row(
  //                           children: [
  //                             Container(
  //                               height: 50,
  //                               width: 30,
  //                               color: Colors.red,
  //                             ),
  //                             SizedBox(
  //                               width: 2,
  //                             ),
  //                             Container(
  //                               height: 50,
  //                               width: 30,
  //                               color: Colors.red,
  //                             ),
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 70,
  //                     )
  //                     // Padding(
  //                     //   padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
  //                     //   child: Container(
  //                     //     width: double.infinity,
  //                     //     child: Padding(
  //                     //       padding: const EdgeInsets.all(8.0),
  //                     //       child: Column(
  //                     //         mainAxisAlignment: MainAxisAlignment.start,
  //                     //         crossAxisAlignment:
  //                     //             CrossAxisAlignment.start,
  //                     //         children: [
  //                     //           Padding(
  //                     //             padding: const EdgeInsets.symmetric(
  //                     //                 horizontal: 10),
  //                     //             child: Text(
  //                     //               'Bos zamanimda:',
  //                     //               style: GoogleFonts.acme(fontSize: 17),
  //                     //             ),
  //                     //           ),
  //                     //           SizedBox(
  //                     //             height: 5,
  //                     //           ),
  //                     //           Container(
  //                     //             child: Wrap(
  //                     //               runSpacing: 7,
  //                     //               children: List.generate(3, (index) {
  //                     //                 return ClipRRect(
  //                     //                   borderRadius:
  //                     //                       BorderRadius.circular(30),
  //                     //                   child: BackdropFilter(
  //                     //                     filter: ImageFilter.blur(
  //                     //                         sigmaX: 5, sigmaY: 5),
  //                     //                     child: Padding(
  //                     //                       padding: const EdgeInsets
  //                     //                           .symmetric(horizontal: 3),
  //                     //                       child: Container(
  //                     //                         child: Padding(
  //                     //                           padding: const EdgeInsets
  //                     //                                   .symmetric(
  //                     //                               horizontal: 17,
  //                     //                               vertical: 7),
  //                     //                           child: Text(
  //                     //                               'Kitap okuyorum'),
  //                     //                         ),
  //                     //                         decoration: BoxDecoration(
  //                     //                             color: Colors.white
  //                     //                                 .withOpacity(0.3),
  //                     //                             borderRadius:
  //                     //                                 BorderRadius
  //                     //                                     .circular(30)),
  //                     //                       ),
  //                     //                     ),
  //                     //                   ),
  //                     //                 );
  //                     //               }),
  //                     //             ),
  //                     //           ),
  //                     //           // SizedBox(
  //                     //           //   height: 10,
  //                     //           // ),

  //                     //           // Container(
  //                     //           //   height: 30,
  //                     //           //   child: ListView.builder(
  //                     //           //     itemCount: 3,
  //                     //           //     physics: BouncingScrollPhysics(),
  //                     //           //     shrinkWrap: true,
  //                     //           //     scrollDirection: Axis.horizontal,
  //                     //           //     itemBuilder: (context, index) {
  //                     //           //       return Padding(
  //                     //           //         padding: const EdgeInsets.symmetric(
  //                     //           //             horizontal: 3),
  //                     //           //         child: Container(
  //                     //           //           child: Center(
  //                     //           //               child: Padding(
  //                     //           //             padding: const EdgeInsets.symmetric(
  //                     //           //                 horizontal: 15),
  //                     //           //             child: Text('Kitap okuyorum'),
  //                     //           //           )),
  //                     //           //           decoration: BoxDecoration(
  //                     //           //               color:
  //                     //           //                   Colors.white.withOpacity(0.5),
  //                     //           //               borderRadius:
  //                     //           //                   BorderRadius.circular(30)),
  //                     //           //         ),
  //                     //           //       );
  //                     //           //     },
  //                     //           //   ),
  //                     //           // )
  //                     //         ],
  //                     //       ),
  //                     //     ),
  //                     //     decoration: BoxDecoration(
  //                     //         borderRadius: BorderRadius.circular(30)),
  //                     //   ),
  //                     // ),
  //                     // Padding(
  //                     //   padding: const EdgeInsets.all(8.0),
  //                     //   child: Container(
  //                     //     width: double.infinity,
  //                     //     child: Padding(
  //                     //       padding: const EdgeInsets.all(8.0),
  //                     //       child: Column(
  //                     //         mainAxisAlignment: MainAxisAlignment.start,
  //                     //         crossAxisAlignment: CrossAxisAlignment.start,
  //                     //         children: [
  //                     //           Padding(
  //                     //             padding:
  //                     //                 const EdgeInsets.symmetric(horizontal: 10),
  //                     //             child: Text(
  //                     //               'Oyunlarım:',
  //                     //               style: GoogleFonts.acme(fontSize: 17),
  //                     //             ),
  //                     //           ),
  //                     //           SizedBox(
  //                     //             height: 5,
  //                     //           ),
  //                     //           Container(
  //                     //             height: 80,
  //                     //             child: Wrap(
  //                     //               runSpacing: 7,
  //                     //               children: List.generate(3, (index) {
  //                     //                 return ClipRRect(
  //                     //                   borderRadius: BorderRadius.circular(30),
  //                     //                   child: BackdropFilter(
  //                     //                     filter: ImageFilter.blur(
  //                     //                         sigmaX: 5, sigmaY: 5),
  //                     //                     child: Padding(
  //                     //                       padding: const EdgeInsets.symmetric(
  //                     //                           horizontal: 3),
  //                     //                       child: Container(
  //                     //                         child: Padding(
  //                     //                           padding:
  //                     //                               const EdgeInsets.symmetric(
  //                     //                                   horizontal: 17,
  //                     //                                   vertical: 7),
  //                     //                           child: Row(
  //                     //                             mainAxisSize: MainAxisSize.min,
  //                     //                             children: [
  //                     //                               CircleAvatar(
  //                     //                                 backgroundColor: Colors.red,
  //                     //                                 radius: 15,
  //                     //                               ),
  //                     //                               SizedBox(
  //                     //                                 width: 5,
  //                     //                               ),
  //                     //                               Text(
  //                     //                                 'GTA 5',
  //                     //                                 style:
  //                     //                                     TextStyle(fontSize: 15),
  //                     //                               ),
  //                     //                             ],
  //                     //                           ),
  //                     //                         ),
  //                     //                         decoration: BoxDecoration(
  //                     //                             color: Colors.white
  //                     //                                 .withOpacity(0.3),
  //                     //                             borderRadius:
  //                     //                                 BorderRadius.circular(30)),
  //                     //                       ),
  //                     //                     ),
  //                     //                   ),
  //                     //                 );
  //                     //               }),
  //                     //             ),
  //                     //           ),
  //                     //           SizedBox(
  //                     //             height: 10,
  //                     //           ),

  //                     //           // Container(
  //                     //           //   height: 30,
  //                     //           //   child: ListView.builder(
  //                     //           //     itemCount: 3,
  //                     //           //     physics: BouncingScrollPhysics(),
  //                     //           //     shrinkWrap: true,
  //                     //           //     scrollDirection: Axis.horizontal,
  //                     //           //     itemBuilder: (context, index) {
  //                     //           //       return Padding(
  //                     //           //         padding: const EdgeInsets.symmetric(
  //                     //           //             horizontal: 3),
  //                     //           //         child: Container(
  //                     //           //           child: Center(
  //                     //           //               child: Padding(
  //                     //           //             padding: const EdgeInsets.symmetric(
  //                     //           //                 horizontal: 15),
  //                     //           //             child: Text('Kitap okuyorum'),
  //                     //           //           )),
  //                     //           //           decoration: BoxDecoration(
  //                     //           //               color:
  //                     //           //                   Colors.white.withOpacity(0.5),
  //                     //           //               borderRadius:
  //                     //           //                   BorderRadius.circular(30)),
  //                     //           //         ),
  //                     //           //       );
  //                     //           //     },
  //                     //           //   ),
  //                     //           // )
  //                     //         ],
  //                     //       ),
  //                     //     ),
  //                     //     decoration: BoxDecoration(
  //                     //         borderRadius: BorderRadius.circular(30)),
  //                     //   ),
  //                     // )
  //                   ],
  //                 ),
  //                 Positioned(
  //                   top: 30,
  //                   right: 0,
  //                   left: 0,
  //                   child: Stack(
  //                     alignment: AlignmentDirectional.center,
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 50,
  //                         backgroundColor: Colors.transparent,
  //                         backgroundImage:
  //                             AssetImage('assets/avatars/kadın-4@2x.png'),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 20),
  //                         child: Container(
  //                           height: 150,
  //                           width: 130,
  //                           decoration: BoxDecoration(
  //                               image: DecorationImage(
  //                                   image: AssetImage(
  //                                       'assets/covers/level-10.png'))),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                   // child: Container(
  //                   //   decoration: BoxDecoration(
  //                   //       image: DecorationImage(
  //                   //           image: AssetImage('assets/10.png'))),
  //                   //   child: CircleAvatar(
  //                   //     radius: 50,
  //                   //     backgroundColor: Colors.red,
  //                   //   ),
  //                   // ),
  //                 ),
  //                 Positioned(
  //                     top: 160,
  //                     left: 10,
  //                     child: Container(
  //                       height: (Get.size.width - 120) / 3,
  //                       width: (Get.size.width - 120) / 3,
  //                       child: GridView(
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.all(6),
  //                               child: Image.asset('assets/medal.png'),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.all(6),
  //                               child: Image.asset('assets/medal.png'),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.all(6),
  //                               child: Image.asset('assets/medal.png'),
  //                             ),
  //                           ],
  //                           gridDelegate:
  //                               SliverGridDelegateWithFixedCrossAxisCount(
  //                                   crossAxisCount: 2)),
  //                     )),
  //                 Positioned(
  //                     top: 160,
  //                     right: 10,
  //                     child: Container(
  //                       height: (Get.size.width - 120) / 3,
  //                       width: (Get.size.width - 120) / 3,
  //                       child: GridView(
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.all(10),
  //                               child: Image.asset('assets/ps.png'),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.all(10),
  //                               child: Image.asset('assets/pc.png'),
  //                             ),
  //                           ],
  //                           gridDelegate:
  //                               SliverGridDelegateWithFixedCrossAxisCount(
  //                                   crossAxisCount: 2)),
  //                     )),
  //                 Positioned(
  //                   child: Image.asset(
  //                     'assets/headset.png',
  //                     height: 30,
  //                     width: 30,
  //                   ),
  //                   top: 10,
  //                   left: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //       decoration: BoxDecoration(
  //           // boxShadow: [
  //           //   BoxShadow(
  //           //       color: Colors.black.withOpacity(0.2),
  //           //       blurRadius: 2,
  //           //       spreadRadius: 5)
  //           // ],
  //           gradient: LinearGradient(
  //               colors: [Colors.red, Colors.orange],
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight),
  //           // color: Colors.grey[200],
  //           borderRadius: BorderRadius.circular(20)),
  //     ),
  //   );
  // }
}
