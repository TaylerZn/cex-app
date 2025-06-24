import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_bottom_kchart_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_operate_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_entrust/controllers/contract_entrust_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';

import '../../contract_postion/controllers/contract_position_controller.dart';
import 'contract_depth_controller.dart';

class ContractController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ContractController get to => Get.find();

  /// 当前合约信息
  Rxn<ContractInfo> currentContractInfo = Rxn<ContractInfo>();
  late TabController tabController;
  late ScrollController scrollController;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    scrollController = ScrollController();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  changeContractInfo(ContractInfo info) async {
    currentContractInfo.value = info;

    ContractDepthController.to.changeContract(info);
    ContractPositionController.to.changeContractInfo(info);
    ContractEntrustController.to.changeContractInfo(info);
    ContractOperateController.to.changeContractInfo(info);
    ContractBottomKChartController.to.changeContractInfo(info);
  }

  @override
  void onClose() {
    tabController.dispose();
    scrollController.dispose();
    Bus.getInstance().off(EventType.login, (data) {});
    super.onClose();
  }

  void showGuideView() {
    if (UserGetx.to.isLogin) {
      Intro.of(Get.context!)
          .start(group: AppGuideType.perpetualContract.name, reset: false);
    }
  }

  Future refreshData() async {
    try {
      List<Future> futures = [
        ContractDepthController.to.fetchFoundRateTimer(),
        ContractPositionController.to.fetchPosition(),
        ContractEntrustController.to.fetchEntrust(),
        ContractOperateController.to.fetchCurrentContractUserConfig(),
      ];
      bool contractListIsEmpty =
          ContractDataStoreController.to.contractList.isEmpty;
      if (contractListIsEmpty) {
        futures.add(ContractDataStoreController.to.fetchPublicInfo());
      }
      await Future.wait(futures);

      /// 如果之前没有合约信息，设置第一个合约
      setFirstContract();
    } on Exception catch (e) {
      AppLogUtil.e(e.toString());
    }
  }

  Future<void> checkContractListIfEmptyLoadData() async {
    if (ContractDataStoreController.to.contractList.isEmpty) {
      await ContractDataStoreController.to.fetchPublicInfo();
    }
    setFirstContract();
  }

  void setFirstContract() {
    if (currentContractInfo.value == null) {
      ContractInfo? contractInfo =
          ContractDataStoreController.to.getContractInfoByContractId(1);
      if (contractInfo != null) {
        changeContractInfo(contractInfo);
      }
    }
  }
}
