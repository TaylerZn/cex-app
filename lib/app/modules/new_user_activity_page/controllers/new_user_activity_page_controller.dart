import 'dart:async';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/activity/activity.dart';
import 'package:nt_app_flutter/app/models/activity/activity_detail.dart';
import 'package:nt_app_flutter/app/models/activity/activity_task.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewUserActivityPageController extends GetxController {
  final activityDetail = ActivityDetail().obs;

  RxList tasks = RxList<ActivityTask?>();

  RefreshController refreshController = RefreshController();

  Timer? _timer;

  RxString endTimeStr = ''.obs;
  String activityId = Get.arguments ?? 'c98ae37e45254b83a72ea2fa48819cf0';

  String endString = "0 D : 0 H : 0 M : 0 S";

  @override
  void onInit() {
    super.onInit();
    fetchActivityDetail();
    fetchTasks();
  }

  void timeChange() {
    int endTime = int.parse(activityDetail.value.endTime ?? '');
    endTime--;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(endTime);
    DateTime now = DateTime.now().toUtc();
    if (dateTime.isAfter(now)) {
      Duration difference = dateTime.difference(now);

      // 计算天、小时、分钟和秒
      int days = difference.inDays;
      int hours = difference.inHours % 24;
      int minutes = difference.inMinutes % 60;
      int seconds = difference.inSeconds % 60;
      endTimeStr.value = "$days D : $hours H : $minutes M : $seconds S";
    } else {
      endTimeStr.value = endString;
    }
  }

  Future<void> fetchActivityDetail() async {
    try {
      activityDetail.value =
          await ActivityApi.instance().fetchActivityDetail(activityId) ??
              ActivityDetail();
    } catch (ignore) {}

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeChange();
    });
  }

  Future<bool> enroll() async {
    try {
      await ActivityApi.instance().signUpActivity(activityId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchTasks() async {
    tasks.value =
        await ActivityApi.instance().fetchActivityTaskList(activityId);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

List<String> rules = [
  LocaleKeys.other86.tr,
  LocaleKeys.other87.tr,
  LocaleKeys.other88.tr,
  LocaleKeys.other89.tr,
  LocaleKeys.other90.tr,
  LocaleKeys.other91.tr,
  LocaleKeys.other92.tr,
  LocaleKeys.other93.tr,
];
