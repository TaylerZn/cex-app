import 'package:get/get.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

class PublicGetx extends GetxController {
  static PublicGetx get to => Get.find();

  /// 初始化
  @override
  void onInit() {
    var instance = ObjectKV.public.get(
        (v) => PublicInfoMarket.fromJson(v as Map<String, dynamic>),
        defValue: PublicInfoMarket());
    // marketInfo = instance!;
    super.onInit();
  }

  void _save() {
    // ObjectKV.public.set(marketInfo);
  }

  void clean() async {
    _save();
    update();
  }

  /// 加载完成
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// 控制器被释放
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
