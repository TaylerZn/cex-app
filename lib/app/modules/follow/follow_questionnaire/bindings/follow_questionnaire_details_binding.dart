import 'package:get/get.dart';

import '../controllers/follow_questionnaire_controller.dart';
import '../controllers/follow_questionnaire_details_controller.dart';

class FollowQuestionnaireDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowQuestionnaireDetailsController>(
      () => FollowQuestionnaireDetailsController(),
    );
  }
}
