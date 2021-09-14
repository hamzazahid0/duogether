import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'newLevel.dart';

class AddSocial extends StatefulWidget {
  const AddSocial({Key? key}) : super(key: key);

  @override
  _AddSocialState createState() => _AddSocialState();
}

class _AddSocialState extends State<AddSocial> {
  FirebaseApi firebaseApi = Get.find();
  InfosGetx infosGetx = Get.find();
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Colors.grey[900],
        title: Text('Sosyal bağlantı seçin'),
        centerTitle: true,
      ),
      body: Container(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firebaseApi.firestore
                  .collection('Users')
                  .doc(firebaseApi.auth.currentUser!.uid)
                  .collection('Social')
                  .snapshots(),
              builder: (context, mydata) {
                return !mydata.hasData
                    ? Container()
                    : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future:
                            firebaseApi.firestore.collection('Social').get(),
                        builder: (context, snapshot) {
                          List<QueryDocumentSnapshot<Map<String, dynamic>>>
                              list = [];
                          if (snapshot.hasData) {
                            list = snapshot.data!.docs;
                            // list.remove(mydata.data!.docs);
                            List<String> myaccounts = [];
                            mydata.data!.docs.forEach((element) {
                              myaccounts.add(element.data()['name']);
                            });
                            print(myaccounts);
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
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Girdiğiniz kullanıcı bilgileri başkaları tarafından görüntülenmeyecek',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: GridView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: list.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 1,
                                                crossAxisCount: 2),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(7),
                                            child: GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  useRootNavigator: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          color: context.isDarkMode
                                                              ? Colors.grey[900]
                                                              : Colors.white,
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Image.network(
                                                                list[index]
                                                                        .data()[
                                                                    'icon'],
                                                                height: 100,
                                                                width: 100,
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                list[index]
                                                                        .data()[
                                                                    'name'],
                                                                style: GoogleFonts
                                                                    .roboto(
                                                                        fontSize:
                                                                            25),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(12),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      text,
                                                                  cursorColor:
                                                                      Colors
                                                                          .black,
                                                                  cursorRadius:
                                                                      Radius.circular(
                                                                          10),
                                                                  maxLines: 1,
                                                                  scrollPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  decoration: InputDecoration(
                                                                      hintText:
                                                                          'Hesabınız (Telefon numarası, hesap ismi ve s.)',
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          borderSide: BorderSide(
                                                                              color: Colors
                                                                                  .black,
                                                                              width:
                                                                                  2)),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          borderSide: BorderSide(
                                                                              color: Colors.black,
                                                                              width: 2))),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        40),
                                                                child: Material(
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  child:
                                                                      InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    onTap:
                                                                        () async {
                                                                      if (text
                                                                          .text
                                                                          .isEmpty) {
                                                                        return;
                                                                      }
                                                                      Get.back();
                                                                      await firebaseApi
                                                                          .firestore
                                                                          .collection(
                                                                              'Users')
                                                                          .doc(firebaseApi
                                                                              .auth
                                                                              .currentUser!
                                                                              .uid)
                                                                          .collection(
                                                                              'Social')
                                                                          .add({
                                                                        'icon':
                                                                            list[index].data()['icon'],
                                                                        'launch':
                                                                            list[index].data()['launch'],
                                                                        'name':
                                                                            list[index].data()['name'],
                                                                        'data':
                                                                            text.text
                                                                      });
                                                                      text.text =
                                                                          '';
                                                                      firebaseApi
                                                                          .firestore
                                                                          .collection(
                                                                              'Users')
                                                                          .doc(firebaseApi
                                                                              .auth
                                                                              .currentUser!
                                                                              .uid)
                                                                          .collection(
                                                                              'Rosettes')
                                                                          .where(
                                                                              'name',
                                                                              isEqualTo: Utils.beslevelrozeti['name']!)
                                                                          .get()
                                                                          .then((value) async {
                                                                        if (value
                                                                            .docs
                                                                            .isEmpty) {
                                                                          Get.snackbar(
                                                                              'Başarı kazandın',
                                                                              Utils.beslevelrozeti['name']!,
                                                                              icon: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                child: Icon(
                                                                                  Icons.emoji_events_outlined,
                                                                                  size: 35,
                                                                                ),
                                                                              ));
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Users')
                                                                              .doc(firebaseApi.auth.currentUser!.uid)
                                                                              .collection('Rosettes')
                                                                              .add({
                                                                            'name':
                                                                                Utils.beslevelrozeti['name']!,
                                                                            'photo':
                                                                                Utils.beslevelrozeti['photo']!,
                                                                          });
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Users')
                                                                              .doc(firebaseApi.auth.currentUser!.uid)
                                                                              .get()
                                                                              .then((value) async {
                                                                            int exp =
                                                                                value.data()!['exp'];
                                                                            int level =
                                                                                value.data()!['level'];
                                                                            int newExp =
                                                                                exp + 100;
                                                                            int newLevel =
                                                                                Utils().getLevel(newExp);
                                                                            await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({
                                                                              'exp': newExp
                                                                            });
                                                                            if (level !=
                                                                                newLevel) {
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
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              18),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'Ekle',
                                                                            style:
                                                                                TextStyle(fontSize: 22, color: Colors.white),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 50,
                                                              )
                                                            ],
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
                                                          const EdgeInsets.all(
                                                              30),
                                                      child: Image.network(
                                                          list[index]
                                                              .data()['icon']),
                                                    )),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      list[index]
                                                          .data()['name'],
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 22),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    )
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                    color: context.isDarkMode
                                                        ? Colors.grey[900]
                                                        : Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
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
