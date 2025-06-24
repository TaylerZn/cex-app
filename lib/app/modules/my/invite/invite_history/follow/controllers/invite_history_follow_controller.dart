import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InviteHistoryFollowController extends GetxController {
  int pageIndex = 1;
  int pageSize = 10;
  bool haveMore = true;

  List<AgentFollowProfitRecordMapList> dataList = [];

  Rx<MyPageLoadingController> loadingController = MyPageLoadingController().obs;
  RefreshController refreshVc = RefreshController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getdataList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getdataList() async {
    if (pageIndex == 1) {
      dataList.clear();
    }
    try {
      AgentFollowProfitRecordModel? res =
          await UserApi.instance().agentFollowProfitRecord(
        pageSize,
        pageIndex,
      );
      if (res != null && res.mapList != null && res.mapList!.isNotEmpty) {
        for (var item in res.mapList ?? []) {
          dataList.add(item);
        }

        loadingController.value.setSuccess();
      } else {
        loadingController.value.setEmpty();
      }
      update();
    } catch (e) {
      print(e);
      Get.log('getdataList error: $e');
      loadingController.value.setEmpty();
    }
  }
}
