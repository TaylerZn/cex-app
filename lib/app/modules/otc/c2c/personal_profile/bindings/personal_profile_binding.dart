import 'package:get/get.dart';

import '../controllers/personal_profile_controller.dart';

class PersonalProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalProfileController>(
      () => PersonalProfileController(),
    );
  }
}
