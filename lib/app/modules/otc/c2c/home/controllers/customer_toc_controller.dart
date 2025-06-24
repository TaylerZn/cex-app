import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_public_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_advert.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_top.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/kyc_check_dialog.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerTocController extends GetxController with GetTickerProviderStateMixin {
  List<C2cType> navTabs = [C2cType.buy, C2cType.sell];
  late TabController tabController;
  int currentIndex = 0;
  var dataArray = [CustomerAdvertListModel().obs, CustomerAdvertListModel().obs];
  var refreshVcArr = [RefreshController(), RefreshController()];
  var requestModel = CustomerTocRequestModel().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: navTabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
        getData();
      }
    });
    getPublicInfo();
  }

  Future? getData({bool isPullDown = false}) async {
    var model = dataArray[currentIndex];

    if (requestModel.value.filterArray[currentIndex]) {
      model.value.page = 1;
      refreshVcArr[currentIndex].requestRefresh();
    } else {
      if (isPullDown) {
        model.value.page = 1;
      } else {
        if (model.value.records != null && model.value.page == 1) return null;
      }
    }

    var value = await AFCustomer.getAdvert(
        tradeType: requestModel.value.tradeType,
        tradeValue: requestModel.value.amount,
        paycoin: requestModel.value.otcDefaultPaycoin,
        payments: requestModel.value.paymentsList,
        side: currentIndex,
        page: model.value.page,
        pageSize: model.value.pageSize);
    int page = model.value.page;
    var pageSize = value.records?.length;
    if (page != 1) {
      model.value.records?.addAll(value.records!);
      value.records = model.value.records;
    }
    model.value = value;
    model.value.page = page;
    model.value.haveMore = pageSize == model.value.pageSize;
    if (!model.value.haveMore) refreshVcArr[currentIndex].loadNoData();
    requestModel.value.filterArray[currentIndex] = false;
    return model;
  }

  getPublicInfo() async {
    OtcPublicInfo? value;
    if (OtcConfigUtils().publicInfo == null) {
      value = await OtcApi.instance().public_info();
      OtcConfigUtils().publicInfo = value;
    } else {
      value = OtcConfigUtils().publicInfo;
    }

    requestModel.value = CustomerTocRequestModel(
        paycoinList: value?.paycoins,
        payments: value?.payments,
        otcDefaultPaycoin: value?.otcDefaultPaycoin ?? 'USD',
        complete: true,
        callback: () => getData(isPullDown: true));
    await getData();

    if (dataArray[currentIndex].value.records?.isNotEmpty == true) {
      Future.delayed(const Duration(milliseconds: 300), () {
        Intro.of(Get.context!).start(group: AppGuideType.c2c.name);
      });
    }
  }

  checkState({required String id, required String coin, required bool isBuy, required String coinSymbol}) async {
    if (!UserGetx.to.isKyc || (!UserGetx.to.isGoogleVerify && !UserGetx.to.isMobileVerify)) {
      Bus.getInstance().on(EventType.closeKycDialog, (data) {
        Get.back();
      });
      showKycDialog();
    } else {
      var value = await AFCustomer.getObtainProtect();
      if ((value['has'] ?? false)) {
        Get.toNamed(Routes.CUSTOMER_DEAL,
            arguments: {'id': id, 'coin': coin, 'isBuy': isBuy, 'coinSymbol': coinSymbol, 'callback': refreshList});
      } else {
        CustomerAlterView.showGuardView(() async {
          Get.toNamed(Routes.CUSTOMER_DEAL,
              arguments: {'id': id, 'coin': coin, 'isBuy': isBuy, 'coinSymbol': coinSymbol, 'callback': refreshList});
        });
      }
    }
  }

  refreshList() {
    getData(isPullDown: true);
  }

  Future<void> showKycDialog() async {
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return const KYCCheckDialog();
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
