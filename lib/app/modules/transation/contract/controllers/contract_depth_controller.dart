import 'dart:async';
import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:nt_app_flutter/app/models/contract/res/depth_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/mixin/price_controller_mixin.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/ws/contract_socket_manager.dart';
import 'package:nt_app_flutter/app/ws/core/model/ws_receive_data.dart';
import 'package:nt_app_flutter/app/ws/future_socket_manager.dart';

import '../../../../api/contract/contract_api.dart';
import '../../mixin/depth_controller.dart';

class ContractDepthController extends GetxController
    with DepthController, PriceControllerMixin {
  static ContractDepthController get to => Get.find();
  ContractInfo? contractInfo;
  int step = 0;

  void changeContract(ContractInfo? info) {
    if (info == null) return;
    step = 0;
    if (contractInfo != null) {
      asks.clear();
      buys.clear();
      ContractSocketManager.instance.unSubDepth(contractInfo!.subSymbol, step);
    }
    fundingRate.value = null;
    contractInfo = info;
    if (info.coinResultVo?.depth != null) {
      precisionList =
          info.coinResultVo!.depth.map((e) => e.toInt().toPrecision()).toList();
    }
    precision = precisionList[0];
    update();
    _subDepth();
    fetchFoundRateTimer();
  }

  /// @param precision 新的精度值
  /// @returns 无返回值
  changePrecision(num precision) {
    // 如果没有合约信息，直接返回，不执行后续操作
    if (contractInfo == null) return;
    // 取消旧的深度数据订阅
    ContractSocketManager.instance.unSubDepth(contractInfo!.subSymbol, step);
    this.precision = precision;
    step = max(0, precisionList.indexOf(precision));
    update();
    // 订阅新的深度数据
    _subDepth();
  }

  @override
  void onClose() {
    if (contractInfo != null) {
      ContractSocketManager.instance.unSubDepth(contractInfo!.subSymbol, 0);
    }
    super.onClose();
  }
}

extension ContractDepthControllerX on ContractDepthController {
  _subDepth() {
    if (contractInfo == null) return;
    ContractSocketManager.instance.subDepth(contractInfo!.subSymbol, step,
        (symbol, data) {
      _handleData(contractInfo!.subSymbol, symbol, data);
    });
  }

  Future fetchFoundRate() async {
    try {
      final res = await ContractApi.instance()
          .getMarketInfo(contractInfo!.symbol, contractInfo!.id);
      fundingRate.value = res;
    } catch (e) {
      Get.log('e ${e.toString()}');
    }
  }

  Future fetchFoundRateTimer() async {
    if (contractInfo == null) return;
    await fetchFoundRate();
    FuturetSocketManager.instance
        .subMarketInfo(contractInfo!.symbol, contractInfo!.id, callback: (res) {
      fundingRate.value = res;
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
    asks = mergeDepthEntities(asks);
    asks.sort((a, b) => b.price.compareTo(a.price));
    askMaxVol = asks.first.vol;
    for (var element in asks) {
      if (element.vol > askMaxVol) {
        askMaxVol = element.vol;
      }
      if (element.price > askMaxPrice) {
        askMaxPrice = element.price;
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
      if (element.price > buyMaxPrice) {
        buyMaxPrice = element.price;
      }
    }
    update();
  }
}
