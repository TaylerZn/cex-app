import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/models/assets/assets_coupon_card_record.dart';

class CouponCardListController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;
  var receivedCoupons = <CardItem>[].obs;
  var expiredCoupons = <CardItem>[].obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    fetchCoupons();
    super.onInit();
  }

  Future<void> fetchCoupons() async {
    var receivedResponse = await AssetsApi.instance().getCouponCardList(0);
    var expiredResponse = await AssetsApi.instance().getCouponCardList(1);

    if (receivedResponse?.cardList != null) {
      receivedCoupons.value = receivedResponse!.cardList ?? [];
    }
    if (expiredResponse?.cardList != null) {
      expiredCoupons.value = expiredResponse!.cardList ?? [];
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
