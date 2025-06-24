import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/enums/login.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/send_code.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_list_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class LoginVerificationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  VerificationDataModel? verificatioData;
  String? thirdType;
  String? thirdData;
  LoginVerificationController({
    required this.verificatioData,
    this.thirdType,
    this.thirdData,
  });

  List<LoginVerificationEnum> verficList = [];
  int verficIndex = 0;
  LoginVerificationEnum get currentType => verficList[verficIndex];
  TextEditingController pinController = TextEditingController();

  PageController pageController = PageController();

  @override
  void onReady() {
    checkGoPage();
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
      var data = {
        'authCode': pin,
        'checkType': currentType.value,
        'token': verificatioData?.token
      };
      if (thirdType != null && thirdData != null) {
        data['third_type'] = thirdType;
        data['third_data'] = thirdData;
      }
      var res = await userconfirmlogin(data);
      EasyLoading.dismiss();
      if (res != true) {
        pinController.text = '';
        update();
      }
    } catch (e) {
      AppLogUtil.e(e);
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
          sendCodeType: UserSafeVerificationEnum.MOBILE_LOGIN,
          verificatioData: verificatioData,
          isKeepleft: true,
          autoClick: true,
        );
      case LoginVerificationEnum.email:
        return MySendCode(
          sendCodeType: UserSafeVerificationEnum.EMAIL_LOGIN,
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
