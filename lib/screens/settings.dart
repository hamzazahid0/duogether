import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/cardsGetx.dart';
import 'package:gamehub/getx/filterGetx.dart';
import 'package:gamehub/screens/contactUs.dart';
import 'package:gamehub/screens/gift.dart';
import 'package:gamehub/screens/howToUse.dart';
import 'package:gamehub/screens/questions.dart';
import 'package:gamehub/screens/terms.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

import 'newLevel.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FirebaseApi firebaseApi = Get.find();
  CardsGetx cardsGetx = Get.find();
  FilterGetx filterGetx = Get.find();

  @override
  void initState() {
    FirebaseAuth.instance.currentUser!.reload().then((value) {
      firebaseApi.firestore
          .collection('Users')
          .doc(firebaseApi.auth.currentUser!.uid)
          .update({'verified': firebaseApi.auth.currentUser!.emailVerified});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        brightness: Brightness.dark,
        title: Text('Ayarlar'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: firebaseApi.firestore
              .collection('Users')
              .doc(firebaseApi.auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Container(
                    color: context.isDarkMode ? Colors.black : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  Get.to(() => GiftScreen(),
                                      transition: Transition.cupertino);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.card_giftcard_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Çekilişe katıl',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            snapshot.data!.data()!['verified']
                                ? Container()
                                : Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'E-posta adresi doğrulanmadı',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Material(
                                        color: context.isDarkMode
                                            ? Colors.grey[900]
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          onTap: () async {
                                            // TextEditingController applyCode =
                                            //     TextEditingController();
                                            await FirebaseAuth
                                                .instance.currentUser!
                                                .sendEmailVerification();
                                            Get.snackbar(
                                                'E-posta doğrulama linki gönderildi',
                                                'Lütfen e-posta adresinizi kontrol edin');
                                            // showModalBottomSheet(
                                            //   context: context,
                                            //   isScrollControlled: true,
                                            //   useRootNavigator: true,
                                            //   builder: (context) {
                                            //     return Padding(
                                            //       padding: EdgeInsets.only(
                                            //           bottom: MediaQuery.of(context)
                                            //               .viewInsets
                                            //               .bottom),
                                            //       child: Container(
                                            //         width: double.maxFinite,
                                            //         color: context.isDarkMode
                                            //             ? Colors.grey[900]
                                            //             : Colors.grey[200],
                                            //         child: Padding(
                                            //           padding:
                                            //               const EdgeInsets.symmetric(
                                            //                   vertical: 30,
                                            //                   horizontal: 20),
                                            //           child: Column(
                                            //             mainAxisSize:
                                            //                 MainAxisSize.min,
                                            //             children: [
                                            //               Text(
                                            //                 'E-posta adresinize gelen kodu giriniz',
                                            //                 textAlign:
                                            //                     TextAlign.center,
                                            //                 style: TextStyle(
                                            //                     fontSize: 26,
                                            //                     color: context.isDarkMode
                                            //                         ? Colors.white
                                            //                         : Colors.black,
                                            //                     fontWeight:
                                            //                         FontWeight.bold),
                                            //               ),
                                            //               SizedBox(
                                            //                 height: 30,
                                            //               ),
                                            //               Padding(
                                            //                 padding: const EdgeInsets
                                            //                         .symmetric(
                                            //                     horizontal: 20),
                                            //                 child: TextField(
                                            //                   controller: applyCode,
                                            //                   keyboardType:
                                            //                       TextInputType
                                            //                           .visiblePassword,
                                            //                   inputFormatters: [
                                            //                     FilteringTextInputFormatter
                                            //                         .allow(RegExp(
                                            //                             "[a-zA-Z0-9 ğüşöçəİĞÜƏŞÖÇЁёА-я]")),
                                            //                   ],
                                            //                   cursorColor:
                                            //                       context.isDarkMode
                                            //                           ? Colors.white
                                            //                           : Colors.black,
                                            //                   cursorRadius:
                                            //                       Radius.circular(10),
                                            //                   maxLines: 1,
                                            //                   scrollPadding:
                                            //                       EdgeInsets.zero,
                                            //                   textAlign:
                                            //                       TextAlign.center,
                                            //                   decoration: InputDecoration(
                                            //                       hintText: 'Kod',
                                            //                       focusedBorder: OutlineInputBorder(
                                            //                           borderRadius:
                                            //                               BorderRadius.circular(
                                            //                                   20),
                                            //                           borderSide: BorderSide(
                                            //                               color: Get
                                            //                                       .isDarkMode
                                            //                                   ? Colors
                                            //                                       .white
                                            //                                   : Colors
                                            //                                       .black,
                                            //                               width: 2)),
                                            //                       border: OutlineInputBorder(
                                            //                           borderRadius:
                                            //                               BorderRadius
                                            //                                   .circular(
                                            //                                       20),
                                            //                           borderSide: BorderSide(
                                            //                               color: Get
                                            //                                       .isDarkMode
                                            //                                   ? Colors
                                            //                                       .white
                                            //                                   : Colors
                                            //                                       .black,
                                            //                               width: 2))),
                                            //                   style: TextStyle(
                                            //                       fontSize: 19,
                                            //                       fontWeight:
                                            //                           FontWeight
                                            //                               .bold),
                                            //                 ),
                                            //               ),
                                            //               SizedBox(height: 15),
                                            //               Padding(
                                            //                 padding: const EdgeInsets
                                            //                         .symmetric(
                                            //                     horizontal: 20),
                                            //                 child: Material(
                                            //                   color: Colors.green,
                                            //                   borderRadius:
                                            //                       BorderRadius
                                            //                           .circular(15),
                                            //                   child: InkWell(
                                            //                     borderRadius:
                                            //                         BorderRadius
                                            //                             .circular(15),
                                            //                     onTap: () async {
                                            //                       try {
                                            //                         await FirebaseAuth
                                            //                             .instance
                                            //                             .applyActionCode(
                                            //                                 applyCode
                                            //                                     .text);
                                            //                         Get.back();
                                            //                         FirebaseAuth
                                            //                             .instance
                                            //                             .currentUser!
                                            //                             .reload()
                                            //                             .then(
                                            //                                 (value) {
                                            //                           firebaseApi
                                            //                               .firestore
                                            //                               .collection(
                                            //                                   'Users')
                                            //                               .doc(firebaseApi
                                            //                                   .auth
                                            //                                   .currentUser!
                                            //                                   .uid)
                                            //                               .update({
                                            //                             'verified': firebaseApi
                                            //                                 .auth
                                            //                                 .currentUser!
                                            //                                 .emailVerified
                                            //                           });
                                            //                         });
                                            //                         Get.snackbar(
                                            //                             'Tebrikler',
                                            //                             'E-posta adresiniz doğrulandı');
                                            //                       } catch (e) {
                                            //                         Get.snackbar(
                                            //                             'Hata',
                                            //                             e.toString());
                                            //                       }
                                            //                     },
                                            //                     child: Padding(
                                            //                       padding:
                                            //                           const EdgeInsets
                                            //                               .all(14),
                                            //                       child: Row(
                                            //                         mainAxisAlignment:
                                            //                             MainAxisAlignment
                                            //                                 .center,
                                            //                         children: [
                                            //                           Text(
                                            //                             'Onayla',
                                            //                             style: TextStyle(
                                            //                                 fontSize:
                                            //                                     24,
                                            //                                 fontWeight:
                                            //                                     FontWeight
                                            //                                         .bold,
                                            //                                 color: Colors
                                            //                                     .white),
                                            //                           )
                                            //                         ],
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     );
                                            //   },
                                            // );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 15),
                                                child:
                                                    Icon(Icons.warning_rounded),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 15),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        'E-posta adresinizi doğrulayın')
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              color: context.isDarkMode
                                  ? Colors.grey[900]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () async {
                                  if (context.isDarkMode) {
                                    Get.changeTheme(ThemeData.light());
                                  } else {
                                    Get.changeTheme(ThemeData.dark());
                                  }
                                  var data = await firebaseApi.firestore
                                      .collection('Users')
                                      .doc(firebaseApi.auth.currentUser!.uid)
                                      .get();
                                  cardsGetx.limit.value = data.data()!['limit'];

                                  filterGetx.generateCard();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          Icon(Icons.dark_mode),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Koyu mod')
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Switch.adaptive(
                                          value: context.isDarkMode,
                                          activeColor: Colors.red,
                                          onChanged: (b) async {
                                            if (context.isDarkMode) {
                                              Get.changeTheme(
                                                  ThemeData.light());
                                            } else {
                                              Get.changeTheme(ThemeData.dark());
                                            }
                                            var data = await firebaseApi
                                                .firestore
                                                .collection('Users')
                                                .doc(firebaseApi
                                                    .auth.currentUser!.uid)
                                                .get();
                                            cardsGetx.limit.value =
                                                data.data()!['limit'];

                                            filterGetx.generateCard();
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              color: context.isDarkMode
                                  ? Colors.grey[900]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  firebaseApi.firestore
                                      .collection('Users')
                                      .doc(firebaseApi.auth.currentUser!.uid)
                                      .update({
                                    'showInPopular':
                                        !snapshot.data!.data()!['showInPopular']
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          Icon(Icons.people_rounded),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Beni popüler duolarda göster')
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Switch.adaptive(
                                          value: snapshot.data!
                                              .data()!['showInPopular'],
                                          activeColor: Colors.red,
                                          onChanged: (b) {
                                            firebaseApi.firestore
                                                .collection('Users')
                                                .doc(firebaseApi
                                                    .auth.currentUser!.uid)
                                                .update({
                                              'showInPopular': !snapshot.data!
                                                  .data()!['showInPopular']
                                            });
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              color: context.isDarkMode
                                  ? Colors.grey[900]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  firebaseApi.firestore
                                      .collection('Users')
                                      .doc(firebaseApi.auth.currentUser!.uid)
                                      .update({
                                    'showLocation':
                                        !snapshot.data!.data()!['showLocation']
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on_rounded),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Konumu göster')
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Switch.adaptive(
                                          value: snapshot.data!
                                              .data()!['showLocation'],
                                          activeColor: Colors.red,
                                          onChanged: (b) {
                                            firebaseApi.firestore
                                                .collection('Users')
                                                .doc(firebaseApi
                                                    .auth.currentUser!.uid)
                                                .update({
                                              'showLocation': !snapshot.data!
                                                  .data()!['showLocation']
                                            });
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Bildirimler',
                                        style: TextStyle(fontSize: 26),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          firebaseApi.firestore
                                              .collection('Users')
                                              .doc(firebaseApi
                                                  .auth.currentUser!.uid)
                                              .update({
                                            'n_newPair': !snapshot.data!
                                                .data()!['n_newPair']
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                children: [
                                                  Text('Yeni eşleşmeler')
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Switch.adaptive(
                                                  value: snapshot.data!
                                                      .data()!['n_newPair'],
                                                  activeColor: Colors.red,
                                                  onChanged: (b) {
                                                    firebaseApi.firestore
                                                        .collection('Users')
                                                        .doc(firebaseApi.auth
                                                            .currentUser!.uid)
                                                        .update({
                                                      'n_newPair': !snapshot
                                                          .data!
                                                          .data()!['n_newPair']
                                                    });
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          firebaseApi.firestore
                                              .collection('Users')
                                              .doc(firebaseApi
                                                  .auth.currentUser!.uid)
                                              .update({
                                            'n_message': !snapshot.data!
                                                .data()!['n_message']
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                children: [Text('Mesajlar')],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Switch.adaptive(
                                                  value: snapshot.data!
                                                      .data()!['n_message'],
                                                  activeColor: Colors.red,
                                                  onChanged: (b) {
                                                    firebaseApi.firestore
                                                        .collection('Users')
                                                        .doc(firebaseApi.auth
                                                            .currentUser!.uid)
                                                        .update({
                                                      'n_message': !snapshot
                                                          .data!
                                                          .data()!['n_message']
                                                    });
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          firebaseApi.firestore
                                              .collection('Users')
                                              .doc(firebaseApi
                                                  .auth.currentUser!.uid)
                                              .update({
                                            'n_photos': !snapshot.data!
                                                .data()!['n_photos']
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      'Resim gönderme izinleri')
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Switch.adaptive(
                                                  value: snapshot.data!
                                                      .data()!['n_photos'],
                                                  activeColor: Colors.red,
                                                  onChanged: (b) {
                                                    firebaseApi.firestore
                                                        .collection('Users')
                                                        .doc(firebaseApi.auth
                                                            .currentUser!.uid)
                                                        .update({
                                                      'n_photos': !snapshot
                                                          .data!
                                                          .data()!['n_photos']
                                                    });
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: context.isDarkMode
                                      ? Colors.grey[900]
                                      : Colors.grey[200]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Yardım',
                                        style: TextStyle(fontSize: 26),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          Get.to(() => Questions(),
                                              transition: Transition.cupertino);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: Row(
                                                children: [
                                                  Text('Sık sorulan sorular')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          Get.to(() => ContactUs(),
                                              transition: Transition.cupertino);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: Row(
                                                children: [Text('Bize ulaşın')],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          Get.to(() => HowToUse(),
                                              transition: Transition.cupertino);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      'Duogether Nasıl kullanılır')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: context.isDarkMode
                                      ? Colors.grey[900]
                                      : Colors.grey[200]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Bizi değerlendir',
                                        style: TextStyle(fontSize: 26),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () async {
                                          if (await InAppReview.instance
                                              .isAvailable()) {
                                            await InAppReview.instance
                                                .requestReview();
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: Row(
                                                children: [
                                                  Text('Bize puan ver')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () async {
                                          await Share.share(
                                              'Duogether’a göz at… Sana uygun oyun arkadaşını bul!\nhttp://onelink.to/duogether',
                                              subject:
                                                  'Duogether’a göz at… Sana uygun oyun arkadaşını bul');
                                          Future.delayed(Duration(seconds: 5),
                                              () async {
                                            firebaseApi.firestore
                                                .collection('Users')
                                                .doc(firebaseApi
                                                    .auth.currentUser!.uid)
                                                .collection('Rosettes')
                                                .where('name',
                                                    isEqualTo: Utils
                                                            .sosyalmedyapaylasma[
                                                        'name']!)
                                                .get()
                                                .then((value) async {
                                              if (value.docs.isEmpty) {
                                                Get.snackbar(
                                                    'Başarı kazandın',
                                                    Utils.sosyalmedyapaylasma[
                                                        'name']!,
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
                                                firebaseApi.firestore
                                                    .collection('Users')
                                                    .doc(firebaseApi
                                                        .auth.currentUser!.uid)
                                                    .collection('Rosettes')
                                                    .add({
                                                  'name':
                                                      Utils.sosyalmedyapaylasma[
                                                          'name']!,
                                                  'photo':
                                                      Utils.sosyalmedyapaylasma[
                                                          'photo']!,
                                                });
                                                await firebaseApi.firestore
                                                    .collection('Users')
                                                    .doc(firebaseApi
                                                        .auth.currentUser!.uid)
                                                    .get()
                                                    .then((value) async {
                                                  int exp =
                                                      value.data()!['exp'];
                                                  int level =
                                                      value.data()!['level'];
                                                  int newExp = exp + 100;
                                                  int newLevel =
                                                      Utils().getLevel(newExp);
                                                  await firebaseApi.firestore
                                                      .collection('Users')
                                                      .doc(firebaseApi.auth
                                                          .currentUser!.uid)
                                                      .update({'exp': newExp});
                                                  if (level != newLevel) {
                                                    //yeni seviyye
                                                    await firebaseApi.firestore
                                                        .collection('Users')
                                                        .doc(firebaseApi.auth
                                                            .currentUser!.uid)
                                                        .update({
                                                      'level': newLevel
                                                    });
                                                    Get.to(() => NewLevel(
                                                        level: newLevel));
                                                  }
                                                });
                                              }
                                            });
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: Row(
                                                children: [Text('Bizi paylaş')],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: context.isDarkMode
                                      ? Colors.grey[900]
                                      : Colors.grey[200]),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Material(
                            //   color: context.isDarkMode
                            //       ? Colors.grey[900]
                            //       : Colors.grey[200],
                            //   borderRadius: BorderRadius.circular(15),
                            //   child: InkWell(
                            //     borderRadius: BorderRadius.circular(15),
                            //     onTap: () {
                            //       Get.to(() => Questions(),
                            //           transition: Transition.cupertino);
                            //     },
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 20, vertical: 15),
                            //           child: Row(
                            //             children: [
                            //               Icon(Icons.help_outline_outlined),
                            //               SizedBox(
                            //                 width: 10,
                            //               ),
                            //               Text('Sık sorulan sorular')
                            //             ],
                            //           ),
                            //         ),
                            //         // Padding(
                            //         //   padding: const EdgeInsets.symmetric(
                            //         //       horizontal: 10),
                            //         //   child: Switch.adaptive(
                            //         //       value: context.isDarkMode,
                            //         //       activeColor: Colors.red,
                            //         //       onChanged: (b) {
                            //         //         if (context.isDarkMode) {
                            //         //           Get.changeTheme(
                            //         //               ThemeData.light());
                            //         //         } else {
                            //         //           Get.changeTheme(ThemeData.dark());
                            //         //         }
                            //         //       }),
                            //         // )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Yasal',
                                        style: TextStyle(fontSize: 26),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          Get.to(
                                              () => Terms(
                                                    hizmet: false,
                                                  ),
                                              transition: Transition.cupertino);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: Row(
                                                children: [
                                                  Text('Gizlilik politikası')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          Get.to(
                                              () => Terms(
                                                    hizmet: true,
                                                  ),
                                              transition: Transition.cupertino);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: Row(
                                                children: [
                                                  Text('Hizmet şartları')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Material(
                                    //   color: context.isDarkMode
                                    //       ? Colors.black
                                    //       : Colors.white,
                                    //   borderRadius: BorderRadius.circular(15),
                                    //   child: InkWell(
                                    //     borderRadius: BorderRadius.circular(15),
                                    //     onTap: () {
                                    //       Get.to(() => Terms(),
                                    //           transition: Transition.cupertino);
                                    //     },
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //       children: [
                                    //         Padding(
                                    //           padding:
                                    //               const EdgeInsets.symmetric(
                                    //                   horizontal: 20,
                                    //                   vertical: 15),
                                    //           child: Row(
                                    //             children: [Text('Lisanslar')],
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: context.isDarkMode
                                      ? Colors.grey[900]
                                      : Colors.grey[200]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              color: context.isDarkMode
                                  ? Colors.grey[900]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () async {
                                  await firebaseApi.signOut();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Row(
                                        children: [
                                          Icon(Icons.exit_to_app_rounded),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Çıkış yap')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (await canLaunch(
                                          'https://www.facebook.com/duogether')) {
                                        launch(
                                            'https://www.facebook.com/duogether');
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/social/facebook.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (await canLaunch(
                                          'https://www.instagram.com/duogether')) {
                                        launch(
                                            'https://www.instagram.com/duogether');
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/social/instagram.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (await canLaunch(
                                          'https://www.twitter.com/duogether1')) {
                                        launch(
                                            'https://www.twitter.com/duogether1');
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/social/twitter.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (await canLaunch(
                                          'https://discord.gg/a6NbHSh4b7')) {
                                        launch('https://discord.gg/a6NbHSh4b7');
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/social/discord.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 70,
                    width: 70,
                  ));
          }),
    );
  }
}
