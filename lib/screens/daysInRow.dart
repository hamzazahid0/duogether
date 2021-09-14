import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DaysInRow extends StatefulWidget {
  final int days;
  const DaysInRow({Key? key, required this.days}) : super(key: key);

  @override
  _DaysInRowState createState() => _DaysInRowState();
}

class _DaysInRowState extends State<DaysInRow> {
  ConfettiController l = ConfettiController(duration: Duration(seconds: 1));
  ConfettiController r = ConfettiController(duration: Duration(seconds: 1));
  InfosGetx infosGetx = Get.find();
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
              padding: const EdgeInsets.only(top: 40, right: 50, left: 50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'HARİKA',
                      style: GoogleFonts.secularOne(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          fontSize: 35),
                    ),
                    Text(
                      "${widget.days}. Gününe Hoşgeldin",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Her gün Duogether’ı ziyaret et ve çerçeveleri topla",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          fontSize: 17),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         infosGetx.avatarIsAsset.value
                    //             ? CircleAvatar(
                    //                 radius: 60,
                    //                 backgroundColor: Colors.transparent,
                    //                 backgroundImage:
                    //                     AssetImage(infosGetx.avatar.value),
                    //               )
                    //             : CircleAvatar(
                    //                 radius: 60,
                    //                 backgroundColor: Colors.transparent,
                    //                 backgroundImage:
                    //                     NetworkImage(infosGetx.avatar.value),
                    //               ),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         Text(
                    //           '${infosGetx.name.value}',
                    //           style: GoogleFonts.secularOne(
                    //               color: Colors.white, fontSize: 30),
                    //         ),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child:
                          Image.asset('assets/covers/level-${widget.days}.png'),
                    ),
                    Text(
                      "${widget.days}. Gün",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          fontSize: 17),
                    ),
                    SizedBox(
                      height: 7,
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
                            "Ödülü Topla",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 17),
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
