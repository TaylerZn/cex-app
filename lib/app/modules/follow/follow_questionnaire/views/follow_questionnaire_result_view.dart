import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_questionnaire/widget/follow_question_draw.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../getX/links_Getx.dart';
import '../../../../getX/user_Getx.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/utilities/share_helper_util.dart';
import '../../../../utils/utilities/ui_util.dart';
import '../../../../widgets/basic/my_image.dart';
import '../../../../widgets/basic/my_page_back.dart';
import '../controllers/follow_questionnaire_result_controller.dart';
import '../widget/follow_question_draw_min.dart';

class FollowQuestionnaireResultView extends GetView<FollowQuestionnaireResultController> {
  FollowQuestionnaireResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.color1F1E20,
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        leading: MyPageBackWidget(
          backColor: AppColor.colorFFFFFF,
          onTap: () {
            Get.dialog(quitDialog());
          },
        ),
        title: Text(
          LocaleKeys.follow421.tr, ////'投资风险评估报告',
          style: AppTextStyle.f_16_600.colorFFFFFF,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(shareDialog(),useSafeArea: false);
            },
            icon: MyImage(
              'flow/share'.svgAssets(),
              width: 18,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                14.verticalSpace,
                // SizedBox(height: 170, child: Placeholder()),
                SizedBox(
                    height: 170.w,
                    child: FollowQuestionrDrawRadar(
                      basicSupport: controller.basicSupport,
                      liquidity: controller.liquidity,
                      riskTolerance: controller.riskTolerance,
                      investmentKnowledge: controller.investmentKnowledge,
                      investmentPreference: controller.investmentPreference,
                    )),
                25.verticalSpace,
                Text(
                  controller.model['name'].toString().tr,//'${controller.model['name']}',
                  style: AppTextStyle.f_24_500.colorFFFFFF,
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: ClampingScrollPhysics(),
                        children: [
                          300.verticalSpace,
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height-kToolbarHeight-136.w-MediaQuery.of(context).padding.top,
                            padding:  EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: const BoxDecoration(
                                color: AppColor.colorFFFFFF,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                8.verticalSpace,
                                Center(
                                  child: Container(
                                    height: 4.w,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10), color: AppColor.colorCCCCCC),
                                  ),
                                ),
                                12.verticalSpace,
                                Text(
                                  LocaleKeys.follow422.tr, //'您的投资偏好分析',
                                  style: AppTextStyle.f_16_600.color111111,
                                ),
                                16.verticalSpace,
                                Container(
                                  padding: EdgeInsets.all(12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColor.colorF9F9F9, borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.follow423.tr, //'特征：',
                                        style: AppTextStyle.f_14_500.color111111,
                                      ),
                                      8.verticalSpace,
                                      Text(
                                        '${controller.model['characteristic'].toString().tr}',
                                        style: AppTextStyle.f_12_400.color666666,
                                      ),
                                    ],
                                  ),
                                ),
                                8.verticalSpace,
                                Container(
                                  padding: EdgeInsets.all(12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColor.colorF9F9F9, borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.follow410.tr, //'推荐策略：',
                                        style: AppTextStyle.f_14_500.color111111,
                                      ),
                                      8.verticalSpace,
                                      Text(
                                        '${controller.model['tactics'].toString().tr}',
                                        style: AppTextStyle.f_12_400.color666666,
                                      ),
                                    ],
                                  ),
                                ),
                                8.verticalSpace,
                                Container(
                                  padding: EdgeInsets.all(12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColor.colorF9F9F9, borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.follow425.tr, // '附加建议：',
                                        style: AppTextStyle.f_14_500.color111111,
                                      ),
                                      8.verticalSpace,
                                      Text(
                                        '${controller.model['suggest'].toString().tr}',
                                        style: AppTextStyle.f_12_400.color666666,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 136.w,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: const BoxDecoration(
                        color: AppColor.colorFFFFFF,
                      ),
                      child: Column(
                        children: [
                          8.verticalSpace,
                          MyButton(
                            onTap: () {
                              controller.toPage();
                            },
                            height: 48,
                            text: LocaleKeys.follow426.tr, //'查看您的专属交易员',
                            backgroundColor: AppColor.colorFFD429,
                            color: AppColor.color111111,
                            textStyle: AppTextStyle.f_16_600.color111111,
                          ),
                          10.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.w), // Adjust the padding as needed
                            child: InkWell(
                              onTap: () {
                                Get.offAndToNamed(Routes.FOLLOW_QUESTIONNAIRE);
                              },
                              child: Center(
                                child: Text(
                                  LocaleKeys.follow427.tr, //'重新评测',
                                  style: AppTextStyle.f_12_400.color4D4D4D,
                                ),
                              ),
                            ),
                          ),
                          6.verticalSpace,
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  GlobalKey saveImageKey = GlobalKey();
  Widget shareDialog() {
    return Column(
      children: [
        Expanded(
          child: SafeArea(
            bottom: false,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.w),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.colorFFFFFF
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RepaintBoundary(
                        key: saveImageKey,
                        child: Container(
                          padding: EdgeInsets.only(top: 16.w),
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(12.w), color: AppColor.colorFFFFFF),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.follow422.tr, //'您的投资偏好分析',
                                    style: AppTextStyle.f_15_600.color111111,
                                  ),
                                  11.verticalSpace,
                                  SizedBox(
                                    height: 85,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          // height: 76.w,
                                          width: 138.w,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                pWidget(
                                                    LocaleKeys.follow428.tr, //'基础知识',
                                                    controller.basicSupport),
                                                6.verticalSpace,
                                                pWidget(
                                                    LocaleKeys.follow407.tr, //'资金流动性',
                                                    controller.liquidity),
                                                6.verticalSpace,
                                                pWidget(
                                                    LocaleKeys.follow521.tr, //'风险承受',
                                                    controller.riskTolerance),
                                                6.verticalSpace,
                                                pWidget(
                                                    LocaleKeys.follow405.tr, //'投资知识',
                                                    controller.investmentKnowledge),
                                                6.verticalSpace,
                                                pWidget(
                                                    LocaleKeys.follow416.tr, //'投资偏好',
                                                    controller.investmentPreference),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        FollowQuestionrDrawRadarMin(
                                          basicSupport: controller.basicSupport,
                                          liquidity: controller.liquidity,
                                          riskTolerance: controller.riskTolerance,
                                          investmentKnowledge: controller.investmentKnowledge,
                                          investmentPreference: controller.investmentPreference,
                                        )
                                      ],
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Text(
                                    "${controller.model['name'].toString().tr}",
                                    // LocaleKeys.follow354.tr, //'激进型投资者',
                                    style: AppTextStyle.f_15_600.color111111,
                                  ),
                                  12.verticalSpace,
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColor.colorF9F9F9, borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LocaleKeys.follow423.tr, //  '特征：',
                                          style: AppTextStyle.f_13_500.color111111,
                                        ),
                                        8.verticalSpace,
                                        Text(
                                          '${controller.model['characteristic'].toString().tr}',
                                          style: AppTextStyle.f_10_400.color666666,
                                        ),
                                      ],
                                    ),
                                  ),
                                  8.verticalSpace,
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColor.colorF9F9F9, borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LocaleKeys.follow424.tr, //'推荐策略：',
                                          style: AppTextStyle.f_13_500.color111111,
                                        ),
                                        8.verticalSpace,
                                        Text(
                                          '${controller.model['tactics'].toString().tr}',
                                          style: AppTextStyle.f_10_400.color666666,
                                        ),
                                      ],
                                    ),
                                  ),
                                  8.verticalSpace,
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColor.colorF9F9F9, borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LocaleKeys.follow425.tr, // '附加建议：',
                                          style: AppTextStyle.f_13_500.color111111,
                                        ),
                                        8.verticalSpace,
                                        Text(
                                          '${controller.model['suggest'].toString().tr}',
                                          style: AppTextStyle.f_10_400.color666666,
                                        ),
                                      ],
                                    ),
                                  ),
                                  18.verticalSpace,
                                ],
                              ).paddingSymmetric(horizontal: 16.w),
                              Divider(thickness: 1, height: 1, color: AppColor.colorF5F5F5),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                child: Row(
                                  children: [
                                    QrImageView(
                                      data: LinksGetx.to.inviteUserUrl ?? '',
                                      version: QrVersions.auto,
                                      size: 64.w,
                                      backgroundColor: AppColor.colorWhite,
                                      padding: const EdgeInsets.all(2),
                                    ),
                                    8.horizontalSpace,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LocaleKeys.follow429.tr, // '扫码查看详情',
                                          style: AppTextStyle.f_14_700.colorBlack,
                                        ),
                                        Text('${LocaleKeys.trade283.tr} ${UserGetx.to.user?.info?.inviteCode}', //邀请码
                                            style: AppTextStyle.f_12_500.colorBlack)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).marginSymmetric(horizontal: 16),
          ),
        ),
        30.verticalSpace,
        Builder(
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)), color: AppColor.colorFFFFFF),
              child: Column(
                children: [
                  Container(
                    height: 62.w,
                    child: Row(
                      children: [
                        16.horizontalSpace,
                        Text(
                          LocaleKeys.community12.tr, ////'分享',
                          style: AppTextStyle.f_20_600.color111111,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SizedBox(height: 24.w, width: 24.w, child: MyImage('flow/share_close'.svgAssets(),width: 24.w)),
                        ),
                        16.horizontalSpace,
                      ],
                    ),
                  ),
                  FutureBuilder<List<bool>>(
                    future: Future.wait([
                      isAppInstalled('org.telegram.messenger', urlScheme: 'tg://'),
                      isAppInstalled('com.twitter.android', urlScheme: 'twitter://')
                    ]),
                    builder: (context, appSnapshot) {
                      if (appSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (appSnapshot.hasError) {
                        return Text('Error: ${appSnapshot.error}');
                      } else if (appSnapshot.hasData) {
                        final bool isTelegramInstalled = appSnapshot.data![0];
                        final bool isXInstalled = appSnapshot.data![1];
                        return Row(
                          children: [
                            shareBtn(
                                icon: 'icon_share',
                                title: LocaleKeys.follow430.tr, //'复制链接',
                                onTap: () {
                                  String uri = '${UserGetx.to.user?.info?.inviteUrl ?? ''}';
                                  CopyUtil.copyText(uri);
                                }),
                            shareBtn(
                                icon: 'icon_down',
                                title: LocaleKeys.follow431.tr, //'下载图片',
                                onTap: () async {
                                  // 获取widget的RenderObject
                                  final renderObject =
                                      saveImageKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
                                  // 将widget绘制到图片中
                                  final image = await renderObject.toImage();
                                  final byteData = await image.toByteData(format: ImageByteFormat.png);
                                  final pngBytes = byteData!.buffer.asUint8List();
                                  await SaveUtil.saveImage(pngBytes);
                                  UIUtil.showToast(LocaleKeys.public20.tr);
                                }),
                            if (isXInstalled)
                              shareBtn(
                                  icon: 'icon_x',
                                  title: 'X',
                                  onTap: () {
                                    String uri = 'twitter://post?message=${UserGetx.to.user?.info?.inviteUrl ?? ''}';
                                    MyUrlUtil.openUrl(uri);
                                  }),
                            if (isTelegramInstalled)
                              shareBtn(
                                  icon: 'icon_telegram',
                                  title: 'Telegram',
                                  onTap: () {
                                    String uri = 'tg://msg?text=${UserGetx.to.user?.info?.inviteUrl ?? ''}';
                                    MyUrlUtil.openUrl(uri);
                                  }),
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  16.verticalSpaceFromWidth,
                  const Divider(thickness: 1, height: 1, color: AppColor.colorBorderGutter),
                  MyButton(
                    height: 48.h,
                    onTap: () {
                      Get.back();
                    },
                    backgroundColor: AppColor.colorF1F1F1,
                    text: LocaleKeys.public2.tr, //'取消',
                    color: AppColor.color111111,
                    textStyle: AppTextStyle.f_14_600,
                  ).marginAll(16.w),
                  SizedBox(height: MediaQuery.of(context).padding.bottom,)
                ],
              ),
            );
          }
        ),
      ],
    );
  }

  Widget shareBtn({String? title, String? icon = '', Function? onTap}) {
    return SizedBox(
      width: 92.w,
      child: Column(
        children: [
          ClipOval(
            child: InkWell(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                }
              },
              child: Container(
                width: 40,
                height: 40,
                color: AppColor.colorF9F9F9,
                alignment: Alignment.center,
                child: MyImage(
                  'flow/$icon'.svgAssets(),
                  width: 24.w,
                  height: 24.w,
                ),
              ),
            ),
          ),
          4.verticalSpace,
          Text(
            '${title}',
            style: AppTextStyle.f_12_500.color333333,
          )
        ],
      ),
    );
  }

  Widget quitDialog() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
        width: 280,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.w), color: AppColor.colorFFFFFF),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.follow419.tr, //'提示'
              style: AppTextStyle.f_16_600.color111111,
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.follow519.tr, //'您确定不查看你的专属交易员吗',
              style: AppTextStyle.f_13_400.color4D4D4D,
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            MyButton(
              onTap: () {
                Get.back();
                controller.toPage();
              },
              height: 36,
              text: LocaleKeys.c2c215.tr, //'去查看',
              textStyle: AppTextStyle.f_14_600.colorFFFFFF,
            ),
            4.verticalSpace,
            InkWell(
              onTap: () {
                Get.back();
                Get.back();
              },
              child: Container(
                height: 36,
                color: AppColor.colorFFFFFF,
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.follow520.tr, // '确定离开',
                  style: AppTextStyle.f_14_600.color666666,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pWidget(String title, num value) {
    return Row(
      children: [
        Expanded(
            child: Text(
          '${title}',
          style: AppTextStyle.f_8_400.colorABABAB,
        )),
        Container(
          width: 84.w,
          height: 3.w,
          decoration: BoxDecoration(color: AppColor.colorEDEDED, borderRadius: BorderRadius.circular(4.w)),
          alignment: Alignment.centerLeft,
          child: Container(
            width: 84.w / 10 * value,
            height: 3.w,
            decoration: BoxDecoration(color: AppColor.upColor, borderRadius: BorderRadius.circular(4.w)),
          ),
        ),
      ],
    );
  }
}
