import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Questions extends StatefulWidget {
  final PageController controller;

  const Questions({Key? key, required this.controller}) : super(key: key);
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  FirebaseApi firebaseApi = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      color: context.isDarkMode
                          ? Colors.grey[900]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          widget.controller.animateToPage(4,
                              duration: Duration(milliseconds: 250),
                              curve: Curves.linear);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back_ios_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Geri',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Daha doğru eşleşmeler bulmak için sorulara cevap verin',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Kendini nasıl tanımlarsın? (4 tane seçiniz)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: firebaseApi.sosyal.value
                              ? Colors.green
                              : Colors.grey[200],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: firebaseApi.selectedQuestion.value == 4
                                ? firebaseApi.sosyal.value
                                    ? () {
                                        if (!firebaseApi.sosyal.value) {
                                          firebaseApi.selectedQuestion.value++;
                                        } else {
                                          firebaseApi.selectedQuestion.value--;
                                        }
                                        firebaseApi.sosyal.value =
                                            !firebaseApi.sosyal.value;
                                      }
                                    : null
                                : () {
                                    if (!firebaseApi.sosyal.value) {
                                      firebaseApi.selectedQuestion.value++;
                                    } else {
                                      firebaseApi.selectedQuestion.value--;
                                    }
                                    firebaseApi.sosyal.value =
                                        !firebaseApi.sosyal.value;
                                  },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Sosyal',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: firebaseApi.sosyal.value
                                          ? Colors.white
                                          : Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: firebaseApi.utangac.value
                              ? Colors.green
                              : Colors.grey[200],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: firebaseApi.selectedQuestion.value == 4
                                ? firebaseApi.utangac.value
                                    ? () {
                                        if (!firebaseApi.utangac.value) {
                                          firebaseApi.selectedQuestion.value++;
                                        } else {
                                          firebaseApi.selectedQuestion.value--;
                                        }
                                        firebaseApi.utangac.value =
                                            !firebaseApi.utangac.value;
                                      }
                                    : null
                                : () {
                                    if (!firebaseApi.utangac.value) {
                                      firebaseApi.selectedQuestion.value++;
                                    } else {
                                      firebaseApi.selectedQuestion.value--;
                                    }
                                    firebaseApi.utangac.value =
                                        !firebaseApi.utangac.value;
                                  },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Utangaç',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: firebaseApi.utangac.value
                                          ? Colors.white
                                          : Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: firebaseApi.neseli.value
                              ? Colors.green
                              : Colors.grey[200],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: firebaseApi.selectedQuestion.value == 4
                                ? firebaseApi.neseli.value
                                    ? () {
                                        if (!firebaseApi.neseli.value) {
                                          firebaseApi.selectedQuestion.value++;
                                        } else {
                                          firebaseApi.selectedQuestion.value--;
                                        }
                                        firebaseApi.neseli.value =
                                            !firebaseApi.neseli.value;
                                      }
                                    : null
                                : () {
                                    if (!firebaseApi.neseli.value) {
                                      firebaseApi.selectedQuestion.value++;
                                    } else {
                                      firebaseApi.selectedQuestion.value--;
                                    }
                                    firebaseApi.neseli.value =
                                        !firebaseApi.neseli.value;
                                  },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Neşeli',
                                  style: TextStyle(
                                      color: firebaseApi.neseli.value
                                          ? Colors.white
                                          : Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: firebaseApi.merakli.value
                              ? Colors.green
                              : Colors.grey[200],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: firebaseApi.selectedQuestion.value == 4
                                ? firebaseApi.merakli.value
                                    ? () {
                                        if (!firebaseApi.merakli.value) {
                                          firebaseApi.selectedQuestion.value++;
                                        } else {
                                          firebaseApi.selectedQuestion.value--;
                                        }
                                        firebaseApi.merakli.value =
                                            !firebaseApi.merakli.value;
                                      }
                                    : null
                                : () {
                                    if (!firebaseApi.merakli.value) {
                                      firebaseApi.selectedQuestion.value++;
                                    } else {
                                      firebaseApi.selectedQuestion.value--;
                                    }
                                    firebaseApi.merakli.value =
                                        !firebaseApi.merakli.value;
                                  },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Meraklı',
                                  style: TextStyle(
                                      color: firebaseApi.merakli.value
                                          ? Colors.white
                                          : Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: firebaseApi.duygusal.value
                              ? Colors.green
                              : Colors.grey[200],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: firebaseApi.selectedQuestion.value == 4
                                ? firebaseApi.duygusal.value
                                    ? () {
                                        if (!firebaseApi.duygusal.value) {
                                          firebaseApi.selectedQuestion.value++;
                                        } else {
                                          firebaseApi.selectedQuestion.value--;
                                        }
                                        firebaseApi.duygusal.value =
                                            !firebaseApi.duygusal.value;
                                      }
                                    : null
                                : () {
                                    if (!firebaseApi.duygusal.value) {
                                      firebaseApi.selectedQuestion.value++;
                                    } else {
                                      firebaseApi.selectedQuestion.value--;
                                    }
                                    firebaseApi.duygusal.value =
                                        !firebaseApi.duygusal.value;
                                  },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Duygusal',
                                  style: TextStyle(
                                      color: firebaseApi.duygusal.value
                                          ? Colors.white
                                          : Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: firebaseApi.kuralci.value
                              ? Colors.green
                              : Colors.grey[200],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: firebaseApi.selectedQuestion.value == 4
                                ? firebaseApi.kuralci.value
                                    ? () {
                                        if (!firebaseApi.kuralci.value) {
                                          firebaseApi.selectedQuestion.value++;
                                        } else {
                                          firebaseApi.selectedQuestion.value--;
                                        }
                                        firebaseApi.kuralci.value =
                                            !firebaseApi.kuralci.value;
                                      }
                                    : null
                                : () {
                                    if (!firebaseApi.kuralci.value) {
                                      firebaseApi.selectedQuestion.value++;
                                    } else {
                                      firebaseApi.selectedQuestion.value--;
                                    }
                                    firebaseApi.kuralci.value =
                                        !firebaseApi.kuralci.value;
                                  },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Kuralcı',
                                  style: TextStyle(
                                      color: firebaseApi.kuralci.value
                                          ? Colors.white
                                          : Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: firebaseApi.fevri.value
                              ? Colors.green
                              : Colors.grey[200],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: firebaseApi.selectedQuestion.value == 4
                                ? firebaseApi.fevri.value
                                    ? () {
                                        if (!firebaseApi.fevri.value) {
                                          firebaseApi.selectedQuestion.value++;
                                        } else {
                                          firebaseApi.selectedQuestion.value--;
                                        }
                                        firebaseApi.fevri.value =
                                            !firebaseApi.fevri.value;
                                      }
                                    : null
                                : () {
                                    if (!firebaseApi.fevri.value) {
                                      firebaseApi.selectedQuestion.value++;
                                    } else {
                                      firebaseApi.selectedQuestion.value--;
                                    }
                                    firebaseApi.fevri.value =
                                        !firebaseApi.fevri.value;
                                  },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Fevri',
                                  style: TextStyle(
                                      color: firebaseApi.fevri.value
                                          ? Colors.white
                                          : Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: firebaseApi.hirsli.value
                              ? Colors.green
                              : Colors.grey[200],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: firebaseApi.selectedQuestion.value == 4
                                ? firebaseApi.hirsli.value
                                    ? () {
                                        if (!firebaseApi.hirsli.value) {
                                          firebaseApi.selectedQuestion.value++;
                                        } else {
                                          firebaseApi.selectedQuestion.value--;
                                        }
                                        firebaseApi.hirsli.value =
                                            !firebaseApi.hirsli.value;
                                      }
                                    : null
                                : () {
                                    if (!firebaseApi.hirsli.value) {
                                      firebaseApi.selectedQuestion.value++;
                                    } else {
                                      firebaseApi.selectedQuestion.value--;
                                    }
                                    firebaseApi.hirsli.value =
                                        !firebaseApi.hirsli.value;
                                  },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Hırslı',
                                  style: TextStyle(
                                      color: firebaseApi.hirsli.value
                                          ? Colors.white
                                          : Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: firebaseApi.karamsar.value
                              ? Colors.green
                              : Colors.grey[200],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: firebaseApi.selectedQuestion.value == 4
                                ? firebaseApi.karamsar.value
                                    ? () {
                                        if (!firebaseApi.karamsar.value) {
                                          firebaseApi.selectedQuestion.value++;
                                        } else {
                                          firebaseApi.selectedQuestion.value--;
                                        }
                                        firebaseApi.karamsar.value =
                                            !firebaseApi.karamsar.value;
                                      }
                                    : null
                                : () {
                                    if (!firebaseApi.karamsar.value) {
                                      firebaseApi.selectedQuestion.value++;
                                    } else {
                                      firebaseApi.selectedQuestion.value--;
                                    }
                                    firebaseApi.karamsar.value =
                                        !firebaseApi.karamsar.value;
                                  },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Karamsar',
                                  style: TextStyle(
                                      color: firebaseApi.karamsar.value
                                          ? Colors.white
                                          : Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Oyun esnasında kendini nasıl tanımlarsın?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  '(her satırdan bir cevap seçiniz) ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q1.value = 1;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Çok sakinim',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q1.value == 1
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: firebaseApi.q1.value == 1
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20))),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q1.value = 2;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Sakinim',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q1.value == 2
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: firebaseApi.q1.value == 2
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q1.value = 3;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Heyecanlıyım',
                                  overflow: TextOverflow.visible,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q1.value == 3
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: firebaseApi.q1.value == 3
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q1.value = 4;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Çok heyecanlıyıma',
                                  overflow: TextOverflow.visible,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q1.value == 4
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: firebaseApi.q1.value == 4
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(20))),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q2.value = 1;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Çok uysalım',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q2.value == 1
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: firebaseApi.q2.value == 1
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20))),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q2.value = 2;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Uysalım',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q2.value == 2
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: firebaseApi.q2.value == 2
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q2.value = 3;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Sinirlenirim',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q2.value == 3
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: firebaseApi.q2.value == 3
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q2.value = 4;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Çok sinirlenirim',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q2.value == 4
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: firebaseApi.q2.value == 4
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(20))),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q3.value = 1;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Takıma katılırım',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q3.value == 1
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: firebaseApi.q3.value == 1
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20))),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q3.value = 2;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Bireysel düşünürüm',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q3.value == 2
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: firebaseApi.q3.value == 2
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            firebaseApi.q3.value = 3;
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  'Takımı yönetirim',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: firebaseApi.q3.value == 3
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: firebaseApi.q3.value == 3
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(20))),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30),
              //   child: Text(
              //     'Oyun saatlerim',
              //     textAlign: TextAlign.center,
              //     style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () async {
              //         TimeRange time = await showTimeRangePicker(
              //             context: context,
              //             padding: 50,
              //             strokeWidth: 8,
              //             fromText: 'Başlangıç',
              //             toText: 'Bitiş',
              //             handlerColor: Colors.green[300],
              //             strokeColor: Colors.purple,
              //             end: TimeOfDay(hour: firebaseApi.endHour.value, minute: firebaseApi.endMinute.value),
              //             handlerRadius: 15,
              //             labels: [
              //               ClockLabel(angle: 0, text: '18:00'),
              //               ClockLabel(angle: 1.55, text: '00:00'),
              //               ClockLabel(angle: 3.15, text: '06:00'),
              //               ClockLabel(angle: 4.7, text: '12:00'),
              //             ],
              //             backgroundWidget: CircleAvatar(
              //               radius: 100,
              //               backgroundColor: Colors.transparent,
              //               child: Padding(
              //                 padding: EdgeInsets.all(20),
              //                 child: Image.asset('assets/orta.png'),
              //               ),
              //             ),
              //             ticks: 12,
              //             autoAdjustLabels: true,
              //             backgroundColor: Colors.red,
              //             selectedColor: Colors.green,
              //             disabledColor: Colors.grey,
              //             start: TimeOfDay(hour: firebaseApi.startHour.value, minute: firebaseApi.startMinute.value));
              //         if (time != null) {
              //           firebaseApi.startHour.value = time.startTime.hour;
              //           firebaseApi.startMinute.value = time.startTime.minute;
              //           firebaseApi.endHour.value = time.endTime.hour;
              //           firebaseApi.endMinute.value = time.endTime.minute;
              //           firebaseApi.firestore
              //               .collection('Users')
              //               .doc(firebaseApi.auth.currentUser!.uid)
              //               .collection('Rosettes')
              //               .where('name', isEqualTo: Utils.aktifsaatleriniduzenleme['name']!)
              //               .get()
              //               .then((value) {
              //             if (value.docs.isEmpty) {
              //               firebaseApi.exp = firebaseApi.exp + 150;
              //               Get.snackbar('Başarı kazandın', Utils.aktifsaatleriniduzenleme['name']!,
              //                   icon: Padding(
              //                     padding: const EdgeInsets.symmetric(horizontal: 5),
              //                     child: Icon(
              //                       Icons.emoji_events_outlined,
              //                       size: 35,
              //                     ),
              //                   ));
              //               firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
              //                 'name': Utils.aktifsaatleriniduzenleme['name']!,
              //                 'photo': Utils.aktifsaatleriniduzenleme['photo']!,
              //               });
              //             }
              //           });
              //         }
              //       },
              //       child: Container(
              //         child: Padding(
              //           padding: const EdgeInsets.all(15),
              //           child: Text(
              //             firebaseApi.startMinute.value < 10 ? '${firebaseApi.startHour.value}:0${firebaseApi.startMinute.value}' : '${firebaseApi.startHour.value}:${firebaseApi.startMinute.value}',
              //             style: GoogleFonts.rationale(fontSize: 30),
              //           ),
              //         ),
              //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: context.isDarkMode ? Colors.grey[900] : Colors.grey[300]),
              //       ),
              //     ),
              //     Text(
              //       ' - ',
              //       style: GoogleFonts.rationale(fontSize: 30),
              //     ),
              //     GestureDetector(
              //       onTap: () async {
              //         TimeRange time = await showTimeRangePicker(
              //             context: context,
              //             padding: 50,
              //             strokeWidth: 8,
              //             fromText: 'Başlangıç',
              //             toText: 'Bitiş',
              //             handlerColor: Colors.green[300],
              //             strokeColor: Colors.purple,
              //             end: TimeOfDay(hour: firebaseApi.endHour.value, minute: firebaseApi.endMinute.value),
              //             handlerRadius: 15,
              //             labels: [
              //               ClockLabel(angle: 0, text: '18:00'),
              //               ClockLabel(angle: 1.55, text: '00:00'),
              //               ClockLabel(angle: 3.15, text: '06:00'),
              //               ClockLabel(angle: 4.7, text: '12:00'),
              //             ],
              //             backgroundWidget: CircleAvatar(
              //               radius: 100,
              //               backgroundColor: Colors.transparent,
              //               child: Padding(
              //                 padding: EdgeInsets.all(20),
              //                 child: Image.asset('assets/orta.png'),
              //               ),
              //             ),
              //             ticks: 12,
              //             autoAdjustLabels: true,
              //             backgroundColor: Colors.red,
              //             selectedColor: Colors.green,
              //             disabledColor: Colors.grey,
              //             start: TimeOfDay(hour: firebaseApi.startHour.value, minute: firebaseApi.startMinute.value));
              //         if (time != null) {
              //           firebaseApi.startHour.value = time.startTime.hour;
              //           firebaseApi.startMinute.value = time.startTime.minute;
              //           firebaseApi.endHour.value = time.endTime.hour;
              //           firebaseApi.endMinute.value = time.endTime.minute;
              //           firebaseApi.firestore
              //               .collection('Users')
              //               .doc(firebaseApi.auth.currentUser!.uid)
              //               .collection('Rosettes')
              //               .where('name', isEqualTo: Utils.aktifsaatleriniduzenleme['name']!)
              //               .get()
              //               .then((value) {
              //             if (value.docs.isEmpty) {
              //               firebaseApi.exp = firebaseApi.exp + 150;
              //               Get.snackbar('Başarı kazandın', Utils.aktifsaatleriniduzenleme['name']!,
              //                   icon: Padding(
              //                     padding: const EdgeInsets.symmetric(horizontal: 5),
              //                     child: Icon(
              //                       Icons.emoji_events_outlined,
              //                       size: 35,
              //                     ),
              //                   ));
              //               firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
              //                 'name': Utils.aktifsaatleriniduzenleme['name']!,
              //                 'photo': Utils.aktifsaatleriniduzenleme['photo']!,
              //               });
              //             }
              //           });
              //         }
              //       },
              //       child: Container(
              //         child: Padding(
              //           padding: const EdgeInsets.all(15),
              //           child: Text(
              //             firebaseApi.endMinute.value < 10 ? '${firebaseApi.endHour.value}:0${firebaseApi.endMinute.value}' : '${firebaseApi.endHour.value}:${firebaseApi.endMinute.value}',
              //             style: GoogleFonts.rationale(fontSize: 30),
              //           ),
              //         ),
              //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: context.isDarkMode ? Colors.grey[900] : Colors.grey[300]),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 50,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10,
                      height: 1,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       firebaseApi.finishRegisterWithSkip();
                    //     },
                    //     child: Text(
                    //       'Atla',
                    //       style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.grey[800], fontSize: 17),
                    //     )),
                    Container(
                      decoration: BoxDecoration(
                          color: firebaseApi.selectedQuestion.value == 4 &&
                                  firebaseApi.q1.value != 0 &&
                                  firebaseApi.q2.value != 0 &&
                                  firebaseApi.q3.value != 0
                              ? Colors.green
                              : Colors.grey[800],
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                          // onPressed: firebaseApi.selectedQuestion.value == 4
                          //     ? () {}
                          //     : null,
                          onPressed: firebaseApi.selectedQuestion.value == 4 &&
                                  firebaseApi.q1.value != 0 &&
                                  firebaseApi.q2.value != 0 &&
                                  firebaseApi.q3.value != 0
                              ? () async {
                                  // await firebaseApi.firestore
                                  //     .collection('Users')
                                  //     .doc(firebaseApi.auth.currentUser!.uid)
                                  //     .collection('Rosettes')
                                  //     .where('name', isEqualTo: Utils.senincizginyapma['name']!)
                                  //     .get()
                                  //     .then((value) async {
                                  //   if (value.docs.isEmpty) {
                                  //     firebaseApi.exp = firebaseApi.exp + 200;
                                  //     Get.snackbar('Başarı kazandın', Utils.senincizginyapma['name']!,
                                  //         icon: Padding(
                                  //           padding: const EdgeInsets.symmetric(horizontal: 5),
                                  //           child: Icon(
                                  //             Icons.emoji_events_outlined,
                                  //             size: 35,
                                  //           ),
                                  //         ));
                                  //     await firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                                  //       'name': Utils.senincizginyapma['name']!,
                                  //       'photo': Utils.senincizginyapma['photo']!,
                                  //     });
                                  //     firebaseApi.finishRegister();
                                  //   } else {
                                  //     firebaseApi.finishRegister();
                                  //   }
                                  // });
                                  firebaseApi.finishRegister();
                                }
                              : null,
                          child: Text(
                            'Bitti',
                            style: firebaseApi.selectedQuestion.value == 4 &&
                                    firebaseApi.q1.value != 0 &&
                                    firebaseApi.q2.value != 0 &&
                                    firebaseApi.q3.value != 0
                                ? TextStyle(color: Colors.white, fontSize: 22)
                                : TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    )
                  ],
                ),
              ),
              firebaseApi.selectedQuestion.value == 4 &&
                      firebaseApi.q1.value != 0 &&
                      firebaseApi.q2.value != 0 &&
                      firebaseApi.q3.value != 0
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 100,
                        ),
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
                        Expanded(
                          child: Text('Soruları cevaplayın',
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[800])),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
              SizedBox(
                height: 20,
              )
              // Container(
              //   color: Colors.grey[200],
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       children: [
              //         SizedBox(
              //           width: double.maxFinite,
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 20),
              //             child: CupertinoSlider(
              //               activeColor: Colors.grey[300],
              //               thumbColor: Colors.green,
              //               value: firebaseApi.value.value,
              //               onChanged: (value) {
              //                 firebaseApi.value.value = value;
              //               },
              //               max: 3,
              //               divisions: 3,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: double.maxFinite,
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 20),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Flexible(
              //                   child: Text('Çok sakinim'),
              //                   flex: 1,
              //                 ),
              //                 Flexible(
              //                   child: Text('Sakinim'),
              //                   flex: 1,
              //                 ),
              //                 Flexible(
              //                   child: Text('Heyecanlıyım'),
              //                   flex: 1,
              //                 ),
              //                 Flexible(
              //                   child: Text('Çok heyecanlıyım'),
              //                   flex: 1,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
