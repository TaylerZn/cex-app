import 'package:get/get.dart';

class UnLoginTipsLogic extends GetxController {
  bool _close = false;

  /// 是否点击了关闭

  bool get close => _close;

  set close(bool value) {
    _close = value;
    update();
  }
}
