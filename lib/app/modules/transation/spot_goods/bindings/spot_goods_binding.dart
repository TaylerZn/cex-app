import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/asset_list_controller.dart';
import '../controllers/spot_depth_controller.dart';
import '../controllers/spot_entrust_controller.dart';
import '../controllers/spot_goods_controller.dart';
import '../controllers/spot_goods_operate_controller.dart';

class SpotGoodsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SpotDepthController>(SpotDepthController(), permanent: true);
    Get.lazyPut<SpotGoodsOperateController>(() => SpotGoodsOperateController(), fenix: true);
    Get.lazyPut<AssetListController>(() => AssetListController(), fenix: true);
    Get.lazyPut<SpotEntrustController>(() => SpotEntrustController(), fenix: true);
    Get.lazyPut<SpotGoodsController>(() => SpotGoodsController(), fenix: true);
  }
}
