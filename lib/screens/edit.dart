import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/editProfileGetx.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/screens/addAccount.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:radar_chart/radar_chart.dart' as radar;
import 'package:gamehub/screens/addGame.dart';
import 'package:gamehub/screens/addSocial.dart';
import 'package:gamehub/screens/addStats.dart';
import 'package:gamehub/screens/newLevel.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:time_range_picker/time_range_picker.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  FirebaseApi firebaseApi = Get.find();
  EditProfileGetx editProfileGetx = Get.find();
  InfosGetx infosGetx = Get.find();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  @override
  Widget build(BuildContext context) {
    editProfileGetx.resetName();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profili düzenle',
          style: GoogleFonts.roboto(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
                onPressed: editProfileGetx.name.value.isEmpty ||
                        editProfileGetx.loading.value
                    ? null
                    : editProfileGetx.name.value.trim().length < 3
                        ? null
                        : editProfileGetx.name.value.trim().length > 12
                            ? null
                            : () async {
                                editProfileGetx.loading.value = true;
                                await firebaseApi.firestore
                                    .collection('Users')
                                    .doc(firebaseApi.auth.currentUser!.uid)
                                    .update({
                                  'name': name.text.trim(),
                                  'bio': bio.text.trim()
                                });
                                await firebaseApi.firestore
                                    .collection('Users')
                                    .doc(firebaseApi.auth.currentUser!.uid)
                                    .get()
                                    .then((value) {
                                  infosGetx.addInfos(
                                      name.text.trim(),
                                      value.data()!['avatar'],
                                      infosGetx.age.value,
                                      value.data()!['avatarIsAsset']);
                                  editProfileGetx.loading.value = false;
                                  Get.back();
                                });
                              },
                icon: Icon(
                  editProfileGetx.loading.value
                      ? Icons.watch_later_outlined
                      : Icons.done,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                )),
          ),
        ],
        // leading: IconButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: context.isDarkMode ? Colors.white : Colors.black,
        //     )),
        leading: Container(),
        backgroundColor: context.isDarkMode ? Colors.grey[900] : Colors.white,
      ),
      extendBodyBehindAppBar: false,
      body: Container(
        color: context.isDarkMode ? Colors.black : Colors.grey[200],
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: firebaseApi.firestore
                .collection('Users')
                .doc(firebaseApi.auth.currentUser!.uid)
                .snapshots(),
            builder: (context1, user) {
              if (user.hasData) {
                name.text = user.data!.data()!['name'];
                if (editProfileGetx.bio.value == 'bio') {
                  bio.text = user.data!.data()!['bio'];
                } else {
                  bio.text = editProfileGetx.bio.value;
                }
              }

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
                                  GestureDetector(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                        context: context,
                                        barrierColor:
                                            Colors.grey[200]!.withOpacity(0.65),
                                        filter: ImageFilter.blur(
                                            sigmaX: 2, sigmaY: 2),
                                        builder: (context1) {
                                          return Container(
                                            color: context.isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 30),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 40),
                                                    child: Material(
                                                      color: context.isDarkMode
                                                          ? Colors.grey[900]
                                                          : Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                          showCupertinoModalPopup(
                                                            barrierColor: Colors
                                                                .grey[200]!
                                                                .withOpacity(
                                                                    0.65),
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 2,
                                                                    sigmaY: 2),
                                                            context: context,
                                                            builder: (context) {
                                                              return DefaultTabController(
                                                                length: 3,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            10,
                                                                            10,
                                                                            10,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Theme(
                                                                          data: ThemeData(
                                                                              splashColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent),
                                                                          child:
                                                                              Material(
                                                                            color: context.isDarkMode
                                                                                ? Colors.grey[900]
                                                                                : Colors.grey[50],
                                                                            child:
                                                                                TabBar(
                                                                              labelColor: context.isDarkMode ? Colors.white : Colors.grey[900],
                                                                              unselectedLabelColor: Colors.grey,
                                                                              labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                                                                              unselectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16),
                                                                              indicatorColor: Colors.transparent,
                                                                              indicatorWeight: 3,
                                                                              labelPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                                                              tabs: [
                                                                                Tab(
                                                                                  iconMargin: EdgeInsets.zero,
                                                                                  // text: 'Mesajlar',
                                                                                  child: Container(
                                                                                    width: double.maxFinite,
                                                                                    child: Center(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                        child: Text(
                                                                                          '1. Seviye',
                                                                                          textAlign: TextAlign.center,
                                                                                          overflow: TextOverflow.visible,
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                        gradient: context.isDarkMode
                                                                                            ? LinearGradient(colors: [
                                                                                                Colors.grey[700]!,
                                                                                                Colors.grey[800]!,
                                                                                                // Colors.grey.withOpacity(0.15),
                                                                                                // Colors.grey.withOpacity(0.10),
                                                                                                // Colors.grey.withOpacity(0.05),
                                                                                              ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                                                                                            : LinearGradient(colors: [
                                                                                                Color(0xFFdfe9f3),
                                                                                                Colors.grey[100]!,
                                                                                                // Colors.grey.withOpacity(0.15),
                                                                                                // Colors.grey.withOpacity(0.10),
                                                                                                // Colors.grey.withOpacity(0.05),
                                                                                              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                                                                                  ),
                                                                                ),
                                                                                Tab(
                                                                                  iconMargin: EdgeInsets.zero,
                                                                                  // text: 'Mesajlar',
                                                                                  child: Container(
                                                                                    width: double.maxFinite,
                                                                                    child: Center(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                        child: Text(
                                                                                          '2. Seviye',
                                                                                          textAlign: TextAlign.center,
                                                                                          overflow: TextOverflow.visible,
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: context.isDarkMode ? Colors.grey[800] : Colors.grey[100]!),
                                                                                  ),
                                                                                ),
                                                                                Tab(
                                                                                  iconMargin: EdgeInsets.zero,
                                                                                  // text: 'Mesajlar',
                                                                                  child: Container(
                                                                                    width: double.maxFinite,
                                                                                    child: Center(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                        child: Text(
                                                                                          '3. Seviye',
                                                                                          overflow: TextOverflow.visible,
                                                                                          textAlign: TextAlign.center,
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                        gradient: context.isDarkMode
                                                                                            ? LinearGradient(colors: [
                                                                                                Colors.grey[800]!,
                                                                                                Colors.grey[700]!,
                                                                                                // Colors.grey.withOpacity(0.15),
                                                                                                // Colors.grey.withOpacity(0.10),
                                                                                                // Colors.grey.withOpacity(0.05),
                                                                                              ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                                                                                            : LinearGradient(colors: [
                                                                                                Colors.grey[100]!,
                                                                                                Color(0xFFdfe9f3),
                                                                                                // Colors.grey.withOpacity(0.15),
                                                                                                // Colors.grey.withOpacity(0.10),
                                                                                                // Colors.grey.withOpacity(0.05),
                                                                                              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
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
                                                                          child:
                                                                              TabBarView(
                                                                            children: [
                                                                              GridView.builder(
                                                                                padding: EdgeInsets.zero,
                                                                                physics: BouncingScrollPhysics(),
                                                                                itemCount: Utils.avatars.length,
                                                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                                                                itemBuilder: (context, index) {
                                                                                  return Padding(
                                                                                    padding: const EdgeInsets.all(5),
                                                                                    child: GestureDetector(
                                                                                      onTap: () async {
                                                                                        await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                          'avatarIsAsset': true,
                                                                                          'avatar': 'assets/avatars/${Utils.avatars[index]}'
                                                                                        });
                                                                                        Get.back();
                                                                                        firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.resimekleme['name']!).get().then((value) async {
                                                                                          if (value.docs.isEmpty) {
                                                                                            Get.snackbar('Başarı kazandın', Utils.resimekleme['name']!,
                                                                                                icon: Padding(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                  child: Icon(
                                                                                                    Icons.emoji_events_outlined,
                                                                                                    size: 35,
                                                                                                  ),
                                                                                                ));
                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                              'name': Utils.resimekleme['name']!,
                                                                                              'photo': Utils.resimekleme['photo']!,
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
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 50,
                                                                                        width: 50,
                                                                                        child: CircleAvatar(backgroundColor: Colors.transparent, radius: 30, backgroundImage: AssetImage('assets/avatars/${Utils.avatars[index]}')),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                              Obx(
                                                                                () => Stack(
                                                                                  children: [
                                                                                    Opacity(
                                                                                      opacity: infosGetx.twoLevelAvatar.value ? 1 : 0.3,
                                                                                      child: IgnorePointer(
                                                                                        ignoring: infosGetx.twoLevelAvatar.value ? false : true,
                                                                                        child: GridView.builder(
                                                                                          padding: EdgeInsets.zero,
                                                                                          physics: BouncingScrollPhysics(),
                                                                                          itemCount: Utils.avatars2.length,
                                                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                                                                          itemBuilder: (context, index) {
                                                                                            return Padding(
                                                                                              padding: const EdgeInsets.all(5),
                                                                                              child: GestureDetector(
                                                                                                onTap: () async {
                                                                                                  await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                                    'avatarIsAsset': true,
                                                                                                    'avatar': 'assets/avatars/level2/${Utils.avatars2[index]}'
                                                                                                  });
                                                                                                  Get.back();

                                                                                                  firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.resimekleme['name']!).get().then((value) async {
                                                                                                    if (value.docs.isEmpty) {
                                                                                                      Get.snackbar('Başarı kazandın', Utils.resimekleme['name']!,
                                                                                                          icon: Padding(
                                                                                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                            child: Icon(
                                                                                                              Icons.emoji_events_outlined,
                                                                                                              size: 35,
                                                                                                            ),
                                                                                                          ));
                                                                                                      firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                                        'name': Utils.resimekleme['name']!,
                                                                                                        'photo': Utils.resimekleme['photo']!,
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
                                                                                                },
                                                                                                child: Container(
                                                                                                  height: 50,
                                                                                                  width: 50,
                                                                                                  child: CircleAvatar(backgroundColor: Colors.transparent, radius: 30, backgroundImage: AssetImage('assets/avatars/level2/${Utils.avatars2[index]}')),
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    infosGetx.twoLevelAvatar.value
                                                                                        ? Container()
                                                                                        : GestureDetector(
                                                                                            onTap: () {
                                                                                              //reklam
                                                                                              RewardedAd.load(
                                                                                                  adUnitId: Utils.ad_id,
                                                                                                  request: AdRequest(),
                                                                                                  rewardedAdLoadCallback: RewardedAdLoadCallback(
                                                                                                      onAdLoaded: (add) {
                                                                                                        add.show(onUserEarnedReward: (add, item) {
                                                                                                          //give reward
                                                                                                          infosGetx.twoLevelAvatar.value = true;
                                                                                                          firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'twoLevelAvatar': true});
                                                                                                        });
                                                                                                      },
                                                                                                      onAdFailedToLoad: (add) {}));
                                                                                            },
                                                                                            child: Center(
                                                                                              child: Material(
                                                                                                color: Colors.transparent,
                                                                                                child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Image.asset(
                                                                                                      'assets/lock.png',
                                                                                                      color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                                      height: 100,
                                                                                                      width: 100,
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 15,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      'Kilidi açmak için reklam izleyin',
                                                                                                      style: GoogleFonts.roboto(color: context.isDarkMode ? Colors.white : Colors.black, fontSize: 25),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                                                                  future: firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get(),
                                                                                  builder: (context, snapshot) {
                                                                                    return snapshot.hasData
                                                                                        ? Stack(
                                                                                            children: [
                                                                                              Opacity(
                                                                                                opacity: snapshot.data!.data()!['level'] > 9 ? 1 : 0.3,
                                                                                                child: IgnorePointer(
                                                                                                  ignoring: snapshot.data!.data()!['level'] < 10,
                                                                                                  child: GridView.builder(
                                                                                                    padding: EdgeInsets.zero,
                                                                                                    physics: BouncingScrollPhysics(),
                                                                                                    itemCount: Utils.avatars3.length,
                                                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                                                                                    itemBuilder: (context, index) {
                                                                                                      return Padding(
                                                                                                        padding: const EdgeInsets.all(5),
                                                                                                        child: GestureDetector(
                                                                                                          onTap: () async {
                                                                                                            await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                                              'avatarIsAsset': true,
                                                                                                              'avatar': 'assets/avatars/level3/${Utils.avatars3[index]}'
                                                                                                            });
                                                                                                            Get.back();
                                                                                                            firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.resimekleme['name']!).get().then((value) async {
                                                                                                              if (value.docs.isEmpty) {
                                                                                                                Get.snackbar('Başarı kazandın', Utils.resimekleme['name']!,
                                                                                                                    icon: Padding(
                                                                                                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                                      child: Icon(
                                                                                                                        Icons.emoji_events_outlined,
                                                                                                                        size: 35,
                                                                                                                      ),
                                                                                                                    ));
                                                                                                                firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                                                  'name': Utils.resimekleme['name']!,
                                                                                                                  'photo': Utils.resimekleme['photo']!,
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
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            height: 50,
                                                                                                            width: 50,
                                                                                                            child: CircleAvatar(backgroundColor: Colors.transparent, radius: 30, backgroundImage: AssetImage('assets/avatars/level3/${Utils.avatars3[index]}')),
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              snapshot.data!.data()!['level'] > 9
                                                                                                  ? Container()
                                                                                                  : Center(
                                                                                                      child: Material(
                                                                                                        color: Colors.transparent,
                                                                                                        child: Column(
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Image.asset(
                                                                                                              'assets/lock.png',
                                                                                                              color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                                              height: 100,
                                                                                                              width: 100,
                                                                                                            ),
                                                                                                            SizedBox(
                                                                                                              height: 15,
                                                                                                            ),
                                                                                                            Text(
                                                                                                              "Kilidi açmak için 10. seviye'ye ulaşın",
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: GoogleFonts.roboto(color: context.isDarkMode ? Colors.white : Colors.black, fontSize: 25),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                            ],
                                                                                          )
                                                                                        : Container(
                                                                                            child: Center(
                                                                                              child: SizedBox(
                                                                                                height: 50,
                                                                                                width: 50,
                                                                                                child: CircularProgressIndicator(
                                                                                                  color: Colors.green,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                  }),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      color: Get
                                                                              .isDarkMode
                                                                          ? Colors.grey[
                                                                              900]
                                                                          : Colors.grey[
                                                                              50],
                                                                      borderRadius:
                                                                          BorderRadius.vertical(
                                                                              top: Radius.circular(20))),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.65,
                                                                  width: double
                                                                      .maxFinite,
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(18),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Avatarı değiş',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 40),
                                                    child: Material(
                                                      color: context.isDarkMode
                                                          ? Colors.grey[900]
                                                          : Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                          showCupertinoModalPopup(
                                                            barrierColor: Colors
                                                                .grey[200]!
                                                                .withOpacity(
                                                                    0.65),
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 2,
                                                                    sigmaY: 2),
                                                            context: context,
                                                            builder: (context) {
                                                              return DefaultTabController(
                                                                length: 2,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            10,
                                                                            10,
                                                                            10,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Theme(
                                                                          data: ThemeData(
                                                                              splashColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent),
                                                                          child:
                                                                              Material(
                                                                            color: context.isDarkMode
                                                                                ? Colors.grey[900]
                                                                                : Colors.grey[50],
                                                                            child:
                                                                                TabBar(
                                                                              labelColor: context.isDarkMode ? Colors.white : Colors.grey[900],
                                                                              unselectedLabelColor: Colors.grey,
                                                                              labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                                                                              unselectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16),
                                                                              indicatorColor: Colors.transparent,
                                                                              indicatorWeight: 3,
                                                                              labelPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                                                              tabs: [
                                                                                Tab(
                                                                                  iconMargin: EdgeInsets.zero,
                                                                                  // text: 'Mesajlar',
                                                                                  child: Container(
                                                                                    width: double.maxFinite,
                                                                                    child: Center(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                        child: Text(
                                                                                          '1. Seviye',
                                                                                          overflow: TextOverflow.visible,
                                                                                          textAlign: TextAlign.center,
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                        gradient: context.isDarkMode
                                                                                            ? LinearGradient(colors: [
                                                                                                Colors.grey[700]!,
                                                                                                Colors.grey[800]!,
                                                                                                // Colors.grey.withOpacity(0.15),
                                                                                                // Colors.grey.withOpacity(0.10),
                                                                                                // Colors.grey.withOpacity(0.05),
                                                                                              ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                                                                                            : LinearGradient(colors: [
                                                                                                Color(0xFFdfe9f3),
                                                                                                Colors.grey[100]!,
                                                                                                // Colors.grey.withOpacity(0.15),
                                                                                                // Colors.grey.withOpacity(0.10),
                                                                                                // Colors.grey.withOpacity(0.05),
                                                                                              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                                                                                  ),
                                                                                ),
                                                                                Tab(
                                                                                  iconMargin: EdgeInsets.zero,
                                                                                  // text: 'Mesajlar',
                                                                                  child: Container(
                                                                                    width: double.maxFinite,
                                                                                    child: Center(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                        child: Text(
                                                                                          '2. Seviye',
                                                                                          overflow: TextOverflow.visible,
                                                                                          textAlign: TextAlign.center,
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                        gradient: context.isDarkMode
                                                                                            ? LinearGradient(colors: [
                                                                                                Colors.grey[800]!,
                                                                                                Colors.grey[700]!,
                                                                                                // Colors.grey.withOpacity(0.15),
                                                                                                // Colors.grey.withOpacity(0.10),
                                                                                                // Colors.grey.withOpacity(0.05),
                                                                                              ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                                                                                            : LinearGradient(colors: [
                                                                                                Colors.grey[100]!,
                                                                                                Color(0xFFdfe9f3),
                                                                                                // Colors.grey.withOpacity(0.15),
                                                                                                // Colors.grey.withOpacity(0.10),
                                                                                                // Colors.grey.withOpacity(0.05),
                                                                                              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
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
                                                                          child:
                                                                              TabBarView(
                                                                            children: [
                                                                              GridView.builder(
                                                                                padding: EdgeInsets.zero,
                                                                                physics: BouncingScrollPhysics(),
                                                                                itemCount: 10,
                                                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
                                                                                itemBuilder: (context, index) {
                                                                                  return Padding(
                                                                                    padding: const EdgeInsets.all(5),
                                                                                    child: GestureDetector(
                                                                                      onTap: () async {
                                                                                        await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                          'back': 'assets/back/arka-plan-${index + 1}.jpg',
                                                                                        });
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage('assets/back/arka-plan-${index + 1}.jpg'), fit: BoxFit.cover)),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                                                                  future: firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get(),
                                                                                  builder: (context, snapshot) {
                                                                                    return snapshot.hasData
                                                                                        ? Stack(
                                                                                            children: [
                                                                                              Opacity(
                                                                                                opacity: snapshot.data!.data()!['level'] > 7 ? 1 : 0.3,
                                                                                                child: IgnorePointer(
                                                                                                  ignoring: snapshot.data!.data()!['level'] < 8,
                                                                                                  child: GridView.builder(
                                                                                                    padding: EdgeInsets.zero,
                                                                                                    physics: BouncingScrollPhysics(),
                                                                                                    itemCount: 10,
                                                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
                                                                                                    itemBuilder: (context, index) {
                                                                                                      return Padding(
                                                                                                        padding: const EdgeInsets.all(5),
                                                                                                        child: GestureDetector(
                                                                                                          onTap: () async {
                                                                                                            await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                                              'back': 'assets/back/arka-plan-${index + 11}.jpg',
                                                                                                            });
                                                                                                            Get.back();
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage('assets/back/arka-plan-${index + 11}.jpg'), fit: BoxFit.cover)),
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              snapshot.data!.data()!['level'] > 7
                                                                                                  ? Container()
                                                                                                  : Center(
                                                                                                      child: Material(
                                                                                                        color: Colors.transparent,
                                                                                                        child: Column(
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Image.asset(
                                                                                                              'assets/lock.png',
                                                                                                              color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                                              height: 100,
                                                                                                              width: 100,
                                                                                                            ),
                                                                                                            SizedBox(
                                                                                                              height: 15,
                                                                                                            ),
                                                                                                            Text(
                                                                                                              "Kilidi açmak için 8. seviye'ye ulaşın",
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: GoogleFonts.roboto(color: context.isDarkMode ? Colors.white : Colors.black, fontSize: 25),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                            ],
                                                                                          )
                                                                                        : Container(
                                                                                            child: Center(
                                                                                              child: SizedBox(
                                                                                                height: 50,
                                                                                                width: 50,
                                                                                                child: CircularProgressIndicator(
                                                                                                  color: Colors.green,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                  }),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      color: Get
                                                                              .isDarkMode
                                                                          ? Colors.grey[
                                                                              900]
                                                                          : Colors.grey[
                                                                              50],
                                                                      borderRadius:
                                                                          BorderRadius.vertical(
                                                                              top: Radius.circular(20))),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.65,
                                                                  width: double
                                                                      .maxFinite,
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(18),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Arka plan değiştir',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 40),
                                                    child: Material(
                                                      color: context.isDarkMode
                                                          ? Colors.grey[900]
                                                          : Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                          showCupertinoModalPopup(
                                                            barrierColor: Colors
                                                                .grey[200]!
                                                                .withOpacity(
                                                                    0.65),
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 2,
                                                                    sigmaY: 2),
                                                            context: context,
                                                            builder: (context) {
                                                              return Container(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                  child: Column(
                                                                    children: [
                                                                      Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            Text(
                                                                          "Her gün Duogether'a\ngiriş yaparak, ödülünü topla",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: context.isDarkMode ? Colors.white : Colors.black,
                                                                              fontSize: 22,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: GridView
                                                                            .builder(
                                                                          padding:
                                                                              EdgeInsets.zero,
                                                                          physics:
                                                                              BouncingScrollPhysics(),
                                                                          itemCount:
                                                                              10,
                                                                          // itemCount: user.data!.data()!['maxDays'] >
                                                                          //         10
                                                                          //     ? 10
                                                                          //     : user.data!.data()!['maxDays'],
                                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                              crossAxisCount: 3,
                                                                              childAspectRatio: 1),
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.all(8),
                                                                              child: GestureDetector(
                                                                                onTap: () async {
                                                                                  if (user.data!.data()!['maxDays'] >= index + 1) {
                                                                                    await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                      'cover': index + 1,
                                                                                    });
                                                                                    Get.back();
                                                                                  }
                                                                                },
                                                                                child: Column(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Container(
                                                                                        // height: 50,
                                                                                        // width: 50,
                                                                                        child: Opacity(
                                                                                          opacity: user.data!.data()!['maxDays'] >= index + 1 ? 1 : 0.2,
                                                                                          child: Image.asset('assets/covers/level-${index + 1}.png'),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 3,
                                                                                    ),
                                                                                    Material(
                                                                                        color: Colors.transparent,
                                                                                        child: Text(
                                                                                          '${index + 1}. Gün',
                                                                                          style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
                                                                                        ))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors.grey[
                                                                            900]
                                                                        : Colors.grey[
                                                                            50],
                                                                    borderRadius:
                                                                        BorderRadius.vertical(
                                                                            top:
                                                                                Radius.circular(20))),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.55,
                                                                width: double
                                                                    .maxFinite,
                                                              );
                                                            },
                                                          );
                                                        },
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(18),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Çerçeveyi değiştir',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 180,
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
                                  ),
                                  Container(
                                    width: (Get.size.width - 40),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Obx(
                                          () => TextField(
                                            controller: name,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp("[a-zA-Z0-9 ]")),
                                            ],
                                            onChanged: (text) {
                                              editProfileGetx.name.value = text;
                                            },
                                            decoration: InputDecoration(
                                                errorText: editProfileGetx
                                                        .name.value.isEmpty
                                                    ? 'Lütfen isim girin'
                                                    : editProfileGetx.name.value
                                                                .trim()
                                                                .length <
                                                            3
                                                        ? 'İsim 3 karakterden uzun olmalı'
                                                        : editProfileGetx
                                                                    .name.value
                                                                    .trim()
                                                                    .length >
                                                                12
                                                            ? 'İsim 12 karakterden kısa olmalı'
                                                            : null),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Text(
                                        //   '${user.data!.data()!['name']}',
                                        //   textAlign: TextAlign.center,
                                        //   style: GoogleFonts.acme(fontSize: 25),
                                        // ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
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
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            // Text(
                                            //   '${user.data!.data()!['country']}, ${user.data!.data()!['city']}',
                                            //   textAlign: TextAlign.center,
                                            //   style: GoogleFonts.roboto(fontSize: 15),
                                            // ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.bottomSheet(
                                                  Container(
                                                    width: double.infinity,
                                                    height: 250,
                                                    color: context.isDarkMode
                                                        ? Colors.black
                                                        : Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Obx(
                                                        () => Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              'Konumu düzenle',
                                                              style: GoogleFonts.roboto(
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 24),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Material(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: Get
                                                                              .isDarkMode
                                                                          ? Colors.grey[
                                                                              900]
                                                                          : Colors
                                                                              .grey[200],
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          showCupertinoModalPopup(
                                                                            barrierColor:
                                                                                Colors.grey[200]!.withOpacity(0.65),
                                                                            filter:
                                                                                ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Container(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                                                  child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                                                                    future: firebaseApi.getCountries(),
                                                                                    builder: (context, snapshot) {
                                                                                      return snapshot.hasData
                                                                                          ? ListView.builder(
                                                                                              padding: EdgeInsets.zero,
                                                                                              physics: BouncingScrollPhysics(),
                                                                                              itemCount: snapshot.data!.docs.length,
                                                                                              itemBuilder: (context, index) {
                                                                                                return Padding(
                                                                                                  padding: const EdgeInsets.all(2),
                                                                                                  child: Material(
                                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                                    color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                                                                                                    child: InkWell(
                                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                                        onTap: () {
                                                                                                          firebaseApi.countrySelected.value = true;
                                                                                                          firebaseApi.country.value = snapshot.data!.docs[index]['name'];
                                                                                                          firebaseApi.city.value = 'Şehir';
                                                                                                          Get.back();
                                                                                                        },
                                                                                                        child: Padding(
                                                                                                          padding: const EdgeInsets.all(17),
                                                                                                          child: Text(
                                                                                                            snapshot.data!.docs[index]['name'],
                                                                                                            style: TextStyle(fontSize: 18),
                                                                                                          ),
                                                                                                        )),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            )
                                                                                          : Container();
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                width: double.maxFinite,
                                                                                height: MediaQuery.of(context).size.height * 0.4,
                                                                                decoration: BoxDecoration(color: context.isDarkMode ? Colors.black : Colors.grey[50], borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(15),
                                                                            child:
                                                                                Text(
                                                                              firebaseApi.country.value,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    child: Text(
                                                                      '-',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Material(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: Get
                                                                              .isDarkMode
                                                                          ? Colors.grey[
                                                                              900]
                                                                          : Colors
                                                                              .grey[200],
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap: firebaseApi.countrySelected.value
                                                                            ? () {
                                                                                showCupertinoModalPopup(
                                                                                  barrierColor: Colors.grey[200]!.withOpacity(0.65),
                                                                                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return Container(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                                                        child: FutureBuilder<List<String>>(
                                                                                          future: firebaseApi.getCities(firebaseApi.country.value),
                                                                                          builder: (context, snapshot) {
                                                                                            return snapshot.hasData
                                                                                                ? ListView.builder(
                                                                                                    padding: EdgeInsets.zero,
                                                                                                    physics: BouncingScrollPhysics(),
                                                                                                    itemCount: snapshot.data!.length,
                                                                                                    itemBuilder: (context, index) {
                                                                                                      return Padding(
                                                                                                        padding: const EdgeInsets.all(2),
                                                                                                        child: Material(
                                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                                          color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                                                                                                          child: InkWell(
                                                                                                              borderRadius: BorderRadius.circular(20),
                                                                                                              onTap: () {
                                                                                                                firebaseApi.city.value = snapshot.data![index];
                                                                                                                Get.back();
                                                                                                              },
                                                                                                              child: Padding(
                                                                                                                padding: const EdgeInsets.all(17),
                                                                                                                child: Text(
                                                                                                                  snapshot.data![index],
                                                                                                                  style: TextStyle(fontSize: 18),
                                                                                                                ),
                                                                                                              )),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  )
                                                                                                : Container();
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      width: double.maxFinite,
                                                                                      height: MediaQuery.of(context).size.height * 0.4,
                                                                                      decoration: BoxDecoration(color: context.isDarkMode ? Colors.black : Colors.grey[50], borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                                                                    );
                                                                                  },
                                                                                );
                                                                              }
                                                                            : null,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(15),
                                                                            child:
                                                                                Text(
                                                                              firebaseApi.city.value,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: firebaseApi.countrySelected.value ? GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold) : GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Material(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors.grey[
                                                                            900]
                                                                        : Colors
                                                                            .grey[200],
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        LocationPermission
                                                                            permission =
                                                                            await Geolocator.checkPermission();
                                                                        if (permission.index ==
                                                                            0) {
                                                                          await Geolocator
                                                                              .requestPermission();
                                                                        } else {
                                                                          Position
                                                                              position =
                                                                              await Geolocator.getCurrentPosition();

                                                                          List<Placemark>
                                                                              placemarks =
                                                                              await placemarkFromCoordinates(position.latitude, position.longitude);
                                                                          firebaseApi
                                                                              .country
                                                                              .value = placemarks.first.country!;
                                                                          firebaseApi
                                                                              .city
                                                                              .value = placemarks.first.administrativeArea!;
                                                                        }
                                                                      },
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(15),
                                                                          child:
                                                                              Icon(Icons.location_on_rounded),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                              child: Material(
                                                                elevation: 10,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                color: firebaseApi.city.value ==
                                                                            '' ||
                                                                        firebaseApi.city.value ==
                                                                            'Şehir'
                                                                    ? Colors.grey[
                                                                        900]
                                                                    : Colors.green[
                                                                        600],
                                                                child: InkWell(
                                                                  onTap: firebaseApi.city.value ==
                                                                              '' ||
                                                                          firebaseApi.city.value ==
                                                                              'Şehir'
                                                                      ? null
                                                                      : () {
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection(
                                                                                  'Users')
                                                                              .doc(firebaseApi
                                                                                  .auth.currentUser!.uid)
                                                                              .update({
                                                                            'country':
                                                                                firebaseApi.country.value,
                                                                            'city':
                                                                                firebaseApi.city.value
                                                                          });
                                                                        },
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    child: Center(
                                                                        child: Text(
                                                                      'Değiştir',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  isScrollControlled: true,
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${user.data!.data()!['country']}, ${user.data!.data()!['city']}',
                                                    maxLines: 4,
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                                  //   child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                  //       stream: firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').snapshots(),
                                  //       builder: (context, rosettes) {
                                  //         return rosettes.hasData
                                  //             ? rosettes.data!.docs.isNotEmpty
                                  //                 ? Container(
                                  //                     width: double.maxFinite,
                                  //                     height: 50,
                                  //                     decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                  //                     child: ListView.builder(
                                  //                       itemCount: rosettes.data!.docs.length,
                                  //                       scrollDirection: Axis.horizontal,
                                  //                       physics: BouncingScrollPhysics(),
                                  //                       shrinkWrap: true,
                                  //                       itemBuilder: (context, index) {
                                  //                         return Padding(
                                  //                           padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                  //                           child: Image.asset('assets/rosettes/${rosettes.data!.docs[index].data()['photo']}'),
                                  //                         );
                                  //                       },
                                  //                     ),
                                  //                   )
                                  //                 : Container(
                                  //                     width: double.maxFinite,
                                  //                     height: 40,
                                  //                     decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                  //                     child: Center(
                                  //                       child: Text('Henüz bir rozetin yok', style: GoogleFonts.roboto(fontSize: 20, color: Colors.black)),
                                  //                     ),
                                  //                   )
                                  //             : CircularPercentIndicator(radius: 20);
                                  //       }),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          // Text(
                                          //   'Hakkımda',
                                          //   style: GoogleFonts.acme(
                                          //       fontSize: 25),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: bio,
                                              maxLength: 300,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white.withOpacity(0.2)),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Get.to(() => AddGame(),
                                                transition:
                                                    Transition.cupertino);
                                          },
                                          icon: Icon(Icons.add),
                                          label: Text('Oyun ekle')),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                  StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      stream: firebaseApi.firestore
                                          .collection('Users')
                                          .doc(
                                              firebaseApi.auth.currentUser!.uid)
                                          .collection('Games')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? snapshot.data!.docs.length != 0
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                        )),
                                                                    Positioned(
                                                                        top: 2,
                                                                        right:
                                                                            2,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          child:
                                                                              BackdropFilter(
                                                                            filter:
                                                                                ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Games').doc(snapshot.data!.docs[index].id).delete();
                                                                                firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                  'games': FieldValue.arrayRemove([
                                                                                    snapshot.data!.docs[index].data()['name']
                                                                                  ])
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(5)),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(3),
                                                                                    child: Icon(Icons.cancel_outlined),
                                                                                  )),
                                                                            ),
                                                                          ),
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
                                                              'assets/about/game.png',
                                                              height: 70,
                                                              width: 70,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                            Text(
                                                              'Oyun eklenmedi',
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 30,
                                                                  color: Get
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
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        Text(
                                                          'Oyun eklenmedi',
                                                          style: GoogleFonts.roboto(
                                                              fontSize: 30,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Get.to(() => AddAccount(),
                                                transition:
                                                    Transition.cupertino);
                                          },
                                          icon: Icon(Icons.add),
                                          label:
                                              Text('İstatistik hesabı ekle')),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 160,
                                    child: StreamBuilder<
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                        stream: firebaseApi.firestore
                                            .collection('Users')
                                            .doc(firebaseApi
                                                .auth.currentUser!.uid)
                                            .collection('Accounts')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return snapshot.hasData
                                              ? snapshot.data!.docs.length == 0
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        width: double.maxFinite,
                                                        height: 80,
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
                                                                    color: Get
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
                                                                    .circular(
                                                                        20),
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.2)),
                                                        child: ListView.builder(
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
                                                              (context, index) {
                                                            print(snapshot.data!
                                                                    .docs[index]
                                                                ['icon']);
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              child:
                                                                  AspectRatio(
                                                                aspectRatio:
                                                                    5 / 4,
                                                                child: Card(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Stack(
                                                                    fit: StackFit
                                                                        .expand,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        child: Image
                                                                            .network(
                                                                          snapshot
                                                                              .data!
                                                                              .docs[index]['icon'],
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 10),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            child:
                                                                                BackdropFilter(
                                                                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(5)),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(3),
                                                                                    child: Center(child: Text(snapshot.data!.docs[index]['data'])),
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        bottom:
                                                                            2,
                                                                        left: 0,
                                                                        right:
                                                                            0,
                                                                      ),
                                                                      Positioned(
                                                                          top:
                                                                              2,
                                                                          right:
                                                                              2,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            child:
                                                                                BackdropFilter(
                                                                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  snapshot.data!.docs[index].reference.delete();
                                                                                  // firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Games').doc(snapshot.data!.docs[index].id).delete();
                                                                                },
                                                                                child: Container(
                                                                                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(5)),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(3),
                                                                                      child: Icon(Icons.cancel_outlined),
                                                                                    )),
                                                                              ),
                                                                            ),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    height: 80,
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
                                                            'assets/about/stat.png',
                                                            height: 70,
                                                            width: 70,
                                                            color: Get
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Get.to(() => AddStats(),
                                                transition:
                                                    Transition.cupertino);
                                          },
                                          icon: Icon(Icons.add),
                                          label: Text('Oyun tecrübesi ekle')),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                  StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      stream: firebaseApi.firestore
                                          .collection('Users')
                                          .doc(
                                              firebaseApi.auth.currentUser!.uid)
                                          .collection('Stats')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? snapshot.data!.docs.length != 0
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Get.bottomSheet(
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          color: context.isDarkMode
                                                                              ? Colors.grey[900]
                                                                              : Colors.white,
                                                                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          500,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(17),
                                                                        child:
                                                                            Stack(
                                                                          fit: StackFit
                                                                              .expand,
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
                                                                    isScrollControlled:
                                                                        true);
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  color: context
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white,
                                                                ),
                                                                child: Obx(
                                                                  () => Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      !snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .data()['hasStats']
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
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.5),
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
                                                                      snapshot.data!.docs[index].data()['info'] ==
                                                                              ''
                                                                          ? Container()
                                                                          : Container(
                                                                              width: 1,
                                                                              height: 100,
                                                                              color: Colors.grey.withOpacity(0.5),
                                                                            ),
                                                                      snapshot.data!.docs[index].data()['info'] ==
                                                                              ''
                                                                          ? Container()
                                                                          : SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                      snapshot.data!.docs[index].data()['info'] ==
                                                                              ''
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
                                                                      snapshot.data!.docs[index].data()['info'] ==
                                                                              ''
                                                                          ? Container()
                                                                          : SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white.withOpacity(0.2)),
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  snapshot.data!.docs[index].reference.delete();
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(5),
                                                                                  child: Center(
                                                                                    child: Icon(Icons.cancel_outlined),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
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
                                                              'assets/about/practice.png',
                                                              height: 70,
                                                              width: 70,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                            Text(
                                                              'Oyun tecrübesi eklenmedi',
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 28,
                                                                  color: Get
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
                                                          style: GoogleFonts.roboto(
                                                              fontSize: 28,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                      }),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Get.to(() => AddSocial(),
                                                transition:
                                                    Transition.cupertino);
                                          },
                                          icon: Icon(Icons.add),
                                          label: Text('Sosyal platform ekle')),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child:
                                          StreamBuilder<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>(
                                              stream: firebaseApi.firestore
                                                  .collection('Users')
                                                  .doc(firebaseApi
                                                      .auth.currentUser!.uid)
                                                  .collection('Social')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                return snapshot.hasData
                                                    ? snapshot.data!.docs
                                                                .length ==
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
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
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
                                                                .data!
                                                                .docs
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        5),
                                                                child: Material(
                                                                  elevation: 2,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors.grey[
                                                                          900]
                                                                      : Colors
                                                                          .white,
                                                                  child:
                                                                      InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 12,
                                                                              vertical: 2),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              CircleAvatar(
                                                                                backgroundColor: Colors.transparent,
                                                                                backgroundImage: NetworkImage(
                                                                                  snapshot.data!.docs[index]['icon'],
                                                                                ),
                                                                                radius: 20,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  // Text(
                                                                                  //     '${snapshot.data!.docs[index]['name']}: '),
                                                                                  // Text('${snapshot.data!.docs[index]['name']}: '),
                                                                                  Text(
                                                                                    snapshot.data!.docs[index]['data'],
                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: () async {
                                                                                      await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Social').doc(snapshot.data!.docs[index].id).delete();
                                                                                      infosGetx.update();
                                                                                    },
                                                                                    child: Icon(Icons.cancel_outlined),
                                                                                  )
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
                                                          )
                                                    : Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/about/social.png',
                                                              height: 40,
                                                              width: 40,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
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
                                                      );
                                              }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              TimeRange time =
                                                  await showTimeRangePicker(
                                                      context: context,
                                                      padding: 50,
                                                      strokeWidth: 8,
                                                      fromText: 'Başlangıç',
                                                      toText: 'Bitiş',
                                                      handlerColor:
                                                          Colors.green[300],
                                                      strokeColor:
                                                          Colors.purple,
                                                      end: TimeOfDay(
                                                          hour: user.data!
                                                                  .data()![
                                                              'endHour'],
                                                          minute:
                                                              user.data!.data()![
                                                                  'endMinute']),
                                                      handlerRadius: 15,
                                                      labels: [
                                                        ClockLabel(
                                                            angle: 0,
                                                            text: '18:00'),
                                                        ClockLabel(
                                                            angle: 1.55,
                                                            text: '00:00'),
                                                        ClockLabel(
                                                            angle: 3.15,
                                                            text: '06:00'),
                                                        ClockLabel(
                                                            angle: 4.7,
                                                            text: '12:00'),
                                                      ],
                                                      backgroundWidget:
                                                          CircleAvatar(
                                                        radius: 100,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: Image.asset(
                                                              'assets/orta.png'),
                                                        ),
                                                      ),
                                                      ticks: 12,
                                                      autoAdjustLabels: true,
                                                      backgroundColor:
                                                          Colors.red,
                                                      selectedColor:
                                                          Colors.green,
                                                      disabledColor:
                                                          Colors.grey,
                                                      start: TimeOfDay(
                                                          hour: user.data!
                                                                  .data()![
                                                              'startHour'],
                                                          minute: user.data!
                                                                  .data()![
                                                              'startMinute']));
                                              if (time != null) {
                                                firebaseApi.firestore
                                                    .collection('Users')
                                                    .doc(firebaseApi
                                                        .auth.currentUser!.uid)
                                                    .update({
                                                  'startHour':
                                                      time.startTime.hour,
                                                  'startMinute':
                                                      time.startTime.minute,
                                                  'endHour': time.endTime.hour,
                                                  'endMinute':
                                                      time.endTime.minute
                                                });
                                                // firebaseApi.firestore
                                                //     .collection('Users')
                                                //     .doc(firebaseApi.auth.currentUser!.uid)
                                                //     .collection('Rosettes')
                                                //     .where('name', isEqualTo: Utils.aktifsaatleriniduzenleme['name']!)
                                                //     .get()
                                                //     .then((value) async {
                                                //   if (value.docs.isEmpty) {
                                                //     firebaseApi.exp = firebaseApi.exp + 150;
                                                //     Get.snackbar('Başarı kazandın', Utils.aktifsaatleriniduzenleme['name']!,
                                                //         icon: Padding(
                                                //           padding: const EdgeInsets.symmetric(horizontal: 5),
                                                //           child: Icon(
                                                //             Icons.emoji_events_outlined,
                                                //             size: 35,
                                                //           ),
                                                //         ));
                                                //     await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                //       'name': Utils.aktifsaatleriniduzenleme['name']!,
                                                //       'photo': Utils.aktifsaatleriniduzenleme['photo']!,
                                                //     });
                                                //     await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                                //       int exp = value.data()!['exp'];
                                                //       int level = value.data()!['level'];
                                                //       int newExp = exp + 600;
                                                //       int newLevel = Utils().getLevel(newExp);
                                                //       await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'exp': newExp});
                                                //       if (level != newLevel) {
                                                //         //yeni seviyye
                                                //         await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'level': newLevel});
                                                //         Get.to(() => NewLevel(level: newLevel));
                                                //       }
                                                //     });
                                                //   }
                                                // });
                                              }
                                            },
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
                                            onTap: () async {
                                              TimeRange time =
                                                  await showTimeRangePicker(
                                                      context: context,
                                                      padding: 50,
                                                      strokeWidth: 8,
                                                      fromText: 'Başlangıç',
                                                      toText: 'Bitiş',
                                                      handlerColor:
                                                          Colors.green[300],
                                                      strokeColor:
                                                          Colors.purple,
                                                      end: TimeOfDay(
                                                          hour: user.data!
                                                                  .data()![
                                                              'endHour'],
                                                          minute:
                                                              user.data!.data()![
                                                                  'endMinute']),
                                                      handlerRadius: 15,
                                                      labels: [
                                                        ClockLabel(
                                                            angle: 0,
                                                            text: '18:00'),
                                                        ClockLabel(
                                                            angle: 1.55,
                                                            text: '00:00'),
                                                        ClockLabel(
                                                            angle: 3.15,
                                                            text: '06:00'),
                                                        ClockLabel(
                                                            angle: 4.7,
                                                            text: '12:00'),
                                                      ],
                                                      backgroundWidget:
                                                          CircleAvatar(
                                                        radius: 100,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: Image.asset(
                                                              'assets/orta.png'),
                                                        ),
                                                      ),
                                                      ticks: 12,
                                                      autoAdjustLabels: true,
                                                      backgroundColor:
                                                          Colors.red,
                                                      selectedColor:
                                                          Colors.green,
                                                      disabledColor:
                                                          Colors.grey,
                                                      start: TimeOfDay(
                                                          hour: user.data!
                                                                  .data()![
                                                              'startHour'],
                                                          minute: user.data!
                                                                  .data()![
                                                              'startMinute']));
                                              if (time != null) {
                                                firebaseApi.firestore
                                                    .collection('Users')
                                                    .doc(firebaseApi
                                                        .auth.currentUser!.uid)
                                                    .update({
                                                  'startHour':
                                                      time.startTime.hour,
                                                  'startMinute':
                                                      time.startTime.minute,
                                                  'endHour': time.endTime.hour,
                                                  'endMinute':
                                                      time.endTime.minute
                                                });
                                                // firebaseApi.firestore
                                                //     .collection('Users')
                                                //     .doc(firebaseApi.auth.currentUser!.uid)
                                                //     .collection('Rosettes')
                                                //     .where('name', isEqualTo: Utils.aktifsaatleriniduzenleme['name']!)
                                                //     .get()
                                                //     .then((value) async {
                                                //   if (value.docs.isEmpty) {
                                                //     firebaseApi.exp = firebaseApi.exp + 150;
                                                //     Get.snackbar('Başarı kazandın', Utils.aktifsaatleriniduzenleme['name']!,
                                                //         icon: Padding(
                                                //           padding: const EdgeInsets.symmetric(horizontal: 5),
                                                //           child: Icon(
                                                //             Icons.emoji_events_outlined,
                                                //             size: 35,
                                                //           ),
                                                //         ));
                                                //     await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                //       'name': Utils.aktifsaatleriniduzenleme['name']!,
                                                //       'photo': Utils.aktifsaatleriniduzenleme['photo']!,
                                                //     });
                                                //     await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
                                                //       int exp = value.data()!['exp'];
                                                //       int level = value.data()!['level'];
                                                //       int newExp = exp + 600;
                                                //       int newLevel = Utils().getLevel(newExp);
                                                //       await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'exp': newExp});
                                                //       if (level != newLevel) {
                                                //         //yeni seviyye
                                                //         await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'level': newLevel});
                                                //         Get.to(() => NewLevel(level: newLevel));
                                                //       }
                                                //     });
                                                //   }
                                                // });
                                              }
                                            },
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
                                    height: 70,
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
                                child: GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                      context: context,
                                      barrierColor:
                                          Colors.grey[200]!.withOpacity(0.65),
                                      filter: ImageFilter.blur(
                                          sigmaX: 2, sigmaY: 2),
                                      builder: (context1) {
                                        return Container(
                                          color: context.isDarkMode
                                              ? Colors.black
                                              : Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 30),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 40),
                                                  child: Material(
                                                    color: context.isDarkMode
                                                        ? Colors.grey[900]
                                                        : Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                        showCupertinoModalPopup(
                                                          barrierColor: Colors
                                                              .grey[200]!
                                                              .withOpacity(
                                                                  0.65),
                                                          filter:
                                                              ImageFilter.blur(
                                                                  sigmaX: 2,
                                                                  sigmaY: 2),
                                                          context: context,
                                                          builder: (context) {
                                                            return DefaultTabController(
                                                              length: 3,
                                                              child: Container(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                  child: Column(
                                                                    children: [
                                                                      Theme(
                                                                        data: ThemeData(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            highlightColor: Colors.transparent),
                                                                        child:
                                                                            Material(
                                                                          color: context.isDarkMode
                                                                              ? Colors.grey[900]
                                                                              : Colors.grey[50],
                                                                          child:
                                                                              TabBar(
                                                                            labelColor: context.isDarkMode
                                                                                ? Colors.white
                                                                                : Colors.grey[900],
                                                                            unselectedLabelColor:
                                                                                Colors.grey,
                                                                            labelStyle:
                                                                                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                                                                            unselectedLabelStyle:
                                                                                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16),
                                                                            indicatorColor:
                                                                                Colors.transparent,
                                                                            indicatorWeight:
                                                                                3,
                                                                            labelPadding:
                                                                                EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                                                            tabs: [
                                                                              Tab(
                                                                                iconMargin: EdgeInsets.zero,
                                                                                // text: 'Mesajlar',
                                                                                child: Container(
                                                                                  width: double.maxFinite,
                                                                                  child: Center(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                      child: Text(
                                                                                        '1. Seviye',
                                                                                        overflow: TextOverflow.visible,
                                                                                        textAlign: TextAlign.center,
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      gradient: context.isDarkMode
                                                                                          ? LinearGradient(colors: [
                                                                                              Colors.grey[700]!,
                                                                                              Colors.grey[800]!,
                                                                                              // Colors.grey.withOpacity(0.15),
                                                                                              // Colors.grey.withOpacity(0.10),
                                                                                              // Colors.grey.withOpacity(0.05),
                                                                                            ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                                                                                          : LinearGradient(colors: [
                                                                                              Color(0xFFdfe9f3),
                                                                                              Colors.grey[100]!,
                                                                                              // Colors.grey.withOpacity(0.15),
                                                                                              // Colors.grey.withOpacity(0.10),
                                                                                              // Colors.grey.withOpacity(0.05),
                                                                                            ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                                                                                ),
                                                                              ),
                                                                              Tab(
                                                                                iconMargin: EdgeInsets.zero,
                                                                                // text: 'Mesajlar',
                                                                                child: Container(
                                                                                  width: double.maxFinite,
                                                                                  child: Center(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                      child: Text(
                                                                                        '2. Seviye',
                                                                                        overflow: TextOverflow.visible,
                                                                                        textAlign: TextAlign.center,
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: context.isDarkMode ? Colors.grey[800] : Colors.grey[100]!),
                                                                                ),
                                                                              ),
                                                                              Tab(
                                                                                iconMargin: EdgeInsets.zero,
                                                                                // text: 'Mesajlar',
                                                                                child: Container(
                                                                                  width: double.maxFinite,
                                                                                  child: Center(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                      child: Text(
                                                                                        '3. Seviye',
                                                                                        overflow: TextOverflow.visible,
                                                                                        textAlign: TextAlign.center,
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      gradient: context.isDarkMode
                                                                                          ? LinearGradient(colors: [
                                                                                              Colors.grey[800]!,
                                                                                              Colors.grey[700]!,
                                                                                              // Colors.grey.withOpacity(0.15),
                                                                                              // Colors.grey.withOpacity(0.10),
                                                                                              // Colors.grey.withOpacity(0.05),
                                                                                            ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                                                                                          : LinearGradient(colors: [
                                                                                              Colors.grey[100]!,
                                                                                              Color(0xFFdfe9f3),
                                                                                              // Colors.grey.withOpacity(0.15),
                                                                                              // Colors.grey.withOpacity(0.10),
                                                                                              // Colors.grey.withOpacity(0.05),
                                                                                            ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
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
                                                                        child:
                                                                            TabBarView(
                                                                          children: [
                                                                            GridView.builder(
                                                                              padding: EdgeInsets.zero,
                                                                              physics: BouncingScrollPhysics(),
                                                                              itemCount: Utils.avatars.length,
                                                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                                                              itemBuilder: (context, index) {
                                                                                return Padding(
                                                                                  padding: const EdgeInsets.all(5),
                                                                                  child: GestureDetector(
                                                                                    onTap: () async {
                                                                                      await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                        'avatarIsAsset': true,
                                                                                        'avatar': 'assets/avatars/${Utils.avatars[index]}'
                                                                                      });
                                                                                      Get.back();
                                                                                      firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.resimekleme['name']!).get().then((value) async {
                                                                                        if (value.docs.isEmpty) {
                                                                                          Get.snackbar('Başarı kazandın', Utils.resimekleme['name']!,
                                                                                              icon: Padding(
                                                                                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                child: Icon(
                                                                                                  Icons.emoji_events_outlined,
                                                                                                  size: 35,
                                                                                                ),
                                                                                              ));
                                                                                          firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                            'name': Utils.resimekleme['name']!,
                                                                                            'photo': Utils.resimekleme['photo']!,
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
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 50,
                                                                                      width: 50,
                                                                                      child: CircleAvatar(backgroundColor: Colors.transparent, radius: 30, backgroundImage: AssetImage('assets/avatars/${Utils.avatars[index]}')),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            Obx(
                                                                              () => Stack(
                                                                                children: [
                                                                                  Opacity(
                                                                                    opacity: infosGetx.twoLevelAvatar.value ? 1 : 0.3,
                                                                                    child: IgnorePointer(
                                                                                      ignoring: infosGetx.twoLevelAvatar.value ? false : true,
                                                                                      child: GridView.builder(
                                                                                        padding: EdgeInsets.zero,
                                                                                        physics: BouncingScrollPhysics(),
                                                                                        itemCount: Utils.avatars2.length,
                                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                                                                        itemBuilder: (context, index) {
                                                                                          return Padding(
                                                                                            padding: const EdgeInsets.all(5),
                                                                                            child: GestureDetector(
                                                                                              onTap: () async {
                                                                                                await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                                  'avatarIsAsset': true,
                                                                                                  'avatar': 'assets/avatars/level2/${Utils.avatars2[index]}'
                                                                                                });
                                                                                                Get.back();

                                                                                                firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.resimekleme['name']!).get().then((value) async {
                                                                                                  if (value.docs.isEmpty) {
                                                                                                    Get.snackbar('Başarı kazandın', Utils.resimekleme['name']!,
                                                                                                        icon: Padding(
                                                                                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                          child: Icon(
                                                                                                            Icons.emoji_events_outlined,
                                                                                                            size: 35,
                                                                                                          ),
                                                                                                        ));
                                                                                                    firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                                      'name': Utils.resimekleme['name']!,
                                                                                                      'photo': Utils.resimekleme['photo']!,
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
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 50,
                                                                                                width: 50,
                                                                                                child: CircleAvatar(backgroundColor: Colors.transparent, radius: 30, backgroundImage: AssetImage('assets/avatars/level2/${Utils.avatars2[index]}')),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  infosGetx.twoLevelAvatar.value
                                                                                      ? Container()
                                                                                      : GestureDetector(
                                                                                          onTap: () {
                                                                                            //reklam
                                                                                            RewardedAd.load(
                                                                                                adUnitId: Utils.ad_id,
                                                                                                request: AdRequest(),
                                                                                                rewardedAdLoadCallback: RewardedAdLoadCallback(
                                                                                                    onAdLoaded: (add) {
                                                                                                      add.show(onUserEarnedReward: (add, item) {
                                                                                                        //give reward
                                                                                                        infosGetx.twoLevelAvatar.value = true;
                                                                                                        firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'twoLevelAvatar': true});
                                                                                                      });
                                                                                                    },
                                                                                                    onAdFailedToLoad: (add) {}));
                                                                                          },
                                                                                          child: Center(
                                                                                            child: Material(
                                                                                              color: Colors.transparent,
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Image.asset(
                                                                                                    'assets/lock.png',
                                                                                                    color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                                    height: 100,
                                                                                                    width: 100,
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: 15,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    'Kilidi açmak için reklam izleyin',
                                                                                                    style: GoogleFonts.roboto(color: context.isDarkMode ? Colors.white : Colors.black, fontSize: 25),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                                                                future: firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get(),
                                                                                builder: (context, snapshot) {
                                                                                  return snapshot.hasData
                                                                                      ? Stack(
                                                                                          children: [
                                                                                            Opacity(
                                                                                              opacity: snapshot.data!.data()!['level'] > 9 ? 1 : 0.3,
                                                                                              child: IgnorePointer(
                                                                                                ignoring: snapshot.data!.data()!['level'] < 10,
                                                                                                child: GridView.builder(
                                                                                                  padding: EdgeInsets.zero,
                                                                                                  physics: BouncingScrollPhysics(),
                                                                                                  itemCount: Utils.avatars3.length,
                                                                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                                                                                  itemBuilder: (context, index) {
                                                                                                    return Padding(
                                                                                                      padding: const EdgeInsets.all(5),
                                                                                                      child: GestureDetector(
                                                                                                        onTap: () async {
                                                                                                          await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                                            'avatarIsAsset': true,
                                                                                                            'avatar': 'assets/avatars/level3/${Utils.avatars3[index]}'
                                                                                                          });
                                                                                                          Get.back();
                                                                                                          firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.resimekleme['name']!).get().then((value) async {
                                                                                                            if (value.docs.isEmpty) {
                                                                                                              Get.snackbar('Başarı kazandın', Utils.resimekleme['name']!,
                                                                                                                  icon: Padding(
                                                                                                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                                    child: Icon(
                                                                                                                      Icons.emoji_events_outlined,
                                                                                                                      size: 35,
                                                                                                                    ),
                                                                                                                  ));
                                                                                                              firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                                                                                                'name': Utils.resimekleme['name']!,
                                                                                                                'photo': Utils.resimekleme['photo']!,
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
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          height: 50,
                                                                                                          width: 50,
                                                                                                          child: CircleAvatar(backgroundColor: Colors.transparent, radius: 30, backgroundImage: AssetImage('assets/avatars/level3/${Utils.avatars3[index]}')),
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            snapshot.data!.data()!['level'] > 9
                                                                                                ? Container()
                                                                                                : Center(
                                                                                                    child: Material(
                                                                                                      color: Colors.transparent,
                                                                                                      child: Column(
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: [
                                                                                                          Image.asset(
                                                                                                            'assets/lock.png',
                                                                                                            color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                                            height: 100,
                                                                                                            width: 100,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 15,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "Kilidi açmak için 10. seviye'ye ulaşın",
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: GoogleFonts.roboto(color: context.isDarkMode ? Colors.white : Colors.black, fontSize: 25),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        )
                                                                                      : Container(
                                                                                          child: Center(
                                                                                            child: SizedBox(
                                                                                              height: 50,
                                                                                              width: 50,
                                                                                              child: CircularProgressIndicator(
                                                                                                color: Colors.green,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                }),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors.grey[
                                                                            900]
                                                                        : Colors.grey[
                                                                            50],
                                                                    borderRadius:
                                                                        BorderRadius.vertical(
                                                                            top:
                                                                                Radius.circular(20))),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.65,
                                                                width: double
                                                                    .maxFinite,
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(18),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Avatarı değiş',
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 40),
                                                  child: Material(
                                                    color: context.isDarkMode
                                                        ? Colors.grey[900]
                                                        : Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                        showCupertinoModalPopup(
                                                          barrierColor: Colors
                                                              .grey[200]!
                                                              .withOpacity(
                                                                  0.65),
                                                          filter:
                                                              ImageFilter.blur(
                                                                  sigmaX: 2,
                                                                  sigmaY: 2),
                                                          context: context,
                                                          builder: (context) {
                                                            return DefaultTabController(
                                                              length: 2,
                                                              child: Container(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                  child: Column(
                                                                    children: [
                                                                      Theme(
                                                                        data: ThemeData(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            highlightColor: Colors.transparent),
                                                                        child:
                                                                            Material(
                                                                          color: context.isDarkMode
                                                                              ? Colors.grey[900]
                                                                              : Colors.grey[50],
                                                                          child:
                                                                              TabBar(
                                                                            labelColor: context.isDarkMode
                                                                                ? Colors.white
                                                                                : Colors.grey[900],
                                                                            unselectedLabelColor:
                                                                                Colors.grey,
                                                                            labelStyle:
                                                                                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                                                                            unselectedLabelStyle:
                                                                                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16),
                                                                            indicatorColor:
                                                                                Colors.transparent,
                                                                            indicatorWeight:
                                                                                3,
                                                                            labelPadding:
                                                                                EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                                                            tabs: [
                                                                              Tab(
                                                                                iconMargin: EdgeInsets.zero,
                                                                                // text: 'Mesajlar',
                                                                                child: Container(
                                                                                  width: double.maxFinite,
                                                                                  child: Center(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                      child: Text(
                                                                                        '1. Seviye',
                                                                                        overflow: TextOverflow.visible,
                                                                                        textAlign: TextAlign.center,
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      gradient: context.isDarkMode
                                                                                          ? LinearGradient(colors: [
                                                                                              Colors.grey[700]!,
                                                                                              Colors.grey[800]!,
                                                                                              // Colors.grey.withOpacity(0.15),
                                                                                              // Colors.grey.withOpacity(0.10),
                                                                                              // Colors.grey.withOpacity(0.05),
                                                                                            ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                                                                                          : LinearGradient(colors: [
                                                                                              Color(0xFFdfe9f3),
                                                                                              Colors.grey[100]!,
                                                                                              // Colors.grey.withOpacity(0.15),
                                                                                              // Colors.grey.withOpacity(0.10),
                                                                                              // Colors.grey.withOpacity(0.05),
                                                                                            ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                                                                                ),
                                                                              ),
                                                                              Tab(
                                                                                iconMargin: EdgeInsets.zero,
                                                                                // text: 'Mesajlar',
                                                                                child: Container(
                                                                                  width: double.maxFinite,
                                                                                  child: Center(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                                                      child: Text(
                                                                                        '2. Seviye',
                                                                                        overflow: TextOverflow.visible,
                                                                                        textAlign: TextAlign.center,
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      gradient: context.isDarkMode
                                                                                          ? LinearGradient(colors: [
                                                                                              Colors.grey[800]!,
                                                                                              Colors.grey[700]!,
                                                                                              // Colors.grey.withOpacity(0.15),
                                                                                              // Colors.grey.withOpacity(0.10),
                                                                                              // Colors.grey.withOpacity(0.05),
                                                                                            ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                                                                                          : LinearGradient(colors: [
                                                                                              Colors.grey[100]!,
                                                                                              Color(0xFFdfe9f3),
                                                                                              // Colors.grey.withOpacity(0.15),
                                                                                              // Colors.grey.withOpacity(0.10),
                                                                                              // Colors.grey.withOpacity(0.05),
                                                                                            ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
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
                                                                        child:
                                                                            TabBarView(
                                                                          children: [
                                                                            GridView.builder(
                                                                              padding: EdgeInsets.zero,
                                                                              physics: BouncingScrollPhysics(),
                                                                              itemCount: 10,
                                                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
                                                                              itemBuilder: (context, index) {
                                                                                return Padding(
                                                                                  padding: const EdgeInsets.all(5),
                                                                                  child: GestureDetector(
                                                                                    onTap: () async {
                                                                                      await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                        'back': 'assets/back/arka-plan-${index + 1}.jpg',
                                                                                      });
                                                                                      Get.back();
                                                                                    },
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage('assets/back/arka-plan-${index + 1}.jpg'), fit: BoxFit.cover)),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                                                                future: firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get(),
                                                                                builder: (context, snapshot) {
                                                                                  return snapshot.hasData
                                                                                      ? Stack(
                                                                                          children: [
                                                                                            Opacity(
                                                                                              opacity: snapshot.data!.data()!['level'] > 7 ? 1 : 0.3,
                                                                                              child: IgnorePointer(
                                                                                                ignoring: snapshot.data!.data()!['level'] < 8,
                                                                                                child: GridView.builder(
                                                                                                  padding: EdgeInsets.zero,
                                                                                                  physics: BouncingScrollPhysics(),
                                                                                                  itemCount: 10,
                                                                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
                                                                                                  itemBuilder: (context, index) {
                                                                                                    return Padding(
                                                                                                      padding: const EdgeInsets.all(5),
                                                                                                      child: GestureDetector(
                                                                                                        onTap: () async {
                                                                                                          await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                                            'back': 'assets/back/arka-plan-${index + 11}.jpg',
                                                                                                          });
                                                                                                          Get.back();
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage('assets/back/arka-plan-${index + 11}.jpg'), fit: BoxFit.cover)),
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            snapshot.data!.data()!['level'] > 7
                                                                                                ? Container()
                                                                                                : Center(
                                                                                                    child: Material(
                                                                                                      color: Colors.transparent,
                                                                                                      child: Column(
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: [
                                                                                                          Image.asset(
                                                                                                            'assets/lock.png',
                                                                                                            color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                                            height: 100,
                                                                                                            width: 100,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 15,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "Kilidi açmak için 8. seviye'ye ulaşın",
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: GoogleFonts.roboto(color: context.isDarkMode ? Colors.white : Colors.black, fontSize: 25),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        )
                                                                                      : Container(
                                                                                          child: Center(
                                                                                            child: SizedBox(
                                                                                              height: 50,
                                                                                              width: 50,
                                                                                              child: CircularProgressIndicator(
                                                                                                color: Colors.green,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                }),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors.grey[
                                                                            900]
                                                                        : Colors.grey[
                                                                            50],
                                                                    borderRadius:
                                                                        BorderRadius.vertical(
                                                                            top:
                                                                                Radius.circular(20))),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.65,
                                                                width: double
                                                                    .maxFinite,
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(18),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Arka plan değiştir',
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 40),
                                                  child: Material(
                                                    color: context.isDarkMode
                                                        ? Colors.grey[900]
                                                        : Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                        showCupertinoModalPopup(
                                                          barrierColor: Colors
                                                              .grey[200]!
                                                              .withOpacity(
                                                                  0.65),
                                                          filter:
                                                              ImageFilter.blur(
                                                                  sigmaX: 2,
                                                                  sigmaY: 2),
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        0),
                                                                child: Column(
                                                                  children: [
                                                                    Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          Text(
                                                                        "Her gün Duogether'a\ngiriş yaparak, ödülünü topla",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: context.isDarkMode
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                            fontSize: 22,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: GridView
                                                                          .builder(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        physics:
                                                                            BouncingScrollPhysics(),
                                                                        itemCount:
                                                                            10,
                                                                        // itemCount: user.data!.data()!['maxDays'] >
                                                                        //         10
                                                                        //     ? 10
                                                                        //     : user.data!.data()!['maxDays'],
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                3,
                                                                            childAspectRatio:
                                                                                1),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () async {
                                                                                if (user.data!.data()!['maxDays'] >= index + 1) {
                                                                                  await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                                    'cover': index + 1,
                                                                                  });
                                                                                  Get.back();
                                                                                }
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      // height: 50,
                                                                                      // width: 50,
                                                                                      child: Opacity(
                                                                                        opacity: user.data!.data()!['maxDays'] >= index + 1 ? 1 : 0.2,
                                                                                        child: Image.asset('assets/covers/level-${index + 1}.png'),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 3,
                                                                                  ),
                                                                                  Material(
                                                                                      color: Colors.transparent,
                                                                                      child: Text(
                                                                                        '${index + 1}. Gün',
                                                                                        style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
                                                                                      ))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors.grey[
                                                                          900]
                                                                      : Colors.grey[
                                                                          50],
                                                                  borderRadius:
                                                                      BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              20))),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.55,
                                                              width: double
                                                                  .maxFinite,
                                                            );
                                                          },
                                                        );
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(18),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Çerçeveyi değiştir',
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                        );
                                      },
                                    );
                                  },
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
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  right: 10,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        color: Colors.white.withOpacity(0.6),
                                        height: 47,
                                        width: 147,
                                        // width: (Get.size.width - 80),
                                        child: ListView(
                                          reverse: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                if (user.data!
                                                        .data()!['mobile'] ||
                                                    user.data!.data()!['ps']) {
                                                  firebaseApi.firestore
                                                      .collection('Users')
                                                      .doc(firebaseApi.auth
                                                          .currentUser!.uid)
                                                      .update({
                                                    'pc': !user.data!
                                                        .data()!['pc']
                                                  });
                                                } else {
                                                  Get.snackbar(
                                                      'En az bir tane plaform gerekli',
                                                      'Lütfen önce yeni platform ekleyin',
                                                      icon: Icon(
                                                          Icons.info_outline));
                                                  return;
                                                }
                                              },
                                              child: user.data!.data()!['pc']
                                                  ? Image.asset(
                                                      'assets/pc.png',
                                                      height: 40,
                                                      width: 40,
                                                    )
                                                  : Opacity(
                                                      opacity: 0.3,
                                                      child: Image.asset(
                                                        'assets/pc.png',
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (user.data!
                                                        .data()!['mobile'] ||
                                                    user.data!.data()!['pc']) {
                                                  firebaseApi.firestore
                                                      .collection('Users')
                                                      .doc(firebaseApi.auth
                                                          .currentUser!.uid)
                                                      .update({
                                                    'ps': !user.data!
                                                        .data()!['ps']
                                                  });
                                                } else {
                                                  Get.snackbar(
                                                      'En az bir tane plaform gerekli',
                                                      'Lütfen önce yeni platform ekleyin',
                                                      icon: Icon(
                                                          Icons.info_outline));
                                                  return;
                                                }
                                              },
                                              child: user.data!.data()!['ps']
                                                  ? Image.asset(
                                                      'assets/ps.png',
                                                      height: 40,
                                                      width: 40,
                                                    )
                                                  : Opacity(
                                                      opacity: 0.3,
                                                      child: Image.asset(
                                                        'assets/ps.png',
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (user.data!.data()!['ps'] ||
                                                    user.data!.data()!['pc']) {
                                                  firebaseApi.firestore
                                                      .collection('Users')
                                                      .doc(firebaseApi.auth
                                                          .currentUser!.uid)
                                                      .update({
                                                    'mobile': !user.data!
                                                        .data()!['mobile']
                                                  });
                                                } else {
                                                  Get.snackbar(
                                                      'En az bir tane plaform gerekli',
                                                      'Lütfen önce yeni platform ekleyin',
                                                      icon: Icon(
                                                          Icons.info_outline));
                                                  return;
                                                }
                                              },
                                              child:
                                                  user.data!.data()!['mobile']
                                                      ? Image.asset(
                                                          'assets/mobil-icon.png',
                                                          height: 40,
                                                          width: 40,
                                                        )
                                                      : Opacity(
                                                          opacity: 0.3,
                                                          child: Image.asset(
                                                            'assets/mobil-icon.png',
                                                            height: 40,
                                                            width: 40,
                                                          ),
                                                        ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),

                              Positioned(
                                child: GestureDetector(
                                  onTap: () async {
                                    firebaseApi.firestore
                                        .collection('Users')
                                        .doc(firebaseApi.auth.currentUser!.uid)
                                        .update({
                                      'headphone':
                                          !user.data!.data()!['headphone']
                                    });
                                  },
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
                        ),
                      ],
                    )
                  : Center(child: CircularPercentIndicator(radius: 50));
            }),
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
