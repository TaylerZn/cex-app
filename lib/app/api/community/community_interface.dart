import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///话题-列表查询
socialtopicpublicslist(current, size, name, sortType,
    {getNftList = false}) async {
  try {
    var res = await CommunityApi.instance()
        .socialtopicpublicslist(current, size, name, sortType, getNftList);
    return res;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    return null;
  }
}

//主页-他的主页信息
socialtopicpublicsfindOne(
  id,
) async {
  try {
    var res = await CommunityApi.instance().socialtopicpublicsfindOne(
      id,
    );

    // popUntil
    return res;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    return TopicdetailModel();
  }
}

///点赞-点赞帖子列表
sociallikepublicssocialLikeList(
  current,
  size,
  infoUid,
) async {
  try {
    var res = await CommunityApi.instance()
        .sociallikepublicssocialLikeList(current, size, infoUid);

    // popUntil
    return res;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    return null;
  }
}

///足迹NFT列表
marketgrowfootprintnftList(
  current,
  size,
) async {
  try {
    var res =
        await CommunityApi.instance().marketgrowfootprintnftList(current, size);

    // popUntil
    return res;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    return null;
  }
}

//取消喜欢列表
socialsociallikeunlikeList(data) async {
  try {
    await CommunityApi.instance().socialsociallikeunlikeList(data);
    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

///足迹合集列表
marketgrowfootprintcollectionList(
  current,
  size,
) async {
  try {
    var res = await CommunityApi.instance()
        .marketgrowfootprintcollectionList(current, size);

    // popUntil
    return res;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    return null;
  }
}

//删除足迹
marketgrowfootprintdel(idsMap) async {
  dio.FormData data = dio.FormData.fromMap(idsMap);
  try {
    await CommunityApi.instance().marketgrowfootprintdel(data);
    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

///帖子-列表查询
topicpageList(
  String currentPage,
  String pageSize,
  String keyWords,
  String memberId,
) async {
  var data = {
    'currentPage': currentPage,
    'pageSize': pageSize,
    'keyWords': keyWords,
    'memberId': memberId,
  };
  try {
    var res = await CommunityApi.instance().topicpageList(data);
    return res;
  } on dio.DioException catch (e) {
    print('topicpageList: e.error===${e.error}');
    return null;
  }
}

focusPageList(
  String currentPage,
  String pageSize,
  String keyWords,
  String memberId,
) async {
  var data = {
    'currentPage': currentPage,
    'pageSize': pageSize,
    'keyWords': keyWords,
    'memberId': memberId,
  };
  try {
    var res = await CommunityApi.instance().focusPageList(
        currentPage: currentPage,
        pageSize: pageSize,
        keyWords: keyWords,
        memberId: memberId);
    return res;
  } on dio.DioException catch (e) {
    print('topicpageList: e.error===${e.error}');
    return null;
  }
}

myFocusPageList(
  String currentPage,
  String pageSize,
  String keyWords,
  String memberId,
) async {
  var data = {
    'currentPage': currentPage,
    'pageSize': pageSize,
    'keyWords': keyWords,
    'memberId': memberId,
  };
  try {
    var res = await CommunityApi.instance().myCollectPage(data);
    return res;
  } on dio.DioException catch (e) {
    print('topicpageList: e.error===${e.error}');
    return null;
  }
}

///帖子-列表查询
topicCollectPage(
  String currentPage,
  String pageSize,
  String keyWords,
  String memberId,
) async {
  var data = {
    'currentPage': currentPage,
    'pageSize': pageSize,
    'keyWords': keyWords,
    'memberId': memberId,
  };
  try {
    var res = await CommunityApi.instance().topicCollectPage(data);
    return res;
  } on dio.DioException catch (e) {
    print('topicpageList: e.error===${e.error}');
    return null;
  }
}

///关注列表
socialsocialpostwatchlist(
  current,
  size,
  name,
  sortType,
) async {
  try {
    var res = await CommunityApi.instance().socialsocialpostwatchlist(
      current,
      size,
      name,
      sortType,
    );

    // popUntil
    return res;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    return null;
  }
}

//帖子详情
topicdetail(topicNo) async {
  var data = {'topicNo': topicNo};
  try {
    var res = await CommunityApi.instance().topicdetail(data);
    return res;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');

    return null;
  }
}

//帖子评论搜索分页查询
Future<CommunityCommentPageListModel?> commentpageList(
  String currentPage,
  String pageSize,
  String topicNo,
) async {
  try {
    CommunityCommentPageListModel? res = await CommunityApi.instance()
        .commentpageList(currentPage, pageSize, topicNo, null);
    res?.data ??= [];
    return res;
  } on dio.DioException catch (e) {
    return null;
  }
}

//帖子评论搜索分页查询
Future<CommunityCommentPageListModel?> commentHotPageList(
  String currentPage,
  String pageSize,
  String topicNo,
) async {
  try {
    CommunityCommentPageListModel? res = await CommunityApi.instance()
        .commentpageHotList(currentPage, pageSize, topicNo, null);
    res?.data ??= [];
    return res;
  } on dio.DioException catch (e) {
    return null;
  }
}

//查询帖子 二级回复 列表
Future<CommunityCommentPageListModel?> commentpageListTwoLevel(
    String currentPage,
    String pageSize,
    String? topicNo,
    String? commentNo) async {
  try {
    var res = await CommunityApi.instance()
        .commentpageList(currentPage, pageSize, topicNo, commentNo);

    // popUntil
    return res;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    return null;
  }
}

//关注-他的关注列表
socialsocialfollowpublicsfollowing(current, size, uid) async {
  print(uid);
  try {
    var res = await CommunityApi.instance()
        .socialsocialfollowpublicsfollowing(current, size, uid);
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

//关注-他的关注话题列表
socialsocialfollowpublicstopiclist(current, size, uid) async {
  print(uid);
  try {
    var res = await CommunityApi.instance()
        .socialsocialfollowpublicstopiclist(current, size, uid);
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

//关注-他的粉丝列表
socialsocialfollowpublicsfollowers(current, size, infoId) async {
  try {
    var res = await CommunityApi.instance()
        .socialsocialfollowpublicsfollowers(current, size, infoId);
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

//修改帖子权限
socialsocialpostupdatePermissionType(id) async {
  dio.FormData data = dio.FormData.fromMap({'id': id});
  try {
    await CommunityApi.instance().socialsocialpostupdatePermissionType(data);
    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

//删除帖子
socialsocialpostdel(id) async {
  try {
    await CommunityApi.instance().socialsocialpostdel({'id': id});
    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

topicDelete(String id) async {
  try {
    await CommunityApi.instance().deleteTopic(id);
    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

//删除评论
Future<bool> socialsocialpostcommentdel(id) async {
  try {
    await CommunityApi.instance().socialsocialpostcommentdel('$id');
    UIUtil.showSuccess(LocaleKeys.public12.tr);
    return true;
  } on dio.DioException catch (e) {
    return false;
  }
}

//删除评论
pinComment(id) async {
  try {
    await CommunityApi.instance().pinTopComment('$id');
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError(e.error);
    return false;
  }
}

Future<bool> likeComment(String commentNo) async {
  try {
    await CommunityApi.instance().likeNewOrCancel(commentNo);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError(e.error);
    return false;
  }
}

isCommentLike(String? commentNo) async {
  try {
    dynamic response =
        await CommunityApi.instance().isNewPraise(commentNo ?? '');
    return response == null;
  } on dio.DioException catch (e) {
    return false;
  }
}

//拉黑
blockMember(String userName, num uid, {Function? blockSuccessFun}) async {
  bool? res = await UIUtil.showConfirm(
    LocaleKeys.community14.tr,
    content: LocaleKeys.community32.trArgs([userName]),
  );
  if (res == true) {
    //status  0取消 1设置
    // type 0标星  1拉黑 2禁止跟单
    AFFollow.setTraceUserRelation(userId: uid, status: 1, types: 1)
        .then((value) {
      if (value == null) {
        UIUtil.showSuccess(LocaleKeys.community33.tr);
        Bus.getInstance().emit(EventType.blockUser, uid);

        if (blockSuccessFun != null) {
          blockSuccessFun();
        }
      } else {
        UIUtil.showError(LocaleKeys.community34.tr);
      }
    });
  }
}

//回复帖子
Future<CommunityCommentItem?> commentReplyPost(
  String topicNo,
  String commentContent,
) async {
  try {
    CommunityCommentItem? res = await CommunityApi.instance()
        .topicCommentAdd(topicNo, null, commentContent);
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return null;
  }
}

//回复评论
Future<CommunityCommentItem?> commentReplyComment(
    topicNo, preCommentNo, commentContent) async {
  try {
    var res = await CommunityApi.instance()
        .topicCommentAdd(topicNo, preCommentNo, commentContent);
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return null;
  }
}

//是否关注 1用户 2话题
socialsocialfollowfindOneByTypeAndInfoId(type, infoId) async {
  try {
    var res = await CommunityApi.instance()
        .socialsocialfollowfindOneByTypeAndInfoId(type, infoId);
    if (res != null) {
      return true;
    } else {
      return false;
    }
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

//关注 1用户 2话题
Future<bool> socialsocialfollowfollow(TopicdetailModel? model) async {
  //219777
  try {
    EasyLoading.show();
    model?.focusOn == true
        ? await CommunityApi.instance().cancelFocus(model?.memberId)
        : await CommunityApi.instance().addUIDFocus(model?.memberId);
    model?.focusOn = !(model.focusOn ?? false);
    EasyLoading.dismiss();

    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

socialFollow(bool focusOn, int? uid) async {
  try {
    var res = focusOn == true
        ? await CommunityApi.instance().cancelFocus(uid)
        : await CommunityApi.instance().addUIDFocus(uid);
    // model?.focusOn = !(model.focusOn ?? false);

    return res == null;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

//取消关注  1用户 2话题
socialsocialfollowunfollow(type, infoId) async {
  print(type);
  print(infoId);
  dio.FormData data = dio.FormData.fromMap({'type': type, 'infoId': infoId});
  try {
    var res = await CommunityApi.instance().socialsocialfollowunfollow(data);

    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

//帖子点赞或取消点赞
topicpraisenewOrCancel(topicNo) async {
  var data = {'topicNo': topicNo};
  try {
    await CommunityApi.instance().topicpraisenewOrCancel(data);

    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    UIUtil.showError('${e.error}');
    return false;
  }
}

Future<bool> likeNewOrCancel(num commentNo) async {
  try {
    dynamic response =
        await CommunityApi.instance().likeNewOrCancel('${commentNo}');
    return response == null;
  } on dio.DioException catch (e) {
    print(e.error);
    UIUtil.showError('${e.error}');
    return false;
  }
}

//帖子收藏或取消收藏
topiccollectnewOrCancel(topicNo) async {
  var data = {'topicNo': topicNo};
  try {
    await CommunityApi.instance().topiccollectnewOrCancel(data);

    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    UIUtil.showError('${e.error}');
    return false;
  }
}

pinTopic(num id) async {
  var data = {'id': id};
  try {
    await CommunityApi.instance().pinTopPost('$id');

    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    UIUtil.showError('${e.error}');
    return false;
  }
}

//搜收藏-查询单个收藏信息
growcollectfindOneByTypeAndInfoIdAndInfoIdFull(
  type,
  infoId,
  infoIdFull,
) async {
//  type	ture	int	收藏类型：1帖子 2NFT 3合集
// infoId	ture	String	被收藏信息id(类型为2的时候：tokenid)
// infoIdFull	false	String	被收藏信息详细(类型为2的时候：token
  if (Get.find<UserGetx>().isLogin) {
    try {
      var res = await CommunityApi.instance()
          .growcollectfindOneByTypeAndInfoIdAndInfoIdFull(
        type,
        infoId,
        infoIdFull,
      );
      return res;
    } on dio.DioException catch (e) {
      print(e.error);
      // UIUtil.showError('${e.error}');
      return null;
    }
  }
}

//搜索 -查询用户列表
marketuserpublicsgetList(current, size, keyword) async {
  dio.FormData data = dio.FormData.fromMap(
      {'current': current, 'size': size, 'keyword': keyword});
  try {
    var res = await CommunityApi.instance().marketuserpublicsgetList(data);
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return false;
  }
}

//搜索 -搜索词 列表
marketgrowsrchpublicsgetList() async {
  try {
    var res = await CommunityApi.instance().marketgrowsrchpublicsgetList();
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return null;
  }
}

//搜索 -帖子列表 --24小时内热门帖子
socialsocialpostpublicsdayHotList(
  current,
  size,
) async {
  try {
    var res = await CommunityApi.instance().socialsocialpostpublicsdayHotList(
      current,
      size,
    );
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return null;
  }
}

//私聊_用户举报类型列表查询
socialreportsTypelist() async {
  try {
    var res = await CommunityApi.instance().socialreportsTypelist();
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    // UIUtil.showError('${e.error}');
    return null;
  }
}

//私聊_用户举报提交
socialreportsadd(type, content, picUrls, toUserId) async {
  dio.FormData data = dio.FormData.fromMap({
    'type': type,
    'content': content,
    'picUrls': picUrls,
    'toUserId': toUserId,
  });
  try {
    await CommunityApi.instance().socialreportsadd(data);
    return 1;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    // UIUtil.showError('${e.error}');
    return 0;
  }
}
