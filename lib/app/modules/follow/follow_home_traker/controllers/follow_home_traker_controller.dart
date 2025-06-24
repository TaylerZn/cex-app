import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/models/community/activity.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';

class FollowHomeTrakerController extends GetxController with GetTickerProviderStateMixin {
  FollowKolListModel model = FollowKolListModel();
  // bool isTrader = false;
  var cmsModel = CmsAdvertModel().obs;

  @override
  void onInit() {
    super.onInit();
    FollowDataManager.instance.onchangeuser = (p) => getData(p);
    FollowDataManager.instance.callbackData(callback: (p) => getData(p));
    Bus.getInstance().on(EventType.changeLang, (data) {
      getCmsAdvertList();
    });
  }

  getData(bool isKol) async {
    // isTrader = isKol;
    // AFFollow.getTraderList(kolType: 1, orderByType: 0).then((value) {
    //   model.list = value.list;
    //   update();
    // });

    AFFollow.getExploreTraderList().then((value) {
      model.list = value.popularTrader;

      update();
    });

    getCmsAdvertList();
  }

  getCmsAdvertList() async {
    CommunityApi.instance().getCmsAdvertList(ActivityEnumn.homeInvite.position, '0').then((value) {
      if (value != null) {
        cmsModel.value = value;
      }
    });
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.changeLang, (data) {});

    super.onClose();
  }
}
