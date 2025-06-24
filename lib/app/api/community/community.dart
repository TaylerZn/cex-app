import 'dart:convert';

import 'package:nt_app_flutter/app/models/community/activity.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/community/focus.dart';
import 'package:nt_app_flutter/app/models/community/greed_voting.dart';
import 'package:nt_app_flutter/app/models/community/hot_topic.dart';
import 'package:nt_app_flutter/app/models/community/interest.dart';
import 'package:nt_app_flutter/app/models/community/translate.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/community/community_station_message.dart';

part 'community.g.dart';

@RestApi()
abstract class CommunityApi {
  factory CommunityApi(Dio dio, {String baseUrl}) = _CommunityApi;

  factory CommunityApi.instance() => CommunityApi(BikaAppDio.getInstance().dio);
  // @Query("q")表示get请求参数

  @GET('/api/social/socialtopic/publics/list') //话题-列表查询
  Future<PublicListModel> socialtopicpublicslist(
    @Query('current') String current,
    @Query('size') String size,
    @Query('name') String name,
    @Query('sortType') String sortType,
    @Query('getNftList') bool getNftList,
  );

  @GET('/api/social/socialtopic/publics/findOne') //话题-查询单个话题信息
  Future<TopicdetailModel> socialtopicpublicsfindOne(
    @Query('id') String id,
  );

  @GET('/api/social/sociallike/publics/socialLikeList') //点赞-点赞帖子列表
  Future<PublicListModel> sociallikepublicssocialLikeList(
    @Query('current') String current,
    @Query('size') String size,
    @Query('keyword') String keyword,
  );

  @POST('/apisocial/sociallike/unlikeList') //取消喜欢列表
  Future socialsociallikeunlikeList(@Body() request);

  @GET('/api/market/growfootprint/nftList') //足迹-足迹NFT列表
  Future<PublicListModel> marketgrowfootprintnftList(
    @Query('current') String current,
    @Query('size') String size,
  );

  @GET('/api/market/growfootprint/collectionList') //足迹-足迹合集列表
  Future<PublicListModel> marketgrowfootprintcollectionList(
    @Query('current') String current,
    @Query('size') String size,
  );

  @POST('/api/market/growfootprint/del') // 帖子-发布帖子
  Future marketgrowfootprintdel(@Body() request);

  @POST('/api/noAuth/topic/pageList') //帖子-列表查询
  Future<PublicListModel?> topicpageList(@Body() request);

  @POST('/api/topic/praise/pageList') //帖子点赞分页查询
  Future<PublicListModel?> praisePageList(@Body() request);

  @POST('/api/topic/focus/pageList') //关注列表查询
  Future<PublicListModel?> focusPageList({
    @Field('pageSize') String? pageSize,
    @Field('currentPage') String? currentPage,
    @Field('keyWords') String? keyWords,
    @Field('memberId') String? memberId,
  });

  @POST('/api/topic/collect/pageList') //帖子收藏分页查询
  Future<PublicListModel?> topicCollectPage(@Body() request);

  @POST('/api/noAuth/topic/trader/pageList') //我的帖子
  Future<PublicListModel?> myCollectPage(@Body() request);

  @POST('/api/noAuth/topic/detail') //帖子详情
  Future<TopicdetailModel?> topicdetail(@Body() request);

  @POST('/api/noAuth/topic/trader/pageList') //交易员的帖子
  Future<PublicListModel> topictraderpageList(
    @Field('memberId') String memberId,
    @Field('currentPage') int currentPage,
    @Field('pageSize') int pageSize,
  );

  @GET('/api/social/socialpost/watchlist') //帖子-我的关注列表
  Future<PublicListModel> socialsocialpostwatchlist(
    @Query('current') String current,
    @Query('size') String size,
    @Query('name') String name,
    @Query('sortType') String sortType,
  );

  @POST('/api/noAuth/topic/comment/pageList') // 帖子评论搜索分页查询
  Future<CommunityCommentPageListModel?> commentpageList(
    @Field('currentPage') String currentPage,
    @Field('pageSize') String pageSize,
    @Field('topicNo') String? topicNo,
    @Field('preCommentNo') String? preCommentNo,
  );

  @POST('/api/noAuth/topic/comment/hotList') // 热门评论
  Future<CommunityCommentPageListModel?> commentpageHotList(
    @Field('currentPage') String currentPage,
    @Field('pageSize') String pageSize,
    @Field('topicNo') String? topicNo,
    @Field('preCommentNo') String? preCommentNo,
  );

  // @GET('/social/socialpostcomment/publics/twolevellist') //帖子回复-查询帖子 二级回复 列表
  // Future<TwoLevelListVoIPageModel> commentpageListTwoLevel(
  //   @Query('current') String current,
  //   @Query('size') String size,
  //   @Query('layerId') String layerId,
  // );

  @GET('/api/social/socialfollow/publics/following') //关注-他的关注列表
  Future<PublicListModel> socialsocialfollowpublicsfollowing(
    @Query('current') String current,
    @Query('size') String size,
    @Query('uid') String uid,
  );

  @GET('/api/social/socialfollow/publics/topiclist') //关注-他的关注话题列表
  Future<PublicListModel> socialsocialfollowpublicstopiclist(
    @Query('current') String current,
    @Query('size') String size,
    @Query('uid') String uid,
  );

  @GET('/api/social/socialfollow/publics/followers') //关注-他的粉丝列表
  Future<PublicListModel> socialsocialfollowpublicsfollowers(
    @Query('current') String current,
    @Query('size') String size,
    @Query('infoId') String infoId,
  );

  @POST('/api/topic/add') // 帖子-发布帖子
  Future topicaddpost(@Body() request);

  @POST('/api/topic/scheduled/add') // 定时添加帖子
  Future topicAddSchedulePost(@Body() request);

  @POST('/api/social/socialpost/updatePermissionType') // 帖子-修改帖子权限
  Future socialsocialpostupdatePermissionType(@Body() request);

  @POST('/api/social/socialpost/del') // 帖子-删除帖子
  Future socialsocialpostdel(@Body() request);

  @POST('/api/topic/delete') // 帖子-删除帖子
  Future deleteTopic(@Field('id') String id);

  @POST('/api/topic/comment/delete') // 帖子回复-删除评论 --发帖人和回复人 才能删除
  Future socialsocialpostcommentdel(
    @Field('id') String id,
  );

  @POST('/api/topic/comment/language/translate') // 帖子回复-删除评论 --发帖人和回复人 才能删除
  Future translateComment(
    @Field('commentNo') String commentNo,
  );

  @Extra({showLoading: true})
  @POST('/api/topic/comment/add') //帖子回复-回复帖子或评论
  Future<CommunityCommentItem?> topicCommentAdd(
    @Field('topicNo') String topicNo,
    @Field('preCommentNo') String? preCommentNo,
    @Field('commentContent') String commentContent,
  );

  @GET('/api/social/socialfollow/findOneByTypeAndInfoId') //关注-是否关注 1用户 2话题
  Future socialsocialfollowfindOneByTypeAndInfoId(
    @Query('type') String type,
    @Query('infoId') String infoId,
  );

  @POST('/api/social/socialfollow/follow') //关注-关注 1用户 2话题
  Future socialsocialfollowfollow(@Body() request);

  @POST('/api/social/socialfollow/unfollow') //关注-取消关注 1用户 2话题
  Future socialsocialfollowunfollow(@Body() request);

  @POST('/api/topic/praise/newOrCancel') //帖子点赞或取消点赞
  Future topicpraisenewOrCancel(@Body() request);

  @POST('/api/topic/collect/newOrCancel') //帖子收藏或取消收藏
  Future topiccollectnewOrCancel(@Body() request);

  @GET(
      '/api/market/growcollect/findOneByTypeAndInfoIdAndInfoIdFull') //收藏-查询单个收藏信息
  Future growcollectfindOneByTypeAndInfoIdAndInfoIdFull(
    @Query('type') String type,
    @Query('infoId') String infoId,
    @Query('infoIdFull') String infoIdFull,
  );

  @POST('/api/market/user/publics/getList') //搜索 -查询用户列表
  Future<PublicListModel> marketuserpublicsgetList(@Body() request);

  @GET('/api/market/growsrch/publics/getList') //搜索 -搜索词 列表
  Future<List<MarketgrowsrchpublicsgetListModel>>
      marketgrowsrchpublicsgetList();

  @GET('/api/social/socialpost/publics/dayHotList') //搜索 -帖子列表 --24小时内热门帖子
  Future<PublicListModel> socialsocialpostpublicsdayHotList(
    @Query('current') String current,
    @Query('size') String size,
  );

  @GET('/api/social/reportsType/list') //私聊_用户举报类型列表查询
  Future<List<SocialreportsTypelistModel>> socialreportsTypelist();

  @POST('/api/social/reports/add') //私聊_用户举报提交
  Future socialreportsadd(@Body() request);

  @POST('/api/topic/isTranslate') //帖子是否需要翻译
  Future<IsTranslateModel?> isTranslate(
    @Field('topicNo') String topicNo,
  );

  @POST('/api/topic/talkingPoint/info') //话题浏览量和内容引用数量
  Future<TalkingPointInfoModel?> talkingPointInfo(
    @Field('talkingPoint') String talkingPoint,
  );

  @POST('/api/topic/language/translate') //社区帖子翻译
  Future<LanguageTranslateModel?> languageTranslate(
    @Field('topicNo') String topicNo,
  );

  @POST('/config/getInterestPeople') //可能感兴趣的人
  Future<List<InterestPeopleListModel?>?> getInterestPeople();

  @POST('/common/cmsAdvertListNew') //广告列表
  Future<CmsAdvertModel?> getCmsAdvertList(
    @Field('position') String optType,
    @Field('size') String type,
  );

  //获取主题帖子里@用户列表
  @POST('/api/topic/FocusAt')
  Future<List<TopicFocusListModel>?> topicFocusAt(
    @Field('keyword') String? keyword, //关注人名称,支持模糊查询
  );

  //关注列表
  @POST('/api/topic/focusList')
  Future<List<TopicFocusListModel>?> topicFocusList(
    @Field('isKol') String? isKol, //isKol:交易员 notKol:普通用户  不传 所有用户
    @Field('uid') int? uid, //用户id
    @Field('keyword') String? keyword, //关注人名称,支持模糊查询
  );

  ///我的粉丝列表
  @POST('/api/topic/fansList')
  Future<List<TopicFocusListModel>?> fansList(
    @Field('uid') int? uid, //用户id
  );

  //  恐惧和贪婪指数
  @POST('/api/index/fear-greed-history')
  Future<dynamic> greedHistory();

  //  恐惧和贪婪指数
  @POST('/api/topic/trendDirection/voteInfo')
  Future<GreedVotingModel?> voteInfo();

  //热门话题
  @POST('/api/topic/talkingPoint/list')
  Future<TopicTalkingPointListModel?> topicTalkingPointList(
      {@Field('name') String? keyword}); //话题名称

  //添加关注接口
  @POST('/api/topic/focus')
  Future<dynamic> addUIDFocus(
    @Field('focusUid') int? focusUid, //关注人 uid
  );
  //添加关注接口
  @POST('/api/topic/unFocus')
  Future<dynamic> cancelFocus(
    @Field('focusUid') int? focusUid, //关注人 uid
  );

  //是否投票过
  @POST('/api/topic/isVoted')
  Future isVotedTopic(
    @Field('topicNo') String? topicNo, //关注人 uid
  );

  //社区帖子和当天恐惧贪婪投票
  @POST('/api/topic/vote')
  Future topicVote(
    @Field('voteOptionId') String voteOptionId, //关注人 uid
  );

//帖子评论点赞或取消点赞
  @POST('/api/topic/comment/praise/newOrCancel')
  Future likeNewOrCancel(
    @Field('commentNo') String commentNo, //commentNo
  );

  //帖子一级评论置顶、取消置顶
  @POST('/api/topic/topComment/Operator')
  Future pinTopComment(
    @Field('id') String id, //commentNo
  );

  //帖子置顶、取消置顶
  @POST('/api/topic/topFlagOperator')
  Future pinTopPost(
    @Field('id') String id, //commentNo
  );

  //是否点赞
  @POST(' /api/topic/praise/isNewPraise')
  Future isNewPraise(
    @Field('commentNo') String commentNo, //commentNo
  );

  //社区站内信 //后台数据不符合需求,后期扩展
  @GET('/message/type/obtain')
  Future<CommunityStationMessage?> fetchCommunityStationMessage();

  // 分享数据记录
  @POST('/api/topic/addForwardNum')
  Future addForwardNum(
    @Field('topicNo') String topicNo,
  );
}
