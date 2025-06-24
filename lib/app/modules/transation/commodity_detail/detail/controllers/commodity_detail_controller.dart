import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_open_time.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity_detail/price/controllers/commodity_price_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/contract_info/controllers/contract_info_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_commondity/views/swap_commodity_bottom_sheet.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../../api/commodity/commodity_api.dart';
import '../../../../../models/commodity/res/commodity_open_status.dart';
import '../../../../../models/contract/res/public_info.dart';
import '../../../../../utils/utilities/log_util.dart';
import '../../../../../widgets/components/transaction/share_kchart_detail_view.dart';

class CommodityDetailController extends GetxController {
  Rxn<ContractInfo> contractInfo = Rxn<ContractInfo>();
  Rxn<CommodityOpenStatus> openStatus = Rxn<CommodityOpenStatus>();
  Rxn<CommodityOpenTime> openTime = Rxn<CommodityOpenTime>();
  ScreenshotController shotController = ScreenshotController();

  Rx<int> maxLevel = 20.obs;

  @override
  void onInit() {
    super.onInit();
    ContractInfo contractInfo = Get.arguments;
    contractInfo = CommodityDataStoreController.to
            .getContractInfoByContractId(contractInfo.id) ??
        contractInfo;
    this.contractInfo.value = contractInfo;
  }

  @override
  void onReady() {
    super.onReady();
    if (contractInfo.value != null) {
      CommodityPriceController.to.changeContractInfo(contractInfo.value!);
    }
    fetchOpenTime();
  }

  swapContract() async {
    final res = await SwapCommodityBottomSheet.show();
    if (res != null) {
      contractInfo.value =
          CommodityDataStoreController.to.getContractInfoByContractId(res.id) ??
              res;
      fetchOpenTime();
      fetchOpenStatus();
      fetchUserConfig();
      CommodityPriceController.to.changeContractInfo(res);
      if (Get.isRegistered<ContractInfoController>()) {
        ContractInfoController.to.changeContractInfo(res);
      }
    }
  }

  fetchOpenTime() async {
    if (contractInfo.value == null) return;
    try {
      final res = await CommodityApi.instance()
          .getContractOpenTime(contractInfo.value!.id);
      openTime.value = res;
      if (Get.isRegistered<ContractInfoController>()) {
        ContractInfoController.to.changeOpenTime(res);
      }
    } catch (e) {
      bobLog('error when fetchCurrentTradePeriodInfo: $e');
    }
  }

  fetchUserConfig() async {
    if (contractInfo.value == null) return;
    try {
      final res = await CommodityApi.instance().getUserConfig(contractInfo.value!.id);
      maxLevel.value = res.maxLevel?.toInt() ?? 20;
    }  catch (e) {
    }
  }

  fetchOpenStatus() async {
    if (contractInfo.value == null) return;
    try {
      final res = await CommodityApi.instance()
          .getContractOpenStatus(contractInfo.value!.id);
      openStatus.value = res;
    } catch (e) {
      bobLog('error when fetchCurrentTradePeriodInfo: $e');
    }
  }

  onShare() {
    shotController.capture(pixelRatio: Get.pixelRatio).then((value) {
      if (value != null) {
        ShareKChartDetailView.show(image: value);
      }
    });
  }
}
