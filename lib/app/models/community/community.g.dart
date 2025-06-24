// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketuserblackdetailModel _$MarketuserblackdetailModelFromJson(
        Map<String, dynamic> json) =>
    MarketuserblackdetailModel(
      bePullBlackState: json['bePullBlackState'],
      pullBlackState: json['pullBlackState'],
    );

Map<String, dynamic> _$MarketuserblackdetailModelToJson(
        MarketuserblackdetailModel instance) =>
    <String, dynamic>{
      'bePullBlackState': instance.bePullBlackState,
      'pullBlackState': instance.pullBlackState,
    };

SocialreportsTypelistModel _$SocialreportsTypelistModelFromJson(
        Map<String, dynamic> json) =>
    SocialreportsTypelistModel(
      name: json['name'],
      type: json['type'],
      sortOrder: json['sortOrder'],
      status: json['status'],
      deleted: json['deleted'],
      select: json['select'] ?? false,
    );

Map<String, dynamic> _$SocialreportsTypelistModelToJson(
        SocialreportsTypelistModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'sortOrder': instance.sortOrder,
      'status': instance.status,
      'deleted': instance.deleted,
      'select': instance.select,
    };

SocialsocialpostpublicsfindOneTranslateModel
    _$SocialsocialpostpublicsfindOneTranslateModelFromJson(
            Map<String, dynamic> json) =>
        SocialsocialpostpublicsfindOneTranslateModel(
          id: json['id'],
          sourceLang: json['sourceLang'],
          postId: json['postId'],
          targetLang: json['targetLang'],
          targetName: json['targetName'],
          targetDescription: json['targetDescription'],
          updateBy: json['updateBy'],
          createTime: json['createTime'],
          updateTime: json['updateTime'],
          createBy: json['createBy'],
        );

Map<String, dynamic> _$SocialsocialpostpublicsfindOneTranslateModelToJson(
        SocialsocialpostpublicsfindOneTranslateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceLang': instance.sourceLang,
      'postId': instance.postId,
      'targetLang': instance.targetLang,
      'targetName': instance.targetName,
      'targetDescription': instance.targetDescription,
      'updateBy': instance.updateBy,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'createBy': instance.createBy,
    };

MarketgrowsrchpublicsgetListModel _$MarketgrowsrchpublicsgetListModelFromJson(
        Map<String, dynamic> json) =>
    MarketgrowsrchpublicsgetListModel(
      content: json['content'],
    );

Map<String, dynamic> _$MarketgrowsrchpublicsgetListModelToJson(
        MarketgrowsrchpublicsgetListModel instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

TopicdetailModel _$TopicdetailModelFromJson(Map<String, dynamic> json) =>
    TopicdetailModel(
      id: json['id'],
      topicNo: json['topicNo'],
      sortNum: json['sortNum'],
      topicDate: json['topicDate'],
      topicTitle: json['topicTitle'],
      topicContent: json['topicContent'],
      topicStatus: json['topicStatus'],
      quoteTopicId: json['quoteTopicId'] as String?,
      memberId: json['memberId'],
      memberHeadUrl: json['memberHeadUrl'],
      memberName: json['memberName'],
      memberEmail: json['memberEmail'],
      focusOn: json['focusOn'] as bool?,
      topicDateTime: (json['topicDateTime'] as num?)?.toInt(),
      levelType: (json['levelType'] as num?)?.toInt(),
      isTranslate: json['isTranslate'] as bool?,
      voteStatus: json['voteStatus'] as bool?,
      memberType: json['memberType'],
      trendDirection: json['trendDirection'] as String?,
      auditBy: json['auditBy'],
      quoteNum: (json['quoteNum'] as num?)?.toInt(),
      symbolList: json['symbolList'] as List<dynamic>?,
      votingNum: json['votingNum'] as num?,
      shareNum: (json['shareNum'] as num?)?.toInt(),
      pageViewNum: (json['pageViewNum'] as num?)?.toInt(),
      auditTime: json['auditTime'],
      auditMemo: json['auditMemo'],
      createBy: json['createBy'],
      votingOptions: (json['votingOptions'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : VoteRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastVoteOption: json['lastVoteOption'] as String?,
      createTime: json['createTime'],
      updateBy: json['updateBy'],
      updateTime: json['updateTime'],
      commentNum: json['commentNum'],
      voteRemainTime: json['voteRemainTime'] as String?,
      praiseNum: json['praiseNum'],
      forwardNum: json['forwardNum'],
      collectNum: json['collectNum'],
      praiseFlag: json['praiseFlag'],
      collectFlag: json['collectFlag'],
      topFlag: json['topFlag'],
      showFlag: json['showFlag'],
      type: json['type'],
      coverInfo: json['coverInfo'] == null
          ? null
          : ScTopicFileVoListModel.fromJson(
              json['coverInfo'] as Map<String, dynamic>),
      picList: (json['picList'] as List<dynamic>?)
          ?.map(
              (e) => ScTopicFileVoListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      videoList: (json['videoList'] as List<dynamic>?)
          ?.map(
              (e) => ScTopicFileVoListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      scTopicCommentVoList: (json['scTopicCommentVoList'] as List<dynamic>?)
          ?.map((e) =>
              ScTopicCommentVoListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      interestPeopleList: (json['interestPeopleList'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : InterestPeopleListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cmsDatatList: (json['cmsDatatList'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CmsAdvertListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      flagIcon: json['flagIcon'] as String?,
      organizationIcon: json['organizationIcon'] as String?,
    )..quoteCache = json['quoteCache'] == null
        ? null
        : TopicdetailModel.fromJson(json['quoteCache'] as Map<String, dynamic>);

Map<String, dynamic> _$TopicdetailModelToJson(TopicdetailModel instance) =>
    <String, dynamic>{
      'quoteCache': instance.quoteCache,
      'id': instance.id,
      'topicNo': instance.topicNo,
      'sortNum': instance.sortNum,
      'isTranslate': instance.isTranslate,
      'topicDate': instance.topicDate,
      'topicTitle': instance.topicTitle,
      'topicContent': instance.topicContent,
      'topicStatus': instance.topicStatus,
      'memberId': instance.memberId,
      'memberHeadUrl': instance.memberHeadUrl,
      'memberName': instance.memberName,
      'memberEmail': instance.memberEmail,
      'memberType': instance.memberType,
      'voteRemainTime': instance.voteRemainTime,
      'votingNum': instance.votingNum,
      'topicDateTime': instance.topicDateTime,
      'trendDirection': instance.trendDirection,
      'quoteNum': instance.quoteNum,
      'lastVoteOption': instance.lastVoteOption,
      'shareNum': instance.shareNum,
      'quoteTopicId': instance.quoteTopicId,
      'pageViewNum': instance.pageViewNum,
      'voteStatus': instance.voteStatus,
      'symbolList': instance.symbolList,
      'votingOptions': instance.votingOptions,
      'auditBy': instance.auditBy,
      'auditTime': instance.auditTime,
      'auditMemo': instance.auditMemo,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'commentNum': instance.commentNum,
      'praiseNum': instance.praiseNum,
      'forwardNum': instance.forwardNum,
      'collectNum': instance.collectNum,
      'praiseFlag': instance.praiseFlag,
      'collectFlag': instance.collectFlag,
      'topFlag': instance.topFlag,
      'showFlag': instance.showFlag,
      'type': instance.type,
      'focusOn': instance.focusOn,
      'levelType': instance.levelType,
      'flagIcon': instance.flagIcon,
      'organizationIcon': instance.organizationIcon,
      'coverInfo': instance.coverInfo,
      'picList': instance.picList,
      'videoList': instance.videoList,
      'scTopicCommentVoList': instance.scTopicCommentVoList,
      'interestPeopleList': instance.interestPeopleList,
      'cmsDatatList': instance.cmsDatatList,
    };

PublicListModel _$PublicListModelFromJson(Map<String, dynamic> json) =>
    PublicListModel(
      data: json['data'],
      total: json['total'],
      pageSize: json['pageSize'],
      currentPage: json['currentPage'],
      totalPage: json['totalPage'],
    );

Map<String, dynamic> _$PublicListModelToJson(PublicListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'pageSize': instance.pageSize,
      'currentPage': instance.currentPage,
      'totalPage': instance.totalPage,
    };

SocialPostVoModel _$SocialPostVoModelFromJson(Map<String, dynamic> json) =>
    SocialPostVoModel(
      id: json['id'],
      uid: json['uid'],
      type: json['type'],
      infoId: json['infoId'],
      uinfoIdFullid: json['uinfoIdFullid'],
      createTime: json['createTime'],
      infoIdFull: json['infoIdFull'],
      collectionName: json['collectionName'],
      collectionImageUrl: json['collectionImageUrl'],
      collectionBannerImageUrl: json['collectionBannerImageUrl'],
      collectionSlug: json['collectionSlug'],
      collectionDescription: json['collectionDescription'],
      nftName: json['nftName'],
      nftImage: json['nftImage'],
      nftPriceMin: json['nftPriceMin'],
      token: json['token'],
      checked: json['checked'] as bool? ?? false,
      socialPostVo: json['socialPostVo'] == null
          ? null
          : TopicdetailModel.fromJson(
              json['socialPostVo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SocialPostVoModelToJson(SocialPostVoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'type': instance.type,
      'infoId': instance.infoId,
      'uinfoIdFullid': instance.uinfoIdFullid,
      'createTime': instance.createTime,
      'infoIdFull': instance.infoIdFull,
      'collectionName': instance.collectionName,
      'collectionImageUrl': instance.collectionImageUrl,
      'collectionBannerImageUrl': instance.collectionBannerImageUrl,
      'collectionSlug': instance.collectionSlug,
      'collectionDescription': instance.collectionDescription,
      'nftName': instance.nftName,
      'nftImage': instance.nftImage,
      'nftPriceMin': instance.nftPriceMin,
      'token': instance.token,
      'checked': instance.checked,
      'socialPostVo': instance.socialPostVo,
    };

ScTopicFileVoListModel _$ScTopicFileVoListModelFromJson(
        Map<String, dynamic> json) =>
    ScTopicFileVoListModel(
      id: json['id'],
      topicNo: json['topicNo'],
      sortNum: json['sortNum'],
      fileType: json['fileType'],
      fileNo: json['fileNo'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
      fileExtend: json['fileExtend'],
      createBy: json['createBy'],
      createTime: json['createTime'],
      platformId: json['platformId'],
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ScTopicFileVoListModelToJson(
        ScTopicFileVoListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topicNo': instance.topicNo,
      'sortNum': instance.sortNum,
      'fileType': instance.fileType,
      'fileNo': instance.fileNo,
      'fileName': instance.fileName,
      'fileUrl': instance.fileUrl,
      'fileExtend': instance.fileExtend,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'platformId': instance.platformId,
      'width': instance.width,
      'height': instance.height,
    };

ScTopicCommentVoListModel _$ScTopicCommentVoListModelFromJson(
        Map<String, dynamic> json) =>
    ScTopicCommentVoListModel(
      id: json['id'],
      commentNo: json['commentNo'],
      topicNo: json['topicNo'],
      commentContent: json['commentContent'],
      memberId: json['memberId'],
      memberName: json['memberName'],
      memberEmail: json['memberEmail'],
      memberType: json['memberType'],
      preCommentNo: json['preCommentNo'],
      createBy: json['createBy'],
      createTime: json['createTime'],
      preMemberId: json['preMemberId'],
      preMemberName: json['preMemberName'],
      preMemberEmail: json['preMemberEmail'],
      preMemberHeadUrl: json['preMemberHeadUrl'],
    );

Map<String, dynamic> _$ScTopicCommentVoListModelToJson(
        ScTopicCommentVoListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'commentNo': instance.commentNo,
      'topicNo': instance.topicNo,
      'commentContent': instance.commentContent,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'memberEmail': instance.memberEmail,
      'memberType': instance.memberType,
      'preCommentNo': instance.preCommentNo,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'preMemberId': instance.preMemberId,
      'preMemberName': instance.preMemberName,
      'preMemberEmail': instance.preMemberEmail,
      'preMemberHeadUrl': instance.preMemberHeadUrl,
    };

TopicpageListModelnftList _$TopicpageListModelnftListFromJson(
        Map<String, dynamic> json) =>
    TopicpageListModelnftList(
      id: json['id'],
      postId: json['postId'],
      type: json['type'],
      resourceUrl: json['resourceUrl'],
      resourceUrlFull: json['resourceUrlFull'],
      updateBy: json['updateBy'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
      createBy: json['createBy'],
      version: json['version'],
      nftName: json['nftName'],
      nftImage: json['nftImage'],
      nftPriceMin: json['nftPriceMin'],
      token: json['token'],
      tokenId: json['tokenId'],
      infoIdFull: json['infoIdFull'],
      remarks: json['remarks'] as String?,
      infoId: json['infoId'],
    );

Map<String, dynamic> _$TopicpageListModelnftListToJson(
        TopicpageListModelnftList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'type': instance.type,
      'resourceUrl': instance.resourceUrl,
      'resourceUrlFull': instance.resourceUrlFull,
      'updateBy': instance.updateBy,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'createBy': instance.createBy,
      'version': instance.version,
      'nftName': instance.nftName,
      'nftImage': instance.nftImage,
      'nftPriceMin': instance.nftPriceMin,
      'token': instance.token,
      'tokenId': instance.tokenId,
      'infoIdFull': instance.infoIdFull,
      'infoId': instance.infoId,
      'remarks': instance.remarks,
    };

ApppublicsitemsfindOneMobel _$ApppublicsitemsfindOneMobelFromJson(
        Map<String, dynamic> json) =>
    ApppublicsitemsfindOneMobel(
      nftItems: json['nftItems'] == null
          ? null
          : CommunityItemListMobel.fromJson(
              json['nftItems'] as Map<String, dynamic>),
      nft: json['nft'] == null
          ? null
          : ApppublicsitemsfindOneNftMobel.fromJson(
              json['nft'] as Map<String, dynamic>),
      nftCategoryName: json['nftCategoryName'],
      memberOwnerIcon: json['memberOwnerIcon'],
      memberOwnerNickname: json['memberOwnerNickname'],
      memberCreatorIcon: json['memberCreatorIcon'],
      memberCreatorNickname: json['memberCreatorNickname'],
    );

Map<String, dynamic> _$ApppublicsitemsfindOneMobelToJson(
        ApppublicsitemsfindOneMobel instance) =>
    <String, dynamic>{
      'nftItems': instance.nftItems,
      'nft': instance.nft,
      'nftCategoryName': instance.nftCategoryName,
      'memberOwnerIcon': instance.memberOwnerIcon,
      'memberOwnerNickname': instance.memberOwnerNickname,
      'memberCreatorIcon': instance.memberCreatorIcon,
      'memberCreatorNickname': instance.memberCreatorNickname,
    };

ApppublicsitemsfindOneNftMobel _$ApppublicsitemsfindOneNftMobelFromJson(
        Map<String, dynamic> json) =>
    ApppublicsitemsfindOneNftMobel(
      id: json['id'],
      createBy: json['createBy'],
      updateBy: json['updateBy'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
      tokenId: json['tokenId'],
      name: json['name'],
      discription: json['discription'],
      url: json['url'],
      token: json['token'],
      creator: json['creator'],
      owner: json['owner'],
      standard: json['standard'],
      contenttype: json['contenttype'],
      royaltie: json['royaltie'],
      contractId: json['contractId'],
      categoryId: json['categoryId'],
      externalLink: json['externalLink'],
      tags: json['tags'],
      blockchain: json['blockchain'],
      medialinks: json['medialinks'],
      quantity: json['quantity'],
      isShow: json['isShow'],
      status: json['status'],
      isSync: json['isSync'],
      txHash: json['txHash'],
      animUrl: json['animUrl'],
      metadataUrl: json['metadataUrl'],
      metadataContent: json['metadataContent'],
      getMetaTimes: json['getMetaTimes'],
      image: json['image'],
    );

Map<String, dynamic> _$ApppublicsitemsfindOneNftMobelToJson(
        ApppublicsitemsfindOneNftMobel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createBy': instance.createBy,
      'updateBy': instance.updateBy,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'tokenId': instance.tokenId,
      'name': instance.name,
      'discription': instance.discription,
      'url': instance.url,
      'token': instance.token,
      'creator': instance.creator,
      'owner': instance.owner,
      'standard': instance.standard,
      'contenttype': instance.contenttype,
      'royaltie': instance.royaltie,
      'contractId': instance.contractId,
      'categoryId': instance.categoryId,
      'externalLink': instance.externalLink,
      'tags': instance.tags,
      'blockchain': instance.blockchain,
      'medialinks': instance.medialinks,
      'quantity': instance.quantity,
      'isShow': instance.isShow,
      'status': instance.status,
      'isSync': instance.isSync,
      'txHash': instance.txHash,
      'animUrl': instance.animUrl,
      'metadataUrl': instance.metadataUrl,
      'metadataContent': instance.metadataContent,
      'getMetaTimes': instance.getMetaTimes,
      'image': instance.image,
    };

CommunityItemMobel _$CommunityItemMobelFromJson(Map<String, dynamic> json) =>
    CommunityItemMobel(
      records: (json['records'] as List<dynamic>?)
          ?.map(
              (e) => CommunityItemListMobel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'],
      size: json['size'],
      current: json['current'],
      pages: json['pages'],
      orders: json['orders'],
      optimizeCountSql: json['optimizeCountSql'],
      searchCount: json['searchCount'],
      countId: json['countId'],
      maxLimit: json['maxLimit'],
    );

Map<String, dynamic> _$CommunityItemMobelToJson(CommunityItemMobel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'pages': instance.pages,
      'orders': instance.orders,
      'optimizeCountSql': instance.optimizeCountSql,
      'searchCount': instance.searchCount,
      'countId': instance.countId,
      'maxLimit': instance.maxLimit,
    };

CommunityItemListMobel _$CommunityItemListMobelFromJson(
        Map<String, dynamic> json) =>
    CommunityItemListMobel(
      image: json['image'],
      title: json['title'],
      connect: json['connect'],
      assetsImage: json['assetsImage'],
      videoPlayerController: json['videoPlayerController'],
      createBy: json['createBy'],
      updateBy: json['updateBy'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
      contractId: json['contractId'],
      sourceLang: json['sourceLang'],
      nftId: json['nftId'],
      uid: json['uid'],
      name: json['name'],
      buyType: json['buyType'],
      description: json['description'],
      imgUrl: json['imgUrl'],
      itemType: json['itemType'],
      onsell: json['onsell'],
      sellQuantity: json['sellQuantity'],
      quantity: json['quantity'],
      starttimel: json['starttimel'],
      endtimel: json['endtimel'],
      itemPrice: json['itemPrice'],
      itemFees: json['itemFees'],
      itemRoyalty: json['itemRoyalty'],
      address: json['address'],
      isSync: json['isSync'],
      tokenId: json['tokenId'],
      version: json['version'],
      likes: json['likes'],
      unickname: json['unickname'],
      uicon: json['uicon'],
      comments: json['comments'],
      collects: json['collects'],
      shares: json['shares'],
      follow: json['follow'],
      coverUrl: json['coverUrl'] as String?,
      permissionType: json['permissionType'],
    )
      ..id = json['id']
      ..collect = json['collect'];

Map<String, dynamic> _$CommunityItemListMobelToJson(
        CommunityItemListMobel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'connect': instance.connect,
      'assetsImage': instance.assetsImage,
      'videoPlayerController': instance.videoPlayerController,
      'id': instance.id,
      'createBy': instance.createBy,
      'updateBy': instance.updateBy,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'contractId': instance.contractId,
      'sourceLang': instance.sourceLang,
      'nftId': instance.nftId,
      'uid': instance.uid,
      'name': instance.name,
      'buyType': instance.buyType,
      'description': instance.description,
      'imgUrl': instance.imgUrl,
      'itemType': instance.itemType,
      'onsell': instance.onsell,
      'sellQuantity': instance.sellQuantity,
      'quantity': instance.quantity,
      'starttimel': instance.starttimel,
      'endtimel': instance.endtimel,
      'itemPrice': instance.itemPrice,
      'itemFees': instance.itemFees,
      'itemRoyalty': instance.itemRoyalty,
      'address': instance.address,
      'isSync': instance.isSync,
      'tokenId': instance.tokenId,
      'version': instance.version,
      'likes': instance.likes,
      'unickname': instance.unickname,
      'uicon': instance.uicon,
      'collect': instance.collect,
      'comments': instance.comments,
      'collects': instance.collects,
      'shares': instance.shares,
      'follow': instance.follow,
      'permissionType': instance.permissionType,
      'coverUrl': instance.coverUrl,
    };
