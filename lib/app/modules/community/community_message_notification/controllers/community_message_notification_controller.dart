import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../widgets/basic/list_view/get_list_controller.dart';
import '../models/community_message_notification_item_model.dart';

class CommunityMessageNotificationController
    extends GetListController<CommunityMessageNotificationItemModel>
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final titles = [
    LocaleKeys.community69.tr,
    LocaleKeys.community70.tr,
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: titles.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  Future<List<CommunityMessageNotificationItemModel>> fetchData() {
    // TODO: implement fetchData
    throw UnimplementedError();
  }
}
