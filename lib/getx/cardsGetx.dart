import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info/package_info.dart';

class CardsGetx extends GetxController {
  var limit = 20.obs;
  var ended = false.obs;
  var noSize = 30.0.obs;
  var yesSize = 30.0.obs;
  var more = true.obs;
  bool boughtExtraLimit = false;
  get getBoughtExtraLimit => this.boughtExtraLimit;

  set setBoughtExtraLimit(bool boughtExtraLimit) {
    this.boughtExtraLimit = boughtExtraLimit;
    update();
  }

  RewardedAd? _rewardedAd;
  RewardedAd? get rewardedAd => this._rewardedAd;

  set rewardedAd(RewardedAd? value) {
    this._rewardedAd = value;
    update();
  }

  decreaseLimit() {
    limit--;
    print(limit);
  }

  var adLoaded = false.obs;
  late BannerAd ad;

  void loadAd() {
    ad = BannerAd(
        size: AdSize(
            width: (Get.size.width * 0.78).toInt(),
            height: (Get.size.height * 0.6).toInt()),
        adUnitId: Utils.banner_id,
        listener: BannerAdListener(onAdLoaded: (ads) {
          adLoaded.value = true;
        }),
        request: AdRequest());
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

  //versiyon kontrolleri
  String _androidVersion = "";
  String _iosVersion = "";
  bool _versionControl = false;
  PackageInfo? _appInfo;

  void setAndroidVersion(String value) {
    _androidVersion = value;
    update();
  }

  void setAppInfo(PackageInfo info) {
    _appInfo = info;
    update();
  }

  void setIosVersion(String value) {
    _iosVersion = value;
    update();
  }

  void setVersionControl(bool value) {
    _versionControl = value;
    update();
  }

  PackageInfo? get appInfo => _appInfo;
  String get anroidVersion => _androidVersion;
  String get iosVersion => _iosVersion;
  bool get versionControl => _versionControl;
}
