import 'package:get/get.dart';

import '../controllers/follow_questionnaire_controller.dart';

class FollowQuestionnaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowQuestionnaireController>(
      () => FollowQuestionnaireController(),
    );
  }
}
