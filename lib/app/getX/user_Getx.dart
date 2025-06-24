import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/user.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/contract_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/spot_favorite_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/user_config_info.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/my/widgets/Kyc_Info_Page.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/fcm/fcm_utils.dart';
import 'package:nt_app_flutter/app/utils/utilities/kyc_dialog_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../modules/transation/immediate_exchange/main/controllers/immediate_exchange_controller.dart';

class UserGetx extends GetxController {
  User? user;
  int? messageUnreadCount;

  static UserGetx get to => Get.find();

  bool _isSignOutExecuting = false;
  Timer? _signOutTimer;

  /// 初始化
  @override
  void onInit() {
    var instance = ObjectKV.user
        .get((v) => User.fromJson(v as Map<String, dynamic>), defValue: null);
    user = instance;
    getRefresh(notify: false);
    getMessageUnreadCount(notify: true);
    getOpenContract();
    super.onInit();
  }

  //是否登录
  bool get isLogin {
    return user != null;
  }

  //登录拦截
  goIsLogin({Object? arguments}) {
    if (user != null) {
      return true;
    } else {
      try {
        Get.find<ImmediateExchangeController>().fromEditingController.clear();
        Get.find<ImmediateExchangeController>().toEditingController.clear();
        Get.find<ImmediateExchangeController>().toError.value = false;
        Get.find<ImmediateExchangeController>().fromError.value = false;
        Get.find<ImmediateExchangeController>().balanceError.value = false;
      } catch (e) {}
      Get.toNamed(Routes.LOGIN, arguments: arguments);
      return false;
    }
  }

  //是否实名认证
  bool get isKyc {
    return user?.info?.authStatus == UserAuditStatus.Success;
  }

  //实名认证拦截
  Future<bool> goIsKyc() async {
    if (user?.info?.authStatus == UserAuditStatus.Success) {
      return true;
    } else {
      EasyLoading.show();
      await Future.wait([getUserinfo()]);
      EasyLoading.dismiss();
      KycDialogUtil.showKycDialog();

      return false;
    }
  }

  //实名认证状态码
  int? get getAuthStatus {
    return user?.info?.authStatus ?? 3;
  }

  //是否开通了合约账户
  bool get isOpenContract {
    return user?.openContract != 1 ? false : true;
  }

  //是否为交易员
  bool get isKol {
    return user?.info?.isKol ?? false;
  }

  //是否为合约经纪人
  bool get isCoAgent {
    if (user?.agentInfo?.coAgentStatus == 1) {
      //兼容老版本
      return true;
    }
    return user?.agentInfo?.agentStatus == 1;
  }

  //是否开启了谷歌验证
  bool get isGoogleVerify {
    return user?.info?.googleStatus == 1;
  }

  //是否开启了手机验证
  bool get isMobileVerify {
    return isSetMobile && user?.info?.isOpenMobileCheck == 1;
  }

  //是否设置了手机号
  bool get isSetMobile {
    return (user?.info?.mobileNumber != null && user?.info?.mobileNumber != '');
  }

  //是否设置了邮箱号
  bool get isSetEmail {
    return (user?.info?.email != null && user?.info?.email != '');
  }

  //区号+手机号
  String get mobile {
    return '${UserGetx.to.user?.info?.countryCode ?? ''} ${UserGetx.to.user?.info?.mobileNumber ?? ''}';
  }

  //用户昵称
  String? get userName {
    return user?.info?.nickName != null && user?.info?.nickName != ''
        ? user?.info?.nickName
        : user?.info?.userAccount ?? '--';
  }

  int? get leverType {
    return user?.info?.levelType;
  }

  String get avatar {
    return user?.info?.profilePictureUrl ?? '';
  }

  //用户昵称
  int? get uid {
    return user?.info?.id;
  }

  //未读消息数量
  int get unreadCount {
    if (messageUnreadCount == null) {
      return 0;
    }
    return messageUnreadCount!;
  }

  //获取用户标识
  List<String> get userTags {
    String tagsString;
    UserInfo? userInfo = user!.info;
    if (userInfo != null) {
      if (userInfo.logoInfo != null && !TextUtil.isEmpty(userInfo.logoInfo)) {
        tagsString = userInfo.logoInfo!;
        return tagsString.split(",");
      }
    }
    return [];
  }

  bool goIsOpenContract() {
    if (isOpenContract) {
      return true;
    } else {
      Get.toNamed(Routes.OPEN_CONTRACT);
      return false;
    }
  }

  Future<void> getRefresh({bool notify = true}) async {
    await getUserinfo(notify: notify);
    update();
    _save();
  }

  Future<void> getUserinfo({bool notify = true}) async {
    if (isLogin) {
      try {
        UserInfo? res = await UserApi.instance().commonuserinfo();
        var model = await AFFollow.getIsKol();
        getCommongetAgentInfo();
        if (res != null) {
          user?.info = res;
          user?.info?.isKol = model.isKol;
          if (notify) update();
        }
      } on DioException catch (e) {
        Get.log(e.error.toString());
      }
    }
  }

  Future<void> getCommongetAgentInfo({bool notify = true}) async {
    if (isLogin) {
      try {
        UserAgentInfo? res =
            await UserApi.instance().agentNewAgentInfo(); //更换新接口
        if (res != null) {
          user?.agentInfo = res;
        }
        if (notify) update();
      } on DioException catch (e) {
        Get.log(e.error.toString());
      }
    }
  }

  Future<void> getOpenContract({bool notify = true}) async {
    if (isLogin) {
      try {
        UserConfigInfo? res = await ContractApi.instance().getUserConfig(1);
        if (res != null) {
          user?.openContract = res.openContract;
          update(['open_contract']);
        }
        if (notify) update();
      } catch (e) {
        Get.log('error when getOpenContract: $e');
      }
    }
  }

  //登录
  void login(User user) async {
    try {
      EasyLoading.show();
      this.user = user;
      try {
        await Future.wait([
          CommodityOptionController.to.fetchOptionContractIdList(),
          getRefresh(),
          getOpenContract(),
          AppGuideView.getUserNewGuide()
        ]);
      } catch (e) {}
      if (MyCommunityUtil.socialMenu != null) {
        Get.untilNamed(MyCommunityUtil.socialMenu!);
      } else {
        Get.untilNamed(Routes.MAIN_TAB);
      }
      Get.forceAppUpdate();
      MyCommunityUtil.socialMenu = null;

      // Get.untilNamed(Routes.MAIN_TAB);
      UIUtil.showSuccess(LocaleKeys.user257.tr);
      _save();
      update();
      //获取是否开通合约状态和资产信息
      AssetsGetx.to.getRefresh();
      // 更新用户的token
      FcmUtils.updateToken(sToken);
      Bus.getInstance().emit(EventType.login);

      /// 获取自选列表
      CommodityOptionController.to.fetchOptionContractIdList();
      ContractOptionController.to.fetchOptionContractIdList();
      SpotOptionController.to.fetchOptionSpotSymbolList();
      //OTC
      OtcConfigUtils.getPublicInfo();
    } catch (e) {
      Get.log('login ${e.toString()}');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signOut({isBackMain = true, isToast = true}) async {
    if (_isSignOutExecuting) return;

    _isSignOutExecuting = true;
    _signOutTimer = Timer(const Duration(seconds: 5), () {
      _isSignOutExecuting = false;
    });

    userloginout();
    if (user != null) {
      if (isToast) {
        UIUtil.showToast(LocaleKeys.public46.tr);
      }

      user = null;
      AssetsGetx.to.clean();
      if (Get.currentRoute != Routes.MAIN_TAB &&
          isBackMain == true &&
          isRouteRegistered(Routes.MAIN_TAB)) {
        Get.untilNamed(Routes.MAIN_TAB);
      }
      _save();
      update();
      Bus.getInstance().emit(EventType.signOut);

      /// 清空自选列表
      ContractOptionController.to.clear();
      SpotOptionController.to.clear();
      CommodityOptionController.to.clear();
    }
  }

  bool isRouteRegistered(String routeName) {
    return Get.routeTree.routes.any((route) => route.name == routeName);
  }

  Future getMessageUnreadCount({bool notify = true}) async {
    if (isLogin) {
      try {
        var res = await PublicApi.instance().getMessageUnreadCount();
        messageUnreadCount = res.noReadMsgCount;
        if (notify) {
          update();
        }
      } catch (e) {
        Get.log('getMessageUnreadCount error: $e');
      }
    }
  }

  void _save() {
    ObjectKV.user.set(user);
  }

  @override
  String toString() {
    return 'UserGetx{user=$user, messageUnreadCount=$messageUnreadCount, _isSignOutExecuting=$_isSignOutExecuting, _signOutTimer=$_signOutTimer}';
  }
}
