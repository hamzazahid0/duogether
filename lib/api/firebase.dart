import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gamehub/getx/cardsGetx.dart';
import 'package:gamehub/getx/editProfileGetx.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/getx/mainGetx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:gamehub/getx/searchGameGetx.dart';
import 'package:crypto/crypto.dart';
import 'package:gamehub/screens/login.dart';
import 'package:gamehub/screens/main.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart' as fb;

class FirebaseApi extends GetxController {
  bool apple = false;

  FirebaseApi(bool apple) {
    this.apple = apple;
  }

  var loginPass = false.obs;
  var registerPass = false.obs;

  var showChart = false.obs;

  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  var storage = FirebaseStorage.instance;
  var avatar = 'assets/user.png'.obs;
  var avatarIsAsset = true.obs;
  var avatarFile = File('').obs;
  var country = 'Ülke'.obs;
  var name = ''.obs;
  var countrySelected = false.obs;
  var twoLevelAvatar = false.obs;
  var city = 'Şehir'.obs;
  var sex = 'null'.obs;
  var date = 'Tarih seçin'.obs;
  // var date =
  //     '${DateTime(DateTime.now().year - 16, DateTime.now().month, DateTime.now().day).toString()}'
  //         .obs;
  DateTime dateTime = DateTime.now();
  int age = 16;
  int exp = 0;
  int level = 1;
  var pc = false.obs;
  var ps = false.obs;
  var mobile = false.obs;
  var toQuestions = false.obs;
  var toQuestions2 = false.obs;
  var headpressed = false.obs;
  var headphone = true.obs;
  var loading = false.obs;
  String pairId = '';

  //
  //Questions
  var sosyal = false.obs;
  var utangac = false.obs;
  var neseli = false.obs;
  var merakli = false.obs;
  var duygusal = false.obs;
  var kuralci = false.obs;
  var fevri = false.obs;
  var hirsli = false.obs;
  var karamsar = false.obs;
  var selectedQuestion = 0.obs;
  //
  var q1 = 0.obs;
  var q2 = 0.obs;
  var q3 = 0.obs;
  //
  //
  bool first = true;
  bool tens = true;
  //
  //Time
  //
  var startHour = 00.obs;
  var startMinute = 00.obs;
  var endHour = 00.obs;
  var endMinute = 00.obs;
  //
  // Games

  void chechToQuestion() {
    if (false
        // name.value.trim().isEmpty || country.value == 'Ülke' || city.value == 'Şehir'
        ) {
      toQuestions.value = false;
    } else {
      if (false
          // !pc.value && !ps.value && !mobile.value
          ) {
        toQuestions.value = false;
      } else {
        if (name.value.trim().trim().length < 3 ||
            name.value.trim().trim().length > 12) {
          toQuestions.value = false;
        } else if (date.value == 'Tarih seçin') {
          toQuestions.value = false;
        } else if (sex.value == 'null') {
          toQuestions.value = false;
        } else {
          toQuestions.value = true;
        }
      }
    }
  }

  void chechToQuestion2() {
    if (name.value.trim().isEmpty ||
        country.value == 'Ülke' ||
        city.value == 'Şehir') {
      toQuestions2.value = false;
    } else {
      if (!pc.value && !ps.value && !mobile.value) {
        toQuestions2.value = false;
      } else {
        if (name.value.trim().length < 3 || name.value.trim().length > 12) {
          toQuestions2.value = false;
        } else {
          if (startHour.value == 00 &&
              startMinute.value == 00 &&
              endHour.value == 00 &&
              endMinute.value == 00) {
            toQuestions2.value = false;
          } else {
            toQuestions2.value = headpressed.value;
          }
        }
      }
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCountries() async {
    return await firestore.collection('Countries').orderBy('name').get();
  }

  Future<void> getAddedGames(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    // games.clear();
  }

  Future<List<String>> getCities(String country) async {
    List<String> cities = [];
    var ids = await firestore
        .collection('Countries')
        .where('name', isEqualTo: country)
        .get();

    String id = ids.docs.first.id;

    var city = await firestore
        .collection('Countries')
        .doc(id)
        .collection('Cities')
        .orderBy('name')
        .get();

    city.docs.forEach((element) {
      print(element.id);
      cities.add(element.data()['name']);
    });

    return cities;
  }

  Future<void> finishRegister() async {
    final InfosGetx infosGetx = Get.find();
    if (exp > 820) {
      level = 7;
    } else if (exp > 550) {
      level = 6;
    } else if (exp > 360) {
      level = 5;
    } else if (exp > 230) {
      level = 4;
    } else if (exp > 140) {
      level = 3;
    } else if (exp > 70) {
      level = 2;
    } else if (exp > 0) {
      level = 1;
    }

    if (!avatarIsAsset.value) {
      var task = storage
          .ref()
          .child('avatars/${Uuid().v1()}')
          .putFile(avatarFile.value);

      task.then((v) async {
        String link = await v.ref.getDownloadURL();
        try {
          await firestore
              .collection('Users')
              .doc(auth.currentUser!.uid)
              .update({
            'finished': true,
            'questionAdded': true,
            'cover': 1,
            'twoLevelAvatar': twoLevelAvatar.value,
            'avatarIsAsset': false,
            'daysInRow': 1,
            'maxDays': 1,
            'hasBack': false,
            'back': 'assets/back/arka-plan-1.jpg',
            'n_newPair': true,
            'n_message': true,
            'n_photos': true,
            'showInPopular': true,
            'showLocation': true,
            'headphone': headphone.value,
            'limit': 30,
            'level': level,
            'exp': exp,
            'avatar': link,
            'name': name.value.trim(),
            'sex': sex.value,
            'bio': 'Merhaba ben yeni DouGether kullanıcısıyım',
            'country': country.value,
            'age': age,
            'city': city.value,
            'pc': pc.value,
            'ps': ps.value,
            'mobile': mobile.value,
            'startHour': startHour.value,
            'startMinute': startMinute.value,
            'endHour': endHour.value,
            'endMinute': endMinute.value,
          });
          await firestore
              .collection('Users')
              .doc(auth.currentUser!.uid)
              .collection('Questions')
              .add({
            'questionAdded': true,
            'sosyal': sosyal.value,
            'utangac': utangac.value,
            'neseli': neseli.value,
            'merakli': merakli.value,
            'duygusal': duygusal.value,
            'kuralci': kuralci.value,
            'fevri': fevri.value,
            'hirsli': hirsli.value,
            'karamsar': karamsar.value,
            'q1': q1.value,
            'q2': q2.value,
            'q3': q3.value,
          });
          infosGetx.addInfos(
              name.value.trim(), avatar.value, age, avatarIsAsset.value);
          Get.offAll(() => Main(first: true));
        } catch (e) {
          Get.snackbar('Hata', e.toString());
        }
      });
    } else {
      try {
        await firestore.collection('Users').doc(auth.currentUser!.uid).update({
          'finished': true,
          'avatarIsAsset': true,
          'questionAdded': true,
          'hasBack': false,
          'twoLevelAvatar': twoLevelAvatar.value,
          'back': 'assets/back/arka-plan-1.jpg',
          'n_newPair': true,
          'n_message': true,
          'cover': 1,
          'daysInRow': 1,
          'n_photos': true,
          'maxDays': 1,
          'headphone': headphone.value,
          'showInPopular': true,
          'limit': 30,
          'showLocation': true,
          'avatar': avatar.value,
          'name': name.value.trim(),
          'level': level,
          'exp': exp,
          'sex': sex.value,
          'bio': 'Merhaba ben yeni DouGether kullanıcısıyım',
          'country': country.value,
          'age': age,
          'city': city.value,
          'pc': pc.value,
          'ps': ps.value,
          'mobile': mobile.value,
          'startHour': startHour.value,
          'startMinute': startMinute.value,
          'endHour': endHour.value,
          'endMinute': endMinute.value,
        });
        await firestore
            .collection('Users')
            .doc(auth.currentUser!.uid)
            .collection('Questions')
            .add({
          'questionAdded': true,
          'sosyal': sosyal.value,
          'utangac': utangac.value,
          'neseli': neseli.value,
          'merakli': merakli.value,
          'duygusal': duygusal.value,
          'kuralci': kuralci.value,
          'fevri': fevri.value,
          'hirsli': hirsli.value,
          'karamsar': karamsar.value,
          'q1': q1.value,
          'q2': q2.value,
          'q3': q3.value,
        });
        infosGetx.addInfos(
            name.value.trim(), avatar.value, age, avatarIsAsset.value);
        Get.offAll(() => Main(
              first: true,
            ));
      } catch (e) {
        Get.snackbar('Hata', e.toString());
      }
    }
  }

  Future<void> finishRegisterWithSkip() async {
    final InfosGetx infosGetx = Get.find();
    if (exp > 820) {
      level = 7;
    } else if (exp > 550) {
      level = 6;
    } else if (exp > 360) {
      level = 5;
    } else if (exp > 230) {
      level = 4;
    } else if (exp > 140) {
      level = 3;
    } else if (exp > 70) {
      level = 2;
    } else if (exp > 0) {
      level = 1;
    }

    if (!avatarIsAsset.value) {
      var task = storage
          .ref()
          .child('avatars/${Uuid().v1()}')
          .putFile(avatarFile.value);

      task.then((v) async {
        String link = await v.ref.getDownloadURL();
        try {
          await firestore
              .collection('Users')
              .doc(auth.currentUser!.uid)
              .update({
            'finished': true,
            'avatarIsAsset': false,
            'hasBack': false,
            'cover': 1,
            'twoLevelAvatar': twoLevelAvatar.value,
            'back': 'assets/back/arka-plan-1.jpg',
            'n_newPair': true,
            'n_photos': true,
            'n_message': true,
            'avatar': link,
            'headphone': headphone.value,
            'daysInRow': 1,
            'limit': 30,
            'showInPopular': true,
            'showLocation': true,
            'maxDays': 1,
            'name': name.value.trim(),
            'sex': sex.value,
            'bio': 'Merhaba ben yeni DouGether kullanıcısıyım',
            'country': country.value,
            'age': age,
            'city': city.value,
            'level': level,
            'exp': exp,
            'pc': pc.value,
            'ps': ps.value,
            'mobile': mobile.value,
            'startHour': startHour.value,
            'startMinute': startMinute.value,
            'endHour': endHour.value,
            'endMinute': endMinute.value,
          });
          await firestore
              .collection('Users')
              .doc(auth.currentUser!.uid)
              .collection('Questions')
              .add({
            'questionAdded': false,
          });
          infosGetx.addInfos(
              name.value.trim(), avatar.value, age, avatarIsAsset.value);
          Get.offAll(() => Main(first: true));
        } catch (e) {
          Get.snackbar('Hata', e.toString());
        }
      });
    } else {
      try {
        await firestore.collection('Users').doc(auth.currentUser!.uid).update({
          'finished': true,
          'avatarIsAsset': true,
          'hasBack': false,
          'daysInRow': 1,
          'maxDays': 1,
          'back': 'assets/back/arka-plan-1.jpg',
          'avatar': avatar.value,
          'twoLevelAvatar': twoLevelAvatar.value,
          'n_newPair': true,
          'n_message': true,
          'n_photos': true,
          'name': name.value.trim(),
          'cover': 1,
          'headphone': headphone.value,
          'sex': sex.value,
          'country': country.value,
          'limit': 30,
          'showLocation': true,
          'showInPopular': true,
          'age': age,
          'bio': 'Merhaba ben yeni DouGether kullanıcısıyım',
          'city': city.value,
          'pc': pc.value,
          'level': level,
          'exp': exp,
          'ps': ps.value,
          'mobile': mobile.value,
          'startHour': startHour.value,
          'startMinute': startMinute.value,
          'endHour': endHour.value,
          'endMinute': endMinute.value,
        });
        await firestore
            .collection('Users')
            .doc(auth.currentUser!.uid)
            .collection('Questions')
            .add({
          'questionAdded': false,
        });
        infosGetx.addInfos(
            name.value.trim(), avatar.value, age, avatarIsAsset.value);
        Get.offAll(() => Main(first: true));
      } catch (e) {
        Get.snackbar('Hata', e.toString());
      }
    }
  }

  Future<bool> registerWithEmail(
      String email, String pass1, String pass2) async {
    if (!email.isEmail) {
      Get.snackbar('E-posta geçerli değil', 'Lütfen geçerli e-posta girin');
      return false;
    }
    if (pass1 != pass2) {
      Get.snackbar('Şifreler uyuşmuyor!', 'Doğrulama şifreni kontrol et');
      return false;
    }
    if (pass1.length < 6) {
      Get.snackbar('Şifre 6 karakterden uzun olmalı',
          '6 karakterden uzun şifre giriniz');
      return false;
    }

    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass1);

      await firestore.collection('Users').doc(user.user!.uid).set({
        'finished': false,
        'email': user.user!.email,
        'verified': false,
        'id': user.user!.uid,
        'avatarIsAsset': true,
        'ids': [''],
        'avatar': avatar.value,
      });
      return true;
    } catch (e) {
      if (e.toString() == Utils.alreadyHave) {
        Get.snackbar('Kullanıcı zaten mevcut',
            'Giriş yapın veya başka bir e-posta adresi girin');
      } else {
        Get.snackbar('Hata', e.toString());
      }

      return false;
    }
  }

  Future<void> loginWithEmail(String email, String pass) async {
    final InfosGetx infosGetx = Get.find();
    loading.value = true;
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) async {
        DocumentSnapshot<Map<String, dynamic>> user = await firestore
            .collection('Users')
            .doc(auth.currentUser!.uid)
            .get();
        infosGetx.addInfos(user.data()!['name'], user.data()!['avatar'],
            user.data()!['age'], user.data()!['avatarIsAsset']);
        loading.value = false;
        Get.offAll(() => Main(first: false));
      });
    } catch (e) {
      if (e.toString() == Utils.noSuchUser) {
        Get.snackbar('Kullanıcı bulunamadı', 'E-posta veya şifre yanlış');
        loading.value = false;
      } else {
        Get.snackbar('Hata', e.toString());
        loading.value = false;
      }
    }
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> signInWithApple() async {
    final InfosGetx infosGetx = Get.find();
    loading.value = true;
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    try {
      var user =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      var data = await firestore.collection('Users').doc(user.user!.uid).get();

      if (data.exists) {
        infosGetx.addInfos(data.data()!['name'], data.data()!['avatar'],
            data.data()!['age'], data.data()!['avatarIsAsset']);
        loading.value = false;
        Get.offAll(() => Main(first: false));
        return false;
      } else {
        await firestore.collection('Users').doc(user.user!.uid).set({
          'finished': false,
          'email': user.user!.email,
          'id': user.user!.uid,
          'avatarIsAsset': true,
          'verified': true,
          'ids': [''],
          'avatar': avatar.value,
        });
        return true;
      }
    } catch (e) {
      return false;
    }

    // return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future<bool> signInWithFacebook() async {
    final InfosGetx infosGetx = Get.find();
    loading.value = true;
    var result = await FacebookAuth.instance.login();
    final facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    try {
      var user = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      var data = await firestore.collection('Users').doc(user.user!.uid).get();

      if (data.exists) {
        infosGetx.addInfos(data.data()!['name'], data.data()!['avatar'],
            data.data()!['age'], data.data()!['avatarIsAsset']);
        loading.value = false;
        Get.offAll(() => Main(first: false));
        return false;
      } else {
        await firestore.collection('Users').doc(user.user!.uid).set({
          'finished': false,
          'email': user.user!.email,
          'id': user.user!.uid,
          'verified': true,
          'avatarIsAsset': true,
          'ids': [''],
          'avatar': avatar.value,
        });
        return true;
      }
    } catch (e) {
      return false;
    }

    // return await FirebaseAuth.instance
    //     .signInWithCredential(facebookAuthCredential);
  }

  // Future<User?> facebookLogin() async {
  //   User? user;
  //   fb.FacebookLoginResult result = await fb.FacebookLogin().logIn(
  //       permissions: [
  //         fb.FacebookPermission.email,
  //         fb.FacebookPermission.publicProfile
  //       ]);
  //   switch (result.status) {
  //     case fb.FacebookLoginStatus.success:
  //       fb.FacebookAccessToken token = result.accessToken!;
  //       AuthCredential authCredential =
  //           FacebookAuthProvider.credential(token.token);
  //       var userCredential =
  //           await FirebaseAuth.instance.signInWithCredential(authCredential);
  //       user = userCredential.user!;
  //       print('tamam');
  //       break;
  //     case fb.FacebookLoginStatus.cancel:
  //       print('canceled');
  //       break;
  //     case fb.FacebookLoginStatus.error:
  //       print('error');
  //       break;
  //   }
  //   return user;
  // }

  Future<bool> signInWithGoogle() async {
    final InfosGetx infosGetx = Get.find();
    loading.value = true;
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (e) {
      print('hahahahahahahah');
      print(e.toString());
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      var user = await FirebaseAuth.instance.signInWithCredential(credential);

      var data = await firestore.collection('Users').doc(user.user!.uid).get();

      if (data.exists) {
        infosGetx.addInfos(data.data()!['name'], data.data()!['avatar'],
            data.data()!['age'], data.data()!['avatarIsAsset']);
        loading.value = false;
        Get.offAll(() => Main(first: false));
        return false;
      } else {
        await firestore.collection('Users').doc(user.user!.uid).set({
          'finished': false,
          'email': user.user!.email,
          'id': user.user!.uid,
          'verified': true,
          'avatarIsAsset': true,
          'ids': [''],
          'avatar': avatar.value,
        });
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await auth.signOut().then((value) async {
      Get.delete<MainGetX>(force: true);
      Get.delete<FirebaseApi>(force: true);
      Get.delete<CardsGetx>(force: true);
      Get.delete<SearchGameGetx>(force: true);
      Get.delete<InfosGetx>(force: true);
      Get.delete<EditProfileGetx>(force: true);

      // bool available = await SignInWithApple.isAvailable();
      bool available = await SignInWithApple.isAvailable() && Platform.isIOS;

      Get.put(MainGetX(), permanent: true);
      Get.put(FirebaseApi(available), permanent: true);
      Get.put(CardsGetx(), permanent: true);
      Get.put(SearchGameGetx(), permanent: true);
      Get.put(InfosGetx(), permanent: true);
      Get.put(EditProfileGetx(), permanent: true);
      Get.offAll(() => Login());
    });
  }
}
