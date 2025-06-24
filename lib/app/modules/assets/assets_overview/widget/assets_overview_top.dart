import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/widget/account_view.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_balance.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import '../../../../widgets/components/assets/assets_profit.dart';
import '../../../assets/assets_overview/controllers/assets_overview_controller.dart';

class AssetsOverviewTop extends StatelessWidget {
  const AssetsOverviewTop({super.key, required this.assetsGetx, required this.controller});

  final AssetsGetx assetsGetx;
  final AssetsOverviewController controller;

  @override
  Widget build(BuildContext context) {
    return controller.isEmptyView
        ? SliverToBoxAdapter(child: getView())
        : Obx(() => SliverToBoxAdapter(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                height: controller.height.value.w,
                // color: Colors.green,
                child: getView(),
              ),
            ));
  }

  Widget getView() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    AssetsBalance(
                      title: LocaleKeys.assets5.tr,
                      balance: assetsGetx.totalBalance,
                    ),
                    SizedBox(height: 2.w),
                    AssetsProfit(
                        valueNum: assetsGetx.pnlAmount,
                        title: LocaleKeys.assets12.tr,
                        value: NumberUtil.mConvert(assetsGetx.pnlAmount, isEyeHide: true, isRate: IsRateEnum.usdt, count: 2),
                        isTitleDotted: true,
                        percent: assetsGetx.pnlRate,
                        onTap: () {
                          UIUtil.showAlert(LocaleKeys.assets12.tr, content: LocaleKeys.assets59.tr);
                        }),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: [
                      // GestureDetector(
                      //   onTap: () {

                      //   },
                      //   child: Row(
                      //     children: <Widget>[
                      //       MyImage(
                      //         'assets/asset_kline'.svgAssets(),
                      //         width: 16.w,
                      //         height: 16.w,
                      //       ),
                      //       Text('Analysis', style: AppTextStyle.small_500.color4D4D4D).paddingOnly(left: 4.w)
                      //     ],
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          showAssetsSheetView(
                              title: LocaleKeys.assets165.tr,
                              array: controller.historyDataArray,
                              callback: (i) {
                                controller.goHistory(i);
                              });
                        },
                        child: MyImage(
                          'assets/asset_history'.svgAssets(),
                          width: 16.w,
                          height: 16.w,
                        ).paddingOnly(left: 16.w),
                      ),
                    ],
                  ),
                  controller.isEmptyView
                      ? SizedBox(height: 33.w)
                      : GestureDetector(
                          onTap: () {
                            if (controller.defaltHeight < controller.topHeight) {
                              controller.height.value = controller.topHeight;
                            }
                          },
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: controller.isDefault ? 1 : 0,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15.w),
                                width: 75.w,
                                height: 33.w,
                                child: AssetsStockChart(profitRateList: controller.klineArr),
                              )),
                        ),
                ],
              )
            ],
          ),
          controller.isEmptyView
              ? const SizedBox()
              : AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: controller.isDefault ? 0 : 1,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    height: controller.height.value.w - controller.defaltHeight.w,
                    child: AssetsStockChart(haveBottom: true, profitRateList: controller.klineArr),
                  ),
                ),
          controller.isEmptyView
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    controller.height.value = controller.topHeight;
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: controller.isDefault ? 0 : 0.5,
                      child: MyImage(
                        'assets/asset_arrowup'.svgAssets(),
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

showAssetsSheetView(
    {required String title,
    String? des,
    required List<String> array,
    List<String>? desArray,
    required Function(int) callback}) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CustomAssetsBottomSheet(title: title, des: des, array: array, desArray: desArray, callback: callback),
      );
    },
  );
}

class CustomAssetsBottomSheet extends StatelessWidget {
  const CustomAssetsBottomSheet({super.key, required this.array, this.callback, required this.title, this.des, this.desArray});
  final String title;
  final String? des;

  final List<String> array;
  final List<String>? desArray;

  final Function(int)? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(title, style: AppTextStyle.f_18_600.color111111),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: MyImage(
                    'assets/assets_close'.svgAssets(),
                    fit: BoxFit.fill,
                    width: 16.w,
                    height: 16.w,
                  ),
                ),
                onTap: () {
                  Get.back();
                },
              )
            ],
          ).marginOnly(bottom: 20.w),
          des != null ? Text(des!, style: AppTextStyle.f_13_400.color4D4D4D).paddingOnly(bottom: 16.w) : const SizedBox(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: array.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Get.back();
                    callback?.call(index);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: AppColor.colorF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                array[index],
                                style: AppTextStyle.f_15_600.color111111,
                              ),
                              desArray != null
                                  ? Text(
                                      desArray![index],
                                      style: AppTextStyle.f_12_400.color666666,
                                    ).paddingOnly(top: 4.w)
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        MyImage(
                          'assets/assets_go'.svgAssets(),
                          width: 24.w,
                        )
                      ],
                    ),
                  ));
            },
          )
        ],
      ),
    );
  }
}
