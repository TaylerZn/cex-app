import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/community.dart';
import 'package:nt_app_flutter/app/enums/file_upload.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/item_row/community_polling.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/post_quote_widget.dart';
import 'package:nt_app_flutter/app/modules/community/enum.dart';
import 'package:nt_app_flutter/app/modules/community/post_index/widgets/coin_kchat_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_list_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/community/social_share_container_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/community/translate_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

Widget communityInfoPublicWidget(
    context, TopicdetailModel? widgetData, TopicdetailModel? infoData,
    {isVideo = false, Function? callback}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Visibility(
          visible: ObjectUtil.isNotEmpty(infoData?.trendDirection),
          child: Container(
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3.r)),
                color: infoData?.isUp == true
                    ? AppColor.upColor.withOpacity(0.1)
                    : AppColor.downColor.withOpacity(0.1)),
            padding: EdgeInsets.all(5.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyImage(infoData?.isUp == true
                    ? 'community/up'.svgAssets()
                    : 'community/down'.svgAssets()),
                2.w.horizontalSpace,
                Text(
                    infoData?.isUp == true
                        ? TrendDirection.up.title()
                        : TrendDirection.down.title(),
                    style: infoData?.isUp == true
                        ? AppTextStyle.f_12_500.upColor
                        : AppTextStyle.f_12_500.downColor)
              ],
            ),
          )),

      Visibility(
          visible: '${infoData?.topicTitle ?? widgetData?.topicTitle ?? ''}'
              .isNotEmpty,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
                '${infoData?.topicTitle ?? widgetData?.topicTitle ?? ''}',
                style: AppTextStyle.f_18_500.color111111),
          ).marginOnly(bottom: 8.2)),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible:
                '${infoData?.topicContent ?? widgetData?.topicContent ?? ''}'
                    .isNotEmpty,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyCommunityUtil.specialStringtToWidget(
                      infoData?.topicContent ?? widgetData?.topicContent ?? '',
                      SpecialContentEnum.postContent,
                      textStyle: AppTextStyle.f_15_400.color4D4D4D,
                      maxLines: false,
                      specialTextStyle: AppTextStyle.f_15_400.tradingYel)
                ],
              ),
            ),
          ),
        ],
      ),
      TranslateWidget(
        topicNo: widgetData?.topicNo,
      ),

      isVideo
          ? 0.verticalSpace
          : (infoData?.picList != null && infoData!.picList!.isNotEmpty) ||
                  (widgetData?.picList != null &&
                      widgetData!.picList!.isNotEmpty)
              ? Padding(
                  padding: EdgeInsets.only(
                    top: 6.w,
                  ),
                  child: postImageWidget(context, CommunityFileTypeEnum.PIC,
                      infoData?.picList ?? widgetData?.picList ?? []))
              : 0.verticalSpace,
      14.verticalSpaceFromWidth,
      Padding(
        padding: EdgeInsets.only(bottom: 14.w),
        child: Center(child: SocialShareContainerWidget(widgetData: infoData)),
      ),

      buildExtension(context, widgetData, infoData, callback),

      Container(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        height: 33.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.w),
            color: AppColor.colorBackgroundSecondary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  MyLongDataUtil.convert('${infoData?.pageViewNum ?? '0'}',
                      showZero: true),
                  style: AppTextStyle.f_14_600.colorTextPrimary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  LocaleKeys.community124.tr,
                  style: AppTextStyle.f_12_400_15.colorTextTips,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  MyLongDataUtil.convert('${infoData?.praiseNum ?? '0'}',
                      showZero: true),
                  style: AppTextStyle.f_14_600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  LocaleKeys.community30.tr,
                  style: AppTextStyle.f_12_400_15.color999999,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  MyLongDataUtil.convert('${infoData?.quoteNum ?? '0'}',
                      showZero: true),
                  style: AppTextStyle.f_14_600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  LocaleKeys.community123.tr,
                  style: AppTextStyle.f_12_400_15.color999999,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  MyLongDataUtil.convert('${infoData?.forwardNum ?? '0'}',
                      showZero: true),
                  style: AppTextStyle.f_14_600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  LocaleKeys.community12.tr,
                  style: AppTextStyle.f_12_400_15.color999999,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
      24.verticalSpace,
    ],
  );
}

Widget buildExtension(context, TopicdetailModel? widgetData,
    TopicdetailModel? infoData, Function? callback) {
  return Column(
    children: [
      infoData?.symbolList != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: worker<Widget>(infoData?.symbolList, (index, item) {
                ContractInfo? info = getContract(infoData!, index);
                if (ObjectUtil.isNotEmpty(info)) {
                  return Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: CommunityCoinKchatWidget(
                        contractInfo: info!,
                        type: CommunityCoinKChatType.info,
                      ));
                }
                return const SizedBox();
              }),
            )
          : const SizedBox(),
      infoData == null
          ? const SizedBox()
          : Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: CommunityPolling(
                  model: infoData,
                  callback: () {
                    callback?.call();
                  }),
            ),
      if (infoData?.quoteTopicId != null)
        Padding(
          padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
          child: PostQuoteWidget(quoteId: infoData?.quoteTopicId),
        ),
    ],
  );
}

ContractInfo? getContract(TopicdetailModel model, int index) {
  dynamic obj = model.symbolList?[index];

  String t = '$obj';
  ContractInfo? info =
      CommodityDataStoreController.to.getContractInfoBySymbol(t);
  return info;
}
