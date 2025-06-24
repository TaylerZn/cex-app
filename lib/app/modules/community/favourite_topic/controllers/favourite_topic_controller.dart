import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/controllers/community_list_controller.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';

class FavouriteTopicController extends GetxController {
  //TODO: Implement FavouriteTopicController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;


}
