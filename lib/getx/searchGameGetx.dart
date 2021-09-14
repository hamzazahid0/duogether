import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchGameGetx extends GetxController {
  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> games =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> search =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  var ps = false.obs;
  var pc = false.obs;
  var mobile = false.obs;

  void getGames() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection('Games').get();
    games.value = data.docs;
    search.value = data.docs;
  }

  void searchGame(String query) {
    search.clear();
    games.forEach((element) {
      String name = element.data()['name'];
      if (name.contains(query) || name.isCaseInsensitiveContains(query)) {
        search.add(element);
      }
    });
  }
}
