import 'package:get/get.dart';

class AddStatsGetx extends GetxController {
  var game = 'Oyun seçin'.obs;
  var stage = 'Hevesli'.obs;
  var image = 'Oyun seçin'.obs;
  var red = 'Oyun seçin'.obs;
  var blue = 'Oyun seçin'.obs;
  var yellow = 'Oyun seçin'.obs;
  var green = 'Oyun seçin'.obs;
  var orange = 'Oyun seçin'.obs;
  var purple = 'Oyun seçin'.obs;
  var date = 'Tarih seçin'.obs;
  var dateTime = DateTime.now().obs;
  var dateSelected = false.obs;
  var r = 0.5.obs;
  var b = 0.5.obs;
  var g = 0.5.obs;
  var y = 0.5.obs;
  var p = 0.5.obs;
  var o = 0.5.obs;
  var hasLevels = false.obs;
  var hasStats = false.obs;
  var selected = false.obs;
  var exp = 1.0.obs;

  setStage() {
    if (exp.value < 0.7) {
      stage.value = 'Amatör';
    } else if (exp.value < 1.5) {
      stage.value = 'Hevesli';
    } else if (exp.value < 3.2) {
      stage.value = 'Deneyimli';
    } else if (exp.value < 4.33) {
      stage.value = 'Profesyonel';
    } else if (exp.value <= 5) {
      stage.value = 'Elit';
    }
  }
}
