import 'package:get/get.dart';

import '../controllers/follow_questionnaire_controller.dart';
import '../controllers/follow_questionnaire_details_controller.dart';
import '../controllers/follow_questionnaire_result_controller.dart';

class FollowQuestionnaireResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowQuestionnaireResultController>(
      () => FollowQuestionnaireResultController(),
    );
  }
}
