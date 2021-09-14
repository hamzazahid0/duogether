import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageGetX extends GetxController {
  var socialExpanded = false.obs;
  var gifExpanded = false.obs;
  var photoExpanded = false.obs;
  var wordsExpanded = false.obs;
  TextEditingController message = TextEditingController();
  TextEditingController gif = TextEditingController();
  var selected = 0.obs;

  var search = 'games'.obs;
  var query = 'games'.obs;

  var imageAllowed = false.obs;

  void expandSocial(bool value) {
    socialExpanded.value = value;
  }

  void expandGif(bool value) {
    gifExpanded.value = value;
  }

  void expandPhoto(bool value) {
    photoExpanded.value = value;
  }

  void expandWords(bool value) {
    wordsExpanded.value = value;
  }
}
