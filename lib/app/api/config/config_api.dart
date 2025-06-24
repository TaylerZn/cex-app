import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/config/check_version_res.dart';
import 'package:nt_app_flutter/app/models/config/links_res.dart';
import 'package:nt_app_flutter/app/models/config/system_message_res.dart';
import 'package:nt_app_flutter/app/models/config/unread_message_res.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';
import 'package:nt_app_flutter/app/network/retry_interceptor.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/config/office_message_res.dart';

part 'config_api.g.dart';

@RestApi()
abstract class ConfigApi {
  factory ConfigApi(Dio dio, {String baseUrl}) = _ConfigApi;

  factory ConfigApi.instance() => ConfigApi(
        BikaAppDio.getInstance().dio,
      );

  @POST('/config/displayLinks') //跳转链接地址集
  @Extra({kRetry: true})
  Future<DisplayLinksModel?> configdisplayLinks();

  @GET('/common/getVersionV1') //话题-查询单个话题信息
  Future<CheckVersionV1Model?> checkVersionV1(
    @Query('time') String time,
  );

  /// 系统消息定时拉取（1min）
  @POST("/message/timedCount")
  Future<UnReadMessageRes> unReadMessage();

  /// 官方推送列表
  @POST("/officialPush/pageList")
  Future<OfficeMessageRes> officePushList(
    @Field('currentPage') num currentPage,
    @Field('pageSize') num pageSize,
    @Field('queryTime') String? queryTime,
  );

  /// 系统消息列表
  @POST("/message/pageList")
  Future<SystemMessageRes> systemMessageList(
    @Field('currentPage') num currentPage,
    @Field('pageSize') num pageSize,
  );

  /// 获取法币汇率
  @POST("/common/public_rate")
  Future commonPublicRate();

  /// 系统消息标记已读
  @POST("/message/isRead")
  Future<dynamic> systemMessageRead(@Field('id') num id);
}
