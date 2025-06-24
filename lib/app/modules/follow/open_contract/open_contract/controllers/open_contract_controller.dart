import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/modules/follow/open_contract/open_contract_answer/controllers/open_contract_answer_controller.dart';

class OpenContractController extends GetxController {
  var isChecked = false.obs;

  List<ContractAnswerModel> array = [];
  @override
  void onInit() {
    super.onInit();

    ContractApi.instance().contractAnswer().then((value) {
      value.forEach((v) {
        array.add(ContractAnswerModel.fromJson(v));
      });
    }).catchError((e) {
      print('$e');
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
