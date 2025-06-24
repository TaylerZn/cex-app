import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

import 'package:nt_app_flutter/app/models/main/main.dart';
import 'package:nt_app_flutter/app/models/public/g_captcha.dart';
import 'package:nt_app_flutter/app/models/public/question.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_search/model/markets_search_model.dart';
import 'package:nt_app_flutter/app/modules/my/coupons/model/coupons_model.dart';
import 'package:nt_app_flutter/app/network/retry_interceptor.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/spot_goods/option_spot_symbol.dart';
import '../../network/bika/bika_app_dio.dart';
import '../../models/message/message_unread.dart';
import '../../models/notice/notice.dart';
import '../../models/message/user_message.dart';

part 'public.g.dart';

@RestApi()
abstract class PublicApi {
  factory PublicApi(Dio dio, {String baseUrl}) = _PublicApi;

  factory PublicApi.instance() => PublicApi(BikaAppDio.getInstance().dio);

  /// @description: 交易页面公共参数
  @POST('/common/public_info_v5')
  Future commonpublicinfov5();

  /// @description: 获取极验初始化信息
  @POST('/common/tartCaptcha')
  Future commontartCaptcha();

  /// @description: 获取谷歌reCaptcha Id
  @POST('/common/getReCaptchaId')
  Future<GetReCaptchaIdModel?> getReCaptchaId();

  /// @description: 认证_国家列表
  @GET('/common/get_country_info')
  Future<CountryListModel?> getcountryinfo();

  /// @description: 获取现货相关信息
  @POST('/common/public_info_market')
  @Extra({kRetry: true})
  Future<PublicInfoMarket> getPublicInfoMarket();

  @POST('/common/recommend_symbol')
  @Extra({showLoading: true})
  Future<MarketRecommend> recommendSymbol();

  @POST('/optional/list_symbol')
  Future<OptionSpotSymbol> getOptionalListSymbol();

  @POST('/optional/update_all_symbol')
  Future setOptionalListSymbol(@Field('symbols') String symbols);

  @POST('/optional/update_symbol') //operationType 1 添加  2:删除
  Future updateOptionalSymbol(@Field('symbols') String symbols, @Field('operationType') String operationType);

  @POST('/message/user_message')
  Future<UserMessageModel> getUserMessageList(
    @Field('page') int page, // 页码
    @Field('pageSize') int pageSize, // 每页数量
    @Field('messageType') int messageType,
  );

  @POST('/message/v2/page/query')
  Future<UserMessageModel> getV1UserMessageList(
    @Field('page') int page, // 页码
    @Field('pageSize') int pageSize, // 每页数量
    @Field('messageType') int messageType,
  );

  @POST('/message/v2/page/query')
  Future<dynamic> getV2UserMessageList(
      @Field('page') int page, // 页码
      @Field('pageSize') int pageSize, // 每页数量
      @Field('tid') int tid,
      );


  @POST('/notice/notice_info_list')
  Future<NoticeModel> getNoticeInfoListNew( //给后台打补丁
      @Field('page') int page, // 页码
      @Field('pageSize') int pageSize, // 每页数量
      @Field('type') int? addTpye); // 1 公告 2 活动  // 老版本不传


  // @POST('/notice/notice_info_list')
  // Future<NoticeModel> getNoticeInfoList(

  //   @Field('page') int page, // 页码
  //   @Field('pageSize') int pageSize, // 每页数量
  //   @Field('tid') int tid,
  // );

  /// @description: 获取公告列表
  /// @param page 页码
  /// @param pageSize 每页数量
  /// @param type 公告类型 1=公告 2=活动
  /// @param position 公告位置 1.消息中心-公告 2.跟单-首页-公告3.交易
  @POST('/notice/notice_info_list')
  Future<NoticeModel> getNoticeInfoList({
    @Field('page') required int page, // 页码
    @Field('pageSize') required int pageSize, // 每页数量
    @Field('type') int? type,
    @Field('position') int? position,
  });

  @POST('/message/get_no_read_message_count')
  Future<MessageUnreadModel> getMessageUnreadCount();

  /// @description: 反馈类型
  @POST('/question/problem_tip_list')
  Future<QuestionProblemTipListModel?> questionProblemTipList();

  /// @description: 提交问题
  @POST('/question/create_problem')
  Future questionCreateProblem(
    @Field('rqType') String page,
    @Field('rqDescribe') String pageSize,
    @Field('imageDataStr') String type,
  );

  /// @description: 推荐
  @POST('/get_index_symbol_config')
  Future getIndexSymbolConfig(@Field('key') String key);

  /// @description: 是否完成新手引导
  @POST('/user/new_guide')
  Future getUserNewGuide(@Field('type') String type);

  /// @description: 完成新手引导
  @POST('/user/complete_new_guide')
  Future completeNewGuide(@Field('type') String type);

  ///赠金券查询
  @POST('/record/coupon_card_list')
  Future<CouponsListModel> getCouponCardList(@Field('status') num status);

  /// @description: 新手引导
  @POST('/user/new_guide/v2')
  Future getUserNewGuideV2(@Field('type') List type);

  ///赠金券查询
  @POST('/record/receive_exp_coupon')
  @Extra({showLoading: true})
  Future getReceiveExpCoupon(@Field('cardSn') String cardSn);
}
