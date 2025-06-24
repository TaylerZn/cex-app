import 'package:json_annotation/json_annotation.dart';
part 'home.g.dart';

@JsonSerializable()
class NoAuthmemberhelpCenterModel {
  var label;
  var answer;
  NoAuthmemberhelpCenterModel({
    this.label,
    this.answer,
  });

  factory NoAuthmemberhelpCenterModel.fromJson(Map<String, dynamic> json) =>
      _$NoAuthmemberhelpCenterModelFromJson(json);
  Map<String, dynamic> toJson() => _$NoAuthmemberhelpCenterModelToJson(this);
}

@JsonSerializable()
class MemberinviteInfoModel {
  var inviteUrl;
  var inviteCode;
  var income;
  var inviteNum;
  var totalIncome;
  var yesterdayIncome;
  var directInvite;
  var indirectInvite;
  var directIncome;
  var indirectIncome;
  MemberinviteInfoModel({
    this.inviteUrl,
    this.inviteCode,
    this.income,
    this.inviteNum,
    this.totalIncome,
    this.yesterdayIncome,
    this.directInvite,
    this.indirectInvite,
    this.directIncome,
    this.indirectIncome,
  });

  factory MemberinviteInfoModel.fromJson(Map<String, dynamic> json) =>
      _$MemberinviteInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$MemberinviteInfoModelToJson(this);
}

@JsonSerializable()
class MarketdecibelpublicsfindListModel {
  List<MarketdecibelpublicsfindListModelRecords>? records;
  var total;
  var pages;
  var size;
  var current;
  MarketdecibelpublicsfindListModel({
    this.records,
    this.total,
    this.size,
    this.current,
  });

  factory MarketdecibelpublicsfindListModel.fromJson(
          Map<String, dynamic> json) =>
      _$MarketdecibelpublicsfindListModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MarketdecibelpublicsfindListModelToJson(this);
}

@JsonSerializable()
class MarketdecibelpublicsfindListModelRecords {
  var id;
  var timel;
  var timetype;
  var nftIndex;
  var buyerNum24h;
  var sellerNum24h;
  var volumeTotal;
  var volumeIncrement;
  var nftCount;
  var nftCountIncrement;
  var foundryCount;
  var foundryCountIncrement;
  var transactionCount;
  var transactionCountIncrement;
  var walletCount;
  var walletCountIncrement;
  var maxBlockNumber;
  var createTime;
  var updateTime;
  var createBy;
  var updateBy;
  MarketdecibelpublicsfindListModelRecords({
    this.id,
    this.timel,
    this.timetype,
    this.nftIndex,
    this.buyerNum24h,
    this.sellerNum24h,
    this.volumeTotal,
    this.volumeIncrement,
    this.nftCount,
    this.nftCountIncrement,
    this.foundryCount,
    this.foundryCountIncrement,
    this.transactionCount,
    this.transactionCountIncrement,
    this.walletCount,
    this.walletCountIncrement,
    this.maxBlockNumber,
    this.createTime,
    this.updateTime,
    this.createBy,
    this.updateBy,
  });

  factory MarketdecibelpublicsfindListModelRecords.fromJson(
          Map<String, dynamic> json) =>
      _$MarketdecibelpublicsfindListModelRecordsFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MarketdecibelpublicsfindListModelRecordsToJson(this);
}

@JsonSerializable()
class MashoppingcartlistModel {
  var records;
  var total;
  var size;
  var current;
  MashoppingcartlistModel({
    this.records,
    this.total,
    this.size,
    this.current,
  });

  factory MashoppingcartlistModel.fromJson(Map<String, dynamic> json) =>
      _$MashoppingcartlistModelFromJson(json);
  Map<String, dynamic> toJson() => _$MashoppingcartlistModelToJson(this);
}

@JsonSerializable()
class collectionpublicslistModel {
  List<collectionpublicslistModelRecords>? records;
  var total;
  var size;
  var current;
  var pages;
  collectionpublicslistModel({
    this.records,
    this.total,
    this.size,
    this.current,
    this.pages,
  });

  factory collectionpublicslistModel.fromJson(Map<String, dynamic> json) =>
      _$collectionpublicslistModelFromJson(json);
  Map<String, dynamic> toJson() => _$collectionpublicslistModelToJson(this);
}

@JsonSerializable()
class collectionpublicslistModelRecords {
  var id;
  var name;
  var imageUrl;
  var bannerImageUrl;
  var slug;
  var holders;
  var floorPrice;
  var volume;
  var oneDayVolume;
  var token;
  var nftCount;
  collectionpublicslistModelRecords(
      {this.id,
      this.name,
      this.imageUrl,
      this.bannerImageUrl,
      this.slug,
      this.holders,
      this.floorPrice,
      this.volume,
      this.oneDayVolume,
      this.token,
      this.nftCount});

  factory collectionpublicslistModelRecords.fromJson(
          Map<String, dynamic> json) =>
      _$collectionpublicslistModelRecordsFromJson(json);
  Map<String, dynamic> toJson() =>
      _$collectionpublicslistModelRecordsToJson(this);
}

@JsonSerializable()
class nftitemsorderModel {
  List<nftitemsorderModelRecords>? records;
  var total;
  var pages;
  var size;
  var current;
  nftitemsorderModel({
    this.total,
    this.pages,
    this.size,
    this.current,
  });

  factory nftitemsorderModel.fromJson(Map<String, dynamic> json) =>
      _$nftitemsorderModelFromJson(json);
  Map<String, dynamic> toJson() => _$nftitemsorderModelToJson(this);
}

@JsonSerializable()
class nftitemsorderModelRecords {
  var fromAddress; //String	卖方地址
  var toAddress; //String	买方用户地址
  var marketLevel; //String	购买类型：1一级市场 2二级市场
  var sellType; //String	类型：1直购 2拍卖 3抽签
  var eventName; //String	状态：Match //交易， Cancel//下架，Transfer //721划转，TransferSingle//1155划转
  var buyQuantity; //String	购买数量
  var price; //String	价格
  var fees;
  var image;
  var createTime;
  var eventType;
  String? name;
  int? sorttimel;
  String? token;
  String? tokenId;
  growUserModel? fromAddressUser;
  growUserModel? toAddressUser;

  nftitemsorderModelRecords(
      {this.fromAddress, //String	卖方地址
      this.toAddress, //String	买方用户地址
      this.marketLevel, //String	购买类型：1一级市场 2二级市场
      this.sellType, //String	类型：1直购 2拍卖 3抽签
      this.eventName, //String	状态：Match //交易， Cancel//下架，Transfer //721划转，TransferSingle//1155划转
      this.buyQuantity, //String	购买数量
      this.price, //String	价格
      this.fees,
      this.image,
      this.createTime,
      this.name,
      this.sorttimel,
      this.fromAddressUser,
      this.toAddressUser,
      this.eventType,
      this.token,
      this.tokenId});

  factory nftitemsorderModelRecords.fromJson(Map<String, dynamic> json) =>
      _$nftitemsorderModelRecordsFromJson(json);
  Map<String, dynamic> toJson() => _$nftitemsorderModelRecordsToJson(this);
}

@JsonSerializable()
class MashoppingcartlistModelRecords {
  var name;
  var token;
  var imageUrl;
  bool checked;
  bool onSell;
  List<MashoppingcartlistModelRecordsList>? list;
  MashoppingcartlistModelRecords(
      {this.name,
      this.token,
      this.imageUrl,
      this.list,
      this.checked = false,
      this.onSell = true});

  factory MashoppingcartlistModelRecords.fromJson(Map<String, dynamic> json) =>
      _$MashoppingcartlistModelRecordsFromJson(json);
  Map<String, dynamic> toJson() => _$MashoppingcartlistModelRecordsToJson(this);
}

@JsonSerializable()
class MashoppingcartlistModelRecordsList {
  var id;
  var token;
  var tokenId;
  var name;
  var image;
  var sellType;
  var onSell;
  var price;
  var oldprice;
  var orderContent;
  var chainId;
  var quantity;
  var sellQuantity;
  var standard;
  var nftitemslistingsid;
  var marketId;
  bool checked;

  MashoppingcartlistModelRecordsList(
      {this.id,
      this.token,
      this.tokenId,
      this.name,
      this.image,
      this.sellType,
      this.onSell,
      this.price,
      this.oldprice,
      this.orderContent,
      this.chainId,
      this.quantity,
      this.sellQuantity,
      this.standard,
      this.nftitemslistingsid,
      this.marketId,
      this.checked = false});

  factory MashoppingcartlistModelRecordsList.fromJson(
          Map<String, dynamic> json) =>
      _$MashoppingcartlistModelRecordsListFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MashoppingcartlistModelRecordsListToJson(this);
}

@JsonSerializable()
class growUserModel {
  var id;
  var nickname;
  var icon;
  growUserModel({
    this.id,
    this.nickname,
    this.icon,
  });

  factory growUserModel.fromJson(Map<String, dynamic> json) =>
      _$growUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$growUserModelToJson(this);
}

@JsonSerializable()
class findOneByTokenIdModel {
  findOneByTokenIdModelNft? nft;
  var marketName;
  var marketLogo;
  var contractName;
  var contractLogo;
  var nftitems;
  var nftcategoryname;
  growUserModel? creatorUser;
  findOneByTokenIdModel(
      {this.nft,
      this.marketName,
      this.marketLogo,
      this.contractName,
      this.contractLogo,
      this.nftitems,
      this.nftcategoryname,
      this.creatorUser});

  factory findOneByTokenIdModel.fromJson(Map<String, dynamic> json) =>
      _$findOneByTokenIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$findOneByTokenIdModelToJson(this);
}

@JsonSerializable()
class findOneByTokenIdModelNft {
  var id;
  var token;
  var tokenId;
  var name;
  var description;
  var url;
  var imageUrl;
  var bannerImageUrl;
  var creator;
  var royaltie;
  var owner;
  var standard;
  var contentType;
  var creators;
  var royalties;
  var contractId;
  var categoryId;
  var blockchain;
  var supply;
  var status;
  var isSync;
  var txHash;
  var image;
  var animationUrl;
  var externalUrl;
  var metadataUrl;
  var metadataContent;
  var getMetaTimes;
  var signatures;
  var mintsContent;
  var verify;
  var totalSales;
  var priceMin;
  var sellQuantity;
  var lazy;
  var updateBy;
  var createTime;
  var updateTime;
  var createBy;
  var version;
  var attributes;
  var chainId;
  var marketId;
  var itemOnSell;
  var itemSellQuantity;
  var itemQuantity;
  var itemPrice;
  var categoryNames;
  var infoId;
  var infoIdFull;
  var holders;
  var oneDayVolume;
  var volume;
  var floorPrice;
  findOneByTokenIdModelNft({
    this.id,
    this.token,
    this.tokenId,
    this.name,
    this.description,
    this.url,
    this.imageUrl,
    this.bannerImageUrl,
    this.creator,
    this.royaltie,
    this.owner,
    this.standard,
    this.contentType,
    this.creators,
    this.royalties,
    this.contractId,
    this.categoryId,
    this.blockchain,
    this.supply,
    this.status,
    this.isSync,
    this.txHash,
    this.image,
    this.animationUrl,
    this.externalUrl,
    this.metadataUrl,
    this.metadataContent,
    this.getMetaTimes,
    this.signatures,
    this.mintsContent,
    this.verify,
    this.totalSales,
    this.priceMin,
    this.sellQuantity,
    this.lazy,
    this.updateBy,
    this.createTime,
    this.updateTime,
    this.createBy,
    this.version,
    this.attributes,
    this.chainId,
    this.marketId,
    this.itemOnSell,
    this.itemSellQuantity,
    this.itemQuantity,
    this.itemPrice,
    this.categoryNames,
    this.infoId,
    this.infoIdFull,
    this.holders,
    this.oneDayVolume,
    this.volume,
    this.floorPrice,
  });
  factory findOneByTokenIdModelNft.fromJson(Map<String, dynamic> json) =>
      _$findOneByTokenIdModelNftFromJson(json);
  Map<String, dynamic> toJson() => _$findOneByTokenIdModelNftToJson(this);
}

@JsonSerializable()
class findOneByTokenIdModelNftAttributes {
  var trait_type;
  var value;
  var display_type;
  var max_value;
  var trait_count;
  var order;
  findOneByTokenIdModelNftAttributes({
    this.trait_type,
    this.value,
    this.display_type,
    this.max_value,
    this.trait_count,
    this.order,
  });
  factory findOneByTokenIdModelNftAttributes.fromJson(
          Map<String, dynamic> json) =>
      _$findOneByTokenIdModelNftAttributesFromJson(json);
  Map<String, dynamic> toJson() =>
      _$findOneByTokenIdModelNftAttributesToJson(this);
}

@JsonSerializable()
class BannerpublicspageModel {
  List<BannerpublicspageModelRecords>? records;
  var total;
  var size;
  var current;
  var pages;
  BannerpublicspageModel({this.total, this.size, this.current, this.pages});

  factory BannerpublicspageModel.fromJson(Map<String, dynamic> json) =>
      _$BannerpublicspageModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerpublicspageModelToJson(this);
}

@JsonSerializable()
class BannerpublicspageModelRecords {
  var id;
  var type;
  var name;
  var icon;
  var imgUrl;
  var image;
  var link;
  var sort;
  var valueId;
  var starttime;
  var endTime;
  var width;
  var high;
  var description;
  BannerpublicspageModelRecords(
      {this.id,
      this.type,
      this.name,
      this.icon,
      this.imgUrl,
      this.image,
      this.link,
      this.sort,
      this.valueId,
      this.starttime,
      this.endTime,
      this.width,
      this.high,
      this.description});

  factory BannerpublicspageModelRecords.fromJson(Map<String, dynamic> json) =>
      _$BannerpublicspageModelRecordsFromJson(json);
  Map<String, dynamic> toJson() => _$BannerpublicspageModelRecordsToJson(this);
}

@JsonSerializable()
class NftprojectslistModel {
  List<NftprojectslistModelRecords>? records;
  var total;
  var size;
  var current;
  var orders;
  var optimizeCountSql;
  var searchCount;
  var countId;
  var maxLimit;
  var pages;
  NftprojectslistModel({
    this.total,
    this.size,
    this.current,
    this.orders,
    this.optimizeCountSql,
    this.searchCount,
    this.countId,
    this.maxLimit,
    this.pages,
  });

  factory NftprojectslistModel.fromJson(Map<String, dynamic> json) =>
      _$NftprojectslistModelFromJson(json);
  Map<String, dynamic> toJson() => _$NftprojectslistModelToJson(this);
}
// @JsonSerializable()
// class MarketmadicpublicsgetInfoModel {
//   var total;
//   var size;
//   var current;
//   var orders;
//   var optimizeCountSql;
//   var searchCount;
//   var countId;
//   var maxLimit;
//   var pages;

//   var seaport;
//         var shareLinkNft;
//         var marketRegister:marketId;
//         var conduitKey;
//         var tradeFees;
//          var Handlingfee;
//         var seapo1.4tMarketId;
//         var conduit;
//         var shareLinkCollection;
//         var shareLinkPost;
//         var grow-aggregator;
//         var zoneHash;
//         var zone;
//         var domainName;
//         var seaport_vertion;
//         var seapot1.1MarketId;
//   MarketmadicpublicsgetInfoModel({
//     this.total,
//     this.size,
//     this.current,
//     this.orders,
//     this.optimizeCountSql,
//     this.searchCount,
//     this.countId,
//     this.maxLimit,
//     this.pages,
//   });

//   factory MarketmadicpublicsgetInfoModel.fromJson(Map<String, dynamic> json) =>
//       _$MarketmadicpublicsgetInfoModelFromJson(json);
//   Map<String, dynamic> toJson() => _$MarketmadicpublicsgetInfoModelToJson(this);
// }

@JsonSerializable()
class NftSelectList {
  var name;
  var bool;
  NftSelectList({
    this.bool,
    this.name,
  });

  factory NftSelectList.fromJson(Map<String, dynamic> json) =>
      _$NftSelectListFromJson(json);
  Map<String, dynamic> toJson() => _$NftSelectListToJson(this);
}

@JsonSerializable()
class NftprojectslistModelRecords {
  var id;
  var name;
  var logo;
  var description;
  var price;
  var total;
  var starttime;
  var link;
  var twitter;
  var discord;
  var mintlink;
  var category;
  NftprojectslistModelRecords({
    this.id,
    this.name,
    this.logo,
    this.description,
    this.price,
    this.total,
    this.starttime,
    this.link,
    this.twitter,
    this.discord,
    this.mintlink,
    this.category,
  });

  factory NftprojectslistModelRecords.fromJson(Map<String, dynamic> json) =>
      _$NftprojectslistModelRecordsFromJson(json);
  Map<String, dynamic> toJson() => _$NftprojectslistModelRecordsToJson(this);
}

@JsonSerializable()
class BeimeipromoteleaderboardModel {
  var fInvalidateIntroCount; //推广人数
  var floginName; //账号
  BeimeipromoteleaderboardModel({
    this.fInvalidateIntroCount,
    this.floginName,
  });

  factory BeimeipromoteleaderboardModel.fromJson(Map<String, dynamic> json) =>
      _$BeimeipromoteleaderboardModelFromJson(json);
  Map<String, dynamic> toJson() => _$BeimeipromoteleaderboardModelToJson(this);
}

@JsonSerializable()
class BeimeihomeoptsModel {
  var fid;
  var fconfigid;
  var fcoinid;
  var forderid;
  var fuid;
  var ftype;
  var fstatus;
  var famount;
  var faddtime;
  var faddtimel;
  var fupdatetimel;
  var usdtValue;
  var version;
  BeimeihomeoptsModel(
      {this.fid,
      this.fconfigid,
      this.fcoinid,
      this.forderid,
      this.fuid,
      this.ftype,
      this.fstatus,
      this.famount,
      this.faddtime,
      this.faddtimel,
      this.fupdatetimel,
      this.version,
      this.usdtValue});

  factory BeimeihomeoptsModel.fromJson(Map<String, dynamic> json) =>
      _$BeimeihomeoptsModelFromJson(json);
  Map<String, dynamic> toJson() => _$BeimeihomeoptsModelToJson(this);
}

@JsonSerializable()
class BeimeiconfigfindPartitionListModel {
  var ftradecategoryid;
  var fcategoryname;
  BeimeiconfigfindPartitionListModel({
    this.ftradecategoryid,
    this.fcategoryname,
  });

  factory BeimeiconfigfindPartitionListModel.fromJson(
          Map<String, dynamic> json) =>
      _$BeimeiconfigfindPartitionListModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$BeimeiconfigfindPartitionListModelToJson(this);
}

@JsonSerializable()
class BeimeiconfigfindCoinListModel {
  var fcoinname;
  var fcoinid;
  var selected;
  BeimeiconfigfindCoinListModel({this.fcoinname, this.fcoinid, this.selected});

  factory BeimeiconfigfindCoinListModel.fromJson(Map<String, dynamic> json) =>
      _$BeimeiconfigfindCoinListModelFromJson(json);
  Map<String, dynamic> toJson() => _$BeimeiconfigfindCoinListModelToJson(this);
}

@JsonSerializable()
class BeimeiorderfindListModel {
  List<BeimeiorderfindListContentModel>? content;
  var totalPages;
  var totalElements;
  var number;
  var size;
  var numberOfElements;
  var prevPage;
  var nextPage;
  BeimeiorderfindListModel({
    this.content,
    this.totalPages,
    this.totalElements,
    this.number,
    this.size,
    this.numberOfElements,
    this.prevPage,
    this.nextPage,
  });

  factory BeimeiorderfindListModel.fromJson(Map<String, dynamic> json) =>
      _$BeimeiorderfindListModelFromJson(json);
  Map<String, dynamic> toJson() => _$BeimeiorderfindListModelToJson(this);
}

@JsonSerializable()
class BeimeiorderfindListContentModel {
  var fid; //订单ID
  var fcoinid; //币种ID
  var fprice; //认购价格
  var fcount; //认购数量
  var ftype; //类型 1普通 2推广
  var fstatus; //状态：0、默认  1、完成  2、取消
  var faddtime; //添加时间
  var faddtimel; //添加时间L
  var fendtimel; //结束时间L
  var fupdatetime; //修改时间
  var incomeAll; //查询累计收益
  var incomeToday; //查询今日收益
  var incomeAllUSDT; //查询累计收益转USDT
  var incomeTodayUSDT; //查询今日收益转USDT
  BeimeiconfigfindList? fconfig;
  BeimeiorderfindListContentModel({
    this.fid, //订单ID
    this.fcoinid, //币种ID
    this.fprice, //认购价格
    this.fcount, //认购数量
    this.ftype, //类型 1普通 2推广
    this.fstatus, //状态：0、默认  1、完成  2、取消
    this.faddtime, //添加时间
    this.faddtimel, //添加时间L
    this.fendtimel, //结束时间L
    this.fupdatetime, //修改时间
    this.fconfig,
    this.incomeAll, //查询累计收益
    this.incomeToday, //查询今日收益
    this.incomeAllUSDT, //查询累计收益转USDT
    this.incomeTodayUSDT, //查询今日收益转USDT
  });

  factory BeimeiorderfindListContentModel.fromJson(Map<String, dynamic> json) =>
      _$BeimeiorderfindListContentModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$BeimeiorderfindListContentModelToJson(this);
}

@JsonSerializable()
class BeimeiconfigfindList {
  var fid; //项目ID
  var fname; //类型名称
  var ftradecategoryid; //
  var fcoinid; //币种ID
  var fcoinname; //币种名称
  var fprice; //单份价格
  var fpower; //单份算力
  var fminingday; //日产出
  var felectricfees; //矿机电费
  var ffees; //管理费
  var fstarttimel; //开始时间
  var fendtimel; //结束时间
  var fstatus; //状态：0、禁用；1、启用
  var ftype; //类型 1普通 2推广
  var fproduct; //产品说明
  var fproject; //项目说明
  var frisk; //风险提示
  var fpowerwaste; //工作功耗
  var ficon; //矿机头像
  var fsort;
  var fcount;
  var fcycletime; //矿机周期(单位/天)

  BeimeiconfigfindList(
      {this.fid, //项目ID
      this.fname, //类型名称
      this.ftradecategoryid, //
      this.fcoinid, //币种ID
      this.fcoinname, //币种名称
      this.fprice, //单份价格
      this.fpower, //单份算力
      this.fminingday, //日产出
      this.felectricfees, //矿机电费
      this.ffees, //管理费
      this.fstarttimel, //开始时间
      this.fendtimel, //结束时间
      this.fstatus, //状态：0、禁用；1、启用
      this.ftype, //类型 1普通 2推广
      this.fproduct, //产品说明
      this.fproject, //项目说明
      this.frisk, //风险提示
      this.fpowerwaste,
      this.ficon, //矿机头像
      this.fsort,
      this.fcount = 1,
      this.fcycletime});

  factory BeimeiconfigfindList.fromJson(Map<String, dynamic> json) =>
      _$BeimeiconfigfindListFromJson(json);
  Map<String, dynamic> toJson() => _$BeimeiconfigfindListToJson(this);
}

@JsonSerializable()
class LaunchPageModel {
  var addTime;
  var cotentType;
  var forder; //排序字段
  var fstatus;
  var ftype; //首页类型:0小图广告,1大图广告
  var id;
  var imgDesc; //图片说明    副标题
  var imgName; //图片名称   主标题
  var imgUrl; //图片路径
  var jumpUrl; //跳转地址

  LaunchPageModel({
    this.addTime,
    this.cotentType,
    this.forder, //排序字段
    this.fstatus,
    this.ftype, //首页类型:0小图广告,1大图广告
    this.id,
    this.imgDesc, //图片说明    副标题
    this.imgName, //图片名称   主标题
    this.imgUrl, //图片路径
    this.jumpUrl, //跳转地址
  });

  factory LaunchPageModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchPageModelFromJson(json);
  Map<String, dynamic> toJson() => _$LaunchPageModelToJson(this);
}

@JsonSerializable()
class BeimeiconfigfindListContent {
  List<BeimeiconfigfindList>? content;
  var totalPages;
  var totalElements;
  var number;
  var size;
  var numberOfElements;
  var prevPage;
  var nextPage;
  BeimeiconfigfindListContent({
    this.content,
    this.totalPages,
    this.totalElements,
    this.number,
    this.size,
    this.numberOfElements,
    this.prevPage,
    this.nextPage,
  });

  factory BeimeiconfigfindListContent.fromJson(Map<String, dynamic> json) =>
      _$BeimeiconfigfindListContentFromJson(json);
  Map<String, dynamic> toJson() => _$BeimeiconfigfindListContentToJson(this);
}

@JsonSerializable()
class orderContentModel {
  var next;
  var previous;
  List<orderContentModelOrders>? orders;
  orderContentModel({
    this.next,
    this.previous,
    this.orders,
  });

  factory orderContentModel.fromJson(Map<String, dynamic> json) =>
      _$orderContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$orderContentModelToJson(this);
}

@JsonSerializable()
class orderContentModelOrders {
  orderContentModelOrdersProtocolData? protocol_data;
  var protocol_address;
  orderContentModelOrders({this.protocol_data, this.protocol_address});

  factory orderContentModelOrders.fromJson(Map<String, dynamic> json) =>
      _$orderContentModelOrdersFromJson(json);
  Map<String, dynamic> toJson() => _$orderContentModelOrdersToJson(this);
}

@JsonSerializable()
class orderContentModelOrdersProtocolData {
  orderContentModelOrdersProtocolDataParameters? parameters;
  var signature;
  orderContentModelOrdersProtocolData({
    this.parameters,
    this.signature,
  });

  factory orderContentModelOrdersProtocolData.fromJson(
          Map<String, dynamic> json) =>
      _$orderContentModelOrdersProtocolDataFromJson(json);
  Map<String, dynamic> toJson() =>
      _$orderContentModelOrdersProtocolDataToJson(this);
}

@JsonSerializable()
class orderContentModelOrdersProtocolDataParameters {
  var offerer;
  List<orderContentModelOrdersProtocolDataParametersOffer>? offer;
  List<orderContentModelOrdersProtocolDataParametersConsideration>?
      consideration;
  var startTime;
  var endTime;
  var orderType;
  var zone;
  var zoneHash;
  var salt;
  var conduitKey;
  var totalOriginalConsiderationItems;
  var counter;

  orderContentModelOrdersProtocolDataParameters({
    this.offerer,
    this.offer,
    this.consideration,
    this.startTime,
    this.endTime,
    this.orderType,
    this.zone,
    this.zoneHash,
    this.salt,
    this.conduitKey,
    this.totalOriginalConsiderationItems,
    this.counter,
  });

  factory orderContentModelOrdersProtocolDataParameters.fromJson(
          Map<String, dynamic> json) =>
      _$orderContentModelOrdersProtocolDataParametersFromJson(json);
  Map<String, dynamic> toJson() =>
      _$orderContentModelOrdersProtocolDataParametersToJson(this);
}

@JsonSerializable()
class orderContentModelOrdersProtocolDataParametersConsideration {
  var itemType;
  var token;
  var identifierOrCriteria;
  var startAmount;
  var endAmount;
  var recipient;
  orderContentModelOrdersProtocolDataParametersConsideration({
    this.itemType,
    this.token,
    this.identifierOrCriteria,
    this.startAmount,
    this.endAmount,
    this.recipient,
  });

  factory orderContentModelOrdersProtocolDataParametersConsideration.fromJson(
          Map<String, dynamic> json) =>
      _$orderContentModelOrdersProtocolDataParametersConsiderationFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$orderContentModelOrdersProtocolDataParametersConsiderationToJson(this);
}

@JsonSerializable()
class orderContentModelOrdersProtocolDataParametersOffer {
  var itemType;
  var token;
  var identifierOrCriteria;
  var startAmount;
  var endAmount;
  orderContentModelOrdersProtocolDataParametersOffer({
    this.itemType,
    this.token,
    this.identifierOrCriteria,
    this.startAmount,
    this.endAmount,
  });

  factory orderContentModelOrdersProtocolDataParametersOffer.fromJson(
          Map<String, dynamic> json) =>
      _$orderContentModelOrdersProtocolDataParametersOfferFromJson(json);
  Map<String, dynamic> toJson() =>
      _$orderContentModelOrdersProtocolDataParametersOfferToJson(this);
}

@JsonSerializable()
class CollectionKLineModel {
  String? id;
  int? timel;
  int? timetype;
  String? token;
  String? slug;
  int? chainId;
  int? marketId;
  var volume;
  int? holders;
  var floorPrice;
  var oneDayVolume;
  var oneDayAveragePrice;
  var sevenDayVolume;
  var thirtyDayVolume;
  String? categoryIds;
  int? nftCount;
  String? updateBy;
  String? createTime;
  String? updateTime;
  String? createBy;

  CollectionKLineModel({
    this.id,
    this.timel,
    this.timetype,
    this.token,
    this.slug,
    this.chainId,
    this.marketId,
    this.volume,
    this.holders,
    this.floorPrice,
    this.oneDayVolume,
    this.oneDayAveragePrice,
    this.sevenDayVolume,
    this.thirtyDayVolume,
    this.categoryIds,
    this.nftCount,
    this.updateBy,
    this.createTime,
    this.updateTime,
    this.createBy,
  });
  factory CollectionKLineModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionKLineModelFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionKLineModelToJson(this);
}

@JsonSerializable()
class MarketAiItemModel {
  var id;
  var position;
  var type;
  var name;
  var nameEn;
  var ossId;
  var picUrl;
  var link;
  var appLink;
  var sort;
  var valueId;
  var content;
  var startTime;
  var endTime;
  var width;
  var high;
  var enabled;
  var createTime;
  var updateTime;
  var deleted;
  var createBy;
  var updateBy;
  var title;
  var subtitle;
  var categoryType;

  MarketAiItemModel({
    this.id,
    this.position,
    this.type,
    this.name,
    this.nameEn,
    this.ossId,
    this.picUrl,
    this.link,
    this.appLink,
    this.sort,
    this.valueId,
    this.content,
    this.startTime,
    this.endTime,
    this.width,
    this.high,
    this.enabled,
    this.createTime,
    this.updateTime,
    this.deleted,
    this.createBy,
    this.updateBy,
    this.title,
    this.subtitle,
    this.categoryType,
  });

  factory MarketAiItemModel.fromJson(Map<String, dynamic> json) =>
      _$MarketAiItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$MarketAiItemModelToJson(this);
}
