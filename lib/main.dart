import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/cardsGetx.dart';
import 'package:gamehub/getx/editProfileGetx.dart';
import 'package:gamehub/getx/filterGetx.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/getx/mainGetx.dart';
import 'package:gamehub/getx/searchGameGetx.dart';
import 'package:gamehub/screens/finish.dart';
import 'package:gamehub/screens/login.dart';
import 'package:gamehub/screens/main.dart';
import 'package:gamehub/screens/message.dart';
import 'package:gamehub/screens/noInternet.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:launch_review/launch_review.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info/package_info.dart';
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
    theme: GetStorage().read("isDark") ?? false
        ? ThemeData.dark()
        : ThemeData.light(),
    onInit: () async {
      FilterGetx filterGetX = Get.find();
      CardsGetx cardsGetx = Get.find();
      firebaseApi.getAppVersions(cardsGetx).then((value) {
        versionControl(cardsGetx);
      });
      firebaseApi.rewardedInit(cardsGetx);
    },
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

void uploadAvatars(BuildContext context) {
  for (int i = 0; i < Utils.avatars.length; i++) {
    precacheImage(AssetImage('assets/avatars/${Utils.avatars[i]}'), context);
  }
  for (int i = 0; i < Utils.avatars2.length; i++) {
    precacheImage(AssetImage('assets/avatars/${Utils.avatars2[i]}'), context);
  }
  for (int i = 0; i < Utils.avatars3.length; i++) {
    precacheImage(AssetImage('assets/avatars/${Utils.avatars3[i]}'), context);
  }
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

void versionControl(CardsGetx cardsGetx) {
  PackageInfo.fromPlatform().then((appInfo) {
    cardsGetx.setAppInfo(appInfo);
    if (!cardsGetx.versionControl) {
      firebaseApi.getAppVersions(cardsGetx).then((value) {
        if (Platform.isAndroid) {
          if ((int.parse(cardsGetx.anroidVersion) >
                  int.parse(appInfo.buildNumber)) &&
              !cardsGetx.versionControl) {
            Future.delayed(Duration.zero, () {
              cardsGetx.setVersionControl(true);
            });

            Get.defaultDialog(
              barrierDismissible: false,
              onWillPop: () async => false,
              backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
              confirm: MaterialButton(
                color: Color(0xff41EC8C),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  LaunchReview.launch(
                      androidAppId: "com.cheavbella.duogether",
                      iOSAppId: "585027354");
                },
                child: Text(
                  "Uygulamayı Güncelle",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              title: "Sürüm Güncellemesi",
              titleStyle: GoogleFonts.roboto(
                fontSize: 20,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              middleTextStyle: GoogleFonts.roboto(
                fontSize: 16,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              middleText:
                  "Uygulamanın son özelliklerine erişebilmek için uygulamayı güncelleyiniz.",
            );
            /*   Get.dialog(
              SizedBox(
                width: 200,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Uygulamamız yeni bir sürümü mevcut."),
                    ),
                    MaterialButton(
                      onPressed: () {
                        LaunchReview.launch(
                            androidAppId: "com.cheavbella.duogether",
                            iOSAppId: "585027354");
                      },
                      child: Text("Hemen indir"),
                    )
                  ],
                ),
              ),
              barrierDismissible: false,
              name: "name",
              useSafeArea: true,
            );
         */
          }
          Future.delayed(Duration.zero, () {
            cardsGetx.setVersionControl(true);
          });
        } else if (Platform.isIOS) {
          if (int.parse(cardsGetx.iosVersion) >
                  int.parse(appInfo.buildNumber) &&
              !cardsGetx.versionControl) {
            Future.delayed(Duration.zero).then((value) {
              cardsGetx.setVersionControl(true);
            });
            Get.dialog(
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      child: Text("Uygulamamız yeni bir sürümü mevcut."),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Text("Hemen indir"),
                    )
                  ],
                ),
              ),
              barrierDismissible: false,
              name: "name",
              useSafeArea: true,
            );
          }
          Future.delayed(Duration.zero)
              .then((value) => cardsGetx.setVersionControl(true));
        }
      });
    }
  });
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
                              Get.isDarkMode ? Colors.black : Colors.white,
                          body: Center(
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child:
                                  Lottie.asset('assets/animation/loading.json'),
                            ),
                          ),
                        );
                },
              )
        : NoInternet();
  }
}
