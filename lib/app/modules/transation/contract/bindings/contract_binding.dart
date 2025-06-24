import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_depth_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_operate_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_entrust/controllers/contract_entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_postion/controllers/contract_position_controller.dart';

import '../controllers/contract_bottom_kchart_controller.dart';
import '../controllers/contract_controller.dart';

class ContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ContractOperateController(), permanent: true);
    Get.put(ContractDepthController(), permanent: true);
    Get.put(ContractPositionController(), permanent: true);
    Get.put(ContractEntrustController(), permanent: true);
    Get.put(ContractController(), permanent: true);
    Get.put(ContractBottomKChartController(), permanent: true);
  }
}
