import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_kol_cancel.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_setup_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

///筛选项 枚举
enum FollowSureViewType {
  defaultFollow,
  smartFollow,
  cancelFollow;

  String get value => [LocaleKeys.follow90.tr, LocaleKeys.follow91.tr][index];
}

showFollowSureView(
    {Function()? callback, required FollowInfoModel model, required FollowKolInfo trader, bool isSmart = false}) {
  getCell(String title, String des, {bool isText = true}) {
    return Padding(
      padding: EdgeInsets.only(top: 13.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.f_14_400.color666666),
          isText ? Text(des, style: AppTextStyle.f_14_500.color111111) : ImageStackPage(symbolList: model.symbolIconList),
        ],
      ),
    );
  }

  Widget getWidgett() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 24.h),
          child: Text(LocaleKeys.follow92.tr, style: AppTextStyle.f_20_600.color111111),
        ),
        GestureDetector(
          onTap: () {
            // Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'model': trader});
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: <Widget>[
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(32.w)),
                child: ClipOval(
                  child: MyImage(
                    model.icon,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(model.name, style: AppTextStyle.f_16_500.color111111),
              // const Spacer(),
              // const Icon(Icons.chevron_right)
            ],
          ),
        ),
        Container(
          height: 1.w,
          color: AppColor.colorF5F5F5,
          margin: EdgeInsets.only(top: 12.h, bottom: 7.h),
        ),
        // getCell('单笔跟单', model.followType == 1 ? model.singleAmountStr : model.singleAmountRateStr),
        getCell(LocaleKeys.follow94.tr, model.followType == 1 ? LocaleKeys.follow90.tr : LocaleKeys.follow91.tr),
        getCell(LocaleKeys.follow95.tr, model.amountStr),
        Container(
          height: 1.w,
          color: AppColor.colorF5F5F5,
          // padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
          margin: EdgeInsets.only(top: 20.h, bottom: 7.h),
        ),
        getCell(LocaleKeys.follow96.tr, LocaleKeys.follow97.tr),
        getCell(LocaleKeys.follow98.tr, LocaleKeys.follow97.tr),
        getCell(LocaleKeys.follow99.tr, '', isText: false),
        getCell(LocaleKeys.follow100.tr, model.stopDeficitStr),
        getCell(LocaleKeys.follow101.tr, model.stopProfitStr),
        Padding(
          padding: EdgeInsets.only(top: 62.h),
          child: FollowSetuPBottomBtn(
            haveTop: false,
            callback: callback,
          ),
        )
      ],
    );
  }

  Widget getSmartWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 24.h),
          child: Text(LocaleKeys.follow92.tr, style: AppTextStyle.f_20_600.color111111),
        ),
        Row(
          children: <Widget>[
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(32.w)),
              child: ClipOval(
                child: MyImage(
                  model.icon,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(model.name, style: AppTextStyle.f_16_500.color111111),
            // const Spacer(),
            // const Icon(Icons.chevron_right)
          ],
        ),
        Container(
          height: 1.w,
          color: AppColor.colorF5F5F5,
          margin: EdgeInsets.only(top: 12.h, bottom: 28.h),
        ),
        getCell(LocaleKeys.follow94.tr, LocaleKeys.follow16.tr),
        getCell(LocaleKeys.follow184.tr, model.rate),
        getCell(LocaleKeys.follow240.tr, '${model.smartAmount} USDT'),
        Container(
          height: 1.w,
          color: AppColor.colorF5F5F5,
          padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
          margin: EdgeInsets.only(bottom: 24.h),
        ),
        getCell(LocaleKeys.follow96.tr, LocaleKeys.follow97.tr),
        getCell(LocaleKeys.follow98.tr, LocaleKeys.follow97.tr),
        getCell(LocaleKeys.follow99.tr, '', isText: false),
        Padding(
          padding: EdgeInsets.only(top: 72.h),
          child: FollowSetuPBottomBtn(
            haveTop: false,
            callback: callback,
          ),
        )
      ],
    );
  }

  showModalBottomSheet(
    // backgroundColor: Colors.red,
    context: Get.context!,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Container(
          decoration: const BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.w, bottom: 16.w),
          child: isSmart ? getSmartWidget() : getWidgett());
    },
  );
}

showCancelFollowSureView({Function()? callback, required FollowKolInfo trader, required FollowCancelDetail cacelModel}) {
  getCell(String title, String des, {bool isText = true}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 13.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.f_14_400.color666666),
          isText ? Text(des, style: AppTextStyle.f_14_500.color111111) : ImageStackPage(),
        ],
      ),
    );
  }

  showModalBottomSheet(
    // backgroundColor: Colors.red,
    context: Get.context!,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 19.w, bottom: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Text(LocaleKeys.follow64.tr, style: AppTextStyle.f_20_600.color111111),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(32.w)),
                    child: ClipOval(
                      child: MyImage(
                        trader.icon,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(trader.userName, style: AppTextStyle.f_16_500.color111111),
                  const Spacer(),
                  // const Icon(Icons.chevron_right)
                ],
              ),
            ),
            Container(
              height: 1.w,
              color: AppColor.colorF5F5F5,
              margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
            ),
            getCell(LocaleKeys.follow102.tr, cacelModel.marginStr),
            getCell(LocaleKeys.follow103.tr, cacelModel.totalPNLStr),
            getCell(LocaleKeys.follow298.tr, cacelModel.platformFeeStr),
            getCell(LocaleKeys.follow104.tr, cacelModel.expectedShardProfitStr),
            Container(
              height: 1.w,
              color: AppColor.colorF5F5F5,
              padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
              margin: EdgeInsets.only(bottom: 20.h),
            ),
            getCell(LocaleKeys.follow105.tr, cacelModel.expectedAmountStr),
            Container(
              height: 1.w,
              color: AppColor.colorF5F5F5,
              padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
              margin: EdgeInsets.only(top: 7.h),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: FollowSetuPBottomBtn(
                btnTitle: LocaleKeys.follow64.tr,
                haveTop: false,
                callback: callback,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class FollowSetuPBottomBtn extends StatelessWidget {
  const FollowSetuPBottomBtn({
    super.key,
    this.callback,
    this.haveTop = true,
    this.btnTitle = LocaleKeys.follow106,
    this.isChecked,
  });
  final Function()? callback;
  final bool haveTop;
  final String btnTitle;
  final RxBool? isChecked;

  @override
  Widget build(BuildContext context) {
    return haveTop
        ? DecoratedBox(
            decoration: const BoxDecoration(color: AppColor.colorWhite),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: AppColor.colorF5F5F5,
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 16.w),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            isChecked!.value = !isChecked!.value;
                          },
                          child: Obx(() => Container(
                                padding: const EdgeInsets.only(right: 4),
                                child: MyImage(
                                  'contract/${isChecked!.value ? 'market_select' : 'market_unSelect'}'.svgAssets(),
                                ),
                              ))),
                      Expanded(
                        child: RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: LocaleKeys.follow107.tr,
                            style: AppTextStyle.f_12_400.color999999,
                            children: <TextSpan>[
                              TextSpan(
                                  text: LocaleKeys.follow108.tr,
                                  style: AppTextStyle.f_12_400.color0075FF,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.followProtocol});
                                    }),
                              TextSpan(
                                text: LocaleKeys.follow109.tr,
                                style: AppTextStyle.f_12_400.color999999,
                              ),
                              TextSpan(
                                  text: LocaleKeys.follow110.tr,
                                  style: AppTextStyle.f_12_400.color0075FF,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.privacyProtocal});
                                    }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (isChecked!.value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      callback?.call();
                    } else {
                      UIUtil.showToast(LocaleKeys.follow111.tr);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 32.w,
                        margin: EdgeInsets.only(top: 16.h, bottom: 16.h + MediaQuery.of(context).padding.bottom),
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        height: 48.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(48), color: AppColor.color111111),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              btnTitle.tr,
                              style: AppTextStyle.f_16_500.colorWhite,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : getButton(context);
  }

  Widget getButton(BuildContext context, {bool isEnabled = true}) {
    return GestureDetector(
      onTap: () {
        if (isEnabled) {
          FocusScope.of(context).requestFocus(FocusNode());
          callback?.call();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 32.w,
            margin: EdgeInsets.only(top: 16.h, bottom: 16.h + MediaQuery.of(context).padding.bottom),
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            height: 48.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48), color: isEnabled ? AppColor.color111111 : AppColor.colorCCCCCC),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  btnTitle.tr,
                  style: AppTextStyle.f_16_500.colorWhite,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
