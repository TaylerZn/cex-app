import 'package:dio/dio.dart' as dio;
import 'package:nt_app_flutter/app/api/trade/trade.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

//超级交易员详情_我的
traderinfo() async {
  var data = {};
  try {
    var res = await TradeApi.instance().traderinfo(
      data,
    );
    return res;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    return null;
  }
}

//超级交易员详情
noAuthtraderinfo(
  id,
) async {
  var data = {'id': id};
  try {
    var res = await TradeApi.instance().noAuthtraderinfo(
      data,
    );
    return res;
  } on dio.DioException catch (e) {
    print('e.error===${e.error}');
    return null;
  }
}

//关注或取消关注交易员
traderFocusupsert(superTraderId) async {
  var data = {'superTraderId': superTraderId};
  try {
    await TradeApi.instance().traderFocusupsert(data);
    return true;
  } on dio.DioException catch (e) {
    print(e.error);
    UIUtil.showError('${e.error}');
    return false;
  }
}

//超级交易员投资列表
traderinvestpageList(currentPage, pageSize, {id}) async {
  Map data = {
    'currentPage': currentPage,
    'pageSize': pageSize,
  };
  if (id != null) {
    data['id'] = id;
  }
  var res;
  try {
    if (id != null) {
      res = await TradeApi.instance().noAuthtraderinvestpageList(data);
    } else {
      res = await TradeApi.instance().traderinvestpageList(data);
    }
    for (var i = 0; i < res.data!.length; i++) {}
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    return null;
  }
}

//跟随者列表
traderfollowerpageList(currentPage, pageSize, {id}) async {
  Map data = {
    'currentPage': currentPage,
    'pageSize': pageSize,
  };
  if (id != null) {
    data['id'] = id;
  }
  var res;
  try {
    if (id != null) {
      res = await TradeApi.instance().noAuthtraderfollowerpageList(data);
    } else {
      res = await TradeApi.instance().traderfollowerpageList(data);
    }
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    return null;
  }
}

//资产分布
noAuthtraderassetDistribution(memberId) async {
  Map data = {
    'memberId': memberId,
  };
  try {
    var res = await TradeApi.instance().noAuthtraderassetDistribution(data);

    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    return null;
  }
}

//资产分布
followOrderConfiglist() async {
  Map data = {};
  try {
    var res = await TradeApi.instance().followOrderConfiglist({});
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    return null;
  }
}

//交易员投资简要信息列表
noAuthtraderinvestlist(memberId) async {
  Map data = {
    'memberId': memberId,
  };
  try {
    var res = await TradeApi.instance().noAuthtraderinvestlist(data);
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    return null;
  }
}

//交易员投资简要信息列表
stockmineInvestfollowOrder(memberId, configId) async {
  Map data = {'memberId': memberId, 'configId': configId};
  try {
    var res = await TradeApi.instance().stockmineInvestfollowOrder(data);
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    return null;
  }
}
