import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/transation/immediate_exchange/main/widgets/convert_faq_widget.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/no/network_error_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../getX/assets_Getx.dart';
import '../../../../../models/trade/convert_currencies_model.dart';
import '../../../../../utils/utilities/number_util.dart';
import '../controllers/immediate_exchange_controller.dart';
import '../widgets/MyNumberTextInputFormatter.dart';

class ImmediateExchangeView extends GetView<ImmediateExchangeController> {
  const ImmediateExchangeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 手动初始化控制器
    Get.lazyPut(() => ImmediateExchangeController());
    // 控制顶部和底部的内容，可以根据需要调整
    // if (Get.arguments?['showNav'] == true) {
    //   return Scaffold(
    //     appBar: MyAppBar(myTitle: LocaleKeys.trade289.tr),
    //     body: content(context),
    //   );
    // }
    return content(context);
  }

  Widget content(BuildContext context) {
    return GetBuilder<UserGetx>(
        autoRemove: false,
        builder: (logic) {
          return Container(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.trade306.tr, //现货账户
                        style: AppTextStyle.f_16_600.color111111),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ConvertFaqWidget.show();
                            // convertShowConfirmBottomSheet(context);
                          },
                          child: MyImage(
                            'trade/faq_icon'.svgAssets(),
                            width: 18.w,
                            height: 18.w,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Get.log('去历史记录');
                            Get.toNamed(Routes.WALLET_HISTORY,
                                arguments: 3); //TODO: 路由参数, 3 代表闪兑 tab 后期优化
                          },
                          child: MyImage(
                            'trade/hstory_icon'.svgAssets(),
                            width: 18.w,
                            height: 18.w,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Obx(() {
                  if (controller.toCoinModel.value == null ||
                      controller.fromCoinModel.value == null) {
                    return Center(child: Center(
                      child: NetworkErrorWidget(
                          //网络重试
                          onTap: () async {
                        await controller.fetchCurrenciesData();
                        if (controller.baseList.value.isNotEmpty &&
                            controller.quoteList.value.isNotEmpty) {
                          controller.update();
                        }
                      }),
                    )); //TODO: 添加网络重试
                  }
                  return Column(
                    children: [
                      Container(
                        // padding: EdgeInsets.all(16.0.w),
                        color: AppColor.colorFFFFFF,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Obx(() {
                              Get.log('--->${controller.baseList.length}');
                              return Column(
                                children: [
                                  // 顶部的Container
                                  _buildSellCurrencyContainer(
                                      model: controller.fromCoinModel.value),
                                  SizedBox(height: 10.0.h), // 留空中间空间
                                  // 底部的Container
                                  _buildBuyCurrencyContainer(
                                      model: controller.toCoinModel.value),
                                ],
                              );
                            }),
                            Obx(() {
                              return AnimatedPositioned(
                                duration: const Duration(milliseconds: 300),
                                left: 16.w,
                                right: 16.w,
                                top: controller.isChange.value ? 166.h : 38.h,
                                child: Obx(() {
                                  if (controller.toCoinModel.value == null ||
                                      controller.fromCoinModel.value == null) {
                                    return Container();
                                  }
                                  return selectInputWidget(
                                      onSelectCurrency:
                                          controller.onSelectFromCurrency,
                                      model: controller.fromCoinModel.value!,
                                      controller:
                                          controller.fromEditingController,
                                      focusNode: controller.formFocusNode);
                                }),
                              );
                            }),
                            Obx(() {
                              return AnimatedPositioned(
                                duration: const Duration(milliseconds: 300),
                                left: 16.w,
                                right: 16.w,
                                top: !controller.isChange.value ? 166.h : 38.h,
                                child: Obx(() {
                                  if (controller.toCoinModel.value == null ||
                                      controller.fromCoinModel.value == null) {
                                    return Container();
                                  }
                                  return selectInputWidget(
                                      onSelectCurrency: () {
                                        controller.onSelectFromCurrency(
                                            isGet: true);
                                      },
                                      model: controller.toCoinModel.value!,
                                      controller:
                                          controller.toEditingController,
                                      focusNode: controller.toFocusNode);
                                }),
                              );
                            }),
                            Align(
                              alignment: Alignment.center,
                              child: ChangeWidget(controller: controller),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        if (controller.convertQuickQuoteRate.value == null) {
                          return Container();
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.isChange.value == false)
                              Text(
                                '1 ${controller.fromCoinModel.value?.symbol} ≈ ${NumberUtil.mConvert('${1 / num.parse(controller.convertQuickQuoteRate.value!.sellPrice!)}', count: controller.toCoinModel.value!.precision, isTruncate: true)} ${controller.toCoinModel.value?.symbol}',
                                style: AppTextStyle.f_12_400.color999999,
                              ),
                            if (controller.isChange.value)
                              Text(
                                '1 ${controller.toCoinModel.value?.symbol} ≈ ${controller.convertQuickQuoteRate.value?.buyPrice} ${controller.fromCoinModel.value?.symbol}',
                                style: AppTextStyle.f_12_400.color999999,
                              ),
                            8.horizontalSpace,
                            SizedBox(
                              height: 12.w,
                              width: 12.w,
                              child: CircularProgressIndicator(
                                color: AppColor.colorFFD429,
                                strokeWidth: 1.75,
                              ),
                            ),
                          ],
                        ).marginOnly(top: 16.w);
                      }),
                      SizedBox(height: 16.h),
                      InkWell(
                        onTap: () {
                          if (UserGetx.to.goIsLogin()) {
                            if (controller.balanceError.value) {
                              return;
                            }
                            if (controller.toError.value ||
                                controller.fromError.value) {
                              return;
                            }
                            if (!controller.balanceError.value) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.confirm();
                            }
                          } else {
                            controller.fromEditingController.clear();
                            controller.toEditingController.clear();
                            controller.fromError.value = false;
                            controller.toError.value = false;
                            controller.balanceError.value = false;
                          }
                        },
                        child: Obx(() {
                          var isEmpty = controller.fromValue.isEmpty;
                          if (controller.balanceError.value) {
                            isEmpty = true;
                          }
                          if (controller.toError.value ||
                              controller.fromError.value) {
                            isEmpty = true;
                          }
                          return Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: UserGetx.to.isLogin
                                  ? (isEmpty
                                      ? AppColor.colorCCCCCC
                                      : AppColor.color0C0D0F)
                                  : AppColor.color0C0D0F,
                            ),
                            child: Stack(
                              children: [
                                // 左侧黄色标签
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.colorFFD429,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(23.r),
                                      bottomLeft: Radius.circular(1.r),
                                      topRight: Radius.circular(1.r),
                                      bottomRight: Radius.circular(12.r),
                                    ),
                                  ),
                                  child: Text(
                                    LocaleKeys.trade293.tr, // 0 手续费
                                    style: AppTextStyle.f_11_500.color111111,
                                  ),
                                ),
                                // Expanded 用于让 Text 占据剩余空间并居中
                                Center(
                                    child: Text(
                                  UserGetx.to.isLogin
                                      ? LocaleKeys.trade298.tr // 预览兑换结果
                                      : LocaleKeys.user6.tr, // 登录
                                  style: AppTextStyle.f_16_600.colorFFFFFF,
                                ))
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                })
              ],
            ),
          );
        }).marginSymmetric(horizontal: 16.w);
  }

  // 生成顶部的Currency Container
  Widget _buildSellCurrencyContainer({
    CoinModel? model,
  }) {
    return GetBuilder<AssetsGetx>(
        autoRemove: false,
        builder: (logic) {
          return Container(
            height: 112.h,
            decoration: BoxDecoration(
              color: AppColor.colorF5F5F5,
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: Column(
              children: [
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.trade291.tr, //消耗
                        style: AppTextStyle.f_11_500.color999999),
                    Visibility(
                        child: Row(
                          children: [
                            Obx(() {
                              var model = controller.isChange.value
                                  ? controller.toCoinModel.value
                                  : controller.fromCoinModel.value;
                              return Text(
                                  //可用:
                                  '${LocaleKeys.trade351.tr}${controller.getUsable(model!)} ${model.symbol}',
                                  style: AppTextStyle.f_11_400.color999999);
                            }),
                            4.horizontalSpace,
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.log('去划转');
                                try {
                                  final bool res = await Get.toNamed(
                                      Routes.ASSETS_TRANSFER,
                                      arguments: {"from": 4, "to": 3});
                                  if (res) {
                                    UIUtil.showSuccess(LocaleKeys.assets10.tr);
                                    AssetsGetx.to.getTotalAccountBalance();
                                  }
                                } catch (e) {
                                  Get.log(e.toString());
                                }
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.only(
                                    left: 5.w,
                                    right: 8.w,
                                    top: 10.w,
                                    bottom: 10.w),
                                child: MyImage(
                                  'assets/images/trade/convert_transfer_icon.svg',
                                  width: 10.w,
                                  height: 10.w,
                                ),
                              ),
                            )
                          ],
                        ),
                        visible: UserGetx.to.isLogin),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    Visibility(
                        child: Obx(() {
                          if (controller.isChange.value) {
                            if (controller.toError.value) {
                              return Text(
                                LocaleKeys.trade356.tr, // '余额不足',
                                style: AppTextStyle.f_10_400.colorDanger,
                              );
                            }
                          } else {
                            if (controller.fromError.value) {
                              return Text(
                                LocaleKeys.trade356.tr, // '余额不足',
                                style: AppTextStyle.f_10_400.colorDanger,
                              );
                            }
                          }
                          if (controller.balanceError.value) {
                            return Row(
                              children: [
                                Text(
                                  LocaleKeys.trade352.tr, // '余额不足',
                                  style: AppTextStyle.f_10_400.colorDanger,
                                ),
                                12.horizontalSpace,
                                GestureDetector(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    Get.toNamed(Routes.CURRENCY_SELECT,
                                        arguments: {
                                          'type':
                                              AssetsCurrencySelectEnumn.depoit
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.w, horizontal: 10.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.w),
                                        border: Border.all(
                                            color: AppColor.colorABABAB,
                                            width: 0.5.w)),
                                    child: Text(
                                      LocaleKeys.trade353.tr, // '充币',
                                      style: AppTextStyle.f_10_400.color111111,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          var model = controller.isChange.value
                              ? controller.toCoinModel.value
                              : controller.fromCoinModel.value;
                          if (num.parse(controller.getUsable(model!)) > 0) {
                            return GestureDetector(
                              onTap: () {
                                if (controller.isChange.value) {
                                  controller.toEditingController.text =
                                      '${controller.getUsable(model!)}';
                                  controller.toFocusNode.requestFocus();
                                } else {
                                  controller.fromEditingController.text =
                                      '${controller.getUsable(model!)}';
                                  controller.formFocusNode.requestFocus();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.w, horizontal: 10.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.w),
                                    border: Border.all(
                                        color: AppColor.colorABABAB,
                                        width: 0.5.w)),
                                child: Text(
                                  LocaleKeys.trade354.tr, //'最大',
                                  style: AppTextStyle.f_10_400.color111111,
                                ),
                              ),
                            );
                          }
                          return Container();
                        }),
                        visible: UserGetx.to.isLogin),
                  ],
                ),
                SizedBox(height: 12.h),
              ],
            ).marginOnly(left: 16.w, right: 16.w),
          );
        });
  }

  Widget _buildBuyCurrencyContainer({CoinModel? model}) {
    return GetBuilder<AssetsGetx>(
      autoRemove: false,
      builder: (logic) {
        return Container(
          height: 112.h,
          decoration: BoxDecoration(
            color: AppColor.colorF5F5F5,
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.trade292.tr, //获得
                      style: AppTextStyle.f_11_500.color999999), //获得
                  Visibility(
                      child: Row(
                        children: [
                          Obx(() {
                            var model = !controller.isChange.value
                                ? controller.toCoinModel.value
                                : controller.fromCoinModel.value;
                            return Text(
                                '${LocaleKeys.trade351.tr}${controller.getUsable(model!)} ${model.symbol}',
                                style: AppTextStyle.f_11_400.color999999);
                          }),
                          // 4.horizontalSpace,
                          // MyImage('assets/images/default/icons_line.svg',width: 10.w,height: 10.w,)
                        ],
                      ),
                      visible: UserGetx.to.isLogin),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  Visibility(
                      child: Obx(() {
                        if (controller.isChange.value) {
                          if (controller.fromError.value) {
                            return Text(
                              LocaleKeys.trade356.tr, // '余额不足',
                              style: AppTextStyle.f_10_400.colorDanger,
                            );
                          }
                        } else {
                          if (controller.toError.value) {
                            return Text(
                              LocaleKeys.trade356.tr, // '余额不足',
                              style: AppTextStyle.f_10_400.colorDanger,
                            );
                          }
                        }
                        return Container();
                      }),
                      visible: UserGetx.to.isLogin),
                ],
              ),
              SizedBox(height: 12.h),
            ],
          ).marginOnly(left: 16.w, right: 16.w),
        );
      },
    );
  }

  Widget getCoinBtnWidget({Function? onTap, CoinModel? model}) {
    if (model == null) {
      return Container();
    }
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        child: Row(
          children: [
            Row(
              children: [
                MyImage(
                  '${model!.icon}', // coinIcon
                  width: 24.w,
                  height: 24.w,
                ),
              ],
            ),
            SizedBox(width: 8.w),
            Row(
              children: [
                Text('${model!.symbol}', //TODO:
                    style: AppTextStyle.f_16_600.color111111),
                SizedBox(width: 2.w),
                MyImage(
                  'my/assets_exchange_rate'.svgAssets(),
                  width: 7.w,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget selectInputWidget(
      {required Function onSelectCurrency,
      required CoinModel model,
      required TextEditingController controller,
      FocusNode? focusNode}) {
    Get.log('--------->${model.precision}');
    return Row(
      children: <Widget>[
        getCoinBtnWidget(onTap: onSelectCurrency, model: model),
        Expanded(
            child: TextField(
                focusNode: focusNode,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.end,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9.]')), //设置只允许输入数字
                  MyNumberTextInputFormatter(digit: model.precision!),
                ],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: '${model?.min}~${model?.max}',
                    hintStyle: AppTextStyle.f_24_600.colorDDDDDD),
                controller: controller,
                style: AppTextStyle.f_24_600.color111111)),
      ],
    );
  }
}

class ChangeWidget extends StatefulWidget {
  const ChangeWidget({
    super.key,
    required this.controller,
  });

  final ImmediateExchangeController controller;

  @override
  State<ChangeWidget> createState() => _ChangeWidgetState();
}

class _ChangeWidgetState extends State<ChangeWidget> {
  double turns = 0;

  void rotate() {
    widget.controller.isChange.value = !widget.controller.isChange.value;
    widget.controller.startTimer();
    setState(() {
      turns += 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          rotate();
        },
        child: AnimatedRotation(
          // key: Key('center_${widget.controller.isChange.value}'),
          duration: const Duration(milliseconds: 300),
          turns: turns,
          child: MyImage(
            'trade/convert_icon'.svgAssets(),
            width: 30.w,
            height: 30.w,
          ),
        ));
  }
}
