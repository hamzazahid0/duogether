import 'package:get/get.dart';

class MainGetX extends GetxController {
  var navBarIndex = 0.obs;
  var pageIndex = 0.obs;
  var themeSelected = false.obs;

  changeNavBar(int index) {
    navBarIndex.value = index;
  }
}
