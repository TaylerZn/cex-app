import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/third_login/third_login.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/enums/login.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/send_code.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_list_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class BindingVerificationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  dynamic type;
  VerificationDataModel? verificatioData;

  BindingVerificationController(
      {required this.type, required this.verificatioData});
  bool isGoogle = false;
  TextEditingController pinController = TextEditingController();
  PageController pageController = PageController();

  List<LoginVerificationEnum> verficList = [];
  int verficIndex = 0;
  LoginVerificationEnum get currentType => verficList[verficIndex];
  @override
  void onReady() {
    checkGoPage();
    if (verificatioData?.type == '${Ver2FAEnum.google}') {
      isGoogle = true;
      update();
    }
    super.onReady();
  }

  @override
  void onInit() {
    getVerficList();
    super.onInit();
  }

  getVerficList() {
    Map<String, dynamic> jsonMap = json.decode(verificatioData?.typeList ?? '');
    var jsonList = jsonMap.keys.toList();
    for (var i = 0; i < jsonList.length; i++) {
      LoginVerificationEnum? itemType = getTypeEnum(jsonList[i]);
      if (itemType != null) {
        if (jsonList[i] == verificatioData?.type) {
          verficList.insert(0, itemType);
        } else {
          verficList.add(itemType);
        }
      }
    }
  }

  checkGoPage() {
    if (currentType == LoginVerificationEnum.mobile) {
      pageController.jumpToPage(1);
    } else if (currentType == LoginVerificationEnum.email) {
      pageController.jumpToPage(2);
    } else {
      pageController.jumpToPage(0);
    }
  }

  LoginVerificationEnum? getTypeEnum(type) {
    switch (type) {
      case '1':
        return LoginVerificationEnum.google;
      case '2':
        return LoginVerificationEnum.mobile;
      case '3':
        return LoginVerificationEnum.email;
      default:
        return null;
    }
  }

  onSubmit(pin) async {
    EasyLoading.show();
    try {
      ThirdLoginApi.instance()
          .unbind(
        type!,
        emailAuthCode: currentType == LoginVerificationEnum.email ? pin : null,
        googleCode: currentType == LoginVerificationEnum.google ? pin : null,
        smsAuthCode: currentType == LoginVerificationEnum.mobile ? pin : null,
      )
          .then((value) {
        Get.back(result: true);
      });
      EasyLoading.dismiss();
    } on DioException catch (e) {
      AppLogUtil.e(e);
      EasyLoading.dismiss();
    } catch (e) {
      AppLogUtil.e(e);
      EasyLoading.dismiss();
    }
  }

  changeCurrentType() async {
    var dataList = [];
    for (var i = 0; i < verficList.length; i++) {
      dataList.add(verficList[i].verficName);
    }
    int res = await showMyBottomListDialog(
      title: LocaleKeys.user12.tr,
      dataList: dataList,
      isHideInit: true,
      initIndex: verficIndex,
      itemPadding: EdgeInsetsDirectional.all(16.w),
      itemBackColor: AppColor.colorF5F5F5,
      type: MyBottomListType.other,
      getDisplayText: (item) {
        return item;
      },
    );

    verficIndex = res;
    checkGoPage();
    update();
  }

  Widget getSendWidget() {
    switch (currentType) {
      case LoginVerificationEnum.mobile:
        return MySendCode(
          sendCodeType: UserSafeVerificationEnum.AUTH_UNBIND,
          verificatioData: verificatioData,
          isKeepleft: true,
          autoClick: true,
        );
      case LoginVerificationEnum.email:
        return MySendCode(
          sendCodeType: UserSafeVerificationEnum.AUTH_UNBIND,
          verificatioData: verificatioData,
          isKeepleft: true,
          autoClick: true,
        );

      default:
        return const SizedBox();
    }
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
