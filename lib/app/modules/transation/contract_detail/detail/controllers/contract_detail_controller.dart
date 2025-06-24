import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/price/controllers/contract_price_controller.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/share_kchart_detail_view.dart';
import 'package:screenshot/screenshot.dart';

import '../../../swap_contract/views/swap_contract_bottom_sheet.dart';

class ContractDetailController extends GetxController {
  Rxn<ContractInfo> contractInfo = Rxn<ContractInfo>();
  ScreenshotController shotController = ScreenshotController();

  RxInt maxLevel = 20.obs;

  @override
  void onInit() {
    super.onInit();
    contractInfo.value = Get.arguments;
  }

  swapContract() async {
    final res = await SwapContractBottomSheet.show();
    if (res != null) {
      contractInfo.value = res;
      ContractPriceController.to.changeContractInfo(res);
      fetchUserConfig();
    }
  }

  fetchUserConfig() async {
    if (contractInfo.value == null) return;
    try {
      final res = await ContractApi.instance().getUserConfig(contractInfo.value!.id);
      maxLevel.value = res?.maxLevel?.toInt() ?? 20;
    }  catch (e) {
    }
  }

  onShare() {
    shotController.capture(pixelRatio: Get.pixelRatio).then((value) {
      if (value != null) {
        Get.dialog(ShareKChartDetailView(image: value), useSafeArea: false);
      }
    });
  }
}
