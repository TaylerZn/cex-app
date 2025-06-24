import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/activity/activity_detail.dart';
import 'package:nt_app_flutter/app/models/activity/activity_task.dart';
import 'package:nt_app_flutter/app/network/app_dio.dart';
import 'package:retrofit/retrofit.dart';

part 'activity.g.dart';

@RestApi()
abstract class ActivityApi {
  factory ActivityApi(Dio dio, {String baseUrl}) = _ActivityApi;

  factory ActivityApi.instance() => ActivityApi(AppDio.getInstance().dio);

  /// 获取活动详情 c98ae37e45254b83a72ea2fa48819cf0
  @GET('/v1/activity/{activityId}')
  Future<ActivityDetail?> fetchActivityDetail(@Path() String activityId);

  /// 活动报名
  @POST('/v1/activity/{activityId}')
  Future<dynamic> signUpActivity(@Path() activityId,);
  /// 活动任务列表
  @GET('/v1/activity/task_list')
  Future<List<ActivityTask?>> fetchActivityTaskList(
      @Query('activityId') String activityId);
}
