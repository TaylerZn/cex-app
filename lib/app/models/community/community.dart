import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:nt_app_flutter/app/models/community/activity.dart';
import 'package:nt_app_flutter/app/models/community/interest.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';

import '../../modules/community/enum.dart';
import 'greed_voting.dart';
part 'community.g.dart';

@JsonSerializable()
class MarketuserblackdetailModel {
  var bePullBlackState;
  var pullBlackState;

  MarketuserblackdetailModel({this.bePullBlackState, this.pullBlackState});

  factory MarketuserblackdetailModel.fromJson(Map<String, dynamic> json) =>
      _$MarketuserblackdetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$MarketuserblackdetailModelToJson(this);
}

@JsonSerializable()
class SocialreportsTypelistModel {
  var name;
  var type;
  var sortOrder;
  var status;
  var deleted;
  var select;

  SocialreportsTypelistModel(
      {this.name,
      this.type,
      this.sortOrder,
      this.status,
      this.deleted,
      this.select = false});

  factory SocialreportsTypelistModel.fromJson(Map<String, dynamic> json) =>
      _$SocialreportsTypelistModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocialreportsTypelistModelToJson(this);
}

@JsonSerializable()
class SocialsocialpostpublicsfindOneTranslateModel {
  var id;
  var sourceLang;
  var postId;
  var targetLang;
  var targetName;
  var targetDescription;
  var updateBy;
  var createTime;
  var updateTime;
  var createBy;
  SocialsocialpostpublicsfindOneTranslateModel({
    var id,
    this.sourceLang,
    this.postId,
    this.targetLang,
    this.targetName,
    this.targetDescription,
    this.updateBy,
    this.createTime,
    this.updateTime,
    this.createBy,
  });

  factory SocialsocialpostpublicsfindOneTranslateModel.fromJson(
          Map<String, dynamic> json) =>
      _$SocialsocialpostpublicsfindOneTranslateModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SocialsocialpostpublicsfindOneTranslateModelToJson(this);
}

@JsonSerializable()
class MarketgrowsrchpublicsgetListModel {
  var content;
  MarketgrowsrchpublicsgetListModel({this.content});

  factory MarketgrowsrchpublicsgetListModel.fromJson(
          Map<String, dynamic> json) =>
      _$MarketgrowsrchpublicsgetListModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MarketgrowsrchpublicsgetListModelToJson(this);
}

enum TopicdetailModelType {
  normal, //普通帖子
  graph, //行情
  recommended, // 热门话题
  voting,
  none//投票
}

class TopicdetailModelWrapper {
  TopicdetailModelType type = TopicdetailModelType.normal;
  TopicdetailModel model = TopicdetailModel();
  TopicdetailModelWrapper(this.model,
      {this.type = TopicdetailModelType.normal});
}

@JsonSerializable()
class TopicdetailModel {
  TopicdetailModel? quoteCache; //缓存的引用对象
  var id;
  var topicNo;
  var sortNum;
  bool? isTranslate;
  var topicDate;
  var topicTitle;
  var topicContent;
  var topicStatus;
  var memberId;
  var memberHeadUrl;
  var memberName;
  var memberEmail;
  var memberType;
  String? voteRemainTime;
  num? votingNum;
  int? topicDateTime;
  String? trendDirection;
  int? quoteNum;
  String? lastVoteOption;
  int? shareNum;
  String? quoteTopicId;
  int? pageViewNum;
  bool? voteStatus;
  List<dynamic>? symbolList;
  List<VoteRecord?>? votingOptions;

  var auditBy;
  var auditTime;
  var auditMemo;
  var createBy;
  var createTime;
  var updateBy;
  var updateTime;
  var commentNum;

  var praiseNum;
  var forwardNum;
  var collectNum;
  var praiseFlag;
  var collectFlag;
  var topFlag;
  var showFlag;
  var type;
  bool? focusOn;
  int? levelType;
  String? flagIcon;
  String? organizationIcon;

  ScTopicFileVoListModel? coverInfo;
  List<ScTopicFileVoListModel>? picList;
  List<ScTopicFileVoListModel>? videoList;
  List<ScTopicCommentVoListModel>? scTopicCommentVoList;
  List<InterestPeopleListModel?>? interestPeopleList;
  List<CmsAdvertListModel?>? cmsDatatList;

  bool get isUp => trendDirection == TrendDirection.up.key;

  TopicdetailModel({
    this.id,
    this.topicNo,
    this.sortNum,
    this.topicDate,
    this.topicTitle,
    this.topicContent,
    this.topicStatus,
    this.quoteTopicId,
    this.memberId,
    this.memberHeadUrl,
    this.memberName,
    this.memberEmail,
    this.focusOn,
    this.topicDateTime,
    this.levelType,
    this.isTranslate,
    this.voteStatus,
    this.memberType,
    this.trendDirection,
    this.auditBy,
    this.quoteNum,
    this.symbolList,
    this.votingNum,
    this.shareNum,
    this.pageViewNum,
    this.auditTime,
    this.auditMemo,
    this.createBy,
    this.votingOptions,
    this.lastVoteOption,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.commentNum,
    this.voteRemainTime,
    this.praiseNum,
    this.forwardNum,
    this.collectNum,
    this.praiseFlag,
    this.collectFlag,
    this.topFlag,
    this.showFlag,
    this.type,

    this.coverInfo,
    this.picList,
    this.videoList,
    this.scTopicCommentVoList,
    this.interestPeopleList,
    this.cmsDatatList,
    this.flagIcon,
    this.organizationIcon,
  });

  factory TopicdetailModel.fromJson(Map<String, dynamic> json) =>
      _$TopicdetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicdetailModelToJson(this);

  String get displayTime => RelativeDateFormat.format(MyTimeUtil.timestampToDate(topicDateTime?.toInt() ?? 0));

}

@JsonSerializable()
class PublicListModel {
  var data;
  var total;
  var pageSize;
  var currentPage;
  var totalPage;
  PublicListModel(
      {this.data, this.total, this.pageSize, this.currentPage, this.totalPage});

  factory PublicListModel.fromJson(Map<String, dynamic> json) =>
      _$PublicListModelFromJson(json);
  Map<String, dynamic> toJson() => _$PublicListModelToJson(this);
}

@JsonSerializable()
class SocialPostVoModel {
  var id;
  var uid;
  var type;
  var infoId;
  var uinfoIdFullid;
  var createTime;
  var infoIdFull;
  var collectionName;
  var collectionImageUrl;
  var collectionBannerImageUrl;
  var collectionSlug;
  var collectionDescription;
  var nftName;
  var nftImage;
  var nftPriceMin;
  var token;
  bool checked;
  TopicdetailModel? socialPostVo;
  SocialPostVoModel({
    this.id,
    this.uid,
    this.type,
    this.infoId,
    this.uinfoIdFullid,
    this.createTime,
    this.infoIdFull,
    this.collectionName,
    this.collectionImageUrl,
    this.collectionBannerImageUrl,
    this.collectionSlug,
    this.collectionDescription,
    this.nftName,
    this.nftImage,
    this.nftPriceMin,
    this.token,
    this.checked = false,
    this.socialPostVo,
  });

  factory SocialPostVoModel.fromJson(Map<String, dynamic> json) =>
      _$SocialPostVoModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocialPostVoModelToJson(this);
}

//帖子文件Model
@JsonSerializable()
class ScTopicFileVoListModel {
  var id;
  var topicNo;
  var sortNum;
  var fileType;
  var fileNo;
  var fileName;
  var fileUrl;
  var fileExtend;
  var createBy;
  var createTime;
  var platformId;
  double? width;
  double? height;
  ScTopicFileVoListModel({
    this.id,
    this.topicNo,
    this.sortNum,
    this.fileType,
    this.fileNo,
    this.fileName,
    this.fileUrl,
    this.fileExtend,
    this.createBy,
    this.createTime,
    this.platformId,
    this.width,
    this.height,
  });

  factory ScTopicFileVoListModel.fromJson(Map<String, dynamic> json) =>
      _$ScTopicFileVoListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScTopicFileVoListModelToJson(this);
}

//帖子评论Model
@JsonSerializable()
class ScTopicCommentVoListModel {
  var id;
  var commentNo;
  var topicNo;
  var commentContent;
  var memberId;
  var memberName;
  var memberEmail;
  var memberType;
  var preCommentNo;
  var createBy;
  var createTime;
  var preMemberId;
  var preMemberName;
  var preMemberEmail;
  var preMemberHeadUrl;
  ScTopicCommentVoListModel({
    this.id,
    this.commentNo,
    this.topicNo,
    this.commentContent,
    this.memberId,
    this.memberName,
    this.memberEmail,
    this.memberType,
    this.preCommentNo,
    this.createBy,
    this.createTime,
    this.preMemberId,
    this.preMemberName,
    this.preMemberEmail,
    this.preMemberHeadUrl,
  });

  factory ScTopicCommentVoListModel.fromJson(Map<String, dynamic> json) =>
      _$ScTopicCommentVoListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScTopicCommentVoListModelToJson(this);
}

@JsonSerializable()
class TopicpageListModelnftList {
  var id;
  var postId;
  var type;
  var resourceUrl;
  var resourceUrlFull;
  var updateBy;
  var createTime;
  var updateTime;
  var createBy;
  var version;
  var nftName;
  var nftImage;
  var nftPriceMin;
  var token;
  var tokenId;
  var infoIdFull;
  var infoId;
  String? remarks;
  @JsonKey(ignore: true)
  List<RemarkModel>? remarkList;
  @JsonKey(ignore: true)
  Size? realImgSize;
  @JsonKey(ignore: true)
  Offset? imgStartOffset;
  @JsonKey(ignore: true)
  Offset? imgOffset;
  @JsonKey(ignore: true)
  Rect? imageRect;

  TopicpageListModelnftList(
      {this.id,
      this.postId,
      this.type,
      this.resourceUrl,
      this.resourceUrlFull,
      this.updateBy,
      this.createTime,
      this.updateTime,
      this.createBy,
      this.version,
      this.nftName,
      this.nftImage,
      this.nftPriceMin,
      this.token,
      this.tokenId,
      this.infoIdFull,
      this.remarks,
      this.infoId});

  factory TopicpageListModelnftList.fromJson(Map<String, dynamic> json) =>
      _$TopicpageListModelnftListFromJson(json);
  Map<String, dynamic> toJson() => _$TopicpageListModelnftListToJson(this);
}

///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class RemarkModel {
/*
{
  "nft_index": 0,
  "x": 30.1,
  "y": 30.1
}
*/

  int? nftIndex;
  double? x;
  double? y;
  double realX = 0.0;
  double realY = 0.0;
  String? token;
  String? tokenId;
  String? nftName;

  RemarkModel({
    this.nftIndex,
    this.x,
    this.y,
  });
  RemarkModel.fromJson(Map<String, dynamic> json) {
    nftIndex = json['nft_index']?.toInt();
    x = double.tryParse('${json['x']}') ?? 0.0;
    y = double.tryParse('${json['y']}') ?? 0.0;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nft_index'] = nftIndex;
    data['x'] = x;
    data['y'] = y;
    return data;
  }
}

// @JsonSerializable()
// class TopiccommentpageListModel {
//   String? commentContent;
//   String? preMemberType;
//   String? memberType;
//   String? createBy;
//   DateTime? createTime;
//   String? preMemberEmail;
//   String? preMemberName;
//   num? id;
//   String? commentNo;
//   String? preMemberHeadUrl;
//   String? topicNo;
//   num memberId;
//   String? memberName;
//   String? memberEmail;
//   dynamic memberHeadUrl;
//   String? preCommentNo;
//   num? preMemberId;
//   num? commentLevel;
//   // 闪烁
//   bool shouldFlash;
//   TwoLevelListVoIPageModel? childComments;
//   TopiccommentpageListModel({
//     this.preMemberType,
//     this.memberType,
//     this.createBy,
//     this.createTime,
//     this.preMemberEmail,
//     this.preMemberName,
//     this.preMemberHeadUrl,
//     this.preMemberId,
//     this.preCommentNo,
//     this.memberHeadUrl,
//     this.memberEmail,
//     this.memberName,
//     required this.memberId,
//     this.topicNo,
//     this.commentContent,
//     this.commentNo,
//     this.id,
//     this.shouldFlash = false,
//     this.childComments,
//   });

//   factory TopiccommentpageListModel.fromJson(Map<String, dynamic> json) =>
//       _$TopiccommentpageListModelFromJson(json);
//   Map<String, dynamic> toJson() => _$TopiccommentpageListModelToJson(this);
// }

// @JsonSerializable()
// class TwoLevelListVoIPageModel {
//   List<TwoLevelListVoIPageModelRecords>? data;
//   var total;
//   var pageSize;
//   var currentPage;
//   var totalPage;
//   TwoLevelListVoIPageModel({
//     this.data,
//     this.total,
//     this.pageSize,
//     this.currentPage,
//     this.totalPage,
//   });

//   factory TwoLevelListVoIPageModel.fromJson(Map<String, dynamic> json) =>
//       _$TwoLevelListVoIPageModelFromJson(json);
//   Map<String, dynamic> toJson() => _$TwoLevelListVoIPageModelToJson(this);
// }

// @JsonSerializable()
// class TwoLevelListVoIPageModelRecords {
//   var id;
//   var commentNo;
//   var topicNo;
//   var commentContent;
//   var memberId;
//   var memberName;
//   var memberEmail;
//   var memberType;
//   var memberHeadUrl;
//   var preCommentNo;
//   var preMemberId;
//   var preMemberName;
//   var preMemberEmail;
//   var preMemberHeadUrl;
//   var createBy;
//   var createTime;
//   TwoLevelListVoIPageModelRecords({
//     this.id,
//     this.commentNo,
//     this.topicNo,
//     this.commentContent,
//     this.memberId,
//     this.memberName,
//     this.memberEmail,
//     this.memberType,
//     this.memberHeadUrl,
//     this.preCommentNo,
//     this.preMemberId,
//     this.preMemberName,
//     this.preMemberEmail,
//     this.preMemberHeadUrl,
//     this.createBy,
//     this.createTime,
//   });

//   factory TwoLevelListVoIPageModelRecords.fromJson(Map<String, dynamic> json) =>
//       _$TwoLevelListVoIPageModelRecordsFromJson(json);
//   Map<String, dynamic> toJson() =>
//       _$TwoLevelListVoIPageModelRecordsToJson(this);
// }

@JsonSerializable()
class ApppublicsitemsfindOneMobel {
  CommunityItemListMobel? nftItems;
  ApppublicsitemsfindOneNftMobel? nft;
  var nftCategoryName;
  var memberOwnerIcon; //拥有者头像
  var memberOwnerNickname;
  var memberCreatorIcon; //铸造人头像
  var memberCreatorNickname;

  ApppublicsitemsfindOneMobel({
    this.nftItems,
    this.nft,
    this.nftCategoryName,
    this.memberOwnerIcon, //拥有者头像
    this.memberOwnerNickname,
    this.memberCreatorIcon, //铸造人头像
    this.memberCreatorNickname,
  });

  factory ApppublicsitemsfindOneMobel.fromJson(Map<String, dynamic> json) =>
      _$ApppublicsitemsfindOneMobelFromJson(json);
  Map<String, dynamic> toJson() => _$ApppublicsitemsfindOneMobelToJson(this);
}

@JsonSerializable()
class ApppublicsitemsfindOneNftMobel {
  var id;
  var createBy;
  var updateBy;
  var createTime;
  var updateTime;
  var tokenId;
  var name;
  var discription;
  var url;
  var token;
  var creator;
  var owner;
  var standard;
  var contenttype;
  var royaltie;
  var contractId;
  var categoryId;
  var externalLink;
  var tags;
  var blockchain;
  var medialinks;
  var quantity;
  var isShow;
  var status;
  var isSync;
  var txHash;
  var animUrl;
  var metadataUrl;
  var metadataContent;
  var getMetaTimes;
  var image;

  ApppublicsitemsfindOneNftMobel(
      {this.id,
      this.createBy,
      this.updateBy,
      this.createTime,
      this.updateTime,
      this.tokenId,
      this.name,
      this.discription,
      this.url,
      this.token,
      this.creator,
      this.owner,
      this.standard,
      this.contenttype,
      this.royaltie,
      this.contractId,
      this.categoryId,
      this.externalLink,
      this.tags,
      this.blockchain,
      this.medialinks,
      this.quantity,
      this.isShow,
      this.status,
      this.isSync,
      this.txHash,
      this.animUrl,
      this.metadataUrl,
      this.metadataContent,
      this.getMetaTimes,
      this.image});

  factory ApppublicsitemsfindOneNftMobel.fromJson(Map<String, dynamic> json) =>
      _$ApppublicsitemsfindOneNftMobelFromJson(json);
  Map<String, dynamic> toJson() => _$ApppublicsitemsfindOneNftMobelToJson(this);
}

@JsonSerializable()
class CommunityItemMobel {
  List<CommunityItemListMobel>? records;
  var total;
  var size;
  var current;
  var pages;
  var orders;
  var optimizeCountSql;
  var searchCount;
  var countId;
  var maxLimit;

  CommunityItemMobel({
    this.records,
    this.total,
    this.size,
    this.current,
    this.pages,
    this.orders,
    this.optimizeCountSql,
    this.searchCount,
    this.countId,
    this.maxLimit,
  });

  factory CommunityItemMobel.fromJson(Map<String, dynamic> json) =>
      _$CommunityItemMobelFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityItemMobelToJson(this);
}

@JsonSerializable()
class CommunityItemListMobel {
  var image; //图片
  var title; //标题
  var connect; //内容
  var assetsImage; //本地图片
  var videoPlayerController;
  var id;
  var createBy;
  var updateBy;
  var createTime;
  var updateTime;
  var contractId;
  var sourceLang;
  var nftId;
  var uid;
  var name;
  var buyType;
  var description;
  var imgUrl;
  var itemType;
  var onsell;
  var sellQuantity;
  var quantity;
  var starttimel;
  var endtimel;
  var itemPrice;
  var itemFees;
  var itemRoyalty;
  var address;
  var isSync;
  var tokenId;
  var version;
  var likes;
  var unickname;
  var uicon;
  var collect;
  var comments;
  var collects;
  var shares;
  var follow;
  var permissionType;
  String? coverUrl;
  CommunityItemListMobel(
      {this.image,
      this.title, //币种名称
      this.connect, //币种ID
      this.assetsImage, //操作类型
      this.videoPlayerController,
      this.createBy,
      this.updateBy,
      this.createTime,
      this.updateTime,
      this.contractId,
      this.sourceLang,
      this.nftId,
      this.uid,
      this.name,
      this.buyType,
      this.description,
      this.imgUrl,
      this.itemType,
      this.onsell,
      this.sellQuantity,
      this.quantity,
      this.starttimel,
      this.endtimel,
      this.itemPrice,
      this.itemFees,
      this.itemRoyalty,
      this.address,
      this.isSync,
      this.tokenId,
      this.version,
      this.likes,
      this.unickname,
      this.uicon,
      this.comments,
      this.collects,
      this.shares,
      this.follow,
      this.coverUrl,
      this.permissionType});

  factory CommunityItemListMobel.fromJson(Map<String, dynamic> json) =>
      _$CommunityItemListMobelFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityItemListMobelToJson(this);
}
