import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gamehub/getx/filterGetx.dart';
import 'package:gamehub/screens/noInternet.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/cardsGetx.dart';
import 'package:gamehub/getx/editProfileGetx.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/getx/mainGetx.dart';
import 'package:gamehub/getx/searchGameGetx.dart';
import 'package:gamehub/screens/finish.dart';
import 'package:gamehub/screens/login.dart';
import 'package:gamehub/screens/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var connectivityResult = await (Connectivity().checkConnectivity());
  bool internet = connectivityResult != ConnectivityResult.none;
  bool first = false;
  Get.put(InfosGetx(), permanent: true);
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(Utils.channel);
  if (internet) {
    await MobileAds.instance.initialize();
    await GetStorage.init();
    await Firebase.initializeApp();
    await refreshUser();
    bool available = await SignInWithApple.isAvailable() && Platform.isIOS;
    if (GetStorage().hasData('first')) {
      first = GetStorage().read('first');
    } else {
      first = true;
      GetStorage().write('first', false);
    }
    Get.put(MainGetX(), permanent: true);
    Get.put(FirebaseApi(available), permanent: true);
    Get.put(CardsGetx(), permanent: true);
    Get.put(SearchGameGetx(), permanent: true);
    Get.put(FilterGetx(), permanent: true);
    Get.put(EditProfileGetx(), permanent: true);
  }

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    builder: (context, child) {
      return MediaQuery(
        child: child!,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      );
    },
    darkTheme: ThemeData.dark(),
    home: Home(
      internet: internet,
      first: first,
    ),
  ));
}

Future<void> refreshUser() async {
  if (FirebaseAuth.instance.currentUser != null) {
    try {
      await FirebaseAuth.instance.currentUser!.reload();
    } catch (e) {
      print(e.toString());
    }
  }
}

class Home extends StatelessWidget {
  final bool internet;
  final bool first;
  final InfosGetx infosGetx = Get.find();

  Home({Key? key, required this.internet, required this.first})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return internet
        ? FirebaseAuth.instance.currentUser == null
            ? first
                ? Splash()
                : Login()
            : FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? !snapshot.data!.exists
                          ? Login()
                          : snapshot.data!.data()!['finished']
                              ? Builder(
                                  builder: (context) {
                                    infosGetx.addInfos(
                                        snapshot.data!.data()!['name'],
                                        snapshot.data!.data()!['avatar'],
                                        snapshot.data!.data()!['age'],
                                        snapshot.data!
                                            .data()!['avatarIsAsset']);
                                    return Main(first: false);
                                  },
                                )
                              : FinishAfter()
                      : Scaffold(
                          backgroundColor:
                              context.isDarkMode ? Colors.black : Colors.white,
                          body: Center(
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child:
                                  Lottie.asset('assets/animation/loading.json'),
                            ),
                            // child: Text(
                            //   'Yükleniyor...',
                            //   style: GoogleFonts.acme(
                            //       fontSize: 30, color: Colors.white),
                            // ),
                          ),
                        );
                },
              )
        : NoInternet();
  }
}
