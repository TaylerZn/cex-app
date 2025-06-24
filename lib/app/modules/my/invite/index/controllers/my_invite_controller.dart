import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/home/home.dart';

class MeInviteController extends GetxController {
  ScrollController scrollController = new ScrollController();
  MemberinviteInfoModel inviteInfo = MemberinviteInfoModel();
  MemberinviteInfoModel inviteTeamInfo = MemberinviteInfoModel();
  List<NoAuthmemberhelpCenterModel> helpCenterList = [];
  var topOpacity = 0x00ffffff.obs;
  var textOpacity = 0xffffffff.obs;

  List<ExpandableController> expandableControllers = [];
  @override
  void onInit() {
    super.onInit();
    UserGetx.to.getCommongetAgentInfo();

    scrollController.addListener(() {
      int offset = scrollController.position.pixels.toInt();
      // print("滑动距离$offset");
      if (topOpacity.value != 0x00ffffff && offset < 20) {
        topOpacity.value = 0x00ffffff;
        textOpacity.value = 0xffffffff;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else if (offset > 20 && topOpacity.value != 0x10ffffff && offset < 40) {
        topOpacity.value = 0x10ffffff;
        textOpacity.value = 0xffffffff;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else if (offset > 40 && topOpacity.value != 0x20ffffff && offset < 60) {
        topOpacity.value = 0x20ffffff;
        textOpacity.value = 0xffeeeeee;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else if (offset > 60 && topOpacity.value != 0x30ffffff && offset < 80) {
        topOpacity.value = 0x30ffffff;
        textOpacity.value = 0xffCCCCCC;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else if (offset > 80 &&
          topOpacity.value != 0x40ffffff &&
          offset < 100) {
        topOpacity.value = 0x40ffffff;
        textOpacity.value = 0xffBBBBBB;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      } else if (offset > 100 &&
          topOpacity.value != 0x50ffffff &&
          offset < 120) {
        topOpacity.value = 0x50ffffff;
        textOpacity.value = 0xff999999;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      } else if (offset > 120 &&
          topOpacity.value != 0x60ffffff &&
          offset < 140) {
        topOpacity.value = 0x60ffffff;
        textOpacity.value = 0xff777777;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      } else if (offset > 140 &&
          topOpacity.value != 0x70ffffff &&
          offset < 160) {
        topOpacity.value = 0x70ffffff;
        textOpacity.value = 0xff555555;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      } else if (offset > 160 &&
          topOpacity.value != 0x80ffffff &&
          offset < 180) {
        topOpacity.value = 0x80ffffff;
        textOpacity.value = 0xff333333;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      } else if (offset > 180 &&
          topOpacity.value != 0x90ffffff &&
          offset < 200) {
        topOpacity.value = 0x90ffffff;
        textOpacity.value = 0xff111111;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      } else if (offset > 200 && topOpacity.value != 0xffffffff) {
        topOpacity.value = 0xffffffff;
        textOpacity.value = 0xff000000;

        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    });
  }

  String removeEnddot(String str) {
    if (str.endsWith('.')) {
      return str.substring(0, str.length - 1);
    }
    return str;
  }
}
