import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';

import '../../../../widgets/basic/list_view/get_list_controller.dart';

class FavouriteListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement FavouriteListController
  late TabController tab;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tab = TabController(length: 2, vsync: this);

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
