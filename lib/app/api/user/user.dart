import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/models/user/res/user_dialing_code.dart';
import 'package:nt_app_flutter/app/models/user/res/user_setting.dart';
import 'package:nt_app_flutter/app/models/user/popular_tag.dart';
import 'package:retrofit/retrofit.dart';
import '../../network/bika/bika_app_dio.dart';

part 'user.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  factory UserApi.instance() => UserApi(BikaAppDio.getInstance().dio);

  @POST('/v6/user/login_in') //效验登录
  @Extra({showLoading: true})
  Future<VerificationDataModel?> userloginin(@Body() request);

  @POST('/user/confirm_login') //验证码确认登录
  Future userconfirmlogin(@Body() request);

  @POST('/user/login_out') //用户登出
  @Extra({isLogOut: true})
  Future userloginout();

  @POST('/common/user_info') //获取用户信息
  Future<UserInfo?> commonuserinfo();

  @POST('/common/getAgentInfo') //获取用户经纪人概要信息
  Future<UserAgentInfo?> commongetAgentInfo();

  @POST('/co/agent/bonus_record_detail') //手续费返佣明细
  Future<AgentBonusRecordDetailModel?> agentBonusRecordDetail(
    @Field('pageSize') int pageSize,
    @Field('page') int page,
  );

  // v1.0.2 修改的接口
  @POST('/agent/new/getAgentInfo') //new获取用户经纪人概要信息
  Future<UserAgentInfo?> agentNewAgentInfo();

  /**
   * 返佣类型：type
   * 空=全部
   * 0.合约手续费（直推），1.合约手续费（间推），2.现货手续费（直推），3.现货手续（间推），4.跟单返佣（直推），5.跟单返佣（间推）
      多个使用英文,分割，如0,1
   * */
  @POST('/agent/new/bonus_record_detail') //new手续费返佣  -> /agent/new/bonus_record
  Future<AgentBonusRecordListModel?> agentNewBonusRecord(
    @Field('pageSize') int pageSize,
    @Field('page') int page,
    @Field('start_time') String startTime,
    @Field('end_time') String endTime,
    @Field('type') String type,
  );

  @POST('/agent/new/user_list') //new邀请用户列表
  Future<InviteUserListModel?> agentNewUserList(
    @Field('pageSize') String pageSize,
    @Field('page') String page,
    @Field('sort') String sort, //排序方式：排序字段：iniviteDate,bonusAmount
    @Field('order') String order, //升序、降序：asc\desc
  );
  @POST('/agent/new/userTypeStat') //邀请用户类型分布
  Future<AgentUserTypeStatModel> agentNewUserTypeStat();

  @POST('/co/agent/follow_profit_record') //跟单分润记录
  Future<AgentFollowProfitRecordModel?> agentFollowProfitRecord(
    @Field('pageSize') int pageSize,
    @Field('page') int page,
  );

  @POST('/v4/common/emailValidCode') //发送邮箱验证码
  @Extra({showLoading: true})
  Future commonemailValidCode(@Body() request);

  @POST('/v4/common/smsValidCode') //发送验证码
  @Extra({showLoading: true})
  Future commonsmsValidCode(@Body() request);

  @POST('/user/register') //用户注册账户(第一步)
  @Extra({showLoading: true})
  Future userregisterOne(@Body() request);

  @POST('/user/valid_code') //用户注册账户(第二步)
  Future userregisterTwo(@Body() request);

  @POST('/user/confirm_pwd') //用户注册账户(第三步)
  @Extra({showLoading: true})
  Future userregisterThree(@Body() request);

  @POST('/user/reset_password_step_one') //忘记密码（第一步）
  Future<ResetPasswordStepModel?> resetpasswordstepone(@Body() request);

  @POST('/user/reset_password_step_two') //忘记密码（第二步）
  Future resetpasswordsteptwo(@Body() request);

  @POST('/user/reset_password_step_three') //忘记密码（第三步）
  Future resetpasswordstepthree(@Body() request);

  @POST('/user/v4/auth_realname') //用户实名认证
  Future userv4authrealname(@Body() request);

  @POST('/user/nickname_update') //修改昵称
  Future usernicknameupdate(@Body() request);

  @POST('/config/defaultPictures') //获取默认头像
  Future<DefaultPicturesModel?> configdefaultPictures();

  @POST('/user/person_picture_update') //修改用户头像
  Future userPersonPictureUpdate(
    @Field('pictureUrl') String pictureUrl,
  );

  @POST('/user/person_signature_update') //修改个性签名
  Future userPersonSignatureUpdate(@Body() request);

  @POST('/user/toopen_google_authenticator') //用户开启google认证
  Future<UsertoopegoogleModel?> usertoopegoogleauthenticator(@Body() request);

  @POST('/user/google_verify') //验证google验证码
  Future usergoogleverify(@Body() request);

  @POST('/user/close_google_verify') //用户关闭Google认证
  Future userclosegoogleverify(@Body() request);

  @POST('/user/mobile_bind_save') //用户绑定手机号
  @Extra({showLoading: true})
  Future usermobilebindsave(@Body() request);

  @POST('/user/mobile_update') //用户更新手机号
  @Extra({showLoading: true})
  Future usermobileupdate(@Body() request);

  @POST('/user/email_bind_save') //用户绑定邮箱
  @Extra({showLoading: true})
  Future useremailbindsave(@Body() request);

  @POST('/user/email_update') //用户修改邮箱
  @Extra({showLoading: true})
  Future useremailupdate(@Body() request);

  @POST('/user/close_mobile_verify') //用户关闭手机认证
  @Extra({showLoading: true})
  Future userclosemobileverify(@Body() request);

  @POST('/user/open_mobile_verify') //用户开启手机认证
  @Extra({showLoading: true})
  Future useropenmobileverify();

  @POST('/user/password_update') //用户密码更新
  @Extra({showLoading: true})
  Future userpasswordupdate(@Body() request);

  @POST('/user/deleteAccount') //注销账户
  @Extra({showLoading: true})
  Future userDeleteAccount(@Body() request);

  @POST('/config/popularTags') //获取热门标签
  Future<PopularTagsModel> popularTags();

  @POST('/config/getDefineTags') //获取用户自定义标签
  Future<String?> getDefineTags();

  @POST('/config/addDefineTags') //添加自定义标签
  @Extra({showLoading: true})
  Future addDefineTags(@Field('defineTags') String defineTags);

  @POST('/user/person_logo_update') //编辑个人标识
  @Extra({showLoading: true})
  Future personLogoUpdate(
    @Field('personLogoData') String personLogoData,
  );

  @POST('/user/deviceTokens')
  Future userDeviceTokens(
      @Field('uid') num uid, @Field('deviceToken') String deviceToken);

  // 根据ip获取手机区号
  @GET('/user/getDialingCode')
  Future<UserDialingCode> getDialingCode();
}
