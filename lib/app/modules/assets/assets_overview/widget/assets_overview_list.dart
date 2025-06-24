import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/model/assets_exchange_rate.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/widget/account_view.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots/views/asset_search_textField.dart';
import 'package:nt_app_flutter/app/modules/otc/b2c/widget/otc_open_bottom_dialog.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../widgets/basic/my_image.dart';
import '../../../assets/assets_overview/controllers/assets_overview_controller.dart';

class AssetsOverviewList extends StatelessWidget {
  const AssetsOverviewList({super.key, required this.assetsGetx, required this.controller});

  final AssetsGetx assetsGetx;
  final AssetsOverviewController controller;

  @override
  Widget build(BuildContext context) {
    return controller.isEmptyView ? getEmptyView() : getListView();
  }

  Widget getEmptyView() {
    return SliverList.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.w, 16.w, 0),
                child: Column(
                  children: [
                    Lottie.asset('assets/json/asset_plane.json', height: 171.w, repeat: true),
                    Text(LocaleKeys.assets148.tr, style: AppTextStyle.f_16_600.color333333).paddingOnly(bottom: 8.w),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: LocaleKeys.assets149.tr, style: AppTextStyle.f_13_400.color666666),
                          TextSpan(text: '\$888', style: AppTextStyle.f_13_600.copyWith(color: const Color(0xFFEEAF00))),
                          TextSpan(text: LocaleKeys.assets150.tr, style: AppTextStyle.f_13_400.color666666),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    MyButton(
                      backgroundColor: Colors.black,
                      borderRadius: const BorderRadius.all((Radius.circular(48))),
                      height: 48.h,
                      onTap: () {
                        otcBottomDialog(context);
                      },
                      child: Text(LocaleKeys.assets151.tr, style: AppTextStyle.f_16_600.colorWhite),
                    ).paddingSymmetric(vertical: 24.w),
                    InkWell(
                      onTap: () {
                        RouteUtil.goTo('/otc-b2c');
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text(LocaleKeys.assets164.tr, style: AppTextStyle.f_16_600.color111111)),
                          MyImage(
                            'default/go'.svgAssets(),
                            width: 16.w,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.fiatArr?.isNotEmpty == true
                  ? Container(
                      height: 94.w,
                      margin: EdgeInsets.only(top: 16.w),
                      child: WaterfallFlow.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.fiatArr!.length,
                        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.w,
                        ),
                        itemBuilder: (context, index) {
                          var model = controller.fiatArr![index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.CUSTOMER_MAIN, arguments: {'index': 0, 'currency': model.currencyStr});
                            },
                            child: Container(
                                padding: EdgeInsets.fromLTRB(12.w, 10.w, 42.w, 10.w),
                                margin: EdgeInsets.only(
                                    left: index == 0 ? 16.w : 0, right: index == (controller.fiatArr!.length - 1) ? 16.w : 0),
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    border: Border.all(color: AppColor.colorEEEEEE),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        MyImage(
                                          model.iconStr,
                                          width: 32.w,
                                          height: 32.w,
                                        ),
                                        SizedBox(width: 8.w),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(model.currencyStr, style: AppTextStyle.f_14_500.color111111),
                                            Text(model.countryNameStr, style: AppTextStyle.f_10_400.color666666),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(model.rateStr, style: AppTextStyle.f_11_500.color666666),
                                      ],
                                    ).paddingOnly(top: 10.w, bottom: 4.w),
                                    Row(
                                      children: <Widget>[
                                        ...model.payTypeArr.map((e) => MyImage(
                                              e,
                                              width: 12.w,
                                              height: 8.w,
                                            ))
                                      ],
                                    )
                                  ],
                                )),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
              getBottomView()
            ],
          );
        },
        itemCount: 1);
  }

  getListView() {
    return Obx(() => controller.tabIndex.value == 0
        ? SliverAnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: controller.currentIndex.value == 0
                ? SliverToBoxAdapter(
                    key: const ValueKey('0'),
                    child: Column(
                      children: <Widget>[getTopView(), ...getAccountList(), ...getFundsList(), getBottomView()],
                    ))
                : SliverToBoxAdapter(
                    key: const ValueKey('1'),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 28.w, 16.w, 160.w),
                      child: AssetsDrawPie(
                          array: controller.accountList.map((e) => {e.pieName.tr: (num.tryParse(e.value) ?? 0)}).toList()),
                    )))
        : SliverAnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: controller.currentIndex.value == 0
                ? SliverToBoxAdapter(
                    key: const ValueKey('coin0'),
                    child: Column(
                      children: <Widget>[getTopView(isAccountList: false), ...getCoinList()],
                    ))
                : SliverToBoxAdapter(
                    key: const ValueKey('coin1'),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 28.w, 16.w, 100.w),
                      child: AssetsDrawPie(
                          limit: 4,
                          array: assetsGetx.assetOverViewList
                              .map((e) => {e.coinName: (num.tryParse(e.usdtValuatin ?? '0'))})
                              .toList()),
                    ))));
  }

  Widget getTopView({bool isAccountList = true}) {
    if (isAccountList) {
      return InkWell(
        onTap: () {
          controller.hiddenPnl = !controller.hiddenPnl;
          controller.update();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          margin: EdgeInsets.only(top: 8.w),
          child: Row(
            children: [
              controller.hiddenPnl
                  ? MyImage(
                      'assets/asset_check'.svgAssets(),
                      width: 12.w,
                      height: 12.w,
                    ).marginOnly(right: 4.w)
                  : MyImage(
                      'assets/asset_ucheck'.svgAssets(),
                      width: 12.w,
                      height: 12.w,
                    ).marginOnly(right: 4.w),
              Text(LocaleKeys.assets154.tr, style: AppTextStyle.f_12_400.color4D4D4D)
            ],
          ),
        ),
      );
    } else {
      return Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              assetsGetx.setHideZeroOpenOVerView();
              assetsGetx.getRefresh();
              controller.update();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
              margin: EdgeInsets.only(top: 8.w),
              child: Row(
                children: [
                  assetsGetx.isOverViewHideZero
                      ? MyImage(
                          'assets/asset_check'.svgAssets(),
                          width: 12.w,
                          height: 12.w,
                        ).marginOnly(right: 4.w)
                      : MyImage(
                          'assets/asset_ucheck'.svgAssets(),
                          width: 12.w,
                          height: 12.w,
                        ).marginOnly(right: 4.w),
                  Text(LocaleKeys.assets61.tr, style: AppTextStyle.f_12_400.color4D4D4D)
                ],
              ),
            ),
          ),
          const Spacer(),
          SearchTextField(
            newStyle: true,
            controller: controller.textEditSearch,
            hintText: LocaleKeys.assets63.tr,
            onChanged: (keyword) {
              assetsGetx.setSearchKeyword(keyword);
              assetsGetx.getRefresh();
            },
          ),
          SizedBox(width: 16.w)
        ],
      );
    }
  }

  String getAccountText(AssetsAccount e) {
    var text = NumberUtil.mConvert(
      e.value,
      isEyeHide: true,
      isRate: IsRateEnum.usdt,
      count: e.precision,
      behind: e.rateCoin,
      isShowLogo: assetsGetx.rateCoin != 'USDT',
    ).commentSplit();

    return e.value == '0.00' ? '0.00 USDT' : text;
  }

  List<Widget> getAccountList() {
    return controller.accountList
        .map((e) => InkWell(
              onTap: () {
                controller.accointItemActionHandler(e.tabIndex);
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.name, style: AppTextStyle.f_14_500.color4D4D4D),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(getAccountText(e), style: AppTextStyle.f_16_500.color333333),
                          (controller.hiddenPnl || e.pnlRateStr.isEmpty)
                              ? const SizedBox()
                              : Padding(
                                  padding: EdgeInsets.only(top: 2.w),
                                  child: Text(e.pnlRateStr, style: AppTextStyle.f_11_400.copyWith(color: e.pnlRateColor)),
                                ),
                        ],
                      ),
                    ],
                  )),
            ))
        .toList();
  }

  List<Widget> getFundsList() {
    if (controller.walletHistoryArr.isEmpty) {
      return [];
    } else {
      List<Widget> historyArray = [
        InkWell(
            onTap: () {
              Get.toNamed(Routes.WALLET_HISTORY, arguments: 0);
            },
            child: Container(
              margin: EdgeInsets.only(top: 12.w),
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: Row(
                children: [
                  Text(LocaleKeys.assets163.tr, style: AppTextStyle.f_16_600.color111111),
                  const Spacer(),
                  MyImage(
                    'assets/assets_go'.svgAssets(),
                    width: 16.w,
                  )
                ],
              ),
            ))
      ];

      var tempArr = controller.walletHistoryArr
          .sublist(0, min(2, controller.walletHistoryArr.length))
          .map((e) => InkWell(
              onTap: () {
                Get.toNamed(Routes.WALLET_HISTORY, arguments: e.type == '1' ? 0 : 1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 16.w),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.colorF5F5F5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        MyImage(e.icon ?? '', width: 32.w),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: MyImage(
                                'assets/${e.type == '1' ? 'assets_deposit_arrow' : 'assets_withdraw_arraow'}'.svgAssets(),
                                width: 12.w))
                      ],
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.type == '1' ? LocaleKeys.assets35.tr : LocaleKeys.assets64.tr,
                          style: AppTextStyle.f_14_500.color333333,
                        ),
                        Text(
                          '${e.type == '1' ? LocaleKeys.assets155.tr : LocaleKeys.assets156.tr}${e.account}',
                          style: AppTextStyle.f_12_400.color666666,
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${e.type == '1' ? '+' : '-'}${e.amount} ${e.coinSymbol}',
                          style: AppTextStyle.f_14_500.color333333,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          e.createTime != null ? e.createTime!.split(' ').first : '',
                          style: AppTextStyle.f_12_400.color666666,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    )
                  ],
                ),
              )))
          .toList();

      historyArray.addAll(tempArr);

      return historyArray;
    }
  }

  List<Widget> getCoinList() {
    List<Widget> array = [];
    for (var i = 0; i < assetsGetx.assetOverViewList.length; i++) {
      var e = assetsGetx.assetOverViewList[i];
      var widget = InkWell(
          onTap: () {
            Get.toNamed(Routes.ASSETS_SPOTS_INFO, arguments: {"index": i, "data": e});
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColor.colorF5F5F5,
                ),
              ),
            ),
            child: Row(
              children: [
                MyImage(
                  e.icon ?? '',
                  width: 24.w,
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.coinName ?? '',
                      style: AppTextStyle.f_16_500.color111111,
                    ),
                    Text(
                      e.showName != null ? e.showName! : (e.coinName ?? ''),
                      style: AppTextStyle.f_10_400.color666666,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      NumberUtil.mConvert(
                        // TODO: JH 26.USDT资产数量精度错误
                        (e.coinName == "USDT")
                            ? e.usdtValuatin //JH: 加个补丁,总览币种USDT时加个allBalance 加上了和合约和跟单资产的总和,这里直换用usdtValuatin
                            : e.allBalance,
                        count: !TextUtil.isEmpty(AssetsGetx.to.currentRate?.coinPrecision) //???: 这里的精度需要时当前法币的精度?
                            ? int.parse(AssetsGetx.to.currentRate!.coinPrecision.toString())
                            : 2,
                        isEyeHide: true,
                      ),
                      style: const TextStyle(
                        color: AppColor.color111111,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      // '${e.btcValuatin}',
                      '≈${NumberUtil.mConvert(e.usdtValuatin, //TODO: JH7.币种价格错了
                          isEyeHide: true, count: !TextUtil.isEmpty(AssetsGetx.to.currentRate?.coinPrecision) ? int.parse(AssetsGetx.to.currentRate!.coinPrecision.toString()) : 2, isRate: IsRateEnum.usdt)}',
                      style: AppTextStyle.f_12_400.color999999,
                      textAlign: TextAlign.end,
                    ),
                  ],
                )
              ],
            ),
          ));
      var showKeyword = e.coinName?.contains(assetsGetx.searchKeyword.toUpperCase());

      if (assetsGetx.isOverViewHideZero) {
        if (double.parse(e.allBalance ?? '0') > 0 && showKeyword == true) array.add(widget);
      } else {
        if (showKeyword == true) {
          array.add(widget);
        }
      }
    }
    return array;
  }

  Widget getBottomView() {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(Routes.WEAL_INDEX, arguments: {'url': LinksGetx.to.proofOfReserve, 'title': LocaleKeys.assets152});
        //
        // String langInfo = StringKV.currentSelectedLangKey.get() ?? 'en_US';
        //
        // /// 兼容后端语言配置错误：繁体中文 zh_TW-> el_GR 在header里重新恢复
        // if (langInfo == 'el_GR') {
        //   langInfo = 'xl_XL';
        // } else if (langInfo == 'zh_TW') {
        //   langInfo = 'el_GR';
        // }

        LangInfo? langInfo = ObjectKV.localLang.get((v) => LangInfo.fromJson(v as Map<String, dynamic>));

        var url =
            '${LinksGetx.to.proofOfReserve}?hide=true&language=${langInfo?.langKey_ ?? 'en_US'}&inviteCode=${UserGetx.to.user?.info?.inviteCode}';

        // Get.toNamed(Routes.WEBVIEW, arguments: {'url': url});

        launchUrl(Uri.parse(url));
      },
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFFFF2CE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 10.w, 10.w, 6.w),
        margin: EdgeInsets.only(top: 24.w, left: 16.w, right: 16.w, bottom: 20.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(LocaleKeys.assets152.tr, style: AppTextStyle.f_14_600.color111111),
                  SizedBox(height: 8.w),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'BITCOCO ', style: AppTextStyle.f_11_400.color666666),
                        TextSpan(text: '100%', style: AppTextStyle.f_11_400.color111111),
                        TextSpan(text: LocaleKeys.assets153.tr, style: AppTextStyle.f_11_400.color666666),
                      ],
                    ),
                  )
                ],
              ),
            ),
            MyImage(
              'assets/asset_bottom'.svgAssets(),
              width: 75.w,
              height: 75.w,
            )
          ],
        ),
      ),
    );
  }

  // getListView1() {
  //   return Obx(() => TabBarView(
  //         controller: controller.tabController,
  //         children: [
  //           AnimatedSwitcher(
  //               duration: const Duration(milliseconds: 200),
  //               transitionBuilder: (Widget child, Animation<double> animation) {
  //                 return FadeTransition(
  //                   opacity: animation,
  //                   child: child,
  //                 );
  //               },
  //               child: controller.currentIndex.value == 0
  //                   ? ListView(
  //                       key: const ValueKey<int>(0),
  //                       children: [
  //                         InkWell(
  //                           onTap: () {
  //                             assetsGetx.setHideZeroOpenOVerView();
  //                             assetsGetx.getRefresh();
  //                           },
  //                           child: Container(
  //                             padding: EdgeInsets.symmetric(horizontal: 16.w),
  //                             height: 40.h,
  //                             child: Row(
  //                               children: [
  //                                 assetsGetx.isOverViewHideZero
  //                                     ? Icon(Icons.check_circle, size: 14.sp, color: AppColor.colorSuccess)
  //                                         .marginOnly(right: 4.w)
  //                                     : Icon(Icons.circle_outlined, size: 14.sp, color: AppColor.colorCCCCCC)
  //                                         .paddingOnly(right: 4.w),
  //                                 Text(LocaleKeys.assets61.tr, style: AppTextStyle.f_12_400.color4D4D4D)
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         ...getAccountList(),
  //                         ...getFundsList(),
  //                         getBottomView()
  //                       ],
  //                     )
  //                   : ListView(
  //                       key: const ValueKey<int>(1),
  //                       padding: EdgeInsets.fromLTRB(16.w, 28.w, 16.w, 0),
  //                       children: [
  //                         const AssetsDrawPie(
  //                           array: [
  //                             {'跟单': 0},
  //                             {'现货': 0},
  //                             {'标准合约': 0},
  //                           ],
  //                         ),
  //                         SizedBox(
  //                           height: 200.w,
  //                         )
  //                       ],
  //                     )),
  //           AnimatedSwitcher(
  //               duration: const Duration(milliseconds: 200),
  //               transitionBuilder: (Widget child, Animation<double> animation) {
  //                 return FadeTransition(
  //                   opacity: animation,
  //                   child: child,
  //                 );
  //               },
  //               child: controller.currentIndex.value == 0
  //                   ? ListView(key: const ValueKey<int>(0), children: [getTopView(), ...getCoinList()])
  //                   : ListView(
  //                       padding: EdgeInsets.fromLTRB(16.w, 28.w, 16.w, 0),
  //                       key: const ValueKey<int>(1),
  //                       children: const [
  //                         AssetsDrawPie(
  //                           array: [
  //                             {'跟单': 10},
  //                             {'现货': 40},
  //                             {'标准合约': 20}
  //                           ],
  //                         )
  //                       ],
  //                     )),
  //         ],
  //       ));
  // }
}
// Expanded(
//   child: SingleChildScrollView(
//     child: AssetView(
//       list: assetsGetx.assetOverViewList,
//       hideZero: assetsGetx.isOverViewHideZero,
//     ),
//   ),
// )
