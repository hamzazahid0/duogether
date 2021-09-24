import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gamehub/getx/cardsGetx.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FinishProfile extends StatefulWidget {
  final PageController controller;

  const FinishProfile({Key? key, required this.controller}) : super(key: key);
  @override
  _FinishProfileState createState() => _FinishProfileState();
}

class _FinishProfileState extends State<FinishProfile> {
  FirebaseApi firebaseApi = Get.find();
  TextEditingController nameContoller = TextEditingController();
  CardsGetx cardsGetx = Get.find();
  @override
  Widget build(BuildContext context) {
    nameContoller.text = firebaseApi.name.value;
    return SafeArea(
      child: Obx(
        () => Container(
          color: context.isDarkMode ? Colors.grey[800] : Colors.white,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      barrierColor: Colors.grey[200]!.withOpacity(0.65),
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      context: context,
                      builder: (context) {
                        return DefaultTabController(
                          length: 3,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Column(
                                children: [
                                  Theme(
                                    data: ThemeData(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent),
                                    child: Material(
                                      color: context.isDarkMode
                                          ? Colors.grey[900]
                                          : Colors.grey[50],
                                      child: TabBar(
                                        labelColor: context.isDarkMode
                                            ? Colors.white
                                            : Colors.grey[900],
                                        unselectedLabelColor: Colors.grey,
                                        labelStyle: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        unselectedLabelStyle:
                                            GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                        indicatorColor: Colors.transparent,
                                        indicatorWeight: 3,
                                        labelPadding: EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 2),
                                        tabs: [
                                          Tab(
                                            iconMargin: EdgeInsets.zero,
                                            // text: 'Mesajlar',
                                            child: Container(
                                              width: double.maxFinite,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                                  child: Text(
                                                    '1. Seviye',
                                                    overflow:
                                                        TextOverflow.visible,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gradient: context.isDarkMode
                                                      ? LinearGradient(
                                                          colors: [
                                                              Colors.grey[700]!,
                                                              Colors.grey[800]!,
                                                              // Colors.grey.withOpacity(0.15),
                                                              // Colors.grey.withOpacity(0.10),
                                                              // Colors.grey.withOpacity(0.05),
                                                            ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight)
                                                      : LinearGradient(
                                                          colors: [
                                                              Color(0xFFdfe9f3),
                                                              Colors.grey[100]!,
                                                              // Colors.grey.withOpacity(0.15),
                                                              // Colors.grey.withOpacity(0.10),
                                                              // Colors.grey.withOpacity(0.05),
                                                            ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight)),
                                            ),
                                          ),
                                          Tab(
                                            iconMargin: EdgeInsets.zero,
                                            // text: 'Mesajlar',
                                            child: Container(
                                              width: double.maxFinite,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                                  child: Text(
                                                    '2. Seviye',
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: context.isDarkMode
                                                      ? Colors.grey[800]
                                                      : Colors.grey[100]!),
                                            ),
                                          ),
                                          Tab(
                                            iconMargin: EdgeInsets.zero,
                                            // text: 'Mesajlar',
                                            child: Container(
                                              width: double.maxFinite,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                                  child: Text(
                                                    '3. Seviye',
                                                    overflow:
                                                        TextOverflow.visible,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gradient: context.isDarkMode
                                                      ? LinearGradient(
                                                          colors: [
                                                              Colors.grey[800]!,
                                                              Colors.grey[700]!,
                                                              // Colors.grey.withOpacity(0.15),
                                                              // Colors.grey.withOpacity(0.10),
                                                              // Colors.grey.withOpacity(0.05),
                                                            ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight)
                                                      : LinearGradient(
                                                          colors: [
                                                              Colors.grey[100]!,
                                                              Color(0xFFdfe9f3),
                                                              // Colors.grey.withOpacity(0.15),
                                                              // Colors.grey.withOpacity(0.10),
                                                              // Colors.grey.withOpacity(0.05),
                                                            ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight)),
                                              // child: Row(
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Flexible(
                                  //       child: Padding(
                                  //         padding:
                                  //             const EdgeInsets
                                  //                 .all(10),
                                  //         child: Material(
                                  //           color: Colors.white,
                                  //           borderRadius:
                                  //               BorderRadius
                                  //                   .circular(30),
                                  //           elevation: 2,
                                  //           child: InkWell(
                                  //             onTap: () async {
                                  //               await Permission
                                  //                   .camera
                                  //                   .request();
                                  //               if (await Permission
                                  //                   .camera
                                  //                   .isGranted) {
                                  //                 var image = await ImagePicker()
                                  //                     .getImage(
                                  //                         source:
                                  //                             ImageSource.camera);
                                  //                 if (image !=
                                  //                     null) {
                                  //                   var file = await ImageCropper.cropImage(
                                  //                       sourcePath:
                                  //                           image
                                  //                               .path,
                                  //                       cropStyle:
                                  //                           CropStyle
                                  //                               .circle);
                                  //                   if (file !=
                                  //                       null) {
                                  //                     var task = firebaseApi
                                  //                         .storage
                                  //                         .ref()
                                  //                         .child(
                                  //                             'avatars/${Uuid().v1()}')
                                  //                         .putFile(
                                  //                             file);
                                  //                     task.then(
                                  //                         (v) async {
                                  //                       String
                                  //                           link =
                                  //                           await v
                                  //                               .ref
                                  //                               .getDownloadURL();
                                  //                       await firebaseApi
                                  //                           .firestore
                                  //                           .collection(
                                  //                               'Users')
                                  //                           .doc(firebaseApi
                                  //                               .auth
                                  //                               .currentUser!
                                  //                               .uid)
                                  //                           .update({
                                  //                         'avatarIsAsset':
                                  //                             false,
                                  //                         'avatar':
                                  //                             link
                                  //                       });
                                  //                       Get.back();
                                  //                     });
                                  //                   }
                                  //                 }
                                  //               }
                                  //             },
                                  //             borderRadius:
                                  //                 BorderRadius
                                  //                     .circular(
                                  //                         30),
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                   // boxShadow: [
                                  //                   //   BoxShadow(
                                  //                   //       color: Colors.purple
                                  //                   //           .withOpacity(
                                  //                   //               0.3),
                                  //                   //       blurRadius: 2,
                                  //                   //       spreadRadius: 1,
                                  //                   //       offset:
                                  //                   //           Offset(2, 2))
                                  //                   // ],
                                  //                   // gradient: LinearGradient(
                                  //                   //     colors: [
                                  //                   //       Colors.purple,
                                  //                   //       Colors.deepPurple
                                  //                   //     ]),
                                  //                   borderRadius: BorderRadius.circular(30)),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets
                                  //                         .symmetric(
                                  //                     horizontal:
                                  //                         5,
                                  //                     vertical:
                                  //                         8),
                                  //                 child: Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .center,
                                  //                   children: [
                                  //                     // Icon(Icons.camera_alt_rounded),
                                  //                     // SizedBox(
                                  //                     //   width: 5,
                                  //                     // ),
                                  //                     Text(
                                  //                         'Kamera',
                                  //                         style: GoogleFonts.acme(
                                  //                             fontSize:
                                  //                                 20,
                                  //                             color:
                                  //                                 Colors.grey[900]))
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       flex: 1,
                                  //     ),
                                  //     Flexible(
                                  //       child: Padding(
                                  //         padding:
                                  //             const EdgeInsets
                                  //                 .all(10),
                                  //         child: Material(
                                  //           color: Colors.white,
                                  //           borderRadius:
                                  //               BorderRadius
                                  //                   .circular(30),
                                  //           elevation: 2,
                                  //           child: InkWell(
                                  //             onTap: () async {
                                  //               await Permission
                                  //                   .storage
                                  //                   .request();
                                  //               await Permission
                                  //                   .photos
                                  //                   .request();
                                  //               if (await Permission
                                  //                       .storage
                                  //                       .isGranted &&
                                  //                   await Permission
                                  //                       .photos
                                  //                       .isGranted) {
                                  //                 var image = await ImagePicker()
                                  //                     .getImage(
                                  //                         source:
                                  //                             ImageSource.gallery);
                                  //                 //
                                  //                 if (image !=
                                  //                     null) {
                                  //                   var file = await ImageCropper.cropImage(
                                  //                       sourcePath:
                                  //                           image
                                  //                               .path,
                                  //                       cropStyle:
                                  //                           CropStyle
                                  //                               .circle);
                                  //                   if (file !=
                                  //                       null) {
                                  //                     var task = firebaseApi
                                  //                         .storage
                                  //                         .ref()
                                  //                         .child(
                                  //                             'avatars/${Uuid().v1()}')
                                  //                         .putFile(
                                  //                             file);
                                  //                     task.then(
                                  //                         (v) async {
                                  //                       String
                                  //                           link =
                                  //                           await v
                                  //                               .ref
                                  //                               .getDownloadURL();
                                  //                       await firebaseApi
                                  //                           .firestore
                                  //                           .collection(
                                  //                               'Users')
                                  //                           .doc(firebaseApi
                                  //                               .auth
                                  //                               .currentUser!
                                  //                               .uid)
                                  //                           .update({
                                  //                         'avatarIsAsset':
                                  //                             false,
                                  //                         'avatar':
                                  //                             link
                                  //                       });
                                  //                       Get.back();
                                  //                     });
                                  //                   }
                                  //                 }
                                  //               }
                                  //             },
                                  //             borderRadius:
                                  //                 BorderRadius
                                  //                     .circular(
                                  //                         30),
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                   borderRadius:
                                  //                       BorderRadius
                                  //                           .circular(
                                  //                               30)),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets
                                  //                         .symmetric(
                                  //                     horizontal:
                                  //                         5,
                                  //                     vertical:
                                  //                         8),
                                  //                 child: Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .center,
                                  //                   children: [
                                  //                     // Icon(Icons.camera_alt_rounded),
                                  //                     // SizedBox(
                                  //                     //   width: 5,
                                  //                     // ),
                                  //                     Text(
                                  //                         'Galeri',
                                  //                         style: GoogleFonts.acme(
                                  //                             fontSize:
                                  //                                 20,
                                  //                             color:
                                  //                                 Colors.grey[900]))
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       flex: 1,
                                  //     ),
                                  //   ],
                                  // ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        GridView.builder(
                                          padding: EdgeInsets.zero,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: Utils.avatars.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: GestureDetector(
                                                onTap: () {
                                                  firebaseApi.avatarIsAsset
                                                      .value = true;
                                                  firebaseApi.avatar.value =
                                                      'assets/avatars/${Utils.avatars[index]}';
                                                  Get.back();
                                                }, //
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      radius: 30,
                                                      backgroundImage: AssetImage(
                                                          'assets/avatars/${Utils.avatars[index]}')),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Obx(
                                          () => Stack(
                                            children: [
                                              Opacity(
                                                opacity: firebaseApi
                                                        .twoLevelAvatar.value
                                                    ? 1
                                                    : 0.3,
                                                child: IgnorePointer(
                                                  ignoring: firebaseApi
                                                          .twoLevelAvatar.value
                                                      ? false
                                                      : true,
                                                  child: GridView.builder(
                                                    padding: EdgeInsets.zero,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount:
                                                        Utils.avatars.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            firebaseApi
                                                                .avatarIsAsset
                                                                .value = true;
                                                            firebaseApi.avatar
                                                                    .value =
                                                                'assets/avatars/level2/${Utils.avatars2[index]}';
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            child: CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                radius: 30,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        'assets/avatars/level2/${Utils.avatars2[index]}')),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              firebaseApi.twoLevelAvatar.value
                                                  ? Container()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        //reklam
                                                        firebaseApi.showAd(
                                                            cardsGetx, () {
                                                          firebaseApi
                                                              .twoLevelAvatar
                                                              .value = true;
                                                        });
                                                      },
                                                      child: Center(
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                'assets/lock.png',
                                                                color: context
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                height: 100,
                                                                width: 100,
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Text(
                                                                'Kilidi açmak için reklam izleyin',
                                                                style: GoogleFonts.roboto(
                                                                    color: context.isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            Opacity(
                                              opacity: 0.3,
                                              child: IgnorePointer(
                                                ignoring: true,
                                                child: GridView.builder(
                                                  padding: EdgeInsets.zero,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount:
                                                      Utils.avatars.length,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          firebaseApi
                                                              .avatarIsAsset
                                                              .value = true;
                                                          firebaseApi.avatar
                                                                  .value =
                                                              'assets/avatars/level3/${Utils.avatars3[index]}';
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          width: 50,
                                                          child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              radius: 30,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'assets/avatars/level3/${Utils.avatars3[index]}')),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                //reklam
                                              },
                                              child: Center(
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/lock.png',
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                        height: 100,
                                                        width: 100,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        "Kilidi açmak için 10. seviye'ye ulaşın",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.roboto(
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize: 25),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: context.isDarkMode
                                    ? Colors.grey[900]
                                    : Colors.grey[50],
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            height: MediaQuery.of(context).size.height * 0.65,
                            width: double.maxFinite,
                          ),
                        );
                      },
                    );

                    // firebaseApi.avatarIsAsset.value = true;
                    // firebaseApi.avatar.value =
                    //     'assets/avatars/${Utils.avatars[index]}';

                    // showCupertinoModalPopup(
                    //   barrierColor: Colors.grey[200]!.withOpacity(0.65),
                    //   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    //   context: context,
                    //   builder: (context) {
                    //     return Container(
                    //       child: Padding(
                    //         padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    //         child: Column(
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Flexible(
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.all(10),
                    //                     child: Material(
                    //                       color: Colors.white,
                    //                       borderRadius: BorderRadius.circular(30),
                    //                       elevation: 2,
                    //                       child: InkWell(
                    //                         onTap: () async {
                    //                           await Permission.camera.request();
                    //                           if (await Permission
                    //                               .camera.isGranted) {
                    //                             var image = await ImagePicker()
                    //                                 .getImage(
                    //                                     source:
                    //                                         ImageSource.camera);
                    //                             if (image != null) {
                    //                               var file = await ImageCropper
                    //                                   .cropImage(
                    //                                       sourcePath: image.path,
                    //                                       cropStyle:
                    //                                           CropStyle.circle);
                    //                               if (file != null) {
                    //                                 Get.back();
                    //                                 firebaseApi.avatarFile.value =
                    //                                     file;
                    //                                 firebaseApi.avatarIsAsset
                    //                                     .value = false;

                    //                                 firebaseApi.firestore
                    //                                     .collection('Users')
                    //                                     .doc(firebaseApi.auth
                    //                                         .currentUser!.uid)
                    //                                     .collection('Rosettes')
                    //                                     .where('name',
                    //                                         isEqualTo:
                    //                                             Utils.resimekleme[
                    //                                                 'name']!)
                    //                                     .get()
                    //                                     .then((value) {
                    //                                   if (value.docs.isEmpty) {
                    //                                     firebaseApi.exp =
                    //                                         firebaseApi.exp + 100;
                    //                                     Get.snackbar(
                    //                                         'Başarı kazandın',
                    //                                         Utils.resimekleme[
                    //                                             'name']!,
                    //                                         icon: Padding(
                    //                                           padding:
                    //                                               const EdgeInsets
                    //                                                       .symmetric(
                    //                                                   horizontal:
                    //                                                       5),
                    //                                           child: Icon(
                    //                                             Icons
                    //                                                 .emoji_events_outlined,
                    //                                             size: 35,
                    //                                           ),
                    //                                         ));
                    //                                     firebaseApi.firestore
                    //                                         .collection('Users')
                    //                                         .doc(firebaseApi.auth
                    //                                             .currentUser!.uid)
                    //                                         .collection(
                    //                                             'Rosettes')
                    //                                         .add({
                    //                                       'name':
                    //                                           Utils.resimekleme[
                    //                                               'name']!,
                    //                                       'photo':
                    //                                           Utils.resimekleme[
                    //                                               'photo']!,
                    //                                     });
                    //                                   }
                    //                                 });
                    //                               }
                    //                             }
                    //                           }
                    //                         },

                    //                         borderRadius:
                    //                             BorderRadius.circular(30),
                    //                         child: Container(
                    //                           decoration: BoxDecoration(
                    //                               // boxShadow: [
                    //                               //   BoxShadow(
                    //                               //       color: Colors.purple
                    //                               //           .withOpacity(
                    //                               //               0.3),
                    //                               //       blurRadius: 2,
                    //                               //       spreadRadius: 1,
                    //                               //       offset:
                    //                               //           Offset(2, 2))
                    //                               // ],
                    //                               // gradient: LinearGradient(
                    //                               //     colors: [
                    //                               //       Colors.purple,
                    //                               //       Colors.deepPurple
                    //                               //     ]),
                    //                               borderRadius:
                    //                                   BorderRadius.circular(30)),
                    //                           child: Padding(
                    //                             padding:
                    //                                 const EdgeInsets.symmetric(
                    //                                     horizontal: 5,
                    //                                     vertical: 8),
                    //                             child: Row(
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment.center,
                    //                               children: [
                    //                                 // Icon(Icons.camera_alt_rounded),
                    //                                 // SizedBox(
                    //                                 //   width: 5,
                    //                                 // ),
                    //                                 Text('Kamera',
                    //                                     style: GoogleFonts.acme(
                    //                                         fontSize: 20,
                    //                                         color:
                    //                                             Colors.grey[900]))
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   flex: 1,
                    //                 ),
                    //                 Flexible(
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.all(10),
                    //                     child: Material(
                    //                       color: Colors.white,
                    //                       borderRadius: BorderRadius.circular(30),
                    //                       elevation: 2,
                    //                       child: InkWell(
                    //                         onTap: () async {
                    //                           await Permission.storage.request();
                    //                           await Permission.photos.request();
                    //                           if (await Permission
                    //                                   .storage.isGranted &&
                    //                               await Permission
                    //                                   .photos.isGranted) {
                    //                             var image = await ImagePicker()
                    //                                 .getImage(
                    //                                     source:
                    //                                         ImageSource.gallery);

                    //                             if (image != null) {
                    //                               var file = await ImageCropper
                    //                                   .cropImage(
                    //                                       sourcePath: image.path,
                    //                                       cropStyle:
                    //                                           CropStyle.circle);
                    //                               if (file != null) {
                    //                                 Get.back();
                    //                                 firebaseApi.avatarFile.value =
                    //                                     file;
                    //                                 firebaseApi.avatarIsAsset
                    //                                     .value = false;
                    //                                 firebaseApi.firestore
                    //                                     .collection('Users')
                    //                                     .doc(firebaseApi.auth
                    //                                         .currentUser!.uid)
                    //                                     .collection('Rosettes')
                    //                                     .where('name',
                    //                                         isEqualTo:
                    //                                             Utils.resimekleme[
                    //                                                 'name']!)
                    //                                     .get()
                    //                                     .then((value) {
                    //                                   if (value.docs.isEmpty) {
                    //                                     firebaseApi.exp =
                    //                                         firebaseApi.exp + 100;
                    //                                     Get.snackbar(
                    //                                         'Başarı kazandın',
                    //                                         Utils.resimekleme[
                    //                                             'name']!,
                    //                                         icon: Padding(
                    //                                           padding:
                    //                                               const EdgeInsets
                    //                                                       .symmetric(
                    //                                                   horizontal:
                    //                                                       5),
                    //                                           child: Icon(
                    //                                             Icons
                    //                                                 .emoji_events_outlined,
                    //                                             size: 35,
                    //                                           ),
                    //                                         ));
                    //                                     firebaseApi.firestore
                    //                                         .collection('Users')
                    //                                         .doc(firebaseApi.auth
                    //                                             .currentUser!.uid)
                    //                                         .collection(
                    //                                             'Rosettes')
                    //                                         .add({
                    //                                       'name':
                    //                                           Utils.resimekleme[
                    //                                               'name']!,
                    //                                       'photo':
                    //                                           Utils.resimekleme[
                    //                                               'photo']!,
                    //                                     });
                    //                                   }
                    //                                 });
                    //                               }
                    //                             }
                    //                           }
                    //                         },
                    //                         borderRadius:
                    //                             BorderRadius.circular(30),
                    //                         child: Container(
                    //                           decoration: BoxDecoration(
                    //                               // boxShadow: [
                    //                               //   BoxShadow(
                    //                               //       color: Colors.purple
                    //                               //           .withOpacity(
                    //                               //               0.3),
                    //                               //       blurRadius: 2,
                    //                               //       spreadRadius: 1,
                    //                               //       offset:
                    //                               //           Offset(2, 2))
                    //                               // ],
                    //                               // gradient: LinearGradient(
                    //                               //     colors: [
                    //                               //       Colors.purple,
                    //                               //       Colors.deepPurple
                    //                               //     ]),
                    //                               borderRadius:
                    //                                   BorderRadius.circular(30)),
                    //                           child: Padding(
                    //                             padding:
                    //                                 const EdgeInsets.symmetric(
                    //                                     horizontal: 5,
                    //                                     vertical: 8),
                    //                             child: Row(
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment.center,
                    //                               children: [
                    //                                 // Icon(Icons.camera_alt_rounded),
                    //                                 // SizedBox(
                    //                                 //   width: 5,
                    //                                 // ),
                    //                                 Text('Galeri',
                    //                                     style: GoogleFonts.acme(
                    //                                         fontSize: 20,
                    //                                         color:
                    //                                             Colors.grey[900]))
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   flex: 1,
                    //                 ),
                    //                 // Flexible(
                    //                 //   child: Padding(
                    //                 //     padding: const EdgeInsets.all(10),
                    //                 //     child: Container(
                    //                 //       decoration: BoxDecoration(
                    //                 //           boxShadow: [
                    //                 //             BoxShadow(
                    //                 //                 color: Colors.green
                    //                 //                     .withOpacity(0.3),
                    //                 //                 blurRadius: 2,
                    //                 //                 spreadRadius: 1,
                    //                 //                 offset: Offset(2, 2))
                    //                 //           ],
                    //                 //           gradient: LinearGradient(
                    //                 //               colors: [
                    //                 //                 Colors.green,
                    //                 //                 Colors.lightGreen
                    //                 //               ]),
                    //                 //           borderRadius:
                    //                 //               BorderRadius.circular(
                    //                 //                   30)),
                    //                 //       child: Padding(
                    //                 //         padding:
                    //                 //             const EdgeInsets.symmetric(
                    //                 //                 horizontal: 5,
                    //                 //                 vertical: 8),
                    //                 //         child: Row(
                    //                 //           mainAxisAlignment:
                    //                 //               MainAxisAlignment.center,
                    //                 //           children: [
                    //                 //             // Icon(Icons.photo_library_rounded),
                    //                 //             // SizedBox(
                    //                 //             //   width: 5,
                    //                 //             // ),
                    //                 //             Text('Galeri',
                    //                 //                 style: GoogleFonts.acme(
                    //                 //                     fontSize: 20,
                    //                 //                     color:
                    //                 //                         Colors.white))
                    //                 //           ],
                    //                 //         ),
                    //                 //       ),
                    //                 //     ),
                    //                 //   ),
                    //                 //   flex: 1,
                    //                 // ),
                    //               ],
                    //             ),
                    //             Expanded(
                    //               child: GridView.builder(
                    //                 padding: EdgeInsets.zero,
                    //                 physics: BouncingScrollPhysics(),
                    //                 itemCount: Utils.avatars.length,
                    //                 gridDelegate:
                    //                     SliverGridDelegateWithFixedCrossAxisCount(
                    //                         crossAxisCount: 3),
                    //                 itemBuilder: (context, index) {
                    //                   return Padding(
                    //                     padding: const EdgeInsets.all(5),
                    //                     child: GestureDetector(
                    //                       onTap: () {
                    //                         firebaseApi.avatarIsAsset.value =
                    //                             true;
                    //                         firebaseApi.avatar.value =
                    //                             'assets/avatars/${Utils.avatars[index]}';
                    //                         Get.back();
                    //                         firebaseApi.firestore
                    //                             .collection('Users')
                    //                             .doc(firebaseApi
                    //                                 .auth.currentUser!.uid)
                    //                             .collection('Rosettes')
                    //                             .where('name',
                    //                                 isEqualTo: Utils
                    //                                     .resimekleme['name']!)
                    //                             .get()
                    //                             .then((value) {
                    //                           if (value.docs.isEmpty) {
                    //                             firebaseApi.exp =
                    //                                 firebaseApi.exp + 100;
                    //                             Get.snackbar('Başarı kazandın',
                    //                                 Utils.resimekleme['name']!,
                    //                                 icon: Padding(
                    //                                   padding: const EdgeInsets
                    //                                           .symmetric(
                    //                                       horizontal: 5),
                    //                                   child: Icon(
                    //                                     Icons
                    //                                         .emoji_events_outlined,
                    //                                     size: 35,
                    //                                   ),
                    //                                 ));
                    //                             firebaseApi.firestore
                    //                                 .collection('Users')
                    //                                 .doc(firebaseApi
                    //                                     .auth.currentUser!.uid)
                    //                                 .collection('Rosettes')
                    //                                 .add({
                    //                               'name':
                    //                                   Utils.resimekleme['name']!,
                    //                               'photo':
                    //                                   Utils.resimekleme['photo']!,
                    //                             });
                    //                           }
                    //                         });
                    //                       },
                    //                       child: Container(
                    //                         height: 50,
                    //                         width: 50,
                    //                         child: CircleAvatar(
                    //                             backgroundColor:
                    //                                 Colors.transparent,
                    //                             radius: 30,
                    //                             backgroundImage: AssetImage(
                    //                                 'assets/avatars/${Utils.avatars[index]}')),
                    //                       ),
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       decoration: BoxDecoration(
                    //           color: Colors.grey[50],
                    //           borderRadius: BorderRadius.vertical(
                    //               top: Radius.circular(20))),
                    //       height: MediaQuery.of(context).size.height * 0.65,
                    //       width: double.maxFinite,
                    //     );
                    //   },
                    // );
                  },
                  child: firebaseApi.avatarIsAsset.value
                      ? CircleAvatar(
                          backgroundImage: AssetImage(
                            firebaseApi.avatar.value,
                          ),
                          backgroundColor: Colors.transparent,
                          radius: 60,
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              FileImage(firebaseApi.avatarFile.value),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Avatar seçin',
                  style: GoogleFonts.roboto(fontSize: 25),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z0-9 ğüşöçəıIİĞÜƏŞÖÇЁёА-я]")),
                    ],
                    cursorColor:
                        context.isDarkMode ? Colors.white : Colors.black,
                    cursorRadius: Radius.circular(10),
                    onChanged: (value) {
                      firebaseApi.name.value = value;
                      firebaseApi.chechToQuestion();
                    },
                    maxLines: 1,
                    scrollPadding: EdgeInsets.zero,
                    controller: nameContoller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'İsim',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                width: 2))),
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('Doğum tarihi',
                    style: GoogleFonts.roboto(
                        fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    var max = DateTime(DateTime.now().year - 16,
                        DateTime.now().month, DateTime.now().day);
                    var time = await DatePicker.showDatePicker(
                      context,
                      maxTime: max,
                      currentTime: firebaseApi.dateTime,
                      onConfirm: (date) {
                        firebaseApi.date.value =
                            '${date.year} - ${date.month} - ${date.day}';
                        firebaseApi.age = DateTime.now().year - date.year;
                        firebaseApi.dateTime = date;
                        firebaseApi.chechToQuestion();
                      },
                      locale: LocaleType.tr,
                      theme: DatePickerTheme(
                          containerHeight: 300,
                          headerColor:
                              context.isDarkMode ? Colors.black : Colors.white,
                          backgroundColor: context.isDarkMode
                              ? Colors.grey[900]!
                              : Colors.grey[200]!,
                          itemStyle: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          cancelStyle: TextStyle(
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                          ),
                          doneStyle: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: context.isDarkMode
                            ? Colors.grey[900]
                            : Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(firebaseApi.date.value,
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Icon(Icons.calendar_today_rounded),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // CustomNumberPicker(
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20)),
                //     valueTextStyle:
                //         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //     customAddButton: Padding(
                //       padding: const EdgeInsets.only(left: 20),
                //       child: CircleAvatar(
                //         child: Icon(
                //           Icons.exposure_plus_1,
                //           color: Colors.green,
                //         ),
                //         backgroundColor: Colors.grey[200],
                //       ),
                //     ),
                //     customMinusButton: Padding(
                //       padding: const EdgeInsets.only(right: 20),
                //       child: CircleAvatar(
                //         child: Icon(
                //           Icons.exposure_minus_1,
                //           color: Colors.red,
                //         ),
                //         backgroundColor: Colors.grey[200],
                //       ),
                //     ),
                //     onValue: (value) {
                //       firebaseApi.age = value;
                //     },
                //     initialValue: 18,
                //     maxValue: 100,
                //     minValue: 18),
                SizedBox(
                  height: 10,
                ),

                Text(
                  'Cinsiyet',
                  style: GoogleFonts.roboto(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Container(
                  width: Get.width * 0.92,
                  height: 55,
                  decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? Colors.grey[600]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.sex.value = 'f';
                            firebaseApi.chechToQuestion();
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Kadın',
                                  minFontSize: 12,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: firebaseApi.sex.value == 'f'
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: firebaseApi.sex.value == 'f'
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.sex.value = 'n';
                            firebaseApi.chechToQuestion();
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Belirtmek istemiyorum',
                                  minFontSize: 12,
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                  wrapWords: true,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: firebaseApi.sex.value == 'n'
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: firebaseApi.sex.value == 'n'
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.sex.value = 'o';
                            firebaseApi.chechToQuestion();
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Diğer',
                                  maxLines: 1,
                                  minFontSize: 12,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: firebaseApi.sex.value == 'o'
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: firebaseApi.sex.value == 'o'
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.sex.value = 'm';
                            firebaseApi.chechToQuestion();
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Erkek',
                                  maxLines: 2,
                                  minFontSize: 12,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: firebaseApi.sex.value == 'm'
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: firebaseApi.sex.value == 'm'
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Material(
                //           borderRadius: BorderRadius.circular(20),
                //           color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                //           child: InkWell(
                //             borderRadius: BorderRadius.circular(20),
                //             onTap: () {
                //               showCupertinoModalPopup(
                //                 barrierColor: Colors.grey[200]!.withOpacity(0.65),
                //                 filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                //                 context: context,
                //                 builder: (context) {
                //                   return Container(
                //                     child: Padding(
                //                       padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                //                       child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                //                         future: firebaseApi.getCountries(),
                //                         builder: (context, snapshot) {
                //                           return snapshot.hasData
                //                               ? ListView.builder(
                //                                   padding: EdgeInsets.zero,
                //                                   physics: BouncingScrollPhysics(),
                //                                   itemCount: snapshot.data!.docs.length,
                //                                   itemBuilder: (context, index) {
                //                                     return Padding(
                //                                       padding: const EdgeInsets.all(2),
                //                                       child: Material(
                //                                         borderRadius: BorderRadius.circular(20),
                //                                         color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                //                                         child: InkWell(
                //                                             borderRadius: BorderRadius.circular(20),
                //                                             onTap: () {
                //                                               firebaseApi.countrySelected.value = true;
                //                                               firebaseApi.country.value = snapshot.data!.docs[index]['name'];
                //                                               firebaseApi.city.value = 'Şehir';
                //                                               firebaseApi.chechToQuestion();
                //                                               Get.back();
                //                                             },
                //                                             child: Padding(
                //                                               padding: const EdgeInsets.all(17),
                //                                               child: Text(
                //                                                 snapshot.data!.docs[index]['name'],
                //                                                 style: TextStyle(fontSize: 18),
                //                                               ),
                //                                             )),
                //                                       ),
                //                                     );
                //                                   },
                //                                 )
                //                               : Container();
                //                         },
                //                       ),
                //                     ),
                //                     width: double.maxFinite,
                //                     height: MediaQuery.of(context).size.height * 0.4,
                //                     decoration: BoxDecoration(color: context.isDarkMode ? Colors.black : Colors.grey[50], borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                //                   );
                //                 },
                //               );
                //             },
                //             child: Center(
                //               child: Padding(
                //                 padding: const EdgeInsets.all(15),
                //                 child: Text(
                //                   firebaseApi.country.value,
                //                   maxLines: 1,
                //                   overflow: TextOverflow.ellipsis,
                //                   style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 5),
                //         child: Text(
                //           '\n,',
                //           style: TextStyle(fontSize: 20),
                //         ),
                //       ),
                //       Expanded(
                //         child: Material(
                //           borderRadius: BorderRadius.circular(20),
                //           color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                //           child: InkWell(
                //             borderRadius: BorderRadius.circular(20),
                //             onTap: firebaseApi.countrySelected.value
                //                 ? () {
                //                     showCupertinoModalPopup(
                //                       barrierColor: Colors.grey[200]!.withOpacity(0.65),
                //                       filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                //                       context: context,
                //                       builder: (context) {
                //                         return Container(
                //                           child: Padding(
                //                             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                //                             child: FutureBuilder<List<String>>(
                //                               future: firebaseApi.getCities(firebaseApi.country.value),
                //                               builder: (context, snapshot) {
                //                                 return snapshot.hasData
                //                                     ? ListView.builder(
                //                                         padding: EdgeInsets.zero,
                //                                         physics: BouncingScrollPhysics(),
                //                                         itemCount: snapshot.data!.length,
                //                                         itemBuilder: (context, index) {
                //                                           return Padding(
                //                                             padding: const EdgeInsets.all(2),
                //                                             child: Material(
                //                                               borderRadius: BorderRadius.circular(20),
                //                                               color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                //                                               child: InkWell(
                //                                                   borderRadius: BorderRadius.circular(20),
                //                                                   onTap: () {
                //                                                     firebaseApi.city.value = snapshot.data![index];
                //                                                     firebaseApi.chechToQuestion();
                //                                                     Get.back();
                //                                                   },
                //                                                   child: Padding(
                //                                                     padding: const EdgeInsets.all(17),
                //                                                     child: Text(
                //                                                       snapshot.data![index],
                //                                                       style: TextStyle(fontSize: 18),
                //                                                     ),
                //                                                   )),
                //                                             ),
                //                                           );
                //                                         },
                //                                       )
                //                                     : Container();
                //                               },
                //                             ),
                //                           ),
                //                           width: double.maxFinite,
                //                           height: MediaQuery.of(context).size.height * 0.4,
                //                           decoration: BoxDecoration(color: context.isDarkMode ? Colors.black : Colors.grey[50], borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                //                         );
                //                       },
                //                     );
                //                   }
                //                 : null,
                //             child: Center(
                //               child: Padding(
                //                 padding: const EdgeInsets.all(15),
                //                 child: Text(
                //                   firebaseApi.city.value,
                //                   maxLines: 1,
                //                   overflow: TextOverflow.ellipsis,
                //                   style: firebaseApi.countrySelected.value
                //                       ? GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)
                //                       : GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Material(
                //         borderRadius: BorderRadius.circular(20),
                //         color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                //         child: InkWell(
                //           onTap: () async {
                //             LocationPermission permission = await Geolocator.checkPermission();
                //             if (permission.index == 0) {
                //               await Geolocator.requestPermission();
                //             } else {
                //               Position position = await Geolocator.getCurrentPosition();

                //               List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
                //               firebaseApi.country.value = placemarks.first.country!;
                //               firebaseApi.city.value = placemarks.first.administrativeArea!;
                //             }
                //           },
                //           borderRadius: BorderRadius.circular(20),
                //           child: Center(
                //             child: Padding(
                //               padding: const EdgeInsets.all(15),
                //               child: Icon(Icons.location_on_rounded),
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 25,
                // ),
                // Text(
                //   'Oynadığım platformlar',
                //   style: GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   decoration: BoxDecoration(color: context.isDarkMode ? Colors.black : Colors.grey[200], borderRadius: BorderRadius.circular(20)),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         GestureDetector(
                //           onTap: () {
                //             firebaseApi.pc.value = !firebaseApi.pc.value;
                //             firebaseApi.chechToQuestion();
                //           },
                //           onLongPress: () {
                //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //                 content: Row(
                //               children: [
                //                 Text(
                //                   'PC platformu',
                //                   style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
                //                 )
                //               ],
                //             )));
                //           },
                //           child: CircleAvatar(
                //             backgroundColor: firebaseApi.pc.value ? Colors.green : Colors.white,
                //             child: firebaseApi.pc.value
                //                 ? Center(
                //                     child: Padding(
                //                       padding: const EdgeInsets.all(6),
                //                       child: Image.asset('assets/pc.png'),
                //                     ),
                //                   )
                //                 : Container(
                //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(90), color: Colors.grey.withOpacity(0.7)),
                //                     child: Center(
                //                       child: Padding(
                //                         padding: const EdgeInsets.all(6),
                //                         child: Image.asset('assets/pc.png'),
                //                       ),
                //                     ),
                //                   ),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             firebaseApi.ps.value = !firebaseApi.ps.value;
                //             firebaseApi.chechToQuestion();
                //           },
                //           onLongPress: () {
                //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //                 content: Row(
                //               children: [
                //                 Text(
                //                   'PlayStation platformu',
                //                   style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
                //                 )
                //               ],
                //             )));
                //           },
                //           child: CircleAvatar(
                //             backgroundColor: firebaseApi.ps.value ? Colors.green : Colors.white,
                //             child: firebaseApi.ps.value
                //                 ? Center(
                //                     child: Padding(
                //                       padding: const EdgeInsets.all(6),
                //                       child: Image.asset('assets/ps.png'),
                //                     ),
                //                   )
                //                 : Container(
                //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(90), color: Colors.grey.withOpacity(0.7)),
                //                     child: Center(
                //                       child: Padding(
                //                         padding: const EdgeInsets.all(6),
                //                         child: Image.asset('assets/ps.png'),
                //                       ),
                //                     ),
                //                   ),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             firebaseApi.mobile.value = !firebaseApi.mobile.value;
                //             firebaseApi.chechToQuestion();
                //           },
                //           onLongPress: () {
                //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //                 content: Row(
                //               children: [
                //                 Text(
                //                   'Mobil platform',
                //                   style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
                //                 )
                //               ],
                //             )));
                //           },
                //           child: CircleAvatar(
                //             backgroundColor: firebaseApi.mobile.value ? Colors.green : Colors.white,
                //             child: firebaseApi.mobile.value
                //                 ? Center(
                //                     child: Padding(
                //                       padding: const EdgeInsets.all(6),
                //                       child: Image.asset('assets/mobil-icon.png'),
                //                     ),
                //                   )
                //                 : Container(
                //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(90), color: Colors.grey.withOpacity(0.7)),
                //                     child: Center(
                //                       child: Padding(
                //                         padding: const EdgeInsets.all(6),
                //                         child: Image.asset('assets/mobil-icon.png'),
                //                       ),
                //                     ),
                //                   ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        color: context.isDarkMode
                            ? Colors.grey[900]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: firebaseApi.toQuestions.value
                              ? () {
                                  if (firebaseApi.avatar.value ==
                                      'assets/user.png') {
                                    Get.snackbar('Avatar seçilmedi',
                                        'Devam etmek için avatar seçiniz');
                                  } else {
                                    widget.controller.animateToPage(4,
                                        duration: Duration(milliseconds: 250),
                                        curve: Curves.linear);
                                  }
                                }
                              : null,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Text(
                                  'İleri',
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: 5),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                firebaseApi.avatar.value == 'assets/user.png'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.red[800],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Avatar seçilmedi',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[800])),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    : const SizedBox(),
                firebaseApi.sex.value == 'null'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.red[800],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Cinsiyet seçilmedi',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[800])),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    : const SizedBox(),
                firebaseApi.date.value == 'Tarih seçin'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.red[800],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Tarih seçilmedi',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[800])),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    : const SizedBox(),
                firebaseApi.name.value.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.red[800],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Lütfen isim girin',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[800])),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    : firebaseApi.name.value.length < 3
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.red[800],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('İsminiz en az 3 karakterden oluşmalı',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[800])),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        : firebaseApi.name.value.length > 12
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Icon(
                                      Icons.error_outline,
                                      color: Colors.red[800],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      'İsminiz en fazla 12 karakterden oluşmalı',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red[800])),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                // SizedBox(
                //   height: 5,
                // ),
                // firebaseApi.country.value == 'Ülke' || firebaseApi.city.value == 'Şehir'
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(bottom: 2),
                //             child: Icon(
                //               Icons.error_outline,
                //               color: Colors.red[800],
                //             ),
                //           ),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           Text('Lütfen konum girin', style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red[800])),
                //           SizedBox(
                //             width: 20,
                //           ),
                //         ],
                //       )
                //     : Container(),
                // SizedBox(
                //   height: 5,
                // ),
                // !firebaseApi.pc.value && !firebaseApi.ps.value && !firebaseApi.mobile.value
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(bottom: 2),
                //             child: Icon(
                //               Icons.error_outline,
                //               color: Colors.red[800],
                //             ),
                //           ),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           Text('Lütfen platform seçin', style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red[800])),
                //           SizedBox(
                //             width: 20,
                //           ),
                //         ],
                //       )
                //     : Container(),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
