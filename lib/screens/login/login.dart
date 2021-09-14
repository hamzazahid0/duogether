import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:get/get.dart';

class LoginEmail extends StatefulWidget {
  final PageController controller;

  const LoginEmail({Key? key, required this.controller}) : super(key: key);
  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  FirebaseApi firebaseApi = Get.find();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: Colors.grey[200],
        child: IgnorePointer(
          ignoring: firebaseApi.loading.value,
          child: Padding(
            padding: const EdgeInsets.only(top: 80, left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Image.asset('assets/login/gmail.png'),
                ),
                SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: email,
                          cursorColor: Colors.black,
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
                                      color: Colors.black, width: 2)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2))),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: pass,
                          cursorColor: Colors.black,
                          obscureText: true,
                          cursorRadius: Radius.circular(10),
                          maxLines: 1,
                          scrollPadding: EdgeInsets.zero,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Şifre',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2))),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Material(
                          color: Colors.blueGrey,
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
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  firebaseApi.loading.value
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Giriş yap',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              widget.controller.jumpToPage(0);
                            },
                            style: ButtonStyle(
                                splashFactory: NoSplash.splashFactory),
                            child: Text(
                              'Geri',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
