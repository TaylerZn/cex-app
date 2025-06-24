// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoAuthmemberhelpCenterModel _$NoAuthmemberhelpCenterModelFromJson(
        Map<String, dynamic> json) =>
    NoAuthmemberhelpCenterModel(
      label: json['label'],
      answer: json['answer'],
    );

Map<String, dynamic> _$NoAuthmemberhelpCenterModelToJson(
        NoAuthmemberhelpCenterModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'answer': instance.answer,
    };

MemberinviteInfoModel _$MemberinviteInfoModelFromJson(
        Map<String, dynamic> json) =>
    MemberinviteInfoModel(
      inviteUrl: json['inviteUrl'],
      inviteCode: json['inviteCode'],
      income: json['income'],
      inviteNum: json['inviteNum'],
      totalIncome: json['totalIncome'],
      yesterdayIncome: json['yesterdayIncome'],
      directInvite: json['directInvite'],
      indirectInvite: json['indirectInvite'],
      directIncome: json['directIncome'],
      indirectIncome: json['indirectIncome'],
    );

Map<String, dynamic> _$MemberinviteInfoModelToJson(
        MemberinviteInfoModel instance) =>
    <String, dynamic>{
      'inviteUrl': instance.inviteUrl,
      'inviteCode': instance.inviteCode,
      'income': instance.income,
      'inviteNum': instance.inviteNum,
      'totalIncome': instance.totalIncome,
      'yesterdayIncome': instance.yesterdayIncome,
      'directInvite': instance.directInvite,
      'indirectInvite': instance.indirectInvite,
      'directIncome': instance.directIncome,
      'indirectIncome': instance.indirectIncome,
    };

MarketdecibelpublicsfindListModel _$MarketdecibelpublicsfindListModelFromJson(
        Map<String, dynamic> json) =>
    MarketdecibelpublicsfindListModel(
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => MarketdecibelpublicsfindListModelRecords.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      total: json['total'],
      size: json['size'],
      current: json['current'],
    )..pages = json['pages'];

Map<String, dynamic> _$MarketdecibelpublicsfindListModelToJson(
        MarketdecibelpublicsfindListModel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'pages': instance.pages,
      'size': instance.size,
      'current': instance.current,
    };

MarketdecibelpublicsfindListModelRecords
    _$MarketdecibelpublicsfindListModelRecordsFromJson(
            Map<String, dynamic> json) =>
        MarketdecibelpublicsfindListModelRecords(
          id: json['id'],
          timel: json['timel'],
          timetype: json['timetype'],
          nftIndex: json['nftIndex'],
          buyerNum24h: json['buyerNum24h'],
          sellerNum24h: json['sellerNum24h'],
          volumeTotal: json['volumeTotal'],
          volumeIncrement: json['volumeIncrement'],
          nftCount: json['nftCount'],
          nftCountIncrement: json['nftCountIncrement'],
          foundryCount: json['foundryCount'],
          foundryCountIncrement: json['foundryCountIncrement'],
          transactionCount: json['transactionCount'],
          transactionCountIncrement: json['transactionCountIncrement'],
          walletCount: json['walletCount'],
          walletCountIncrement: json['walletCountIncrement'],
          maxBlockNumber: json['maxBlockNumber'],
          createTime: json['createTime'],
          updateTime: json['updateTime'],
          createBy: json['createBy'],
          updateBy: json['updateBy'],
        );

Map<String, dynamic> _$MarketdecibelpublicsfindListModelRecordsToJson(
        MarketdecibelpublicsfindListModelRecords instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timel': instance.timel,
      'timetype': instance.timetype,
      'nftIndex': instance.nftIndex,
      'buyerNum24h': instance.buyerNum24h,
      'sellerNum24h': instance.sellerNum24h,
      'volumeTotal': instance.volumeTotal,
      'volumeIncrement': instance.volumeIncrement,
      'nftCount': instance.nftCount,
      'nftCountIncrement': instance.nftCountIncrement,
      'foundryCount': instance.foundryCount,
      'foundryCountIncrement': instance.foundryCountIncrement,
      'transactionCount': instance.transactionCount,
      'transactionCountIncrement': instance.transactionCountIncrement,
      'walletCount': instance.walletCount,
      'walletCountIncrement': instance.walletCountIncrement,
      'maxBlockNumber': instance.maxBlockNumber,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'createBy': instance.createBy,
      'updateBy': instance.updateBy,
    };

MashoppingcartlistModel _$MashoppingcartlistModelFromJson(
        Map<String, dynamic> json) =>
    MashoppingcartlistModel(
      records: json['records'],
      total: json['total'],
      size: json['size'],
      current: json['current'],
    );

Map<String, dynamic> _$MashoppingcartlistModelToJson(
        MashoppingcartlistModel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
    };

collectionpublicslistModel _$collectionpublicslistModelFromJson(
        Map<String, dynamic> json) =>
    collectionpublicslistModel(
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => collectionpublicslistModelRecords
              .fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'],
      size: json['size'],
      current: json['current'],
      pages: json['pages'],
    );

Map<String, dynamic> _$collectionpublicslistModelToJson(
        collectionpublicslistModel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'pages': instance.pages,
    };

collectionpublicslistModelRecords _$collectionpublicslistModelRecordsFromJson(
        Map<String, dynamic> json) =>
    collectionpublicslistModelRecords(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      bannerImageUrl: json['bannerImageUrl'],
      slug: json['slug'],
      holders: json['holders'],
      floorPrice: json['floorPrice'],
      volume: json['volume'],
      oneDayVolume: json['oneDayVolume'],
      token: json['token'],
      nftCount: json['nftCount'],
    );

Map<String, dynamic> _$collectionpublicslistModelRecordsToJson(
        collectionpublicslistModelRecords instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'bannerImageUrl': instance.bannerImageUrl,
      'slug': instance.slug,
      'holders': instance.holders,
      'floorPrice': instance.floorPrice,
      'volume': instance.volume,
      'oneDayVolume': instance.oneDayVolume,
      'token': instance.token,
      'nftCount': instance.nftCount,
    };

nftitemsorderModel _$nftitemsorderModelFromJson(Map<String, dynamic> json) =>
    nftitemsorderModel(
      total: json['total'],
      pages: json['pages'],
      size: json['size'],
      current: json['current'],
    )..records = (json['records'] as List<dynamic>?)
        ?.map((e) =>
            nftitemsorderModelRecords.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$nftitemsorderModelToJson(nftitemsorderModel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'pages': instance.pages,
      'size': instance.size,
      'current': instance.current,
    };

nftitemsorderModelRecords _$nftitemsorderModelRecordsFromJson(
        Map<String, dynamic> json) =>
    nftitemsorderModelRecords(
      fromAddress: json['fromAddress'],
      toAddress: json['toAddress'],
      marketLevel: json['marketLevel'],
      sellType: json['sellType'],
      eventName: json['eventName'],
      buyQuantity: json['buyQuantity'],
      price: json['price'],
      fees: json['fees'],
      image: json['image'],
      createTime: json['createTime'],
      name: json['name'] as String?,
      sorttimel: (json['sorttimel'] as num?)?.toInt(),
      fromAddressUser: json['fromAddressUser'] == null
          ? null
          : growUserModel
              .fromJson(json['fromAddressUser'] as Map<String, dynamic>),
      toAddressUser: json['toAddressUser'] == null
          ? null
          : growUserModel
              .fromJson(json['toAddressUser'] as Map<String, dynamic>),
      eventType: json['eventType'],
      token: json['token'] as String?,
      tokenId: json['tokenId'] as String?,
    );

Map<String, dynamic> _$nftitemsorderModelRecordsToJson(
        nftitemsorderModelRecords instance) =>
    <String, dynamic>{
      'fromAddress': instance.fromAddress,
      'toAddress': instance.toAddress,
      'marketLevel': instance.marketLevel,
      'sellType': instance.sellType,
      'eventName': instance.eventName,
      'buyQuantity': instance.buyQuantity,
      'price': instance.price,
      'fees': instance.fees,
      'image': instance.image,
      'createTime': instance.createTime,
      'eventType': instance.eventType,
      'name': instance.name,
      'sorttimel': instance.sorttimel,
      'token': instance.token,
      'tokenId': instance.tokenId,
      'fromAddressUser': instance.fromAddressUser,
      'toAddressUser': instance.toAddressUser,
    };

MashoppingcartlistModelRecords _$MashoppingcartlistModelRecordsFromJson(
        Map<String, dynamic> json) =>
    MashoppingcartlistModelRecords(
      name: json['name'],
      token: json['token'],
      imageUrl: json['imageUrl'],
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => MashoppingcartlistModelRecordsList.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      checked: json['checked'] as bool? ?? false,
      onSell: json['onSell'] as bool? ?? true,
    );

Map<String, dynamic> _$MashoppingcartlistModelRecordsToJson(
        MashoppingcartlistModelRecords instance) =>
    <String, dynamic>{
      'name': instance.name,
      'token': instance.token,
      'imageUrl': instance.imageUrl,
      'checked': instance.checked,
      'onSell': instance.onSell,
      'list': instance.list,
    };

MashoppingcartlistModelRecordsList _$MashoppingcartlistModelRecordsListFromJson(
        Map<String, dynamic> json) =>
    MashoppingcartlistModelRecordsList(
      id: json['id'],
      token: json['token'],
      tokenId: json['tokenId'],
      name: json['name'],
      image: json['image'],
      sellType: json['sellType'],
      onSell: json['onSell'],
      price: json['price'],
      oldprice: json['oldprice'],
      orderContent: json['orderContent'],
      chainId: json['chainId'],
      quantity: json['quantity'],
      sellQuantity: json['sellQuantity'],
      standard: json['standard'],
      nftitemslistingsid: json['nftitemslistingsid'],
      marketId: json['marketId'],
      checked: json['checked'] as bool? ?? false,
    );

Map<String, dynamic> _$MashoppingcartlistModelRecordsListToJson(
        MashoppingcartlistModelRecordsList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'tokenId': instance.tokenId,
      'name': instance.name,
      'image': instance.image,
      'sellType': instance.sellType,
      'onSell': instance.onSell,
      'price': instance.price,
      'oldprice': instance.oldprice,
      'orderContent': instance.orderContent,
      'chainId': instance.chainId,
      'quantity': instance.quantity,
      'sellQuantity': instance.sellQuantity,
      'standard': instance.standard,
      'nftitemslistingsid': instance.nftitemslistingsid,
      'marketId': instance.marketId,
      'checked': instance.checked,
    };

growUserModel _$growUserModelFromJson(Map<String, dynamic> json) =>
    growUserModel(
      id: json['id'],
      nickname: json['nickname'],
      icon: json['icon'],
    );

Map<String, dynamic> _$growUserModelToJson(growUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'icon': instance.icon,
    };

findOneByTokenIdModel _$findOneByTokenIdModelFromJson(
        Map<String, dynamic> json) =>
    findOneByTokenIdModel(
      nft: json['nft'] == null
          ? null
          : findOneByTokenIdModelNft
              .fromJson(json['nft'] as Map<String, dynamic>),
      marketName: json['marketName'],
      marketLogo: json['marketLogo'],
      contractName: json['contractName'],
      contractLogo: json['contractLogo'],
      nftitems: json['nftitems'],
      nftcategoryname: json['nftcategoryname'],
      creatorUser: json['creatorUser'] == null
          ? null
          : growUserModel.fromJson(json['creatorUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$findOneByTokenIdModelToJson(
        findOneByTokenIdModel instance) =>
    <String, dynamic>{
      'nft': instance.nft,
      'marketName': instance.marketName,
      'marketLogo': instance.marketLogo,
      'contractName': instance.contractName,
      'contractLogo': instance.contractLogo,
      'nftitems': instance.nftitems,
      'nftcategoryname': instance.nftcategoryname,
      'creatorUser': instance.creatorUser,
    };

findOneByTokenIdModelNft _$findOneByTokenIdModelNftFromJson(
        Map<String, dynamic> json) =>
    findOneByTokenIdModelNft(
      id: json['id'],
      token: json['token'],
      tokenId: json['tokenId'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      bannerImageUrl: json['bannerImageUrl'],
      creator: json['creator'],
      royaltie: json['royaltie'],
      owner: json['owner'],
      standard: json['standard'],
      contentType: json['contentType'],
      creators: json['creators'],
      royalties: json['royalties'],
      contractId: json['contractId'],
      categoryId: json['categoryId'],
      blockchain: json['blockchain'],
      supply: json['supply'],
      status: json['status'],
      isSync: json['isSync'],
      txHash: json['txHash'],
      image: json['image'],
      animationUrl: json['animationUrl'],
      externalUrl: json['externalUrl'],
      metadataUrl: json['metadataUrl'],
      metadataContent: json['metadataContent'],
      getMetaTimes: json['getMetaTimes'],
      signatures: json['signatures'],
      mintsContent: json['mintsContent'],
      verify: json['verify'],
      totalSales: json['totalSales'],
      priceMin: json['priceMin'],
      sellQuantity: json['sellQuantity'],
      lazy: json['lazy'],
      updateBy: json['updateBy'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
      createBy: json['createBy'],
      version: json['version'],
      attributes: json['attributes'],
      chainId: json['chainId'],
      marketId: json['marketId'],
      itemOnSell: json['itemOnSell'],
      itemSellQuantity: json['itemSellQuantity'],
      itemQuantity: json['itemQuantity'],
      itemPrice: json['itemPrice'],
      categoryNames: json['categoryNames'],
      infoId: json['infoId'],
      infoIdFull: json['infoIdFull'],
      holders: json['holders'],
      oneDayVolume: json['oneDayVolume'],
      volume: json['volume'],
      floorPrice: json['floorPrice'],
    );

Map<String, dynamic> _$findOneByTokenIdModelNftToJson(
        findOneByTokenIdModelNft instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'tokenId': instance.tokenId,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'imageUrl': instance.imageUrl,
      'bannerImageUrl': instance.bannerImageUrl,
      'creator': instance.creator,
      'royaltie': instance.royaltie,
      'owner': instance.owner,
      'standard': instance.standard,
      'contentType': instance.contentType,
      'creators': instance.creators,
      'royalties': instance.royalties,
      'contractId': instance.contractId,
      'categoryId': instance.categoryId,
      'blockchain': instance.blockchain,
      'supply': instance.supply,
      'status': instance.status,
      'isSync': instance.isSync,
      'txHash': instance.txHash,
      'image': instance.image,
      'animationUrl': instance.animationUrl,
      'externalUrl': instance.externalUrl,
      'metadataUrl': instance.metadataUrl,
      'metadataContent': instance.metadataContent,
      'getMetaTimes': instance.getMetaTimes,
      'signatures': instance.signatures,
      'mintsContent': instance.mintsContent,
      'verify': instance.verify,
      'totalSales': instance.totalSales,
      'priceMin': instance.priceMin,
      'sellQuantity': instance.sellQuantity,
      'lazy': instance.lazy,
      'updateBy': instance.updateBy,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'createBy': instance.createBy,
      'version': instance.version,
      'attributes': instance.attributes,
      'chainId': instance.chainId,
      'marketId': instance.marketId,
      'itemOnSell': instance.itemOnSell,
      'itemSellQuantity': instance.itemSellQuantity,
      'itemQuantity': instance.itemQuantity,
      'itemPrice': instance.itemPrice,
      'categoryNames': instance.categoryNames,
      'infoId': instance.infoId,
      'infoIdFull': instance.infoIdFull,
      'holders': instance.holders,
      'oneDayVolume': instance.oneDayVolume,
      'volume': instance.volume,
      'floorPrice': instance.floorPrice,
    };

findOneByTokenIdModelNftAttributes _$findOneByTokenIdModelNftAttributesFromJson(
        Map<String, dynamic> json) =>
    findOneByTokenIdModelNftAttributes(
      trait_type: json['trait_type'],
      value: json['value'],
      display_type: json['display_type'],
      max_value: json['max_value'],
      trait_count: json['trait_count'],
      order: json['order'],
    );

Map<String, dynamic> _$findOneByTokenIdModelNftAttributesToJson(
        findOneByTokenIdModelNftAttributes instance) =>
    <String, dynamic>{
      'trait_type': instance.trait_type,
      'value': instance.value,
      'display_type': instance.display_type,
      'max_value': instance.max_value,
      'trait_count': instance.trait_count,
      'order': instance.order,
    };

BannerpublicspageModel _$BannerpublicspageModelFromJson(
        Map<String, dynamic> json) =>
    BannerpublicspageModel(
      total: json['total'],
      size: json['size'],
      current: json['current'],
      pages: json['pages'],
    )..records = (json['records'] as List<dynamic>?)
        ?.map((e) =>
            BannerpublicspageModelRecords.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$BannerpublicspageModelToJson(
        BannerpublicspageModel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'pages': instance.pages,
    };

BannerpublicspageModelRecords _$BannerpublicspageModelRecordsFromJson(
        Map<String, dynamic> json) =>
    BannerpublicspageModelRecords(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      icon: json['icon'],
      imgUrl: json['imgUrl'],
      image: json['image'],
      link: json['link'],
      sort: json['sort'],
      valueId: json['valueId'],
      starttime: json['starttime'],
      endTime: json['endTime'],
      width: json['width'],
      high: json['high'],
      description: json['description'],
    );

Map<String, dynamic> _$BannerpublicspageModelRecordsToJson(
        BannerpublicspageModelRecords instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'icon': instance.icon,
      'imgUrl': instance.imgUrl,
      'image': instance.image,
      'link': instance.link,
      'sort': instance.sort,
      'valueId': instance.valueId,
      'starttime': instance.starttime,
      'endTime': instance.endTime,
      'width': instance.width,
      'high': instance.high,
      'description': instance.description,
    };

NftprojectslistModel _$NftprojectslistModelFromJson(
        Map<String, dynamic> json) =>
    NftprojectslistModel(
      total: json['total'],
      size: json['size'],
      current: json['current'],
      orders: json['orders'],
      optimizeCountSql: json['optimizeCountSql'],
      searchCount: json['searchCount'],
      countId: json['countId'],
      maxLimit: json['maxLimit'],
      pages: json['pages'],
    )..records = (json['records'] as List<dynamic>?)
        ?.map((e) =>
            NftprojectslistModelRecords.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$NftprojectslistModelToJson(
        NftprojectslistModel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'orders': instance.orders,
      'optimizeCountSql': instance.optimizeCountSql,
      'searchCount': instance.searchCount,
      'countId': instance.countId,
      'maxLimit': instance.maxLimit,
      'pages': instance.pages,
    };

NftSelectList _$NftSelectListFromJson(Map<String, dynamic> json) =>
    NftSelectList(
      bool: json['bool'],
      name: json['name'],
    );

Map<String, dynamic> _$NftSelectListToJson(NftSelectList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'bool': instance.bool,
    };

NftprojectslistModelRecords _$NftprojectslistModelRecordsFromJson(
        Map<String, dynamic> json) =>
    NftprojectslistModelRecords(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      description: json['description'],
      price: json['price'],
      total: json['total'],
      starttime: json['starttime'],
      link: json['link'],
      twitter: json['twitter'],
      discord: json['discord'],
      mintlink: json['mintlink'],
      category: json['category'],
    );

Map<String, dynamic> _$NftprojectslistModelRecordsToJson(
        NftprojectslistModelRecords instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'description': instance.description,
      'price': instance.price,
      'total': instance.total,
      'starttime': instance.starttime,
      'link': instance.link,
      'twitter': instance.twitter,
      'discord': instance.discord,
      'mintlink': instance.mintlink,
      'category': instance.category,
    };

BeimeipromoteleaderboardModel _$BeimeipromoteleaderboardModelFromJson(
        Map<String, dynamic> json) =>
    BeimeipromoteleaderboardModel(
      fInvalidateIntroCount: json['fInvalidateIntroCount'],
      floginName: json['floginName'],
    );

Map<String, dynamic> _$BeimeipromoteleaderboardModelToJson(
        BeimeipromoteleaderboardModel instance) =>
    <String, dynamic>{
      'fInvalidateIntroCount': instance.fInvalidateIntroCount,
      'floginName': instance.floginName,
    };

BeimeihomeoptsModel _$BeimeihomeoptsModelFromJson(Map<String, dynamic> json) =>
    BeimeihomeoptsModel(
      fid: json['fid'],
      fconfigid: json['fconfigid'],
      fcoinid: json['fcoinid'],
      forderid: json['forderid'],
      fuid: json['fuid'],
      ftype: json['ftype'],
      fstatus: json['fstatus'],
      famount: json['famount'],
      faddtime: json['faddtime'],
      faddtimel: json['faddtimel'],
      fupdatetimel: json['fupdatetimel'],
      version: json['version'],
      usdtValue: json['usdtValue'],
    );

Map<String, dynamic> _$BeimeihomeoptsModelToJson(
        BeimeihomeoptsModel instance) =>
    <String, dynamic>{
      'fid': instance.fid,
      'fconfigid': instance.fconfigid,
      'fcoinid': instance.fcoinid,
      'forderid': instance.forderid,
      'fuid': instance.fuid,
      'ftype': instance.ftype,
      'fstatus': instance.fstatus,
      'famount': instance.famount,
      'faddtime': instance.faddtime,
      'faddtimel': instance.faddtimel,
      'fupdatetimel': instance.fupdatetimel,
      'usdtValue': instance.usdtValue,
      'version': instance.version,
    };

BeimeiconfigfindPartitionListModel _$BeimeiconfigfindPartitionListModelFromJson(
        Map<String, dynamic> json) =>
    BeimeiconfigfindPartitionListModel(
      ftradecategoryid: json['ftradecategoryid'],
      fcategoryname: json['fcategoryname'],
    );

Map<String, dynamic> _$BeimeiconfigfindPartitionListModelToJson(
        BeimeiconfigfindPartitionListModel instance) =>
    <String, dynamic>{
      'ftradecategoryid': instance.ftradecategoryid,
      'fcategoryname': instance.fcategoryname,
    };

BeimeiconfigfindCoinListModel _$BeimeiconfigfindCoinListModelFromJson(
        Map<String, dynamic> json) =>
    BeimeiconfigfindCoinListModel(
      fcoinname: json['fcoinname'],
      fcoinid: json['fcoinid'],
      selected: json['selected'],
    );

Map<String, dynamic> _$BeimeiconfigfindCoinListModelToJson(
        BeimeiconfigfindCoinListModel instance) =>
    <String, dynamic>{
      'fcoinname': instance.fcoinname,
      'fcoinid': instance.fcoinid,
      'selected': instance.selected,
    };

BeimeiorderfindListModel _$BeimeiorderfindListModelFromJson(
        Map<String, dynamic> json) =>
    BeimeiorderfindListModel(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => BeimeiorderfindListContentModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      number: json['number'],
      size: json['size'],
      numberOfElements: json['numberOfElements'],
      prevPage: json['prevPage'],
      nextPage: json['nextPage'],
    );

Map<String, dynamic> _$BeimeiorderfindListModelToJson(
        BeimeiorderfindListModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'number': instance.number,
      'size': instance.size,
      'numberOfElements': instance.numberOfElements,
      'prevPage': instance.prevPage,
      'nextPage': instance.nextPage,
    };

BeimeiorderfindListContentModel _$BeimeiorderfindListContentModelFromJson(
        Map<String, dynamic> json) =>
    BeimeiorderfindListContentModel(
      fid: json['fid'],
      fcoinid: json['fcoinid'],
      fprice: json['fprice'],
      fcount: json['fcount'],
      ftype: json['ftype'],
      fstatus: json['fstatus'],
      faddtime: json['faddtime'],
      faddtimel: json['faddtimel'],
      fendtimel: json['fendtimel'],
      fupdatetime: json['fupdatetime'],
      fconfig: json['fconfig'] == null
          ? null
          : BeimeiconfigfindList.fromJson(
              json['fconfig'] as Map<String, dynamic>),
      incomeAll: json['incomeAll'],
      incomeToday: json['incomeToday'],
      incomeAllUSDT: json['incomeAllUSDT'],
      incomeTodayUSDT: json['incomeTodayUSDT'],
    );

Map<String, dynamic> _$BeimeiorderfindListContentModelToJson(
        BeimeiorderfindListContentModel instance) =>
    <String, dynamic>{
      'fid': instance.fid,
      'fcoinid': instance.fcoinid,
      'fprice': instance.fprice,
      'fcount': instance.fcount,
      'ftype': instance.ftype,
      'fstatus': instance.fstatus,
      'faddtime': instance.faddtime,
      'faddtimel': instance.faddtimel,
      'fendtimel': instance.fendtimel,
      'fupdatetime': instance.fupdatetime,
      'incomeAll': instance.incomeAll,
      'incomeToday': instance.incomeToday,
      'incomeAllUSDT': instance.incomeAllUSDT,
      'incomeTodayUSDT': instance.incomeTodayUSDT,
      'fconfig': instance.fconfig,
    };

BeimeiconfigfindList _$BeimeiconfigfindListFromJson(
        Map<String, dynamic> json) =>
    BeimeiconfigfindList(
      fid: json['fid'],
      fname: json['fname'],
      ftradecategoryid: json['ftradecategoryid'],
      fcoinid: json['fcoinid'],
      fcoinname: json['fcoinname'],
      fprice: json['fprice'],
      fpower: json['fpower'],
      fminingday: json['fminingday'],
      felectricfees: json['felectricfees'],
      ffees: json['ffees'],
      fstarttimel: json['fstarttimel'],
      fendtimel: json['fendtimel'],
      fstatus: json['fstatus'],
      ftype: json['ftype'],
      fproduct: json['fproduct'],
      fproject: json['fproject'],
      frisk: json['frisk'],
      fpowerwaste: json['fpowerwaste'],
      ficon: json['ficon'],
      fsort: json['fsort'],
      fcount: json['fcount'] ?? 1,
      fcycletime: json['fcycletime'],
    );

Map<String, dynamic> _$BeimeiconfigfindListToJson(
        BeimeiconfigfindList instance) =>
    <String, dynamic>{
      'fid': instance.fid,
      'fname': instance.fname,
      'ftradecategoryid': instance.ftradecategoryid,
      'fcoinid': instance.fcoinid,
      'fcoinname': instance.fcoinname,
      'fprice': instance.fprice,
      'fpower': instance.fpower,
      'fminingday': instance.fminingday,
      'felectricfees': instance.felectricfees,
      'ffees': instance.ffees,
      'fstarttimel': instance.fstarttimel,
      'fendtimel': instance.fendtimel,
      'fstatus': instance.fstatus,
      'ftype': instance.ftype,
      'fproduct': instance.fproduct,
      'fproject': instance.fproject,
      'frisk': instance.frisk,
      'fpowerwaste': instance.fpowerwaste,
      'ficon': instance.ficon,
      'fsort': instance.fsort,
      'fcount': instance.fcount,
      'fcycletime': instance.fcycletime,
    };

LaunchPageModel _$LaunchPageModelFromJson(Map<String, dynamic> json) =>
    LaunchPageModel(
      addTime: json['addTime'],
      cotentType: json['cotentType'],
      forder: json['forder'],
      fstatus: json['fstatus'],
      ftype: json['ftype'],
      id: json['id'],
      imgDesc: json['imgDesc'],
      imgName: json['imgName'],
      imgUrl: json['imgUrl'],
      jumpUrl: json['jumpUrl'],
    );

Map<String, dynamic> _$LaunchPageModelToJson(LaunchPageModel instance) =>
    <String, dynamic>{
      'addTime': instance.addTime,
      'cotentType': instance.cotentType,
      'forder': instance.forder,
      'fstatus': instance.fstatus,
      'ftype': instance.ftype,
      'id': instance.id,
      'imgDesc': instance.imgDesc,
      'imgName': instance.imgName,
      'imgUrl': instance.imgUrl,
      'jumpUrl': instance.jumpUrl,
    };

BeimeiconfigfindListContent _$BeimeiconfigfindListContentFromJson(
        Map<String, dynamic> json) =>
    BeimeiconfigfindListContent(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => BeimeiconfigfindList.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      number: json['number'],
      size: json['size'],
      numberOfElements: json['numberOfElements'],
      prevPage: json['prevPage'],
      nextPage: json['nextPage'],
    );

Map<String, dynamic> _$BeimeiconfigfindListContentToJson(
        BeimeiconfigfindListContent instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'number': instance.number,
      'size': instance.size,
      'numberOfElements': instance.numberOfElements,
      'prevPage': instance.prevPage,
      'nextPage': instance.nextPage,
    };

orderContentModel _$orderContentModelFromJson(Map<String, dynamic> json) =>
    orderContentModel(
      next: json['next'],
      previous: json['previous'],
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) =>
              orderContentModelOrders.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$orderContentModelToJson(orderContentModel instance) =>
    <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
      'orders': instance.orders,
    };

orderContentModelOrders _$orderContentModelOrdersFromJson(
        Map<String, dynamic> json) =>
    orderContentModelOrders(
      protocol_data: json['protocol_data'] == null
          ? null
          : orderContentModelOrdersProtocolData
              .fromJson(json['protocol_data'] as Map<String, dynamic>),
      protocol_address: json['protocol_address'],
    );

Map<String, dynamic> _$orderContentModelOrdersToJson(
        orderContentModelOrders instance) =>
    <String, dynamic>{
      'protocol_data': instance.protocol_data,
      'protocol_address': instance.protocol_address,
    };

orderContentModelOrdersProtocolData
    _$orderContentModelOrdersProtocolDataFromJson(Map<String, dynamic> json) =>
        orderContentModelOrdersProtocolData(
          parameters: json['parameters'] == null
              ? null
              : orderContentModelOrdersProtocolDataParameters
                  .fromJson(json['parameters'] as Map<String, dynamic>),
          signature: json['signature'],
        );

Map<String, dynamic> _$orderContentModelOrdersProtocolDataToJson(
        orderContentModelOrdersProtocolData instance) =>
    <String, dynamic>{
      'parameters': instance.parameters,
      'signature': instance.signature,
    };

orderContentModelOrdersProtocolDataParameters
    _$orderContentModelOrdersProtocolDataParametersFromJson(
            Map<String, dynamic> json) =>
        orderContentModelOrdersProtocolDataParameters(
          offerer: json['offerer'],
          offer: (json['offer'] as List<dynamic>?)
              ?.map((e) => orderContentModelOrdersProtocolDataParametersOffer
                  .fromJson(e as Map<String, dynamic>))
              .toList(),
          consideration: (json['consideration'] as List<dynamic>?)
              ?.map((e) =>
                  orderContentModelOrdersProtocolDataParametersConsideration
                      .fromJson(e as Map<String, dynamic>))
              .toList(),
          startTime: json['startTime'],
          endTime: json['endTime'],
          orderType: json['orderType'],
          zone: json['zone'],
          zoneHash: json['zoneHash'],
          salt: json['salt'],
          conduitKey: json['conduitKey'],
          totalOriginalConsiderationItems:
              json['totalOriginalConsiderationItems'],
          counter: json['counter'],
        );

Map<String, dynamic> _$orderContentModelOrdersProtocolDataParametersToJson(
        orderContentModelOrdersProtocolDataParameters instance) =>
    <String, dynamic>{
      'offerer': instance.offerer,
      'offer': instance.offer,
      'consideration': instance.consideration,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'orderType': instance.orderType,
      'zone': instance.zone,
      'zoneHash': instance.zoneHash,
      'salt': instance.salt,
      'conduitKey': instance.conduitKey,
      'totalOriginalConsiderationItems':
          instance.totalOriginalConsiderationItems,
      'counter': instance.counter,
    };

orderContentModelOrdersProtocolDataParametersConsideration
    _$orderContentModelOrdersProtocolDataParametersConsiderationFromJson(
            Map<String, dynamic> json) =>
        orderContentModelOrdersProtocolDataParametersConsideration(
          itemType: json['itemType'],
          token: json['token'],
          identifierOrCriteria: json['identifierOrCriteria'],
          startAmount: json['startAmount'],
          endAmount: json['endAmount'],
          recipient: json['recipient'],
        );

Map<String,
    dynamic> _$orderContentModelOrdersProtocolDataParametersConsiderationToJson(
        orderContentModelOrdersProtocolDataParametersConsideration instance) =>
    <String, dynamic>{
      'itemType': instance.itemType,
      'token': instance.token,
      'identifierOrCriteria': instance.identifierOrCriteria,
      'startAmount': instance.startAmount,
      'endAmount': instance.endAmount,
      'recipient': instance.recipient,
    };

orderContentModelOrdersProtocolDataParametersOffer
    _$orderContentModelOrdersProtocolDataParametersOfferFromJson(
            Map<String, dynamic> json) =>
        orderContentModelOrdersProtocolDataParametersOffer(
          itemType: json['itemType'],
          token: json['token'],
          identifierOrCriteria: json['identifierOrCriteria'],
          startAmount: json['startAmount'],
          endAmount: json['endAmount'],
        );

Map<String, dynamic> _$orderContentModelOrdersProtocolDataParametersOfferToJson(
        orderContentModelOrdersProtocolDataParametersOffer instance) =>
    <String, dynamic>{
      'itemType': instance.itemType,
      'token': instance.token,
      'identifierOrCriteria': instance.identifierOrCriteria,
      'startAmount': instance.startAmount,
      'endAmount': instance.endAmount,
    };

CollectionKLineModel _$CollectionKLineModelFromJson(
        Map<String, dynamic> json) =>
    CollectionKLineModel(
      id: json['id'] as String?,
      timel: (json['timel'] as num?)?.toInt(),
      timetype: (json['timetype'] as num?)?.toInt(),
      token: json['token'] as String?,
      slug: json['slug'] as String?,
      chainId: (json['chainId'] as num?)?.toInt(),
      marketId: (json['marketId'] as num?)?.toInt(),
      volume: json['volume'],
      holders: (json['holders'] as num?)?.toInt(),
      floorPrice: json['floorPrice'],
      oneDayVolume: json['oneDayVolume'],
      oneDayAveragePrice: json['oneDayAveragePrice'],
      sevenDayVolume: json['sevenDayVolume'],
      thirtyDayVolume: json['thirtyDayVolume'],
      categoryIds: json['categoryIds'] as String?,
      nftCount: (json['nftCount'] as num?)?.toInt(),
      updateBy: json['updateBy'] as String?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
      createBy: json['createBy'] as String?,
    );

Map<String, dynamic> _$CollectionKLineModelToJson(
        CollectionKLineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timel': instance.timel,
      'timetype': instance.timetype,
      'token': instance.token,
      'slug': instance.slug,
      'chainId': instance.chainId,
      'marketId': instance.marketId,
      'volume': instance.volume,
      'holders': instance.holders,
      'floorPrice': instance.floorPrice,
      'oneDayVolume': instance.oneDayVolume,
      'oneDayAveragePrice': instance.oneDayAveragePrice,
      'sevenDayVolume': instance.sevenDayVolume,
      'thirtyDayVolume': instance.thirtyDayVolume,
      'categoryIds': instance.categoryIds,
      'nftCount': instance.nftCount,
      'updateBy': instance.updateBy,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'createBy': instance.createBy,
    };

MarketAiItemModel _$MarketAiItemModelFromJson(Map<String, dynamic> json) =>
    MarketAiItemModel(
      id: json['id'],
      position: json['position'],
      type: json['type'],
      name: json['name'],
      nameEn: json['nameEn'],
      ossId: json['ossId'],
      picUrl: json['picUrl'],
      link: json['link'],
      appLink: json['appLink'],
      sort: json['sort'],
      valueId: json['valueId'],
      content: json['content'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      width: json['width'],
      high: json['high'],
      enabled: json['enabled'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
      deleted: json['deleted'],
      createBy: json['createBy'],
      updateBy: json['updateBy'],
      title: json['title'],
      subtitle: json['subtitle'],
      categoryType: json['categoryType'],
    );

Map<String, dynamic> _$MarketAiItemModelToJson(MarketAiItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'type': instance.type,
      'name': instance.name,
      'nameEn': instance.nameEn,
      'ossId': instance.ossId,
      'picUrl': instance.picUrl,
      'link': instance.link,
      'appLink': instance.appLink,
      'sort': instance.sort,
      'valueId': instance.valueId,
      'content': instance.content,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'width': instance.width,
      'high': instance.high,
      'enabled': instance.enabled,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'deleted': instance.deleted,
      'createBy': instance.createBy,
      'updateBy': instance.updateBy,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'categoryType': instance.categoryType,
    };
