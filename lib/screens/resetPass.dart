import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: context.isDarkMode ? Colors.white : Colors.black,
            )),
      ),
      body: SafeArea(
          child: Container(
        decoration:
            BoxDecoration(color: context.isDarkMode ? Colors.black : Colors.white),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: context.isDarkMode ? Colors.black : Colors.white,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 100, left: 100),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/orta.png'),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Şifreni sıfırla",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'E-posta adresinize şifre sıfırlama kodu gönderin',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                      //   child: Image.asset('assets/orta.png'),
                      // ),
                      // Text(
                      //   "DuoGether'e\nhoşgeldin",
                      //   textAlign: TextAlign.center,
                      //   style: GoogleFonts.josefinSans(
                      //       fontSize: 32, fontWeight: FontWeight.bold),
                      // ),
                      Column(
                        children: [
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
                          TextField(
                            cursorColor:
                                context.isDarkMode ? Colors.white : Colors.black,
                            cursorRadius: Radius.circular(10),
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            controller: email,
                            scrollPadding: EdgeInsets.zero,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: 'E-posta adresiniz',
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
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () async {
                                if (email.text.isEmail) {
                                  try {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: email.text);
                                            Get.snackbar('Şifre sıfırlama linki gönderildi', 'Lütfen e-posta adresinizi kontrol edin');
                                  } catch (e) {
                                    if(e.toString().isCaseInsensitiveContainsAny(Utils.nouser)){
                                      Get.snackbar('Hata', 'Kullanıcı mövcut değil');
                                    } else if(e.toString().isCaseInsensitiveContainsAny(Utils.blocked)){
                                      Get.snackbar('Hata', 'Daha sonra tekrar deneyin');
                                    }
                                    
                                  }
                                }else{
                                  Get.snackbar('E-posta geçerli değil', 'Lütfen doğru e-posta adresi girin');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Gönder',
                                      style: GoogleFonts.roboto(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
