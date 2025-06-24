import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/ws/spot_goods_socket_manager.dart';

import '../../../../models/contract/res/depth_info.dart';
import '../../../../ws/core/model/ws_receive_data.dart';
import '../../mixin/depth_controller.dart';

class SpotDepthController extends GetxController with DepthController {
  static SpotDepthController get to => Get.find();

  MarketInfoModel? marketInfoModel;
  int step = 0;

  void changeMarketInfo(MarketInfoModel? info) {
    if (info == null) return;
    step = 0;
    if (marketInfoModel != null) {
      SpotGoodsSocketManager.instance.unSubDepth(marketInfoModel!.symbol, step);
      SpotGoodsSocketManager.instance.unSubTicker(marketInfoModel!.symbol);
    }

    marketInfoModel = info;
    if (!ObjectUtil.isEmptyString(info.depth)) {
      precisionList = info.depth!.split(',').map((e) => e.toNum()).toList();
      precision = precisionList.first;
    }
    update();

    _subDepth();
  }

  /// 更改精度
  ///
  /// 该函数用于更改市场信息的精度。首先检查marketInfoModel是否为null，如果是，则不执行任何操作。
  /// 如果不为null，则取消订阅当前精度的深度数据，更新精度值，然后重新订阅新的精度的深度数据。
  ///
  /// @param precision 新的精度值，用于更新当前精度。
  /// @returns 无返回值
  changePrecision(num precision) {
    // 如果marketInfoModel为null，则直接返回，不执行后续操作
    if (marketInfoModel == null) return;

    // 取消订阅当前精度的深度数据
    SpotGoodsSocketManager().unSubDepth(marketInfoModel!.symbol, step);

    // 更新精度值
    this.precision = precision;
    step = max(0, precisionList.indexOf(precision));
    // 更新相关信息
    update();

    // 订阅新的精度的深度数据，并提供数据处理回调函数
    _subDepth();
  }

  @override
  void onClose() {
    if (marketInfoModel != null) {
      SpotGoodsSocketManager()
          .unSubDepth(marketInfoModel!.symbol, precision.numDecimalPlaces());
      SpotGoodsSocketManager().unSubTicker(marketInfoModel!.symbol);
    }
    super.onClose();
  }
}

extension SpotDepthControllerX on SpotDepthController {
  _subDepth() {
    if (marketInfoModel == null) return;
    SpotGoodsSocketManager().subDepth(marketInfoModel!.symbol, step,
        (symbol, data) {
      _handleData(marketInfoModel!.symbol, symbol, data);
    });
  }

  _handleData(String subSymbol, String symbol, WSReceiveData data) {
    if (ObjectUtil.isEmpty(data.tick) || subSymbol != symbol) {
      return;
    }
    DepthTick depthTick = DepthTick.fromJson(data.tick!);

    asks.clear();
    asks.addAll(depthTick.asks
            ?.map((e) => DepthEntity(
                e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
            .toList() ??
        []);
    asks.sort((a, b) => b.price.compareTo(a.price));
    for (var element in asks) {
      if (element.vol > askMaxVol) {
        askMaxVol = element.vol;
      }
    }

    buys.clear();
    buys.addAll(depthTick.buys
            ?.map((e) => DepthEntity(
                e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
            .toList() ??
        []);
    buys.sort((a, b) => b.price.compareTo(a.price));
    for (var element in buys) {
      if (element.vol > buyMaxVol) {
        buyMaxVol = element.vol;
      }
    }
    update();
  }
}
