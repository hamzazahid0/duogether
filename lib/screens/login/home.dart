import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/screens/resetPass.dart';
import 'package:gamehub/screens/terms.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginHome extends StatefulWidget {
  final PageController controller;

  const LoginHome({Key? key, required this.controller}) : super(key: key);
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  FirebaseApi firebaseApi = Get.find();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  var termsConditionRecognizer = TapGestureRecognizer()
    ..onTap = () {
      Get.to(
          () => Terms(
                hizmet: true,
              ),
          transition: Transition.cupertino);
    };
  var privacyPolicyRecognizer = TapGestureRecognizer()
    ..onTap = () {
      Get.to(
          () => Terms(
                hizmet: false,
              ),
          transition: Transition.cupertino);
    };
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.black : Colors.white),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: context.isDarkMode ? Colors.black : Colors.white,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, right: 80, left: 80),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 85,
                          height: 85,
                          child: Image.asset(
                            'assets/orta.png',
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Duogether'a\nhoş geldin",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Giriş yaparak ',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              TextSpan(
                                  text: 'gizlilik politikasını',
                                  recognizer: privacyPolicyRecognizer,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: ' ve ',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              TextSpan(
                                  text: 'hizmet şartlarını ',
                                  recognizer: termsConditionRecognizer,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: 'kabul ediyorsunuz',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                            ])
                            // '  ve hizmet şartlarını kabul ediyorsunuz',
                            // style: TextStyle(
                            //   fontSize: 13,
                            // ),
                            // textAlign: TextAlign.center,
                            )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: context.isDarkMode
                        ? [Colors.grey[900]!, Colors.grey[800]!]
                        : [
                            Color(0xFFffffff),
                            Color(0xFFdfe9f3),
                          ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                color: context.isDarkMode
                                    ? Colors.black
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(30)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () async {
                                  await firebaseApi
                                      .signInWithGoogle()
                                      .then((value) {
                                    firebaseApi.loading.value = false;
                                    GetStorage().write("signMethod", "google");
                                    widget.controller.jumpToPage(3);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/login/google.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                              color: context.isDarkMode
                                  ? Colors.black
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(30)),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () async {
                                var success =
                                    await firebaseApi.signInWithFacebook();
                                if (success) {
                                  firebaseApi.loading.value = false;
                                  GetStorage().write("signMethod", "facebook");
                                  widget.controller.jumpToPage(3);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/login/facebook.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        !firebaseApi.apple
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                      color: context.isDarkMode
                                          ? Colors.black
                                          : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        var success =
                                            await firebaseApi.signInWithApple();
                                        if (success) {
                                          firebaseApi.loading.value = false;
                                          GetStorage()
                                              .write("signMethod", "apple");
                                          widget.controller.jumpToPage(3);
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 9, 10),
                                        child: Image.asset(
                                          'assets/login/apple.png',
                                          color: context.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'Giriş yapın',
                    //   style: GoogleFonts.josefinSans(
                    //       fontSize: 30, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: 14,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: email,
                        cursorColor:
                            context.isDarkMode ? Colors.white : Colors.black,
                        cursorRadius: Radius.circular(10),
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        scrollPadding: EdgeInsets.zero,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'E-posta',
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
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: pass,
                                cursorColor: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                obscureText: !firebaseApi.loginPass.value,
                                cursorRadius: Radius.circular(10),
                                maxLines: 1,
                                scrollPadding: EdgeInsets.zero,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Şifre',
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
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                firebaseApi.loginPass.value =
                                    !firebaseApi.loginPass.value;
                              },
                              child: Icon(
                                firebaseApi.loginPass.value
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.grey[900],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Material(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            if (email.text.isEmpty) {
                              Get.snackbar('E-posta adresi yok',
                                  'Lütfen e-posta adresi girin');
                              return;
                            }
                            if (pass.text.isEmpty) {
                              Get.snackbar('Şifre yok', 'Lütfen şifre girin');
                              return;
                            }
                            firebaseApi.loginWithEmail(email.text, pass.text);
                            GetStorage().write("signMethod", "email");
                            GetStorage().write("email", email.text);
                            GetStorage().write("pass", pass.text);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                firebaseApi.loading.value
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Giriş yap',
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
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
                    GestureDetector(
                      onTap: () {
                        Get.to(ResetPass());
                      },
                      child: Text(
                        'Şifremi unuttum',
                        style: TextStyle(
                            fontSize: 15,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Material(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(15),
                    //   child: InkWell(
                    //     borderRadius: BorderRadius.circular(15),
                    //     onTap: () {},
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(15),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             'assets/login/google.png',
                    //             width: 30,
                    //             height: 30,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Text(
                    //             'Google ile giriş yap',
                    //             style: TextStyle(fontSize: 20),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Material(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(15),
                    //   child: InkWell(
                    //     borderRadius: BorderRadius.circular(15),
                    //     onTap: () {},
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(15),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             'assets/login/apple.png',
                    //             width: 30,
                    //             height: 30,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Text(
                    //             'Apple ile giriş yap',
                    //             style: TextStyle(
                    //                 fontSize: 20, color: Colors.black),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Material(
                    //   color: Colors.blue[700],
                    //   borderRadius: BorderRadius.circular(15),
                    //   child: InkWell(
                    //     borderRadius: BorderRadius.circular(15),
                    //     onTap: () {},
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(15),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             'assets/login/facebook.png',
                    //             width: 30,
                    //             height: 30,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Text(
                    //             'Facebook ile giriş yap',
                    //             style: TextStyle(
                    //                 fontSize: 20, color: Colors.white),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Material(
                    //   color: Colors.blueGrey,
                    //   borderRadius: BorderRadius.circular(15),
                    //   child: InkWell(
                    //     borderRadius: BorderRadius.circular(15),
                    //     onTap: () {
                    //       widget.controller.jumpToPage(1);
                    //     },
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(15),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             'assets/login/gmail.png',
                    //             width: 30,
                    //             height: 30,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Text(
                    //             'E-posta ile kaydol',
                    //             style: TextStyle(
                    //                 fontSize: 20, color: Colors.white),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hesabınız yok mu?',
                          style: TextStyle(
                              fontSize: 15,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              widget.controller.jumpToPage(1);
                            },
                            style: ButtonStyle(
                                splashFactory: NoSplash.splashFactory),
                            child: Text(
                              'Hesap oluştur',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
