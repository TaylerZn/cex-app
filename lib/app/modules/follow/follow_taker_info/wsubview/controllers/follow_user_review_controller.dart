import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowUserReviewController extends GetxController {
  Rx<FollowComment> comment = FollowComment().obs;
  RefreshController commentRefreshVc = RefreshController();
  num uid = -1;
  @override
  void onInit() {
    super.onInit();
    uid = Get.arguments?['uid'] ?? -1;
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future getData({bool isPullDown = false}) async {
    if (isPullDown) {
      comment.value.page = 1;
    } else {
      if (comment.value.records != null && comment.value.page == 1) return null;
    }

    return AFFollow.getRatingPage(traderUid: uid, page: 1, pageSize: 10).then((value) {
      comment.value = value;

      int page = comment.value.page;
      var pageSize = value.records?.length;

      if (page != 1) {
        comment.value.records?.addAll(value.records ?? []);
        value.records = comment.value.records;
      }
      comment.value = value;
      comment.value.page = page;
      comment.value.haveMore = pageSize == comment.value.pageSize;
    });
  }
}
