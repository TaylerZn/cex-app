import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../enums/public.dart';
import '../../../../../getX/assets_Getx.dart';
import '../../../../../models/assets/assets_spots.dart';
import '../../../../../models/trade/convert_currencies_model.dart';
import '../../../../../utils/utilities/number_util.dart';
import '../../../../../widgets/basic/my_image.dart';
import '../controllers/immediate_exchange_controller.dart';

class SelectCurrencyDialog extends StatefulWidget {
  final List<CoinModel> baseList;
  final List<CoinModel> quoteList;

  final CoinModel fromCoinModel;
  final CoinModel toCoinModel;
  final bool isGet;
  final bool isChange;
  final Function(CoinModel, CoinModel)? callBack;

  const SelectCurrencyDialog({
    super.key,
    required this.baseList,
    required this.quoteList,
    this.isGet = false,
    required this.fromCoinModel,
    required this.toCoinModel,
    this.callBack,
    this.isChange = false,
  });

  @override
  State<SelectCurrencyDialog> createState() => _SelectCurrencyDialogState();
}

class _SelectCurrencyDialogState extends State<SelectCurrencyDialog> {
  bool showClear = false;
  TextEditingController controller = TextEditingController();
  final logic = Get.find<ImmediateExchangeController>();
  RxBool isGet = false.obs;
  Rxn<CoinModel> fromCoinModel = Rxn();
  Rxn<CoinModel> toCoinModel = Rxn();
  Rx<String> keyword = ''.obs;

  @override
  void initState() {
    controller = TextEditingController()
      ..addListener(() {
        keyword.value = controller.text.trim();
        showClear = keyword.isNotEmpty;
      });
    isGet.value = widget.isGet;
    fromCoinModel.value = widget.fromCoinModel;
    toCoinModel.value = widget.toCoinModel;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
      decoration: BoxDecoration(
          color: AppColor.bgColorLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w),
            topRight: Radius.circular(20.w),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.trade299.tr, //'选择币种',
            style: AppTextStyle.f_20_600.color111111,
          ),
          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.all(4.w),
            height: 65.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w),
                color: AppColor.colorF9F9F9),
            child: Obx(() {
              return Row(
                children: [
                  _buildSelectBox(LocaleKeys.trade291.tr, !isGet.value, () {
                    //消耗
                    isGet.value = false;
                  },
                      widget.isChange
                          ? toCoinModel.value!
                          : fromCoinModel.value!),
                  _buildSelectBox(LocaleKeys.trade292.tr, isGet.value, () {
                    isGet.value = true;
                  },
                      widget.isChange
                          ? fromCoinModel.value!
                          : toCoinModel.value!),
                ],
              );
            }),
          ),
          SizedBox(
            height: 14.w,
          ),
          _buildSearchTextFiled(),
          SizedBox(
            height: 14.w,
          ),
          Expanded(child: Obx(() {
            List<CoinModel> items = [];
            if (widget.isChange) {
              if (isGet.value) {
                widget.quoteList.forEach((element) {
                  items.add(element);
                });
              } else {
                widget.baseList.forEach((element) {
                  items.add(element);
                });
              }
            } else {
              if (isGet.value) {
                widget.baseList.forEach((element) {
                  items.add(element);
                });
              } else {
                widget.quoteList.forEach((element) {
                  items.add(element);
                });
              }
            }
            if (keyword.isNotEmpty) {
              items.removeWhere((element) => !(element.symbol
                      ?.toLowerCase()
                      .contains(keyword.value.toLowerCase()) ??
                  true));
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                CoinModel model = items[index];
                return buildContainer(model, onTap: () {
                  if (!isGet.value) {
                    if (widget.isChange) {
                      toCoinModel.value = model;
                    } else {
                      fromCoinModel.value = model;
                    }
                    isGet.value = true;
                  } else {
                    if (widget.isChange) {
                      fromCoinModel.value = model;
                    } else {
                      toCoinModel.value = model;
                    }

                    widget.callBack
                        ?.call(fromCoinModel.value!, toCoinModel.value!);
                    Get.back();
                  }
                });
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 4.w,
                );
              },
              itemCount: items.length,
            );
          })),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 48.w,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.colorABABAB, width: 1.w),
                  borderRadius: BorderRadius.circular(48.w)),
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.trade301.tr, //'取消',
                style: AppTextStyle.f_16_600.color111111,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildContainer(CoinModel model, {Function? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 52.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyImage(
              '${model.icon}', // coinIcon
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              '${model.symbol}',
              style: AppTextStyle.f_15_600.color111111,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Spacer(),
                    Builder(builder: (context) {
                      AssetSpotsAllCoinMapModel? map =
                          logic.getAssetSpotsAllCoinMapModel(model);
                      if (map == null) {
                        return Container();
                      }
                      return Text(
                        '${NumberUtil.mConvert(
                            // TODO: JH 26.USDT资产数量精度错误
                            (model.symbol == "USDT") ? map.usdtValuatin //JH: 加个补丁,总览币种USDT时加个allBalance 加上了和合约和跟单资产的总和,这里直换用usdtValuatin
                                : map.allBalance, count: !TextUtil.isEmpty(AssetsGetx.to.currentRate?.coinPrecision) //???: 这里的精度需要时当前法币的精度?
                                ? int.parse(AssetsGetx.to.currentRate!.coinPrecision.toString()) : 2, isEyeHide: true, isTruncate: true)}',
                        style: AppTextStyle.f_15_600.color111111,
                      );
                    })
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    Builder(builder: (context) {
                      AssetSpotsAllCoinMapModel? map =
                          logic.getAssetSpotsAllCoinMapModel(model);
                      if (map == null) {
                        return Container();
                      }
                      return Text(
                        '≈\$${NumberUtil.mConvert(map.usdtValuatin, //TODO: JH7.币种价格错了
                            isEyeHide: true, count: !TextUtil.isEmpty(AssetsGetx.to.currentRate?.coinPrecision) ? int.parse(AssetsGetx.to.currentRate!.coinPrecision.toString()) : 2, isRate: IsRateEnum.usdt, isTruncate: true)}',
                        style: AppTextStyle.f_11_400.color666666,
                      );
                    })
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildSelectBox(
      String title, bool select, Function onTap, CoinModel model) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap.call();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
              color: select ? AppColor.bgColorLight : null,
              borderRadius: BorderRadius.circular(8.w)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${title}',
                style: AppTextStyle.f_13_400.color999999,
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyImage(
                    '${model.icon}', // coinIcon
                    width: 20.w,
                    height: 20.w,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    '${model.symbol}',
                    style: AppTextStyle.f_14_600.color111111,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextFiled() {
    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        color: AppColor.colorF5F5F5,
        borderRadius: BorderRadius.circular(50.r),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          16.horizontalSpace,
          MyImage(
            'assets/images/contract/search_icon.png',
            width: 16.w,
            height: 16.w,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: controller,
              style: TextStyle(fontSize: 12.sp),
              cursorColor: AppColor.color111111,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 6.w),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                disabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: LocaleKeys.public11.tr,//'请输入关键词搜索',
                hintStyle: TextStyle(
                  color: AppColor.colorABABAB,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: showClear
                    ? IconButton(
                        icon: const Icon(
                          Icons.highlight_remove_rounded,
                          color: AppColor.colorBlack,
                        ),
                        onPressed: () {
                          controller.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
