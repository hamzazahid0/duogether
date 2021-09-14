import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamehub/screens/message.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';

class InfosGetx extends GetxController {
  var name = ''.obs;
  var age = 18.obs;
  var avatar = ''.obs;
  String pc_season = '';
  String ps_season = '';
  var avatarIsAsset = true.obs;
  var twoLevelAvatar = false.obs;
  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> social =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  List<String> words = [''];

  @override
  void onInit() {
    updateWords();
    // getPubgSeasons();
    super.onInit();
  }

  // void getPubgSeasons() {
  //   firebaseApi.firestore
  //       .collection('Apis')
  //       .where('name', isEqualTo: 'PUBG')
  //       .get()
  //       .then((value) {
  //     pc_season = value.docs.first.data()['pc_season'];
  //     ps_season = value.docs.first.data()['ps_season'];
  //   });
  // }

  void updateWords() {
    words.clear();
    List<String> temp = Utils.words.toList();
    int r1 = Random().nextInt(temp.length - 1);
    words.add(temp[r1]);
    temp.removeAt(r1);
    int r2 = Random().nextInt(temp.length - 1);
    words.add(temp[r2]);
    temp.removeAt(r2);
    int r3 = Random().nextInt(temp.length - 1);
    words.add(temp[r3]);
    temp.removeAt(r3);
  }

  void addInfos(String name, String avatar, int age, bool avatarIsAsset) async {
    this.name.value = name;
    this.age.value = age;
    this.avatar.value = avatar;
    this.avatarIsAsset.value = avatarIsAsset;

    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      twoLevelAvatar.value = value.data()!['twoLevelAvatar'];
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Social')
        .snapshots()
        .listen((event) {
      social.value.clear();
      event.docs.forEach((element) {
        social.value.add(element);
      });
    });
    update();
  }
}
