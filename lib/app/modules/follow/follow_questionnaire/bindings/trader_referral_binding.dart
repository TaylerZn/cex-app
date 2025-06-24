import 'package:get/get.dart';

import '../controllers/follow_questionnaire_controller.dart';
import '../controllers/follow_questionnaire_details_controller.dart';
import '../controllers/follow_questionnaire_result_controller.dart';
import '../controllers/trader_referral_controller.dart';

class TraderReferralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraderReferralController>(
      () => TraderReferralController(),
    );
  }
}
