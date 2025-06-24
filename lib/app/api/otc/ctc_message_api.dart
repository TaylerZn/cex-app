import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/c2c_detail_problem_res.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ctc_message_api.g.dart';

@RestApi()
abstract class CtcMessageApi {
  factory CtcMessageApi(Dio dio, {String baseUrl}) = _CtcMessageApi;

  factory CtcMessageApi.instance() => CtcMessageApi(
        BikaAppDio.getInstance().dio,
        baseUrl: BestApi.getApi().baseUrl,
      );

  /// 发起申述
  /// rqType 问题类型 8 卖方未放行 9 买方未付款
  @POST('/question/create_problem')
  Future createProblem(
    @Field('rqType') String rqType,
  );

  /// 申诉消息列表
  /// id 申述id
  @POST('/question/details_problem')
  Future<C2CDetailProblemRes> detailsProblem(@Field('id') String id);

  /// 申诉消息
  /// id 申述id
  /// rqReplyContent 问题描述 contentType = 2 图片,传图片的相对路径
  /// contentType 问题类型 1 文字 2 图片
  @POST('/question/reply_create')
  Future replyCreate(
    @Field('rqId') String rqId,
    @Field('rqReplyContent') String rqReplyContent,
    @Field('contentType') String contentType,
  );

  /// 图片上传
  @POST('/common/upload_img')
  Future<Map<String, String>> uploadImg(
    @Part() File file,
  );
}
