import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/file_upload.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/utilities/share_helper_util.dart';

// 帖子更多
postMoreBottomDialog(
    {required String userName,
    required num uid,
    required postData,
    required Function? blockSuccessFun}) {
  bool isMe = UserGetx.to.uid == uid;
  showModalBottomSheet(
    context: Get.context!,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Container(
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          padding: EdgeInsets.fromLTRB(
              16.w, 16.h, 16.w, 16.w + MediaQuery.of(context).padding.bottom),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: ShapeDecoration(
                  color: AppColor.color999999,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            24.verticalSpace,
            Container(
                width: 375.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.colorWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    postMoreColumnWidget(
                        LocaleKeys.community12.tr, 'default/share', () async {
                      Get.dialog(
                        MyShareView(
                          content: postShareWidget(postData,
                              '${LinksGetx.to.topicUrl}${postData.topicNo}'),
                          url: '${LinksGetx.to.topicUrl}${postData.topicNo}',
                        ),
                        useSafeArea: false,
                        barrierDismissible: true,
                      );
                      recordShareData(postData.topicNo);
                    }),
                    20.horizontalSpace,
                    UserGetx.to.isLogin && isMe == false
                        ? postMoreColumnWidget(
                            LocaleKeys.community13.tr, 'flow/follow_blacklist',
                            () async {
                            Get.back();
                            bool? res = await UIUtil.showConfirm(
                              LocaleKeys.community14.tr,
                              content:
                                  LocaleKeys.community32.trArgs([userName]),
                            );
                            if (res == true) {
                              //status  0取消 1设置
                              // type 0标星  1拉黑 2禁止跟单
                              AFFollow.setTraceUserRelation(
                                      userId: uid, status: 1, types: 1)
                                  .then((value) {
                                if (value == null) {
                                  UIUtil.showSuccess(LocaleKeys.community33.tr);
                                  Bus.getInstance()
                                      .emit(EventType.blockUser, uid);

                                  if (blockSuccessFun != null) {
                                    blockSuccessFun();
                                  }
                                } else {
                                  UIUtil.showError(LocaleKeys.community34.tr);
                                }
                              });
                            }
                          })
                        : const SizedBox()
                  ],
                )),
          ]));
    },
  );
}

postMoreColumnWidget(title, image, onTap) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
              color: AppColor.colorF5F5F5,
              borderRadius: BorderRadius.circular(43)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyImage(
                '$image'.svgAssets(),
                // color: Colors.black,
                width: 20.w,
                height: 20.w,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 6.w,
        ),
        Text('$title', style: AppTextStyle.f_12_400.color666666)
      ],
    ),
  );
}

postShareWidget(postData, shareUrl) {
  return Container(
    constraints: BoxConstraints(
      maxWidth: 327.w,
    ),
    padding: EdgeInsets.all(10.w),
    color: AppColor.colorWhite,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        postData.type == CommunityFileTypeEnum.VIDEO
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                clipBehavior: Clip.antiAlias,
                constraints: BoxConstraints(
                  maxHeight: 327.w * 4 / 3,
                  minHeight: 327.w * 3 / 4,
                ),
                child: MyImage(
                  '${postData.coverInfo.fileUrl ?? ''}',
                  width: postData.coverInfo.width,
                  height: postData.coverInfo.height,
                  radius: 6,
                  isDefaultSize: true,
                  fit: BoxFit.cover,
                ))
            : postData.picList == null || postData.picList.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                      color: AppColor.color111111,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          topRight: Radius.circular(18.r)),
                    ),
                    child: MyImage(
                      'community/share_bg'.pngAssets(),
                      width: 307.w,
                      height: 307.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : postData.picList.length == 1
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        clipBehavior: Clip.antiAlias,
                        constraints: BoxConstraints(
                          maxHeight: 327.w * 4 / 3,
                          minHeight: 327.w * 3 / 4,
                        ),
                        child: MyImage(
                          '${postData.picList[0].fileUrl ?? ''}',
                          width: postData.picList[0].width,
                          height: postData.picList[0].height,
                          isDefaultSize: true,
                          radius: 6,
                          fit: BoxFit.cover,
                        ))
                    : postData.picList.length == 2
                        ? Row(
                            children: [
                              MyImage(
                                '${postData.picList[0].fileUrl}',
                                width: 152.w,
                                height: 152.w,
                                radius: 3.r,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              MyImage(
                                '${postData.picList[1].fileUrl}',
                                width: 152.w,
                                height: 152.w,
                                radius: 3.r,
                                fit: BoxFit.cover,
                              )
                            ],
                          )
                        : Row(
                            children: [
                              MyImage(
                                '${postData.picList[0].fileUrl}',
                                width: 204.w,
                                height: 204.w,
                                radius: 3.r,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Column(
                                children: [
                                  MyImage(
                                    '${postData.picList[1].fileUrl}',
                                    width: 100.w,
                                    height: 100.w,
                                    radius: 3.r,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 3.w,
                                  ),
                                  MyImage(
                                    '${postData.picList[2].fileUrl}',
                                    width: 100.w,
                                    height: 100.w,
                                    radius: 3.r,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              )
                            ],
                          ),
        SizedBox(
          height: 10.w,
        ),
        SizedBox(
          width: Get.width,
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.w,
                  ),
                  Row(
                    children: [
                      UserAvatar(
                        '${postData.memberHeadUrl ?? ''}',
                        width: 18.w,
                        height: 18.w,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                          child: Text(
                              '${postData.memberName ?? ''}'.stringSplit(),
                              style: AppTextStyle.f_14_500))
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    '${postData.topicTitle ?? ''}'.stringSplit(),
                    style: AppTextStyle.f_14_400.color4D4D4D,
                    maxLines: 1,
                  )
                ],
              )),
              SizedBox(
                width: 4.w,
              ),
              Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                      color: AppColor.colorWhite,
                      borderRadius: BorderRadius.circular(6.r)),
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QrImageView(
                        data: shareUrl,
                        version: QrVersions.auto,
                        padding: EdgeInsets.all(0.w),
                      ),
                    ],
                  ))
            ],
          ),
        )
      ],
    ),
  );
}

// 新分享面板 //TODO: -> 调试分享

// Modify the postShareBottomDialog function
postShareBottomDialog(
    {required String userName,
    required num uid,
    required postData,
    required Function? blockSuccessFun}) async {
  bool isMe = UserGetx.to.uid == uid;
  bool isTelegramInstalled =
      await isAppInstalled('org.telegram.messenger', urlScheme: 'tg://');
  bool isWhatsappInstalled =
      await isAppInstalled('com.whatsapp', urlScheme: 'whatsapp://');
  bool isXInstalled =
      await isAppInstalled('com.twitter.android', urlScheme: 'twitter://');
  bool _isSharing = false;
  showModalBottomSheet(
    context: Get.context!,
    useSafeArea: true,
    builder: (BuildContext context) {
      double itemWidth = 55.w;
      return Container(
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          padding: EdgeInsets.fromLTRB(
              16.w, 16.h, 16.w, 16.w + MediaQuery.of(context).padding.bottom),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: ShapeDecoration(
                  color: AppColor.color999999,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            16.verticalSpace,
            Center(
              child: Text(
                LocaleKeys.public34.tr,
                style: AppTextStyle.f_15_500.color111111,
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyImage('community/community_share_titile_icon'.svgAssets(),
                    width: 18.w, height: 18.w),
                Text(LocaleKeys.community78.tr,
                    style: AppTextStyle.f_11_400.color4D4D4D)
              ],
            ),
            24.verticalSpace,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.colorWhite,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Wrap(
                  spacing: 35.w, // 计算后的水平间距
                  runSpacing: 16.h, // 每行之间的垂直间距
                  children: [
                    if (isTelegramInstalled)
                      SizedBox(
                        width: itemWidth,
                        child: postShareColumnWidget(
                            'Telegram',
                            'community/share_tg',
                            postData?.topicNo ?? '', () async {
                          String uri =
                              'tg://msg?text=${LinksGetx.to.topicUrl}${postData?.topicNo}';
                          MyUrlUtil.openUrl(uri);
                        }),
                      ),
                    if (isWhatsappInstalled)
                      SizedBox(
                        width: itemWidth,
                        child: postShareColumnWidget(
                            'Whatsapp',
                            'community/share_whatapp',
                            postData?.topicNo ?? '', () async {
                          String uri =
                              'whatsapp://send?text=${LinksGetx.to.topicUrl}${postData?.topicNo}';
                          MyUrlUtil.openUrl(uri);
                        }),
                      ),
                    if (isXInstalled)
                      SizedBox(
                        width: itemWidth,
                        child: postShareColumnWidget(
                            'X', 'community/share_x', postData?.topicNo ?? '',
                            () async {
                          String uri =
                              'twitter://post?message=${LinksGetx.to.topicUrl}${postData?.topicNo}';
                          MyUrlUtil.openUrl(uri);
                        }),
                      ),
                    SizedBox(
                      width: itemWidth,
                      child: postShareColumnWidget(
                          LocaleKeys.public62.tr,
                          'community/share_copy',
                          postData?.topicNo ?? '', () async {
                        String uri =
                            '${LinksGetx.to.topicUrl}${postData?.topicNo}';
                        CopyUtil.copyText(uri);
                      }),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: postShareColumnWidget(
                          //制作海报
                          LocaleKeys.community79.tr,
                          'community/share_photo',
                          postData?.topicNo ?? '', () async {
                        Get.dialog(
                          MyShareView(
                            content: postShareWidget(postData,
                                '${LinksGetx.to.topicUrl}${postData.topicNo}'),
                            url: '${LinksGetx.to.topicUrl}${postData.topicNo}',
                          ),
                          useSafeArea: false,
                          barrierDismissible: true,
                        );
                      }),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: postShareColumnWidget(
                          //系统分享
                          LocaleKeys.public14.tr,
                          'community/share_more',
                          postData?.topicNo ?? '', () async {
                        if (_isSharing) return;
                        _isSharing = true;
                        String uri =
                            '${LinksGetx.to.topicUrl}${postData?.topicNo}';
                        await Share.shareUri(Uri.parse(uri));
                        _isSharing = false;
                      }),
                    ),
                  ],
                ),
              ),
            )
          ]));
    },
  );
}

postShareColumnWidget(title, image, String topicNo, onTap) {
  return InkWell(
    onTap: () {
      onTap();
      recordShareData(topicNo); //分享记录
    },
    child: Column(
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
              color: AppColor.colorF5F5F5,
              borderRadius: BorderRadius.circular(43)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyImage(
                '$image'.svgAssets(),
                // color: Colors.black,
                width: 20.w,
                height: 20.w,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.w,
        ),
        Text('$title', style: AppTextStyle.f_12_400.color4D4D4D)
      ],
    ),
  );
}
