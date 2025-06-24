import 'package:get/get.dart';

import '../controllers/open_contract_answer_controller.dart';

class OpenContractAnswerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpenContractAnswerController>(
      () => OpenContractAnswerController(),
    );
  }
}
