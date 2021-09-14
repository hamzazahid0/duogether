import 'package:get/get.dart';

class EditProfileGetx extends GetxService {
  var name = 'name'.obs;
  var loading = false.obs;
  var bio = 'bio'.obs;

  void resetName() {
    name.value = 'name';
  }
}
