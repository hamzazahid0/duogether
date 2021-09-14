import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewLevel extends StatefulWidget {
  final int level;
  const NewLevel({Key? key, required this.level}) : super(key: key);

  @override
  _NewLevelState createState() => _NewLevelState();
}

class _NewLevelState extends State<NewLevel> {
  InfosGetx infosGetx = Get.find();
  FirebaseApi firebaseApi = Get.find();
  ConfettiController l = ConfettiController(duration: Duration(seconds: 1));
  ConfettiController r = ConfettiController(duration: Duration(seconds: 1));

  @override
  void initState() {
    super.initState();

    // if (widget.level == 5 || widget.level == 6 || widget.level == 7) {
    //   firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').where('name', isEqualTo: Utils.beslevelrozeti['name']!).get().then((value) async {
    //     if (value.docs.isEmpty) {
    //       Get.snackbar('Başarı kazandın', Utils.beslevelrozeti['name']!,
    //           icon: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 5),
    //             child: Icon(
    //               Icons.emoji_events_outlined,
    //               size: 35,
    //             ),
    //           ));
    //       firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
    //         'name': Utils.beslevelrozeti['name']!,
    //         'photo': Utils.beslevelrozeti['photo']!,
    //       });
    //       await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).get().then((value) async {
    //         int exp = value.data()!['exp'];
    //         int level = value.data()!['level'];
    //         int newExp = exp + 400;
    //         int newLevel = Utils().getLevel(newExp);
    //         await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'exp': newExp});
    //         if (level != newLevel) {
    //           //yeni seviyye
    //           await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).update({'level': newLevel});
    //           Get.off(() => NewLevel(level: newLevel));
    //         }
    //       });
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    l.play();
    r.play();
    return Scaffold(
      backgroundColor: Color.fromRGBO(23, 26, 32, 1),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'TEBRİKLER',
                      style: GoogleFonts.secularOne(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          fontSize: 45),
                    ),
                    Text(
                      "Yeni seviye'ye yükseldin",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            infosGetx.avatarIsAsset.value
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        AssetImage(infosGetx.avatar.value),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        NetworkImage(infosGetx.avatar.value),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${infosGetx.name.value}',
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 30),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.level}. Seviye',
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 22),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Material(
                      color: Color.fromRGBO(0, 117, 247, 1),
                      borderRadius: BorderRadius.circular(40),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          child: Text(
                            "Devam",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.3,
              left: 0,
              child: ConfettiWidget(
                confettiController: l,
                blastDirection: pi * 1.59,
                maxBlastForce: 70,
                minBlastForce: 20,
                maximumSize: Size(16, 7),
                minimumSize: Size(12, 5),
                colors: [
                  Colors.pink,
                  Colors.purple,
                  Colors.blue,
                  Colors.blueGrey,
                  Colors.red,
                  Colors.yellow,
                  Colors.orange,
                  Colors.green
                ],
                gravity: 0.2,
                numberOfParticles: 160,
                shouldLoop: false,
              )),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.3,
              right: 0,
              child: ConfettiWidget(
                confettiController: r,
                blastDirection: pi * 1.388,
                maxBlastForce: 70,
                minBlastForce: 20,
                maximumSize: Size(16, 7),
                minimumSize: Size(12, 5),
                colors: [
                  Colors.pink,
                  Colors.purple,
                  Colors.blue,
                  Colors.blueGrey,
                  Colors.red,
                  Colors.yellow,
                  Colors.orange,
                  Colors.green
                ],
                gravity: 0.2,
                numberOfParticles: 160,
                shouldLoop: false,
              ))
          // Positioned(
          //     bottom: 0,
          //     left: MediaQuery.of(context).size.width * 0.2,
          //     child: ConfettiWidget(
          //       confettiController: l,
          //       blastDirection: pi * 1.5,
          //       maxBlastForce: 200,
          //       minBlastForce: 10,
          //       maximumSize: Size(16, 7),
          //       minimumSize: Size(12, 5),
          //       colors: [
          //         Colors.pink,
          //         Colors.purple,
          //         Colors.blue,
          //         Colors.blueGrey,
          //         Colors.red,
          //         Colors.yellow,
          //         Colors.orange,
          //         Colors.green
          //       ],
          //       gravity: 0.2,
          //       numberOfParticles: 350,
          //       shouldLoop: false,
          //     )),
          // Positioned(
          //     bottom: 0,
          //     right: MediaQuery.of(context).size.width / 2,
          //     child: ConfettiWidget(
          //       confettiController: c,
          //       blastDirection: pi * 1.5,
          //       maxBlastForce: 50,
          //       minBlastForce: 10,
          //       maximumSize: Size(16, 7),
          //       minimumSize: Size(12, 5),
          //       colors: [
          //         Colors.pink,
          //         Colors.purple,
          //         Colors.blue,
          //         Colors.blueGrey,
          //         Colors.red,
          //         Colors.yellow,
          //         Colors.orange,
          //         Colors.green
          //       ],
          //       gravity: 0.2,
          //       numberOfParticles: 350,
          //       shouldLoop: false,
          //     )),
          // Positioned(
          //     bottom: 0,
          //     right: MediaQuery.of(context).size.width * 0.2,
          //     child: ConfettiWidget(
          //       confettiController: r,
          //       blastDirection: pi * 1.5,
          //       maxBlastForce: 150,
          //       minBlastForce: 10,
          //       maximumSize: Size(16, 7),
          //       minimumSize: Size(12, 5),
          //       colors: [
          //         Colors.pink,
          //         Colors.purple,
          //         Colors.blue,
          //         Colors.blueGrey,
          //         Colors.red,
          //         Colors.yellow,
          //         Colors.orange,
          //         Colors.green
          //       ],
          //       gravity: 0.2,
          //       numberOfParticles: 350,
          //       shouldLoop: false,
          //     )),
        ],
      ),
    );
  }
}
