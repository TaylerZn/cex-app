import 'package:get/get.dart';

import '../controllers/question_index_controller.dart';

class QuestionIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionIndexController>(
      () => QuestionIndexController(),
    );
  }
}
