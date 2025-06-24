import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commdity_kchar_controller.dart';

import '../../commodity_position/controllers/commodity_position_controller.dart';
import '../../commodiy_entrust/controllers/commondiy_entrust_controller.dart';
import '../controllers/commodity_controller.dart';

class CommodityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CommodityKChartController>(
      CommodityKChartController(),
      permanent: true,
    );
    Get.put<CommodityController>(
      CommodityController(),
      permanent: true,
    );
    Get.put<CommodityEntrustController>(
      CommodityEntrustController(),
      permanent: true,
    );
    Get.put<CommodityPositionController>(
      CommodityPositionController(),
      permanent: true,
    );
  }
}
