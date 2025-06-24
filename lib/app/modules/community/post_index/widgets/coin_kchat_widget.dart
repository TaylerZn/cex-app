import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/custom_loading_progress_indicator.dart';
import 'package:nt_app_flutter/app/ws/standard_socket_manager.dart';

enum CommunityCoinKChatType {
  post,

  /// 发布时的币对信息
  info,

  /// 详情页的币对信息
}

class CommunityCoinKchatWidget extends StatefulWidget {
  const CommunityCoinKchatWidget(
      {super.key,
      required this.contractInfo,
      required this.type,
      this.onClose});
  final ContractInfo contractInfo;
  final CommunityCoinKChatType type;
  final ValueChanged<ContractInfo>? onClose;

  @override
  State<CommunityCoinKchatWidget> createState() =>
      _CommunityCoinKchatWidgetState();
}

class _CommunityCoinKchatWidgetState extends State<CommunityCoinKchatWidget> {
  List<FlSpot> spotList = [];
  double minY = 0;
  double maxY = 0;
  @override
  void initState() {
    super.initState();
    StandardSocketManager.instance.reqKline(
      widget.contractInfo.subSymbol,
      '1day',
      (symbol, data) {
        if (symbol == widget.contractInfo.subSymbol &&
            data.data != null &&
            mounted) {
          List<KLineEntity> list = data.data
              .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
              .toList()
              .cast<KLineEntity>();
          list.removeWhere((element) =>
              element.open == 0 &&
              element.close == 0 &&
              element.high == 0 &&
              element.low == 0);
          list.sort((a, b) => a.time?.compareTo(b.time ?? 0) ?? 0);
          spotList = list
              .asMap()
              .entries
              .map((e) => FlSpot(e.value.time! * 1.0, e.value.close))
              .toList();
          minY = spotList
              .map((e) => e.y)
              .reduce((value, element) => value < element ? value : element);
          maxY = spotList
              .map((e) => e.y)
              .reduce((value, element) => value > element ? value : element);
          setState(() {});
        }
      },
      pageSize: 20,
    );
  }

// assets/images/community/community_kchart_close.svg
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommodityDataStoreController>(
      id: widget.contractInfo.subSymbol,
      builder: (_) {
        ContractInfo contractInfo = CommodityDataStoreController
                .to.contractSymbolHashMap[widget.contractInfo.subSymbol] ??
            widget.contractInfo;
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.colorBorderSubtle,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.none,
              width: double.infinity,
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.contractInfo.firstName +
                          widget.contractInfo.secondName,
                      style: AppTextStyle.f_14_500.color111111,
                    ),
                    4.horizontalSpace,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      margin: EdgeInsets.only(right: 4.w),
                      decoration: ShapeDecoration(
                        color: AppColor.colorF3F3F3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      child: Text(
                        contractInfo.getContractType,
                        style: AppTextStyle.f_10_500.copyWith(
                          color: AppColor.color4D4D4D,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.contractInfo.close.toPrecision(widget
                              .contractInfo.coinResultVo?.symbolPricePrecision
                              .toInt() ??
                          2),
                      style: AppTextStyle.f_16_600.color111111,
                    ),
                    4.horizontalSpace,
                    Text(
                      contractInfo.roseStr,
                      style: AppTextStyle.f_16_600.copyWith(
                        color: widget.contractInfo.backColor,
                      ),
                    ),
                  ],
                ).marginOnly(left: 17.w, top: 14.h, right: 12.w),
                SizedBox(
                  width: 343.w,
                  height: 60.h,
                  child: spotList.isEmpty
                      ? const CustomLoadingProgressIndicator()
                      : LineChart(
                          LineChartData(
                            lineTouchData: const LineTouchData(enabled: false),
                            gridData: const FlGridData(show: false),
                            titlesData: const FlTitlesData(show: false),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            minX: spotList.first.x,
                            maxX: spotList.last.x,
                            minY: minY,
                            maxY: maxY,
                            lineBarsData: [
                              LineChartBarData(
                                spots: spotList,
                                isCurved: true,
                                barWidth: 1.0,
                                curveSmoothness: 0.5,
                                color: contractInfo.backColor,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      contractInfo.backColor.withOpacity(0.3),
                                      contractInfo.backColor.withOpacity(0.1),
                                      contractInfo.backColor.withOpacity(0.0),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                10.verticalSpace,
              ]),
            ),
            if (widget.type == CommunityCoinKChatType.info)
              Positioned(
                right: 0,
                bottom: 0,
                child: InkWell(
                  onTap: () {
                    goToCommodityKline(contractInfo: contractInfo);
                  },
                  child: MyImage(
                    'assets/images/community/community_kchat_arrow.svg',
                    width: 15.w,
                    height: 15.w,
                  ).marginAll(6.w),
                ),
              ),
            if (widget.type == CommunityCoinKChatType.post)
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () {
                    widget.onClose?.call(contractInfo);
                  },
                  child: MyImage(
                    'assets/images/community/community_kchart_close.svg',
                    width: 15.w,
                    height: 15.w,
                  ).marginAll(6.w),
                ),
              ),
          ],
        );
      },
    );
  }
}
