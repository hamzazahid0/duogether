import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/screens/terms.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterEmail extends StatefulWidget {
  final PageController controller;

  const RegisterEmail({Key? key, required this.controller}) : super(key: key);
  @override
  _RegisterEmailState createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  TextEditingController email = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  FirebaseApi firebaseApi = Get.find();

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
    return Obx(
      () => Container(
        color: context.isDarkMode ? Colors.black : Colors.white,
        child: IgnorePointer(
          ignoring: firebaseApi.loading.value,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: context.isDarkMode ? Colors.black : Colors.white,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40, right: 80, left: 80),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                                width: 85,
                                height: 85,
                                child: Image.asset('assets/orta.png')),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Duogether'a\nhoş geldin",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 27, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Hesap oluşturarak ',
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
                                ]))
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: TextField(
                                controller: email,
                                cursorColor: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: TextField(
                                controller: pass1,
                                cursorColor: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                obscureText: !firebaseApi.registerPass.value,
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Obx(
                                () => Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: pass2,
                                        cursorColor: context.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        obscureText:
                                            !firebaseApi.registerPass.value,
                                        cursorRadius: Radius.circular(10),
                                        maxLines: 1,
                                        scrollPadding: EdgeInsets.zero,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            hintText: 'Şifre tekrar',
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: context.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                    width: 2)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: context.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                    width: 2))),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        firebaseApi.registerPass.value =
                                            !firebaseApi.registerPass.value;
                                      },
                                      child: Icon(
                                        firebaseApi.registerPass.value
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Material(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(15),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () async {
                                    firebaseApi.loading.value = true;
                                    if (!email.text.isEmail) {
                                      Get.snackbar(
                                          'E-posta adresi geçerli değil',
                                          'Lütfen e-posta adresini doğru giriniz');
                                      firebaseApi.loading.value = false;
                                      return;
                                    }
                                    bool success =
                                        await firebaseApi.registerWithEmail(
                                            email.text, pass1.text, pass2.text);
                                    if (success) {
                                      firebaseApi.loading.value = false;
                                      GetStorage().write("email", email.text);
                                      GetStorage().write("pass", pass1.text);
                                      GetStorage().write("signMethod", "email");
                                      widget.controller.jumpToPage(3);
                                    } else {
                                      firebaseApi.loading.value = false;
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        firebaseApi.loading.value
                                            ? CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text(
                                                'Kaydol',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20,
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
                              height: 5,
                            ),
                            TextButton(
                                onPressed: () {
                                  widget.controller.jumpToPage(0);
                                },
                                style: ButtonStyle(
                                    splashFactory: NoSplash.splashFactory),
                                child: Text(
                                  'Geri',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
