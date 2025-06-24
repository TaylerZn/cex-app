import 'package:get/get.dart';

class QuickEntryExpansionGetx extends GetxController {
  var expansionState = false.obs;

  changeExpansionState() {
    expansionState.value = !expansionState.value;
  }
}
