import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:k_chart/utils/data_util.dart';
import 'package:nt_app_flutter/app/ws/contract_socket_manager.dart';

import '../../../../models/contract/res/public_info.dart';
import '../../widgets/price/widgets/kchart/model/sub_time.dart';
import '../widgets/kchart/contract_bottom_kchart.dart';

class ContractBottomKChartController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  static ContractBottomKChartController get to => Get.find();

  final Rxn<ContractInfo> contractInfo = Rxn<ContractInfo>();
  final RxBool isShow = false.obs;

  @override
  void onInit() {
    tabController =
        TabController(length: SubTime.contractTrade().length, vsync: this);
    super.onInit();
  }

  void toggleShow() {
    isShow.toggle();
  }

  ContractBottomKchartStateRx state = ContractBottomKchartStateRx();

  /// k线正在加载更多
  bool isLoadingMore = false;
  bool hasMore = true;

  /// k线数据，key为时间类型，目的是去重复
  LinkedHashMap<int, KLineEntity> kLineData = LinkedHashMap();

  changeContractInfo(ContractInfo contractInfo) {
    if (this.contractInfo.value != null) {
      unSubKline(this.contractInfo.value!, state.subTime.value.subTime);
    }
    isLoadingMore = false;
    hasMore = true;
    this.contractInfo.value = contractInfo;
    subKline(contractInfo, state.subTime.value.subTime);
  }

  @override
  void onClose() {
    if (contractInfo.value != null) {
      unSubKline(contractInfo.value!, state.subTime.value.subTime);
    }
    tabController.dispose();
    super.onClose();
  }

  subKline(ContractInfo contractInfo, String subTime) {
    state.isLoading.value = true;
    state.kLineData.clear();
    kLineData.clear();
    ContractSocketManager.instance.reqKline(contractInfo.subSymbol, subTime,
        (symbol, data) {
      if (symbol == contractInfo.subSymbol && data.data != null) {
        /// 停止加载
        state.isLoading.value = false;
        List<KLineEntity> list = data.data
            .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<KLineEntity>();

        /// 过滤无效数据
        for (var element in list) {
          if (element.isValidData()) {
            kLineData[element.time ?? 0] = element;
          }
        }

        /// 去重复
        list = kLineData.values.toList();
        if (list.isNotEmpty) {
          /// 排序
          list.sort((a, b) => a.time?.compareTo(b.time ?? 0) ?? 0);
          DataUtil.calculate(list);
          state.kLineData.assignAll(list);
        }
      }
    });
    ContractSocketManager.instance.subKline(contractInfo.subSymbol, subTime,
        (symbol, data) {
      /// 对应的订阅，非空的数据，且k线数据不为空，列表数据未回来避免只显示一条数据
      if (symbol == contractInfo.subSymbol && data.tick != null) {
        KLineEntity kLineEntity = KLineEntity.fromJson(data.tick!);

        /// 无效数据不处理
        if (!kLineEntity.isValidData()) return;

        /// 第一次数据，先存储
        if (kLineData.isEmpty) {
          kLineData[kLineEntity.time ?? 0] = kLineEntity;
          return;
        }

        /// 重复数据替换最后一条，分时的不替换
        kLineData[kLineEntity.time ?? 0] = kLineEntity;
        List<KLineEntity> list = kLineData.values.toList();
        list.sort((a, b) => a.time?.compareTo(b.time ?? 0) ?? 0);
        DataUtil.calculate(list);
        state.kLineData.assignAll(list);
      }
    });
  }

  unSubKline(ContractInfo contractInfo, String subTime) {
    state.kLineData.clear();
    ContractSocketManager.instance.unSubKline(contractInfo.subSymbol, subTime);
  }

  void changeSubTime(SubTime e) {
    if (contractInfo.value == null) {
      return;
    }
    isLoadingMore = false;
    hasMore = true;
    unSubKline(contractInfo.value!, state.subTime.value.subTime);
    state.subTime.value = e;
    subKline(contractInfo.value!, state.subTime.value.subTime);
  }

  void onLoadMore() {
    if (contractInfo.value == null ||
        state.kLineData.isEmpty ||
        isLoadingMore ||
        !hasMore) {
      return;
    }
    isLoadingMore = true;
    int endIdx = state.kLineData.value.first.time! ~/ 1000;
    ContractSocketManager.instance
        .reqKline(contractInfo.value!.subSymbol, state.subTime.value.subTime,
            (symbol, data) {
      if (symbol == contractInfo.value!.subSymbol && data.data != null) {
        isLoadingMore = false;
        List<KLineEntity> list = data.data
            .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<KLineEntity>();

        /// 删除已有的数据
        list.removeWhere((element) =>
            kLineData.containsKey(element.time ?? 0) || !element.isValidData());
        hasMore = list.isNotEmpty;

        if (list.isNotEmpty) {
          for (var element in list) {
            kLineData[element.time ?? 0] = element;
          }
          list = kLineData.values.toList();
          list.sort((a, b) => a.time?.compareTo(b.time ?? 0) ?? 0);

          /// 计算主副图指标
          DataUtil.calculate(state.kLineData.value);
          state.kLineData.assignAll(list);
        }
      }
    }, endIdx: endIdx);
  }

  void onMainStateChanged(MainState value) {
    if (state.mainState.value == value) {
      state.mainState.value = MainState.NONE;
    } else {
      state.mainState.value = value;
    }
  }

  void onSecondaryStateChanged(SecondaryState value) {
    if (state.secondaryState.value == value) {
      state.secondaryState.value = SecondaryState.NONE;
    } else {
      state.secondaryState.value = value;
    }
  }
}
