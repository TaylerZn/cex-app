import 'package:get/get.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';

class AssetsWithdrawalResultController extends GetxController {
  dynamic currency;
  dynamic amount;

  AssetsWithdrawalResultController({
    required this.currency,
    required this.amount,
  });
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void jumpToTheHistory() async {
    Bus.getInstance().emit(EventType.withdraw);
    Get.back();
    Get.offNamed(Routes.WALLET_HISTORY,arguments: 1);
  }
}
