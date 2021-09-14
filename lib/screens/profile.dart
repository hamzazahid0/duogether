import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gamehub/api/api.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/model/brawlBattle.dart' as brawlBattle;
import 'package:radar_chart/radar_chart.dart' as radar;
import 'package:gamehub/model/brawlPlayer.dart' as brawlPlayer;
import 'package:gamehub/screens/edit.dart';
import 'package:gamehub/screens/settings.dart' as settings;
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseApi firebaseApi = Get.find();
  InfosGetx infosGetx = Get.find();
  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
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
          IconButton(
              onPressed: () {
                Get.to(() => settings.Settings(),
                    transition: Transition.cupertino);
              },
              icon: Icon(
                Icons.settings,
                color: context.isDarkMode ? Colors.white : Colors.black,
              )),
        ],
        backgroundColor: context.isDarkMode ? Colors.grey[900] : Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(top: padding),
        child: Container(
          color: context.isDarkMode ? Colors.black : Colors.grey[200],
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: firebaseApi.firestore
                  .collection('Users')
                  .doc(firebaseApi.auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, user) {
                return user.hasData
                    ? Stack(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        children: [
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 57,
                                    ),
                                    Container(
                                      height: 180,
                                      child: Stack(
                                        children: [
                                          Positioned(
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
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                0.7,
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          image: user.data!.data()!['hasBack']
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                      'assets/gta5back.jpg'),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: AssetImage(user.data!
                                                      .data()!['back']),
                                                  fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),

                                            Text(
                                              '${user.data!.data()!['name']}, ${user.data!.data()!['age']}',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 26),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 3),
                                                child: Text(
                                                  'Lvl ${user.data!.data()!['level']}',
                                                  overflow:
                                                      TextOverflow.visible,
                                                  maxLines: 1,
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
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            // Column(
                                            //   children: [
                                            //     CircleAvatar(
                                            //       backgroundColor: context.isDarkMode ? Colors.grey[900] : Colors.white,
                                            //       child: IconButton(
                                            //           onPressed: () {
                                            //             Get.to(() => Edit(), transition: Transition.fadeIn);
                                            //           },
                                            //           icon: Icon(
                                            //             Icons.create_outlined,
                                            //             color: context.isDarkMode ? Colors.white : Colors.black,
                                            //           )),
                                            //     ),
                                            //     SizedBox(
                                            //       height: 3,
                                            //     ),
                                            //     Text('Düzenle')
                                            //   ],
                                            // ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => Edit(),
                                            transition: Transition.fadeIn);
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: LinearGradient(colors: [
                                                Color(0xFF8360c3),
                                                Color(0xFF2ebf91)
                                              ])),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              'Profili düzenle',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        width: double.maxFinite,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
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
                                                    .doc(firebaseApi
                                                        .auth.currentUser!.uid)
                                                    .collection('Rosettes')
                                                    .where('photo',
                                                        isEqualTo: Utils
                                                                .rosettes[index]
                                                            ['photo']!)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  return snapshot.hasData
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 7,
                                                                  vertical: 5),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Container(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              30),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
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
                                                                            Utils.rosettes[index]['name']!,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            Utils.rosettes[index]['detail']!,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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
                                                                              color: Colors.green,
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              child: InkWell(
                                                                                borderRadius: BorderRadius.circular(15),
                                                                                onTap: () {
                                                                                  Get.back();
                                                                                },
                                                                                child: Padding(
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
                                                                    color: context
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
                                                              child:
                                                                  Image.asset(
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 10),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Hakkımda',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 25),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Text(
                                                  '${user.data!.data()!['bio']}',
                                                  textAlign: TextAlign.left,
                                                  maxLines: 4,
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.white.withOpacity(0.2)),
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
                                            style: GoogleFonts.roboto(
                                                fontSize: 25),
                                          )),
                                    ),
                                    StreamBuilder<
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                        stream: firebaseApi.firestore
                                            .collection('Users')
                                            .doc(firebaseApi
                                                .auth.currentUser!.uid)
                                            .collection('Games')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return snapshot.hasData
                                              ? snapshot.data!.docs.length != 0
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                          width:
                                                              double.maxFinite,
                                                          height: 160,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.2)),
                                                          child:
                                                              ListView.builder(
                                                            itemCount: snapshot
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
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                child:
                                                                    AspectRatio(
                                                                  aspectRatio:
                                                                      4 / 5,
                                                                  child: Card(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child:
                                                                        Stack(
                                                                      fit: StackFit
                                                                          .expand,
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          child:
                                                                              Image.network(
                                                                            snapshot.data!.docs[index]['photo'],
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                            bottom:
                                                                                2,
                                                                            left:
                                                                                2,
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        width: double.maxFinite,
                                                        height: 160,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
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
                                                                'assets/about/game.png',
                                                                height: 70,
                                                                width: 70,
                                                                color: context
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                              Text(
                                                                'Oyun eklenmedi',
                                                                style: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        30,
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
                                            style: GoogleFonts.roboto(
                                                fontSize: 25),
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
                                                  .doc(firebaseApi
                                                      .auth.currentUser!.uid)
                                                  .collection('Accounts')
                                                  .where('done',
                                                      isEqualTo: true)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                return snapshot.hasData
                                                    ? snapshot.data!.docs
                                                                .length ==
                                                            0
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                                                              child: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Image.asset(
                                                                      'assets/about/stat.png',
                                                                      height:
                                                                          70,
                                                                      width: 70,
                                                                      color: context.isDarkMode
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
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize:
                                                                              28,
                                                                          color: context.isDarkMode
                                                                              ? Colors.white
                                                                              : Colors.black),
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
                                                                      .circular(
                                                                          20),
                                                              child: Container(
                                                                width: double
                                                                    .maxFinite,
                                                                height: 80,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    if (snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .data()['name'] ==
                                                                        'Brawl Stars') {
                                                                      String data = snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .data()[
                                                                              'data']
                                                                          .toString();
                                                                      if (data.startsWith(
                                                                          "#")) {
                                                                        data = data
                                                                            .substring(1);
                                                                      }
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4),
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
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
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
                                                                            .docs[index]
                                                                            .data()['name'] ==
                                                                        'PubG') {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4),
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
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
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
                                                                                              Text((snapshot.data!.docs[index].data()['duoKills'] / snapshot.data!.docs[index].data()['duoDeath']).toString().length > 4 ? "Duo K/D: ${(snapshot.data!.docs[index].data()['duoKills'] / snapshot.data!.docs[index].data()['duoDeath']).toString().substring(0, 3)}" : "Duo K/D: ${(snapshot.data!.docs[index].data()['duoKills'] / snapshot.data!.docs[index].data()['duoDeath']).toString()}",
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                  )),
                                                                                              Text((snapshot.data!.docs[index].data()['soloKills'] / snapshot.data!.docs[index].data()['soloDeath']).toString().length > 4 ? "Solo K/D: ${(snapshot.data!.docs[index].data()['soloKills'] / snapshot.data!.docs[index].data()['soloDeath']).toString().substring(0, 3)}" : "Solo K/D: ${(snapshot.data!.docs[index].data()['soloKills'] / snapshot.data!.docs[index].data()['soloDeath']).toString()}",
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                  )),
                                                                                              Text((snapshot.data!.docs[index].data()['squadKills'] / snapshot.data!.docs[index].data()['squadDeath']).toString().length > 4 ? "Squad K/D: ${(snapshot.data!.docs[index].data()['squadKills'] / snapshot.data!.docs[index].data()['squadDeath']).toString().substring(0, 3)}" : "Squad K/D: ${(snapshot.data!.docs[index].data()['squadKills'] / snapshot.data!.docs[index].data()['squadDeath']).toString()}",
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                  )),
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
                                                                                              Text((snapshot.data!.docs[index].data()['duoKillsFpp'] / snapshot.data!.docs[index].data()['duoDeathFpp']).toString().length > 4 ? "Duo Fpp K/D: ${(snapshot.data!.docs[index].data()['duoKillsFpp'] / snapshot.data!.docs[index].data()['duoDeathFpp']).toString().substring(0, 3)}" : "Duo Fpp K/D: ${(snapshot.data!.docs[index].data()['duoKillsFpp'] / snapshot.data!.docs[index].data()['duoDeathFpp']).toString()}",
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                  )),
                                                                                              Text((snapshot.data!.docs[index].data()['soloKillsFpp'] / snapshot.data!.docs[index].data()['soloDeathFpp']).toString().length > 4 ? "Solo Fpp K/D: ${(snapshot.data!.docs[index].data()['soloKillsFpp'] / snapshot.data!.docs[index].data()['soloDeathFpp']).toString().substring(0, 3)}" : "Solo Fpp K/D: ${(snapshot.data!.docs[index].data()['soloKillsFpp'] / snapshot.data!.docs[index].data()['soloDeathFpp']).toString()}",
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                  )),
                                                                                              Text((snapshot.data!.docs[index].data()['squadKillsFpp'] / snapshot.data!.docs[index].data()['squadDeathFpp']).toString().length > 4 ? "Squad Fpp K/D: ${(snapshot.data!.docs[index].data()['squadKillsFpp'] / snapshot.data!.docs[index].data()['squadDeathFpp']).toString().substring(0, 3)}" : "Squad Fpp K/D: ${(snapshot.data!.docs[index].data()['squadKillsFpp'] / snapshot.data!.docs[index].data()['squadDeathFpp']).toString()}",
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
                                                                                  ))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .data()['name'] ==
                                                                        'Teamfight Tactics') {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4),
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
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
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
                                                                            .docs[index]
                                                                            .data()['name'] ==
                                                                        'League of Legends') {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4),
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
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
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
                                                                            const EdgeInsets.all(4),
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
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
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
                                                                  style: GoogleFonts.roboto(
                                                                      fontSize:
                                                                          28,
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
                                                      );
                                              }),
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
                                            'Oyun tecrübesi',
                                            style: GoogleFonts.roboto(
                                                fontSize: 25),
                                          )),
                                    ),
                                    StreamBuilder<
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                        stream: firebaseApi.firestore
                                            .collection('Users')
                                            .doc(firebaseApi
                                                .auth.currentUser!.uid)
                                            .collection('Stats')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return snapshot.hasData
                                              ? snapshot.data!.docs.length != 0
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                          width:
                                                              double.maxFinite,
                                                          height: 160,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.2)),
                                                          child:
                                                              ListView.builder(
                                                            itemCount: snapshot
                                                                .data!
                                                                .docs
                                                                .length,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            physics:
                                                                BouncingScrollPhysics(),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Get.bottomSheet(
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              color: context.isDarkMode ? Colors.grey[900] : Colors.white,
                                                                              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              500,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(17),
                                                                            child:
                                                                                Stack(
                                                                              fit: StackFit.expand,
                                                                              children: [
                                                                                SingleChildScrollView(
                                                                                  physics: BouncingScrollPhysics(),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Text(
                                                                                        snapshot.data!.docs[index].data()['name'],
                                                                                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Column(
                                                                                            children: [
                                                                                              Text('Oyun süresi'),
                                                                                              Text(
                                                                                                snapshot.data!.docs[index].data()['time'],
                                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                          Container(width: 2, height: 50, color: Colors.grey),
                                                                                          Expanded(
                                                                                              child: Column(
                                                                                            children: [
                                                                                              Text(
                                                                                                snapshot.data!.docs[index].data()['exp'] == 3.0
                                                                                                    ? 'Uzman'
                                                                                                    : snapshot.data!.docs[index].data()['exp'] == 2.0
                                                                                                        ? 'Ortalama'
                                                                                                        : snapshot.data!.docs[index].data()['exp'] == 1.0
                                                                                                            ? 'Acemi'
                                                                                                            : '',
                                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 5,
                                                                                              ),
                                                                                              Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: 30,
                                                                                                    height: 10,
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: snapshot.data!.docs[index].data()['exp'] >= 1.0 ? Colors.green : Colors.grey),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 5,
                                                                                                  ),
                                                                                                  Container(
                                                                                                    width: 30,
                                                                                                    height: 10,
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: snapshot.data!.docs[index].data()['exp'] >= 2.0 ? Colors.green : Colors.grey),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 5,
                                                                                                  ),
                                                                                                  Container(
                                                                                                    width: 30,
                                                                                                    height: 10,
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: snapshot.data!.docs[index].data()['exp'] == 3.0 ? Colors.green : Colors.grey),
                                                                                                  )
                                                                                                ],
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                      snapshot.data!.docs[index].data()['info'] == ''
                                                                                          ? Container()
                                                                                          : Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Container(
                                                                                                width: double.infinity,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text(snapshot.data!.docs[index].data()['info']),
                                                                                                ),
                                                                                                decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                                                                                              ),
                                                                                            ),
                                                                                      !snapshot.data!.docs[index].data()['hasStats']
                                                                                          ? Container()
                                                                                          : SizedBox(
                                                                                              height: 320,
                                                                                              width: 320,
                                                                                              child: Stack(
                                                                                                children: [
                                                                                                  PieChart(PieChartData(centerSpaceRadius: 100, sections: [
                                                                                                    PieChartSectionData(
                                                                                                      color: Colors.green,
                                                                                                      value: snapshot.data!.docs[index].data()['g'] + 0.1,
                                                                                                      showTitle: false,
                                                                                                      radius: 20,
                                                                                                    ),
                                                                                                    PieChartSectionData(
                                                                                                      color: Colors.red,
                                                                                                      value: snapshot.data!.docs[index].data()['r'] + 0.1,
                                                                                                      showTitle: false,
                                                                                                      radius: 20,
                                                                                                    ),
                                                                                                    PieChartSectionData(
                                                                                                      color: Colors.blue,
                                                                                                      value: snapshot.data!.docs[index].data()['b'] + 0.1,
                                                                                                      showTitle: false,
                                                                                                      radius: 20,
                                                                                                    ),
                                                                                                    PieChartSectionData(
                                                                                                      color: Colors.yellow,
                                                                                                      value: snapshot.data!.docs[index].data()['y'] + 0.1,
                                                                                                      showTitle: false,
                                                                                                      radius: 20,
                                                                                                    ),
                                                                                                    PieChartSectionData(
                                                                                                      color: Colors.orange,
                                                                                                      value: snapshot.data!.docs[index].data()['o'] + 0.1,
                                                                                                      showTitle: false,
                                                                                                      radius: 20,
                                                                                                    ),
                                                                                                    PieChartSectionData(
                                                                                                      color: Colors.purple,
                                                                                                      value: snapshot.data!.docs[index].data()['p'] + 0.1,
                                                                                                      showTitle: false,
                                                                                                      radius: 20,
                                                                                                    ),
                                                                                                  ])),
                                                                                                  Center(
                                                                                                    child: SizedBox(
                                                                                                      height: 200,
                                                                                                      width: 200,
                                                                                                      child: Center(
                                                                                                        child: radar.RadarChart(
                                                                                                          radius: 90,
                                                                                                          length: 6,
                                                                                                          backgroundColor: Colors.white.withOpacity(0.2),
                                                                                                          radialColor: Colors.grey.withOpacity(0.1),
                                                                                                          radialStroke: 1.5,
                                                                                                          radars: [
                                                                                                            radar.RadarTile(
                                                                                                              values: [
                                                                                                                snapshot.data!.docs[index].data()['r'],
                                                                                                                snapshot.data!.docs[index].data()['o'],
                                                                                                                snapshot.data!.docs[index].data()['p'],
                                                                                                                snapshot.data!.docs[index].data()['g'],
                                                                                                                snapshot.data!.docs[index].data()['b'],
                                                                                                                snapshot.data!.docs[index].data()['y']
                                                                                                              ],
                                                                                                              borderStroke: 2,
                                                                                                              vertices: [
                                                                                                                PreferredSize(child: Text(snapshot.data!.docs[index].data()['green']), preferredSize: Size(10, 50)),
                                                                                                                PreferredSize(child: Text(snapshot.data!.docs[index].data()['red']), preferredSize: Size(10, 50)),
                                                                                                                PreferredSize(child: Text(snapshot.data!.docs[index].data()['yellow']), preferredSize: Size(10, 50)),
                                                                                                                PreferredSize(child: Text(snapshot.data!.docs[index].data()['blue']), preferredSize: Size(10, 50)),
                                                                                                                PreferredSize(child: Text(snapshot.data!.docs[index].data()['orange']), preferredSize: Size(10, 50)),
                                                                                                                PreferredSize(child: Text(snapshot.data!.docs[index].data()['purple']), preferredSize: Size(10, 50)),
                                                                                                              ],
                                                                                                              borderColor: Colors.purple,
                                                                                                              backgroundColor: Colors.purple.withOpacity(0.4),
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                      !snapshot.data!.docs[index].data()['hasStats']
                                                                                          ? Container()
                                                                                          : ListView.builder(
                                                                                              shrinkWrap: true,
                                                                                              itemCount: 6,
                                                                                              itemBuilder: (context, indexx) => Padding(
                                                                                                padding: const EdgeInsets.symmetric(vertical: 3),
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    CircleAvatar(
                                                                                                      radius: 10,
                                                                                                      backgroundColor: Utils.colors[indexx],
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      width: 5,
                                                                                                    ),
                                                                                                    Text(snapshot.data!.docs[index].data()[Utils.colorNames[indexx]])
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                      SizedBox(
                                                                                        height: 90,
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Positioned(
                                                                                  bottom: 10,
                                                                                  left: 0,
                                                                                  right: 0,
                                                                                  child: Material(
                                                                                    color: Colors.green,
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                    child: InkWell(
                                                                                      borderRadius: BorderRadius.circular(15),
                                                                                      onTap: () {
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Padding(
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
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        isScrollControlled: true);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: context.isDarkMode
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white,
                                                                    ),
                                                                    child: Obx(
                                                                      () => Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          !snapshot.data!.docs[index].data()['hasStats']
                                                                              ? Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                  child: SizedBox(
                                                                                    height: 80,
                                                                                    width: 80,
                                                                                    child: firebaseApi.showChart.value
                                                                                        ? CircleAvatar(
                                                                                            backgroundImage: NetworkImage(snapshot.data!.docs[index].data()['photo']),
                                                                                            radius: 40,
                                                                                          )
                                                                                        : CircleAvatar(
                                                                                            backgroundImage: NetworkImage(snapshot.data!.docs[index].data()['photo']),
                                                                                            radius: 40,
                                                                                          ),
                                                                                  ),
                                                                                )
                                                                              : SizedBox(
                                                                                  height: 160,
                                                                                  width: 140,
                                                                                  child: Stack(
                                                                                    children: [
                                                                                      PieChart(PieChartData(centerSpaceRadius: 45, sections: [
                                                                                        PieChartSectionData(
                                                                                          color: Colors.green,
                                                                                          value: snapshot.data!.docs[index].data()['g'] + 0.1,
                                                                                          showTitle: false,
                                                                                          radius: 5,
                                                                                        ),
                                                                                        PieChartSectionData(
                                                                                          color: Colors.red,
                                                                                          value: snapshot.data!.docs[index].data()['r'] + 0.1,
                                                                                          showTitle: false,
                                                                                          radius: 5,
                                                                                        ),
                                                                                        PieChartSectionData(
                                                                                          color: Colors.blue,
                                                                                          value: snapshot.data!.docs[index].data()['b'] + 0.1,
                                                                                          showTitle: false,
                                                                                          radius: 5,
                                                                                        ),
                                                                                        PieChartSectionData(
                                                                                          color: Colors.yellow,
                                                                                          value: snapshot.data!.docs[index].data()['y'] + 0.1,
                                                                                          showTitle: false,
                                                                                          radius: 5,
                                                                                        ),
                                                                                        PieChartSectionData(
                                                                                          color: Colors.orange,
                                                                                          value: snapshot.data!.docs[index].data()['o'] + 0.1,
                                                                                          showTitle: false,
                                                                                          radius: 5,
                                                                                        ),
                                                                                        PieChartSectionData(
                                                                                          color: Colors.purple,
                                                                                          value: snapshot.data!.docs[index].data()['p'] + 0.1,
                                                                                          showTitle: false,
                                                                                          radius: 5,
                                                                                        ),
                                                                                      ])),
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          firebaseApi.showChart.value = !firebaseApi.showChart.value;
                                                                                        },
                                                                                        onLongPress: () {
                                                                                          Get.bottomSheet(
                                                                                              Container(
                                                                                                decoration: BoxDecoration(color: context.isDarkMode ? Colors.grey[900] : Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                                                                                width: double.infinity,
                                                                                                height: 500,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(17),
                                                                                                  child: Stack(
                                                                                                    fit: StackFit.expand,
                                                                                                    children: [
                                                                                                      SingleChildScrollView(
                                                                                                        physics: BouncingScrollPhysics(),
                                                                                                        child: Column(
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              snapshot.data!.docs[index].data()['name'],
                                                                                                              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                                                                                                            ),
                                                                                                            SizedBox(
                                                                                                              height: 10,
                                                                                                            ),
                                                                                                            Row(
                                                                                                              children: [
                                                                                                                Expanded(
                                                                                                                    child: Column(
                                                                                                                  children: [
                                                                                                                    Text('Oyun süresi'),
                                                                                                                    Text(
                                                                                                                      snapshot.data!.docs[index].data()['time'],
                                                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                                    )
                                                                                                                  ],
                                                                                                                )),
                                                                                                                Container(width: 2, height: 50, color: Colors.grey),
                                                                                                                Expanded(
                                                                                                                    child: Column(
                                                                                                                  children: [
                                                                                                                    Text(
                                                                                                                      snapshot.data!.docs[index].data()['exp'] == 3.0
                                                                                                                          ? 'Uzman'
                                                                                                                          : snapshot.data!.docs[index].data()['exp'] == 2.0
                                                                                                                              ? 'Ortalama'
                                                                                                                              : snapshot.data!.docs[index].data()['exp'] == 1.0
                                                                                                                                  ? 'Acemi'
                                                                                                                                  : '',
                                                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      height: 5,
                                                                                                                    ),
                                                                                                                    Row(
                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                      children: [
                                                                                                                        Container(
                                                                                                                          width: 30,
                                                                                                                          height: 10,
                                                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: snapshot.data!.docs[index].data()['exp'] >= 1.0 ? Colors.green : Colors.grey),
                                                                                                                        ),
                                                                                                                        SizedBox(
                                                                                                                          width: 5,
                                                                                                                        ),
                                                                                                                        Container(
                                                                                                                          width: 30,
                                                                                                                          height: 10,
                                                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: snapshot.data!.docs[index].data()['exp'] >= 2.0 ? Colors.green : Colors.grey),
                                                                                                                        ),
                                                                                                                        SizedBox(
                                                                                                                          width: 5,
                                                                                                                        ),
                                                                                                                        Container(
                                                                                                                          width: 30,
                                                                                                                          height: 10,
                                                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: snapshot.data!.docs[index].data()['exp'] == 3.0 ? Colors.green : Colors.grey),
                                                                                                                        )
                                                                                                                      ],
                                                                                                                    )
                                                                                                                  ],
                                                                                                                )),
                                                                                                              ],
                                                                                                            ),
                                                                                                            snapshot.data!.docs[index].data()['info'] == ''
                                                                                                                ? Container()
                                                                                                                : Padding(
                                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                                    child: Container(
                                                                                                                      width: double.infinity,
                                                                                                                      child: Padding(
                                                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                                                        child: Text(snapshot.data!.docs[index].data()['info']),
                                                                                                                      ),
                                                                                                                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                            !snapshot.data!.docs[index].data()['hasStats']
                                                                                                                ? Container()
                                                                                                                : SizedBox(
                                                                                                                    height: 320,
                                                                                                                    width: 320,
                                                                                                                    child: Stack(
                                                                                                                      children: [
                                                                                                                        PieChart(PieChartData(centerSpaceRadius: 100, sections: [
                                                                                                                          PieChartSectionData(
                                                                                                                            color: Colors.green,
                                                                                                                            value: snapshot.data!.docs[index].data()['g'] + 0.1,
                                                                                                                            showTitle: false,
                                                                                                                            radius: 20,
                                                                                                                          ),
                                                                                                                          PieChartSectionData(
                                                                                                                            color: Colors.red,
                                                                                                                            value: snapshot.data!.docs[index].data()['r'] + 0.1,
                                                                                                                            showTitle: false,
                                                                                                                            radius: 20,
                                                                                                                          ),
                                                                                                                          PieChartSectionData(
                                                                                                                            color: Colors.blue,
                                                                                                                            value: snapshot.data!.docs[index].data()['b'] + 0.1,
                                                                                                                            showTitle: false,
                                                                                                                            radius: 20,
                                                                                                                          ),
                                                                                                                          PieChartSectionData(
                                                                                                                            color: Colors.yellow,
                                                                                                                            value: snapshot.data!.docs[index].data()['y'] + 0.1,
                                                                                                                            showTitle: false,
                                                                                                                            radius: 20,
                                                                                                                          ),
                                                                                                                          PieChartSectionData(
                                                                                                                            color: Colors.orange,
                                                                                                                            value: snapshot.data!.docs[index].data()['o'] + 0.1,
                                                                                                                            showTitle: false,
                                                                                                                            radius: 20,
                                                                                                                          ),
                                                                                                                          PieChartSectionData(
                                                                                                                            color: Colors.purple,
                                                                                                                            value: snapshot.data!.docs[index].data()['p'] + 0.1,
                                                                                                                            showTitle: false,
                                                                                                                            radius: 20,
                                                                                                                          ),
                                                                                                                        ])),
                                                                                                                        Center(
                                                                                                                          child: SizedBox(
                                                                                                                            height: 200,
                                                                                                                            width: 200,
                                                                                                                            child: Center(
                                                                                                                              child: radar.RadarChart(
                                                                                                                                radius: 90,
                                                                                                                                length: 6,
                                                                                                                                backgroundColor: Colors.white.withOpacity(0.2),
                                                                                                                                radialColor: Colors.grey.withOpacity(0.1),
                                                                                                                                radialStroke: 1.5,
                                                                                                                                radars: [
                                                                                                                                  radar.RadarTile(
                                                                                                                                    values: [
                                                                                                                                      snapshot.data!.docs[index].data()['r'],
                                                                                                                                      snapshot.data!.docs[index].data()['o'],
                                                                                                                                      snapshot.data!.docs[index].data()['p'],
                                                                                                                                      snapshot.data!.docs[index].data()['g'],
                                                                                                                                      snapshot.data!.docs[index].data()['b'],
                                                                                                                                      snapshot.data!.docs[index].data()['y']
                                                                                                                                    ],
                                                                                                                                    borderStroke: 2,
                                                                                                                                    vertices: [
                                                                                                                                      PreferredSize(child: Text(snapshot.data!.docs[index].data()['green']), preferredSize: Size(10, 50)),
                                                                                                                                      PreferredSize(child: Text(snapshot.data!.docs[index].data()['red']), preferredSize: Size(10, 50)),
                                                                                                                                      PreferredSize(child: Text(snapshot.data!.docs[index].data()['yellow']), preferredSize: Size(10, 50)),
                                                                                                                                      PreferredSize(child: Text(snapshot.data!.docs[index].data()['blue']), preferredSize: Size(10, 50)),
                                                                                                                                      PreferredSize(child: Text(snapshot.data!.docs[index].data()['orange']), preferredSize: Size(10, 50)),
                                                                                                                                      PreferredSize(child: Text(snapshot.data!.docs[index].data()['purple']), preferredSize: Size(10, 50)),
                                                                                                                                    ],
                                                                                                                                    borderColor: Colors.purple,
                                                                                                                                    backgroundColor: Colors.purple.withOpacity(0.4),
                                                                                                                                  )
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                            !snapshot.data!.docs[index].data()['hasStats']
                                                                                                                ? Container()
                                                                                                                : ListView.builder(
                                                                                                                    shrinkWrap: true,
                                                                                                                    itemCount: 6,
                                                                                                                    itemBuilder: (context, indexx) => Padding(
                                                                                                                      padding: const EdgeInsets.symmetric(vertical: 3),
                                                                                                                      child: Row(
                                                                                                                        children: [
                                                                                                                          CircleAvatar(
                                                                                                                            radius: 10,
                                                                                                                            backgroundColor: Utils.colors[indexx],
                                                                                                                          ),
                                                                                                                          SizedBox(
                                                                                                                            width: 5,
                                                                                                                          ),
                                                                                                                          Text(snapshot.data!.docs[index].data()[Utils.colorNames[indexx]])
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                            SizedBox(
                                                                                                              height: 90,
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Positioned(
                                                                                                        bottom: 10,
                                                                                                        left: 0,
                                                                                                        right: 0,
                                                                                                        child: Material(
                                                                                                          color: Colors.green,
                                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                                          child: InkWell(
                                                                                                            borderRadius: BorderRadius.circular(15),
                                                                                                            onTap: () {
                                                                                                              Get.back();
                                                                                                            },
                                                                                                            child: Padding(
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
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              isScrollControlled: true);
                                                                                        },
                                                                                        child: Center(
                                                                                            child: firebaseApi.showChart.value
                                                                                                ? radar.RadarChart(
                                                                                                    radius: 43,
                                                                                                    length: 6,
                                                                                                    backgroundColor: Colors.white.withOpacity(0.2),
                                                                                                    radialColor: Colors.grey.withOpacity(0.1),
                                                                                                    radialStroke: 1.5,
                                                                                                    radars: [
                                                                                                      radar.RadarTile(
                                                                                                        values: [
                                                                                                          snapshot.data!.docs[index].data()['r'],
                                                                                                          snapshot.data!.docs[index].data()['o'],
                                                                                                          snapshot.data!.docs[index].data()['p'],
                                                                                                          snapshot.data!.docs[index].data()['g'],
                                                                                                          snapshot.data!.docs[index].data()['b'],
                                                                                                          snapshot.data!.docs[index].data()['y']
                                                                                                        ],
                                                                                                        borderStroke: 2,
                                                                                                        borderColor: Colors.purple,
                                                                                                        backgroundColor: Colors.purple.withOpacity(0.4),
                                                                                                      )
                                                                                                    ],
                                                                                                  )
                                                                                                : CircleAvatar(
                                                                                                    backgroundImage: NetworkImage(snapshot.data!.docs[index].data()['photo']),
                                                                                                    radius: 43,
                                                                                                  )),
                                                                                      ),
                                                                                      snapshot.data!.docs[index].data()['hasLevels']
                                                                                          ? Positioned(
                                                                                              bottom: 5,
                                                                                              left: 0,
                                                                                              right: 0,
                                                                                              child: Text(
                                                                                                '${snapshot.data!.docs[index].data()['level']}. Seviye',
                                                                                                textAlign: TextAlign.center,
                                                                                              ))
                                                                                          : Container()
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                          Container(
                                                                            width:
                                                                                1,
                                                                            height:
                                                                                100,
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 30),
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                // SleekCircularSlider(
                                                                                //   min: 0,
                                                                                //   max: 5,
                                                                                //   innerWidget: (data) => Center(child: Text('${snapshot.data!.docs[index].data()['stage']}', style: GoogleFonts.economica(fontSize: 20))),
                                                                                //   appearance: CircularSliderAppearance(
                                                                                //       spinnerMode:
                                                                                //           false,
                                                                                //       startAngle:
                                                                                //           170,
                                                                                //       angleRange:
                                                                                //           200,
                                                                                //       size:
                                                                                //           105,
                                                                                //       customColors: CustomSliderColors(dynamicGradient: false, dotColor: Colors.transparent, progressBarColors: [
                                                                                //         Color(0xFFFF0080),
                                                                                //         Color(0xFFFF8C00),
                                                                                //         Color(0xFF40E0D0)
                                                                                //       ])),
                                                                                //   initialValue: snapshot.data!.docs[index].data()['exp'],
                                                                                // ),
                                                                                Column(
                                                                                  children: [
                                                                                    Text(snapshot.data!.docs[index].data()['exp'] == 3.0
                                                                                        ? 'Uzman'
                                                                                        : snapshot.data!.docs[index].data()['exp'] == 2.0
                                                                                            ? 'Ortalama'
                                                                                            : snapshot.data!.docs[index].data()['exp'] == 1.0
                                                                                                ? 'Acemi'
                                                                                                : ''),
                                                                                    SizedBox(
                                                                                      height: 7,
                                                                                    ),
                                                                                    Container(
                                                                                      width: 60,
                                                                                      height: 10,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: snapshot.data!.docs[index].data()['exp'] == 3.0 ? Colors.green : Colors.grey),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Container(
                                                                                      width: 60,
                                                                                      height: 10,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: snapshot.data!.docs[index].data()['exp'] >= 2.0 ? Colors.green : Colors.grey),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Container(
                                                                                      width: 60,
                                                                                      height: 10,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: snapshot.data!.docs[index].data()['exp'] >= 1.0 ? Colors.green : Colors.grey),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                                Positioned(
                                                                                    bottom: 5,
                                                                                    left: 0,
                                                                                    right: 0,
                                                                                    child: Text(
                                                                                      '${snapshot.data!.docs[index].data()['time']}',
                                                                                      textAlign: TextAlign.center,
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          snapshot.data!.docs[index].data()['info'] == ''
                                                                              ? Container()
                                                                              : Container(
                                                                                  width: 1,
                                                                                  height: 100,
                                                                                  color: Colors.grey.withOpacity(0.5),
                                                                                ),
                                                                          snapshot.data!.docs[index].data()['info'] == ''
                                                                              ? Container()
                                                                              : SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                          snapshot.data!.docs[index].data()['info'] == ''
                                                                              ? Container()
                                                                              : Container(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(7),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          snapshot.data!.docs[index].data()['info'],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  height: 130,
                                                                                  width: 100,
                                                                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                                                                                ),
                                                                          snapshot.data!.docs[index].data()['info'] == ''
                                                                              ? Container()
                                                                              : SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    ),
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        width: double.maxFinite,
                                                        height: 160,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
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
                                                                'assets/about/practice.png',
                                                                height: 70,
                                                                width: 70,
                                                                color: context
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                              Text(
                                                                'Oyun tecrübesi eklenmedi',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        28,
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
                                                            'assets/about/practice.png',
                                                            height: 70,
                                                            width: 70,
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                          Text(
                                                            'Oyun tecrübesi eklenmedi',
                                                            textAlign: TextAlign
                                                                .center,
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Container(
                                          width: double.infinity,
                                          child: Text(
                                            'Sosyal Platformlar',
                                            style: GoogleFonts.roboto(
                                                fontSize: 25),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        width: double.maxFinite,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Obx(
                                          () => infosGetx.social.length == 0
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
                                                        color:
                                                            context.isDarkMode
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
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        infosGetx.social.length,
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
                                                                  .circular(30),
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
                                                                child: Padding(
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
                                                                          infosGetx.social[index]
                                                                              [
                                                                              'icon'],
                                                                        ),
                                                                        radius:
                                                                            20,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          // Text(
                                                                          //     '${snapshot.data!.docs[index]['name']}: '),
                                                                          // Text(
                                                                          //     '${infosGetx.social[index]['name']}: '),
                                                                          SizedBox(
                                                                            width:
                                                                                6,
                                                                          ),
                                                                          Text(
                                                                            infosGetx.social[index]['data'],
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold),
                                                                          ),
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
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Aktif olduğum saatler',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    user.data!.data()![
                                                                'startMinute'] <
                                                            10
                                                        ? '${user.data!.data()!['startHour']}:0${user.data!.data()!['startMinute']}'
                                                        : '${user.data!.data()!['startHour']}:${user.data!.data()!['startMinute']}',
                                                    style:
                                                        GoogleFonts.rationale(
                                                            fontSize: 27,
                                                            color:
                                                                Color.fromRGBO(
                                                                    165,
                                                                    255,
                                                                    23,
                                                                    1)),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.cyan),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        Colors.blueGrey[900]),
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
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    user.data!.data()![
                                                                'endMinute'] <
                                                            10
                                                        ? '${user.data!.data()!['endHour']}:0${user.data!.data()!['endMinute']}'
                                                        : '${user.data!.data()!['endHour']}:${user.data!.data()!['endMinute']}',
                                                    style:
                                                        GoogleFonts.rationale(
                                                            fontSize: 27,
                                                            color:
                                                                Color.fromRGBO(
                                                                    165,
                                                                    255,
                                                                    23,
                                                                    1)),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.cyan),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        Colors.blueGrey[900]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
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
                                  top: 95,
                                  right: 0,
                                  left: 0,
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      user.data!.data()!['avatarIsAsset']
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundColor: user.data!
                                                          .data()!['avatar'] ==
                                                      'assets/user.png'
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              backgroundImage: AssetImage(
                                                  user.data!.data()!['avatar']),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: NetworkImage(
                                                  user.data!.data()!['avatar']),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 23),
                                        child: Container(
                                          height: 170,
                                          width: 140,
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
                                    top: 65,
                                    right: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: Container(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: Container(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7),
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
                                  top: 65,
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
                          ),
                        ],
                      )
                    : CircularPercentIndicator(radius: 30);
              }),
        ),
      ),
    );
    // return Container(
    //     child: SingleChildScrollView(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(20),
    //         child: Row(
    //           children: [
    //             CircleAvatar(
    //               radius: 30,
    //               backgroundColor: Colors.red,
    //               backgroundImage: AssetImage('assets/avatars/erkek-11@2x.png'),
    //             ),
    //             SizedBox(
    //               width: 12,
    //             ),
    //             Expanded(
    //                 child: Column(
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       'Ronald Richard',
    //                       style: GoogleFonts.acme(fontSize: 19),
    //                     ),
    //                     Row(
    //                       children: [
    //                         Text(
    //                           'Seviyye 123',
    //                           style: TextStyle(fontSize: 13),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 15,
    //                 ),
    //                 LinearPercentIndicator(
    //                   percent: 0.6,
    //                   trailing: Text('60%', style: TextStyle(fontSize: 13)),
    //                   padding: EdgeInsets.only(right: 20, left: 3),
    //                   lineHeight: 10,
    //                   animation: true,
    //                   // fillColor: Color.fromRGBO(253, 103, 68, 0.25),
    //                   backgroundColor: Color.fromRGBO(253, 103, 68, 0.25),
    //                   progressColor: Color.fromRGBO(253, 103, 68, 1),
    //                 )
    //               ],
    //             ))
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 25),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Hakkımda',
    //               style: GoogleFonts.acme(fontSize: 22),
    //             ),
    //             IconButton(
    //                 splashRadius: 20,
    //                 onPressed: () {},
    //                 icon: Icon(
    //                   Icons.edit,
    //                   color: Colors.grey[900],
    //                 ))
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         child: Container(
    //           decoration: BoxDecoration(
    //               color: Colors.grey[200],
    //               borderRadius: BorderRadius.circular(15)),
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Text(
    //               'Hakkimda uzun uzun bir bilgi ve cok uzun bir bilgi bu',
    //               style: TextStyle(fontSize: 17),
    //             ),
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 25),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Hobilerim',
    //               style: GoogleFonts.acme(fontSize: 22),
    //             ),
    //             IconButton(
    //                 splashRadius: 20,
    //                 onPressed: () {},
    //                 icon: Icon(
    //                   Icons.add,
    //                   size: 26,
    //                   color: Colors.grey[900],
    //                 ))
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         child: Container(
    //           decoration: BoxDecoration(
    //               color: Colors.grey[200],
    //               borderRadius: BorderRadius.circular(15)),
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: GridView.builder(
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: 3,
    //               shrinkWrap: true,
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                   childAspectRatio: 1.61, crossAxisCount: 2),
    //               itemBuilder: (context, index) {
    //                 return Padding(
    //                   padding: const EdgeInsets.all(7),
    //                   child: Container(
    //                     child: Column(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Expanded(
    //                                   child: Text(
    //                                 'Kitab okumak',
    //                                 maxLines: 1,
    //                                 overflow: TextOverflow.ellipsis,
    //                                 style: GoogleFonts.acme(fontSize: 17),
    //                               )),
    //                               GestureDetector(
    //                                 onTap: () {
    //                                   print('delete');
    //                                 },
    //                                 child: Padding(
    //                                   padding: const EdgeInsets.all(5),
    //                                   child: Icon(
    //                                     Icons.cancel_outlined,
    //                                     color: Colors.red[900],
    //                                     size: 20,
    //                                   ),
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                         Expanded(
    //                             child: Padding(
    //                           padding: const EdgeInsets.symmetric(
    //                               horizontal: 6, vertical: 2),
    //                           child: Text(
    //                             'En cok yapdigim seylerden biri kitap okumakdir',
    //                             overflow: TextOverflow.ellipsis,
    //                             maxLines: 3,
    //                           ),
    //                         ))
    //                       ],
    //                     ),
    //                     decoration: BoxDecoration(
    //                         gradient: LinearGradient(
    //                             colors: [Colors.green, Colors.lime]),
    //                         borderRadius: BorderRadius.circular(15)),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 25),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Oyunlarım',
    //               style: GoogleFonts.acme(fontSize: 22),
    //             ),
    //             IconButton(
    //                 splashRadius: 20,
    //                 onPressed: () {},
    //                 icon: Icon(
    //                   Icons.add,
    //                   size: 26,
    //                   color: Colors.grey[900],
    //                 ))
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         child: Container(
    //           decoration: BoxDecoration(
    //               color: Colors.grey[200],
    //               borderRadius: BorderRadius.circular(15)),
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: GridView.builder(
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: 1,
    //               shrinkWrap: true,
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                   childAspectRatio: 1, crossAxisCount: 2),
    //               itemBuilder: (context, index) {
    //                 return Padding(
    //                   padding: const EdgeInsets.all(7),
    //                   child: Container(
    //                     child: Column(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Expanded(
    //                                   child: Text(
    //                                 'GTA V',
    //                                 maxLines: 1,
    //                                 overflow: TextOverflow.ellipsis,
    //                                 style: GoogleFonts.acme(fontSize: 17),
    //                               )),
    //                               GestureDetector(
    //                                 onTap: () {
    //                                   print('delete');
    //                                 },
    //                                 child: Padding(
    //                                   padding: const EdgeInsets.all(5),
    //                                   child: Icon(
    //                                     Icons.cancel_outlined,
    //                                     color: Colors.red[900],
    //                                     size: 20,
    //                                   ),
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.symmetric(
    //                               horizontal: 6, vertical: 2),
    //                           child: Row(
    //                             children: [
    //                               CircleAvatar(
    //                                 backgroundColor: Colors.red,
    //                               ),
    //                               Expanded(
    //                                 child: Padding(
    //                                   padding: const EdgeInsets.all(4),
    //                                   child: Text(
    //                                     'NickName\nSeviyye: 25',
    //                                     overflow: TextOverflow.ellipsis,
    //                                     maxLines: 2,
    //                                     style: GoogleFonts.acme(),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Expanded(
    //                             child: Padding(
    //                           padding: const EdgeInsets.all(5.0),
    //                           child: Text(
    //                               'Oyundaki tum binalara sahipim ve bir milyar param var'),
    //                         ))
    //                       ],
    //                     ),
    //                     decoration: BoxDecoration(
    //                         gradient: LinearGradient(
    //                             colors: [Colors.blueAccent, Colors.cyanAccent]),
    //                         borderRadius: BorderRadius.circular(15)),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // ));
  }
}
