import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GiftScreen extends StatefulWidget {
  const GiftScreen({Key? key}) : super(key: key);
  @override
  _GiftScreenState createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool data = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: SizedBox(
                      child: CircularProgressIndicator.adaptive(),
                      height: 60,
                      width: 60,
                    ),
                  )
                : snapshot.data!.data()!['level'] >= 5
                    ? Container(
                        child: StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('Campaign')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? snapshot.data!.exists
                                    ? Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/prize.png',
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              height: 180,
                                              width: 180,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40),
                                              child: Text(
                                                  "Çekiliş ön başvurusu alınmıştır.\nKatılımcı numaranız #${snapshot.data!.get('id')}'dır.\nBu numara ile instagram gönderisinde yorum yapabilirsiniz.",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Text(
                                                'Duogether id',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 80),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(20),
                                                      color: Colors.black
                                                          .withOpacity(0.2)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: TextField(
                                                      enabled: false,
                                                      controller:
                                                          TextEditingController(
                                                              text: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid
                                                                  .toString()
                                                                  .substring(
                                                                      0, 8)),
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                'Adın ve soyadın',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 80),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(20),
                                                      color: Colors.black
                                                          .withOpacity(0.2)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: TextField(
                                                      controller: name,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                'Instagram kullanıcı adın',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 80),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(20),
                                                      color: Colors.black
                                                          .withOpacity(0.2)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: TextField(
                                                      controller: instagram,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                'Telefon numaran',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 80),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(20),
                                                      color: Colors.black
                                                          .withOpacity(0.2)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      controller: phone,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Checkbox(
                                                      value: data,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          data = value!;
                                                        });
                                                      }),
                                                  Text(
                                                      'Tüm bilgileri doğru şekilde girdim')
                                                ],
                                              ),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 80),
                                                child: Material(
                                                  elevation: 10,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.green[600],
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (name.text
                                                          .toString()
                                                          .isEmpty) {
                                                        Get.snackbar(
                                                            'Gerekli tüm alanları doldurun',
                                                            'Doğru bilgi girdiğinize emin olun');
                                                        return;
                                                      }
                                                      if (phone.text
                                                          .toString()
                                                          .isEmpty) {
                                                        Get.snackbar(
                                                            'Gerekli tüm alanları doldurun',
                                                            'Doğru bilgi girdiğinize emin olun');
                                                        return;
                                                      }
                                                      if (instagram.text
                                                          .toString()
                                                          .isEmpty) {
                                                        Get.snackbar(
                                                            'Gerekli tüm alanları doldurun',
                                                            'Doğru bilgi girdiğinize emin olun');
                                                        return;
                                                      }
                                                      if (!data) {
                                                        Get.snackbar(
                                                            'Gerekli tüm alanları doldurun',
                                                            'Bilgilerin doğru olduğunu onaylayın');
                                                        return;
                                                      }
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Campaign')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .set({
                                                        'id': Random().nextInt(
                                                                49999) +
                                                            9999 +
                                                            Random().nextInt(
                                                                39999) +
                                                            Random()
                                                                .nextInt(99) +
                                                            13,
                                                        'name':
                                                            name.text.trim(),
                                                        'phone':
                                                            phone.text.trim(),
                                                        'instagram': instagram
                                                            .text
                                                            .trim(),
                                                        'userID': FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid,
                                                        "date": Timestamp.now(),
                                                      });
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Center(
                                                          child: Text(
                                                        'Katıl',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                child: Text(
                                                  'Not: Bilgileri doğru girmediğiniz takdirde çekiliş hakkınız devredilecektir',
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                : Center(
                                    child: SizedBox(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                      height: 60,
                                      width: 60,
                                    ),
                                  );
                          },
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/level.png',
                              height: 180,
                              width: 180,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                  "Çekilişe katılmak için 5. Seviye veya üstü olmanız gerek",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      );
          }),
    );
  }
}
