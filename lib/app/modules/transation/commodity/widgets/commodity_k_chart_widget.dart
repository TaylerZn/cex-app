import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:k_chart/chart_style.dart';
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:k_chart/renderer/main_renderer.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commdity_kchar_controller.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/custom_loading_progress_indicator.dart';

import '../../widgets/price/widgets/kchart/model/sub_time.dart';

class CommodityStateRx {
  RxList<KLineEntity> kLineData = RxList<KLineEntity>();
  RxBool isLoading = false.obs;
  Rx<SubTime> subTime = SubTime.commodity()[3].obs;
  Rx<MainState> mainState = MainState.MA.obs;
  RxBool isShowVol = true.obs;
  Rx<SecondaryState> secondaryState = SecondaryState.MACD.obs;
}

final Map<String, MainState> _mainStateMap = {
  'MA': MainState.MA,
  'BOLL': MainState.BOLL,
};

final Map<String, SecondaryState> _secondaryStateMap = {
  'MACD': SecondaryState.MACD,
  'RSI': SecondaryState.RSI,
  'KDJ': SecondaryState.KDJ,
  'WR': SecondaryState.WR,
  // 'CCI': SecondaryState.CCI,
};

class CommodityKChartWidget extends GetView<CommodityKChartController> {
  const CommodityKChartWidget(this.isDetail, {super.key});
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColor.colorBorderGutter,
                width: 0.5,
              ),
            ),
          ),
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: SubTime.commodity()
                .map((e) => Obx(() {
                      return _subTimeItem(
                          e, e.id == controller.state.subTime.value.id, () {
                        controller.changeSubTime(e);
                      });
                    }))
                .toList(),
          ),
        ),
        SizedBox(
          height: isDetail ? 350.h : 156.h,
          child: Obx(() {
            if (controller.state.isLoading.value) {
              return const CustomLoadingProgressIndicator();
            }
            return KChartWidget(
              controller.state.kLineData.value,
              ChartStyle(),
              ChartColors(),
              isLine: controller.state.subTime.value.id == 1,
              onSecondaryTap: () {},
              isTrendLine: false,
              mainState:
                  isDetail ? controller.state.mainState.value : MainState.MA,
              volHidden: isDetail ? !controller.state.isShowVol.value : true,
              secondaryState: isDetail
                  ? controller.state.secondaryState.value
                  : SecondaryState.NONE,
              timeFormat: TimeFormat.YEAR_MONTH_DAY,
              translations: kChartTranslations,
              showNowPrice: isDetail,
              hideGrid: false,
              isTapShowInfoDialog: isDetail,
              isOnDrag: (value) {},
              verticalTextAlignment: VerticalTextAlignment.right,
              onLoadMore: (value) {
                if (!value) {
                  controller.onLoadMore();
                }
              },
            );
          }),
        ),
        if (isDetail) _buildStateWidget(),
      ],
    );
  }

  Widget _subTimeItem(SubTime subTime, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 20.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.colorBackgroundSecondary
              : AppColor.transparent,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Text(
          subTime.title,
          style: isSelected
              ? AppTextStyle.f_12_500.color111111
              : AppTextStyle.f_12_500.colorABABAB,
        ),
      ),
    );
  }

  _buildStateWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1.w,
          ),
          top: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1.w,
          ),
        ),
      ),
      height: 30.h,
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          8.horizontalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: _mainStateMap.entries
                .map((e) => Obx(() {
                      return InkWell(
                          onTap: () => controller.onMainStateChanged(e.value),
                          child: _buildStateItem(e.key,
                              e.value == controller.state.mainState.value));
                    }))
                .toList(),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            height: 12.h,
            width: 1.w,
            color: AppColor.colorEEEEEE,
          ),
          Row(mainAxisSize: MainAxisSize.min, children: [
            /// VOL深度特殊处理
            Obx(() {
              return InkWell(
                  onTap: () {
                    controller.state.isShowVol.toggle();
                  },
                  child:
                      _buildStateItem('VOL', controller.state.isShowVol.value));
            }),
            ..._secondaryStateMap.entries.map((e) => Obx(() {
                  return InkWell(
                    onTap: () {
                      controller.onSecondaryStateChanged(e.value);
                    },
                    child: _buildStateItem(e.key,
                        e.value == controller.state.secondaryState.value),
                  );
                }))
          ]),
          8.horizontalSpace,
        ],
      ),
    );
  }

  Widget _buildStateItem(String title, bool isSelected) {
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColor.color111111 : AppColor.color999999),
      ),
    );
  }
}
