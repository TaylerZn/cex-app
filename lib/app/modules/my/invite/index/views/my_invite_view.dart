import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/my/invite/index/controllers/my_invite_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/copy_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/number_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:styled_text/styled_text.dart';

class MeInviteView extends GetView<MeInviteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.color111111,
        body: Stack(
          children: [
            SingleChildScrollView(
                controller: controller.scrollController,
                child: GetBuilder<UserGetx>(builder: (userGetx) {
                  return Column(
                    children: [
                      Container(
                          color: AppColor.colorFFFFFF,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    color: AppColor.color111111,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: MyImage(
                                            'my/invite_bg'.pngAssets(),
                                            width: 375.w,
                                          ),
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 120.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 174.w,
                                                      child: ShaderMask(
                                                          shaderCallback:
                                                              (Rect bounds) {
                                                            return LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors: [
                                                                AppColor
                                                                    .colorWhite,
                                                                AppColor
                                                                    .colorWhite
                                                                    .withOpacity(
                                                                        0.6)
                                                              ], // 字体渐变
                                                              stops: const [
                                                                0.0,
                                                                1.0
                                                              ],
                                                            ).createShader(
                                                                bounds);
                                                          },
                                                          child: Transform(
                                                              transform: Matrix4
                                                                  .skewX(-(8 *
                                                                      (pi /
                                                                          180.0))), // 创建斜体效果的变换矩阵
                                                              child:
                                                                  AutoSizeText(
                                                                LocaleKeys
                                                                    .user35.tr,
                                                                maxLines: 1,
                                                                minFontSize: 8,
                                                                style:
                                                                    TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal, // 重置字体样式为普通
                                                                  fontSize:
                                                                      34.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white, // 设置文字颜色为白色，以便渐变色生效
                                                                ),
                                                              ))),
                                                    ),
                                                    Container(
                                                      width: 140.w,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Transform(
                                                          transform: Matrix4
                                                              .skewX(-(8 *
                                                                  (pi /
                                                                      180.0))), // 创建斜体效果的变换矩阵
                                                          child:
                                                              AutoSizeText.rich(
                                                            TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      LocaleKeys
                                                                          .user36
                                                                          .tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          34.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColor
                                                                          .colorWhite),
                                                                ),
                                                                TextSpan(
                                                                    text: LocaleKeys
                                                                        .user37
                                                                        .tr,
                                                                    style: TextStyle(
                                                                        fontSize: 34
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColor
                                                                            .colorFFD429)),
                                                              ],
                                                            ),
                                                            maxLines: 1,
                                                            minFontSize: 8,
                                                            style: TextStyle(
                                                              fontStyle: FontStyle
                                                                  .normal, // 重置字体样式为普通
                                                              fontSize: 34.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          )),
                                                    ),
                                                    12.verticalSpace
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 220.w,
                                                        child: StyledText(
                                                          text: LocaleKeys
                                                              .user38.tr
                                                              .replaceAll("40%",
                                                                  "${userGetx.user?.agentInfo?.scaleReturn != null ? ((userGetx.user!.agentInfo!.scaleReturn! * 100).toStringAsFixed(1).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")) : '--'}%"),
                                                          style: AppTextStyle
                                                              .f_12_400_15
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .colorWhite
                                                                      .withOpacity(
                                                                          0.6)),
                                                          tags: {
                                                            'b': StyledTextTag(
                                                                style: AppTextStyle
                                                                    .f_16_600
                                                                    .colorFFD429),
                                                          },
                                                        ),
                                                      ),
                                                      24.verticalSpace,
                                                      Text(
                                                        LocaleKeys.user39.tr,
                                                        style: AppTextStyle
                                                            .f_12_600
                                                            .colorBBBBBB,
                                                      ),
                                                      Text(
                                                        '${userGetx.user?.agentInfo?.scaleReturn != null ? ((userGetx.user!.agentInfo!.scaleReturn! * 100).toStringAsFixed(1).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")) : '--'}%',
                                                        style: AppTextStyle
                                                            .f_38_600
                                                            .colorWhite,
                                                      ),
                                                      10.verticalSpace
                                                    ],
                                                  )),
                                              Container(
                                                width: 343.w,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 16.w),
                                                decoration: BoxDecoration(
                                                    color: AppColor.colorWhite
                                                        .withOpacity(0.06),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          LocaleKeys.user40.tr,
                                                          style: AppTextStyle
                                                              .f_12_600
                                                              .colorBBBBBB,
                                                        ),
                                                        10.horizontalSpace,
                                                        Expanded(
                                                            child: InkWell(
                                                                onTap: () {
                                                                  CopyUtil
                                                                      .copyText(
                                                                    userGetx
                                                                            .user
                                                                            ?.info
                                                                            ?.inviteUrl ??
                                                                        '',
                                                                  );
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Text(
                                                                        userGetx.user?.info?.inviteUrl ??
                                                                            '--',
                                                                        style: AppTextStyle
                                                                            .f_12_600
                                                                            .colorWhite,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    )),
                                                                    SizedBox(
                                                                      width:
                                                                          4.w,
                                                                    ),
                                                                    MyImage(
                                                                      'default/copy'
                                                                          .svgAssets(),
                                                                      color: AppColor
                                                                          .color666666,
                                                                      width:
                                                                          12.w,
                                                                    )
                                                                  ],
                                                                )))
                                                      ],
                                                    ),
                                                    16.verticalSpace,
                                                    Row(
                                                      children: [
                                                        Text(
                                                          LocaleKeys.user41.tr,
                                                          style: AppTextStyle
                                                              .f_12_600
                                                              .colorBBBBBB,
                                                        ),
                                                        10.horizontalSpace,
                                                        Expanded(
                                                            child: InkWell(
                                                                onTap: () {
                                                                  CopyUtil
                                                                      .copyText(
                                                                    userGetx
                                                                            .user
                                                                            ?.info
                                                                            ?.inviteCode ??
                                                                        '',
                                                                  );
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Text(
                                                                        userGetx.user?.info?.inviteCode ??
                                                                            '--',
                                                                        style: AppTextStyle
                                                                            .f_12_600
                                                                            .colorWhite,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    )),
                                                                    SizedBox(
                                                                      width:
                                                                          4.w,
                                                                    ),
                                                                    MyImage(
                                                                      'default/copy'
                                                                          .svgAssets(),
                                                                      color: AppColor
                                                                          .color666666,
                                                                      width:
                                                                          12.w,
                                                                    )
                                                                  ],
                                                                )))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 24.w,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: MyButton.mainBg(
                                                      height: 48.h,
                                                      text:
                                                          LocaleKeys.user35.tr,
                                                      onTap: () {
                                                        Get.dialog(
                                                          MyShareView(
                                                            content:
                                                                inviteShareWidget(
                                                                    context),
                                                            url: UserGetx
                                                                    .to
                                                                    .user
                                                                    ?.info
                                                                    ?.inviteUrl ??
                                                                '',
                                                          ),
                                                          useSafeArea: false,
                                                          barrierDismissible:
                                                              true,
                                                        );
                                                        // showMyBottomDialog(
                                                        //     context,
                                                        //     MyMoreWidget(context,
                                                        //         infoData, widget.topicNo,
                                                        //         type: 1, isMe: isMe,
                                                        //         callBack: (data) {
                                                        //       print(data);
                                                        //       setState(() {
                                                        //         infoData = data;
                                                        //       });
                                                        //     }),
                                                        //     isviewInsetsBottom: false,
                                                        //     padding: EdgeInsets.fromLTRB(
                                                        //         0,
                                                        //         16.w,
                                                        //         0,
                                                        //         paddingBottom),
                                                        //     isDismissible: true,
                                                        //     backgroundColor: 0xffF5F5F5);

                                                        // // show a notification at top of screen.
                                                        // showSimpleNotification(
                                                        //     Container(
                                                        //       margin:
                                                        //           EdgeInsets.only(
                                                        //               top: 200.w),
                                                        //       color: Colors.green,
                                                        //     ),
                                                        //     background:
                                                        //         Colors.transparent);
                                                      },
                                                    ),
                                                  ),
                                                  !userGetx.isCoAgent
                                                      ? Expanded(
                                                          child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                    Expanded(
                                                        child: MyButton(
                                                      height: 48.h,
                                                      border: Border.all(width: 1, color: AppColor.colorABABAB),
                                                      borderRadius: BorderRadius.circular(100.r),
                                                      onTap: () {
                                                        Get.toNamed(
                                                          Routes.WEBVIEW,
                                                          arguments: {
                                                            'url': userGetx.user?.agentInfo?.agentApplyFormUrl ?? ''
                                                          },
                                                        );
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            LocaleKeys.user42.tr.stringSplit(),
                                                            style: AppTextStyle.f_16_600.colorWhite.copyWith(height: 1),
                                                          ),
                                                          SizedBox(height: 3.h),
                                                          Text(
                                                            LocaleKeys.user43.tr.stringSplit(),
                                                            style:
                                                                AppTextStyle.f_12_400.colorABABAB.copyWith(height: 1),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                  ],
                                                        ))
                                                      : 0.horizontalSpace,
                                                ],
                                              )
                                            ]),
                                      ],
                                    )),
                              ])),
                      Container(
                        padding: EdgeInsets.only(top: 24.w),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0, color: AppColor.color111111),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.r),
                                    topRight: Radius.circular(16.r)),
                                color: AppColor.colorWhite,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 16.w,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0, color: AppColor.colorWhite),
                            color: AppColor.colorWhite,
                          ),
                          child: Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: AppColor.colorEEEEEE,
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                  padding: EdgeInsets.all(16.w),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                Routes.INVITE_HISTORY_MAIN);
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    LocaleKeys.user44.tr,
                                                    style:
                                                        AppTextStyle.f_15_600),
                                              ),
                                              MyImage(
                                                'default/go'.svgAssets(),
                                                width: 16.w,
                                                color: AppColor.colorABABAB,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 1.w,
                                          color: AppColor.colorEEEEEE,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.w),
                                        ),
                                        Row(
                                          children: [
                                            dataWidget(
                                                title:
                                                    '${LocaleKeys.user45.tr}(${userGetx.user?.agentInfo?.coin ?? ''})',
                                                data: userGetx.user?.agentInfo
                                                        ?.amountTotal ?? //JH: 邀请总收益
                                                    '--',
                                                isGreen: true,
                                                count: 2,
                                                isTruncate: true),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            dataWidget(
                                                title:
                                                    '${LocaleKeys.user46.tr}(${userGetx.user?.agentInfo?.coin ?? ''})',
                                                data: userGetx.user?.agentInfo
                                                        ?.amountYesterday ?? //JH: 邀请昨日收益
                                                    '--',
                                                count: 2,
                                                isTruncate: true),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16.w,
                                        ),
                                        Row(
                                          children: [
                                            dataWidget(
                                                title:
                                                    LocaleKeys.user47.tr, //直邀人数
                                                data: userGetx.user?.agentInfo
                                                        ?.userCount ??
                                                    '--',
                                                count: 0),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            userGetx.isCoAgent
                                                ? dataWidget(
                                                    title: LocaleKeys
                                                        .user48.tr, //团队人数
                                                    data: userGetx
                                                            .user
                                                            ?.agentInfo
                                                            ?.totalNumber ??
                                                        '--',
                                                    count: 0)
                                                : 0.verticalSpace,
                                          ],
                                        ),
                                      ])),
                              SizedBox(
                                height: 10.w,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  padding: EdgeInsets.fromLTRB(
                                      16.w, 16.w, 16.w, 0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text('帮助中心',
                                      //     style: TextStyle(
                                      //         height: 1,
                                      //         fontSize: 16.sp,
                                      //         fontWeight: FontWeight.w600,
                                      //         color: Color(0xff111111))),
                                      // Container(
                                      //   height: 1.w,
                                      //   color: Color(0xffEEEEEE),
                                      //   margin: EdgeInsets.only(top: 16.w),
                                      // ),
                                      // WaterfallFlow.builder(
                                      //     padding: EdgeInsets.only(top: 0.w),
                                      //     shrinkWrap: true,
                                      //     physics:
                                      //         NeverScrollableScrollPhysics(),
                                      //     addAutomaticKeepAlives: false,
                                      //     addRepaintBoundaries: false,
                                      //     itemCount:
                                      //         controller.helpCenterList.length,
                                      //     gridDelegate:
                                      //         SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                      //       crossAxisCount: 1,
                                      //       crossAxisSpacing: 0.w,
                                      //       mainAxisSpacing: 0.w,
                                      //     ),
                                      //     itemBuilder: (context, i) {
                                      //       NoAuthmemberhelpCenterModel item =
                                      //           controller.helpCenterList[i];

                                      //       return Container(
                                      //           width: MediaQuery.of(context)
                                      //               .size
                                      //               .width,
                                      //           child: Column(
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.start,
                                      //             children: [
                                      //               ExpandablePanel(
                                      //                   controller: controller
                                      //                           .expandableControllers[
                                      //                       i],
                                      //                   theme:
                                      //                       const ExpandableThemeData(
                                      //                     hasIcon: false,
                                      //                     iconColor:
                                      //                         Colors.black,
                                      //                     headerAlignment:
                                      //                         ExpandablePanelHeaderAlignment
                                      //                             .center,
                                      //                     tapBodyToCollapse:
                                      //                         false,
                                      //                   ),
                                      //                   header: Builder(
                                      //                       builder: (context) {
                                      //                     return InkWell(
                                      //                         onTap: () {
                                      //                           controller
                                      //                                   .expandableControllers[
                                      //                                       i]
                                      //                                   .expanded =
                                      //                               !controller
                                      //                                   .expandableControllers[
                                      //                                       i]
                                      //                                   .expanded;
                                      //                           controller
                                      //                               .update();
                                      //                         },
                                      //                         child: Container(
                                      //                             // height: 48.w,
                                      //                             padding: EdgeInsets
                                      //                                 .symmetric(
                                      //                                     vertical:
                                      //                                         8.w),
                                      //                             child: Row(
                                      //                               children: [
                                      //                                 Expanded(
                                      //                                     child:
                                      //                                         Text(
                                      //                                   '${item.label}',
                                      //                                   style: TextStyle(
                                      //                                       fontSize:
                                      //                                           14.sp,
                                      //                                       fontWeight: FontWeight.w500,
                                      //                                       color: Color(0xff666666)),
                                      //                                 )),
                                      //                                 SizedBox(
                                      //                                   width:
                                      //                                       10.w,
                                      //                                 ),
                                      //                                 MyImage(
                                      //                                   controller.expandableControllers[i].expanded
                                      //                                       ? 'default/arrow_top'.svgAssets()
                                      //                                       : 'default/arrow_bottom'.svgAssets(),
                                      //                                   width:
                                      //                                       16.w,
                                      //                                   color: Color(
                                      //                                       0xff4D4D4D),
                                      //                                 )
                                      //                               ],
                                      //                             )));
                                      //                   }),
                                      //                   collapsed: SizedBox(),
                                      //                   expanded: Container(
                                      //                     width: MediaQuery.of(
                                      //                             context)
                                      //                         .size
                                      //                         .width,
                                      //                     margin:
                                      //                         EdgeInsets.only(
                                      //                             top: 4.w),
                                      //                     padding:
                                      //                         EdgeInsets.all(
                                      //                             10.w),
                                      //                     decoration: BoxDecoration(
                                      //                         borderRadius:
                                      //                             BorderRadius
                                      //                                 .circular(
                                      //                                     6),
                                      //                         color: Color(
                                      //                             0xffF5F5F5)),
                                      //                     child: Text(
                                      //                       '${item.answer}'
                                      //                           .stringSplit(),
                                      //                       style: TextStyle(
                                      //                           color: Color(
                                      //                               0xff4D4D4D)),
                                      //                     ),
                                      //                   ))
                                      //             ],
                                      //           ));
                                      //     }),
                                      MyButton(
                                        height: 36.h,
                                        borderRadius: BorderRadius.circular(100.r),
                                        backgroundColor: AppColor.colorF5F5F5,
                                        onTap: () {
                                          Get.toNamed(Routes.WEBVIEW,
                                              arguments: {'url': LinksGetx.to.onlineServiceProtocal});
                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            MyImage(
                                              'my/service'.svgAssets(),
                                              width: 16.w,
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              LocaleKeys.user87.tr.stringSplit(),
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 46.w,
                              ),
                            ],
                          ))
                    ],
                  );
                })),
            Obx(() => Positioned(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60.w + MediaQuery.of(context).padding.top,
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    color: Color(controller.topOpacity.value),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyPageBackWidget(
                          backColor: AppColor.colorWhite,
                        )
                      ],
                    ))))
          ],
        ));
  }

  dataWidget({
    data = '',
    title = '',
    isGreen = false,
    int? count,
    bool isTruncate = false,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              (count == 0)
                  ? controller.removeEnddot(
                      NumberUtil.mConvert(data, count: count)) // 加个补丁,移除末尾的.
                  : NumberUtil.mConvert(data,
                          count: count, isTruncate: isTruncate)
                      .stringSplit(),
              style: AppTextStyle.f_16_600.copyWith(
                  color:
                      isGreen ? AppColor.colorSuccess : AppColor.color111111)),
          4.verticalSpace,
          Text('$title'.stringSplit(),
              style: AppTextStyle.f_12_400.colorABABAB),
        ],
      ),
    );
  }

  inviteShareWidget(context) {
    return Container(
        width: 313.w,
        color: AppColor.color0C0D0F,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 225.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r))),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: MyImage(
                    'my/invite_share_bg'.svgAssets(),
                    width: 313.w,
                  ),
                ),
                Positioned(
                    top: 94.h,
                    right: 25.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.r), // 指定圆角半径
                      child: QrImageView(
                        backgroundColor: AppColor.colorWhite,
                        data: UserGetx.to.user?.info?.inviteUrl ?? '',
                        version: QrVersions.auto,
                        size: 80.w,
                        padding: EdgeInsets.all(5.w),
                      ),
                    ))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 26.h),
              decoration: BoxDecoration(
                  color: AppColor.color1A1A1A,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.user49.tr,
                    style: AppTextStyle.f_24_600.colorWhite,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    LocaleKeys.user50.tr,
                    style: AppTextStyle.f_12_400.colorCCCCCC,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
