import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/file/file_interface.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/models/public/question.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class QuestionIndexController extends GetxController {
  RefreshController refreshController = RefreshController();
  TextEditingController descriptionControll = TextEditingController();
  List<QuestionProblemTipList> reportList = [];
  int reportIndex = 0;
  QuestionProblemTipList get currentReport => reportList[reportIndex];
  List<AssetEntity> imageList = [];
  int imageMax = 3;
  bool otherSelect = false;
  MyPageLoadingController loadingController = MyPageLoadingController();

  @override
  void onInit() {
    getReportList();
    super.onInit();
  }

  getReportList() async {
    try {
      QuestionProblemTipListModel? res =
          await PublicApi.instance().questionProblemTipList();
      if (res != null && res.rqTypeList != null) {
        for (QuestionProblemTipList item in res.rqTypeList ?? []) {
          reportList.add(item);
        }
        update();
        loadingController.setSuccess();
      } else {
        loadingController.setEmpty();
      }
      update();
    } catch (e) {
      print(e);
      Get.log('getReportList error: $e');
      loadingController.setError();
    }
  }

  submitOntap() async {
    EasyLoading.show();
    if (descriptionControll.text.isEmpty) {
      UIUtil.showToast(LocaleKeys.user111.tr);
      EasyLoading.dismiss();
      return;
    }
    if (descriptionControll.text.length > 200) {
      UIUtil.showToast(LocaleKeys.user205.tr);
      EasyLoading.dismiss();
      return;
    }

    var dataImgList = [];
    for (var i = 0; i < imageList.length; i++) {
      var imageFile = await imageList[i].file;
      var imageUrl = await communitystorageupload(imageFile);
      dataImgList.add(imageUrl);
    }
    String imageDataStr = dataImgList.join(',');
    try {
      await PublicApi.instance().questionCreateProblem(
          '${currentReport.code}', descriptionControll.text, imageDataStr);
      Get.back();
      UIUtil.showSuccess(LocaleKeys.user112.tr);
      update();
    } on DioException catch (e) {
      Get.log('submitOntap error: $e');
      UIUtil.showError('${e.error}');
    }

    EasyLoading.dismiss();
  }
}
