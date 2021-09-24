import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/screens/message.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confetti/confetti.dart';

class Paired extends StatelessWidget {
  final String name;
  final int age;
  final String id;
  final String pairId;
  final String avatar;
  final bool avatarIsAsset;

  Paired(
      {Key? key,
      required this.name,
      required this.age,
      required this.id,
      required this.avatar,
      required this.avatarIsAsset,
      required this.pairId})
      : super(key: key);
  ConfettiController l = ConfettiController(duration: Duration(seconds: 1));
  ConfettiController r = ConfettiController(duration: Duration(seconds: 1));
  @override
  Widget build(BuildContext context) {
    InfosGetx infosGetx = Get.find();
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
                          fontSize: 35),
                    ),
                    Text(
                      "Duo'nu buldun\nhadi bekletme onu",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            infosGetx.avatarIsAsset.value
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        AssetImage(infosGetx.avatar.value),
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        NetworkImage(infosGetx.avatar.value),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${infosGetx.name.value}, ${infosGetx.age.value}',
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            avatarIsAsset
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(avatar),
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(avatar),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$name, $age',
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/punch.svg',
                      height: 110,
                      color: Color.fromRGBO(169, 168, 90, 1),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Material(
                      color: Color.fromRGBO(0, 117, 247, 1),
                      borderRadius: BorderRadius.circular(40),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () async {
                          // await firebaseApi.firestore
                          //     .collection('Pairs')
                          //     .doc(pairId)
                          //     .update({'hasMessage': true});
                          Get.off(
                              () => Message(
                                    avatar: avatar,
                                    avatarIsAsset: avatarIsAsset,
                                    name: name,
                                    pairId: pairId,
                                    id: id,
                                  ),
                              transition: Transition.cupertino);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: Text(
                            "$name kişisine yaz",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Aramaya geri dön',
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 15),
                        ))
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
        ],
      ),
    );
  }
}
