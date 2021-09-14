import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CardsGetx extends GetxController {
  var limit = 10.obs;
  var ended = false.obs;
  var noSize = 30.0.obs;
  var yesSize = 30.0.obs;
  var more = false.obs;

   var adLoaded = false.obs;
   late BannerAd ad;
   

    void loadAd(){
       ad = BannerAd(size: AdSize(width: (Get.size.width*0.78).toInt(), height: (Get.size.height*0.6).toInt()), adUnitId: Utils.banner_id, listener: BannerAdListener(onAdLoaded: (ads){
      adLoaded.value = true;
    }), request: AdRequest());
    ad.load();
    }

  void pair() {
    yesSize.value = 34.0;
    Future.delayed(Duration(milliseconds: 300), () {
      yesSize.value = 30.0;
    });
  }

  void no() {
    noSize.value = 34.0;
    Future.delayed(Duration(milliseconds: 300), () {
      noSize.value = 30.0;
    });
  }
}
