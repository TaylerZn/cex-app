import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k_chart/chart_style.dart';
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:k_chart/renderer/main_renderer.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../../config/theme/app_color.dart';
import '../../../../../../widgets/components/popup_window.dart';
import '../../../../../../widgets/components/transaction/custom_loading_progress_indicator.dart';
import 'kline_time_widget.dart';
import 'model/sub_time.dart';

class RxKChartState {
  RxList<KLineEntity> datas = RxList<KLineEntity>();
  Rx<MainState> mainState = MainState.MA.obs;
  Rx<SecondaryState> secondaryState = SecondaryState.MACD.obs;
  RxBool isShowVol = true.obs;
  Rx<SubTime> subTime = SubTime(LocaleKeys.trade183.tr, 1, '15min').obs;
  RxList<DepthEntity> asks = RxList<DepthEntity>();
  RxList<DepthEntity> bids = RxList<DepthEntity>();
  RxBool isShowDepth = true.obs;
  RxBool isLoading = true.obs;
}

class KChartDetailWidget extends StatelessWidget {
  KChartDetailWidget({
    super.key,
    required this.state,
    required this.onSubTimeChanged,
    required this.onMainStateChanged,
    required this.onSecondaryStateChanged,
    required this.onLoadMore,
  });

  final RxKChartState state;
  final ValueChanged<SubTime> onSubTimeChanged;
  final ValueChanged<MainState> onMainStateChanged;
  final ValueChanged<SecondaryState> onSecondaryStateChanged;
  final VoidCallback onLoadMore;

  final GlobalKey _moreKey = GlobalKey();

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildToolBar(),
        Column(
          children: [
            _buildChart(),
            _buildStateWidget(),
          ],
        ),
      ],
    );
  }

  _buildChart() {
    return Container(
      height: 400.h,
      padding: const EdgeInsets.only(right: 4),
      child: Obx(() {
        if (state.isLoading.value) {
          return const CustomLoadingProgressIndicator();
        }
        return KChartWidget(
          state.datas.value,
          ChartStyle(),
          ChartColors(),
          isLine: state.subTime.value.id == 8,
          onSecondaryTap: () {},
          isTrendLine: false,
          mainState: state.mainState.value,
          volHidden: !state.isShowVol.value,
          secondaryState: state.secondaryState.value,
          timeFormat: TimeFormat.YEAR_MONTH_DAY,
          translations: kChartTranslations,
          showNowPrice: true,
          hideGrid: false,
          isTapShowInfoDialog: true,
          verticalTextAlignment: VerticalTextAlignment.right,
          onLoadMore: (value) {
            if (!value) {
              onLoadMore();
            }
          },
        );
      }),
    );
  }

  _buildToolBar() {
    return Container(
      height: 32.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorBorderGutter,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: SubTime.tools().asMap().entries.map((e) {
          SubTime item = SubTime.tools()[e.key];
          String title = item.title;
          return Obx(() {
            // 当前是更多
            bool isSelected = state.subTime.value.id == item.id;
            if (e.key == 6) {
              isSelected = [9, 10, 11, 13].contains(state.subTime.value.id);
              if ([9, 10, 11, 13].contains(state.subTime.value.id)) {
                title = state.subTime.value.title;
              }
            }
            return InkWell(
              key: item.id == 5 ? _moreKey : ValueKey(item.id),
              onTap: () {
                if (item.id == 5) {
                  _showMore(Get.context!);
                  return;
                }
                onSubTimeChanged(item);
              },
              child: Center(
                child: Container(
                  height: 20.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  alignment: Alignment.center,
                  decoration: isSelected
                      ? BoxDecoration(
                          color: AppColor.colorBackgroundSecondary,
                          borderRadius: BorderRadius.circular(15.w),
                        )
                      : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.f_12_500.copyWith(
                          color: isSelected
                              ? AppColor.color111111
                              : AppColor.colorABABAB,
                        ),
                      ),
                      if ([5, 7].contains(item.id))
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 14.sp,
                          color: AppColor.color999999,
                        ).marginOnly(left: 2.w),
                    ],
                  ),
                ),
              ),
            );
          });
        }).toList(),
      ),
      // child: ListView.builder(
      //   itemCount: SubTime.tools().length,
      //   padding: EdgeInsets.only(left: 6.w),
      //   physics: const NeverScrollableScrollPhysics(),
      //   scrollDirection: Axis.horizontal,
      //   itemBuilder: (BuildContext context, int index) {
      //
      //   },
      // ),
    );
  }

  _buildStateWidget() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorBorderGutter,
            width: 0.5,
          ),
          top: BorderSide(
            color: AppColor.colorBorderGutter,
            width: 0.5,
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
                          onTap: () => onMainStateChanged(e.value),
                          child: _buildStateItem(
                              e.key, e.value == state.mainState.value));
                    }))
                .toList(),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            height: 12.h,
            width: 1.w,
            color: AppColor.colorEEEEEE,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                return InkWell(
                  onTap: () {
                    state.isShowVol.toggle();
                  },
                  child: _buildStateItem('VOL', state.isShowVol.value),
                );
              }),
              ..._secondaryStateMap.entries.map((e) => Obx(() {
                    return InkWell(
                      onTap: () {
                        onSecondaryStateChanged(e.value);
                      },
                      child: _buildStateItem(
                          e.key, e.value == state.secondaryState.value),
                    );
                  })),
            ],
          ),
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

  void _showMore(BuildContext context) {
    int selectIndex = SubTime.mores()
        .indexWhere((element) => element.id == state.subTime.value.id);

    PopupWindow.showPopWindow(
        context: context,
        popWidget: KLineTimeWidget(
            timeList: SubTime.mores().map((e) => e.title).toList(),
            selectIndex: selectIndex,
            onValueChanged: (value) {
              onSubTimeChanged(SubTime.mores()[value]);
              Get.back();
            }),
        popKey: _moreKey);
  }
}
