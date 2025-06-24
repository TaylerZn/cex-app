import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/advert_model.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_user_info.dart';

import '../../../../../utils/utilities/ui_util.dart';

class PersonalProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement PersonalProfileController
  OtcUserInfo? userInfo;
  late TabController tab;
  List<String>? list = ['信息', '广告'];
  List<DataList?>? dataList;
  int? uid;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    uid = Get.arguments['uid'];
    tab = TabController(length: 2, vsync: this);
    loadData();
  }

  Future<void> loadData() async {
    EasyLoading.show();
    try{
      userInfo = await OtcApi.instance().personInfo(uid ?? UserGetx.to.uid!);

      AdvertModel? model = await OtcApi.instance()
          .advertList(currentPage: 1, pageSize: 20, uid: uid!);
      dataList = model?.dataList;

    }on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }


    EasyLoading.dismiss();
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
