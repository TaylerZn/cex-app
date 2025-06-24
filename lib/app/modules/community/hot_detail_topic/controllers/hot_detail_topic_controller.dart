import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/models/community/hot_topic.dart';

class HotDetailTopicController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  //TODO: Implement HotDetailTopicController

  final count = 0.obs;
  HotTopicModel? model;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    model = Get.arguments?['model'];
    String? topic = Get.parameters['topic'];
    if (ObjectUtil.isEmpty(model)) {
      model = HotTopicModel(name: topic);
    }

    loadData();
  }

  Future<void> loadData() async {
    TalkingPointInfoModel? response =
        await CommunityApi.instance().talkingPointInfo('#${model?.name ?? ''}');
    TopicTalkingPointListModel? list = await CommunityApi.instance().topicTalkingPointList();
    HotTopicModel? temp = list?.talkingPointList?.firstWhereOrNull((element) => element.name?.contains(model?.name ?? '') == true);

    if (response != null) {
      model?.quoteNum = response.talkingPointInfo?.quoteNum;
      model?.pageViewNum = response.talkingPointInfo?.pageViewNum;
      if(temp != null){
        model?.sort = temp.sort;
      }

    }

    update();
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
