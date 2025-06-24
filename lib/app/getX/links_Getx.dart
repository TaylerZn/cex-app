import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/config/config_api.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/models/config/links_res.dart';

class LinksGetx extends GetxController {
  static LinksGetx get to => Get.find();
  late DisplayLinksModel links;

  //账户协议与服务条款
  String get accountProtocol {
    return links.accountProtocol ?? '';
  }

  //在线客服
  String get onlineServiceProtocal {
    return links.onlineServiceProtocal ?? '';
  }

  // 帮助中心
  String get helpCenter {
    return links.helpCenter?.commonProblem ?? '';
  }

  // 学习跟单
  String get helpHowToCopyTradeCenter {
    return links.helpCenter?.howToCopyTrade ?? '';
  }

  //邀请规则
  String get inviteRules {
    return links.inviteRules ?? '';
  }

  //注销条款
  String get accountDelete {
    return links.accountDelete ?? '';
  }

  //社区规范
  String get communityAgreement {
    return links.communityAgreement ?? '';
  }

  //合约使用协议
  String get futuresUseAgreement {
    return links.futuresUseAgreement ?? '';
  }

  //风险披露
  String get riskDisclosure {
    return links.riskDisclosure ?? '';
  }

  //免责声明
  String get disclaimer {
    return links.disclaimer ?? '';
  }

  //卡券规则
  String get couponRules {
    return links.couponRules ?? '';
  }

  ///关于我们-模块
  //twitter
  String get twitter {
    return links.abountUs?.twitter ?? '';
  }

  //discord
  String get discord {
    return links.abountUs?.discord ?? '';
  }

  //telegram
  String get telegram {
    return links.abountUs?.telegram ?? '';
  }

  //email
  String get email {
    return links.abountUs?.email ?? '';
  }

  //用户协议
  String get userProtocal {
    return links.abountUs?.userProtocal ?? '';
  }

  //风险协议
  String get riskProtocal {
    return links.abountUs?.riskProtocal ?? '';
  }

  //隐私协议
  String get privacyProtocal {
    return links.abountUs?.privacyProtocal ?? '';
  }

  //合约服务协议
  String get contractUsageAgreement {
    return links.contractUsageAgreement ?? '';
  }

  //平台介绍
  String get platformIntroduce {
    return links.abountUs?.platformIntroduce ?? '';
  }

  //用户认证
  String get usLicense {
    return links.abountUs?.usLicense ?? '';
  }

  //商业合作
  String get businessCooperation {
    return links.abountUs?.businessCooperation ?? '';
  }

  // 跟单交易协议
  String get followProtocol {
    return links.followProtocol ?? '';
  }

  // 分享-帖子详情H5链接
  String get topicUrl {
    return links.share?.topicUrl ?? '';
  }

  // 分享-交易员分享-邀请注册
  String get followUrl {
    return links.share?.followUrl ?? '';
  }

  // 分享-历史跟单分享-邀请注册
  String get followHistoryUrl {
    return links.share?.followHistoryUrl ?? '';
  }

  // 分享-邀请用户分享-注册带邀请码
  String get inviteUserUrl {
    return links.share?.inviteUserUrl ?? '';
  }

  // 分享-合约分享-邀请注册
  String get futuresUrl {
    return links.share?.futuresUrl ?? '';
  }

  // 分享-合约分享-邀请注册
  String get downloadUrl {
    return links.share?.downloadUrl ?? '';
  }

  //跟单成交价格说明
  String get followDealPriceDescription {
    return links.followDealPriceDescription ?? '';
  }

  //渠道分润规则
  String get proxyRules {
    return links.proxyRules ?? '';
  }

  //存款证明
  String get proofOfReserve {
    return links.proofOfReserve ?? '';
  }

  /// 初始化
  @override
  void onInit() {
    var instance =
        ObjectKV.links.get((v) => DisplayLinksModel.fromJson(v as Map<String, dynamic>), defValue: DisplayLinksModel());
    links = instance!;
    getRefresh();
    super.onInit();
  }

  Future<void> getRefresh({bool notify = true}) async {
    await Future.wait([
      getLinks(notify: notify),
    ]);
    _save();
  }

  Future getLinks({bool notify = true}) async {
    try {
      DisplayLinksModel? res = await ConfigApi.instance().configdisplayLinks();
      links = res ?? DisplayLinksModel();
      if (notify) {
        update();
      }
    } catch (e) {
      links = DisplayLinksModel();
      Get.log('getFollowInfo error: $e');
    }
  }

  void _save() {
    ObjectKV.links.set(links);
  }

  /// 加载完成
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// 控制器被释放
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
