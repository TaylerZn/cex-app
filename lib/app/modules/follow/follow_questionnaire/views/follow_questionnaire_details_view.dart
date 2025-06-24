import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../widgets/basic/my_image.dart';
import '../../../../widgets/basic/my_page_back.dart';
import '../controllers/follow_questionnaire_controller.dart';
import '../controllers/follow_questionnaire_details_controller.dart';

class FollowQuestionnaireDetailsView
    extends GetView<FollowQuestionnaireDetailsController> {
  const FollowQuestionnaireDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() {
        if (controller.isGetResulting.value) {
          return Scaffold(
            backgroundColor: AppColor.colorBackgroundInversePrimary,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 44.w,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.isGetResulting.value = false;
                          },
                          child: MyImage(
                            'default/page_back'.svgAssets(),
                            width: 20.w,
                            height: 20.w,
                            color: AppColor.colorFFFFFF,
                          ).paddingOnly(
                              left: 16.w, top: 10.w, bottom: 10.w, right: 10.w),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  51.verticalSpace,
                  Text(
                    LocaleKeys.follow403.tr, //'正在为您生成风险评估',
                    style: AppTextStyle.f_20_600.colorFFFFFF,
                  ),
                  32.verticalSpace,
                  SizedBox(
                    width: 285.w,
                    height: 285.w,
                    child: Lottie.asset(
                      'assets/json/fspg.json',
                      width: 200.w,
                      height: 140.w,
                      repeat: true,
                    ),
                  ),
                  32.verticalSpace,
                  Container(
                    width: 200.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                        color: AppColor.color2E2E2E,
                        borderRadius: BorderRadius.circular(4.w)),
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      return Container(
                        width: 200.w / 100 * (controller.tic.value),
                        height: 4.w,
                        decoration: BoxDecoration(
                            color: AppColor.colorFFFFFF,
                            borderRadius: BorderRadius.circular(4.w)),
                      );
                    }),
                  ),
                  16.verticalSpace,
                  Text(
                    LocaleKeys.follow404.tr, //'分析测算中...',
                    style: AppTextStyle.f_16_400.colorDDDDDD,
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: AppColor.colorBackgroundInversePrimary,
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 44.w,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (controller.count.value == 0) {
                            // Get.back();
                            Get.dialog(quitDialog());
                          } else {
                            controller.count.value = controller.count.value - 1;
                          }
                        },
                        child: MyImage(
                          'default/page_back'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                          color: AppColor.colorFFFFFF,
                        ).paddingOnly(
                            left: 16.w, top: 10.w, bottom: 10.w, right: 10.w),
                      ),
                      Spacer(),
                      Container(
                        width: 283.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                            color: AppColor.color2E2E2E,
                            borderRadius: BorderRadius.circular(4.w)),
                        alignment: Alignment.centerLeft,
                        child: Obx(() {
                          return Container(
                            width: 283.w / 10 * (controller.count.value + 1),
                            height: 4.w,
                            decoration: BoxDecoration(
                                color: AppColor.colorFFFFFF,
                                borderRadius: BorderRadius.circular(4.w)),
                          );
                        }),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.dialog(quitDialog());
                        },
                        child: MyImage(
                          'flow/close'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                        ).paddingOnly(
                            right: 16.w, top: 10.w, bottom: 10.w, left: 10.w),
                      ),
                    ],
                  ),
                ),
                8.verticalSpace,
                Expanded(
                    child: Obx(() {
                      return IndexedStack(
                        index: controller.count.value,
                        children: [
                          questionnaire1(),
                          questionnaire2(),
                          questionnaire3(),
                          questionnaire4(),
                          questionnaire5(),
                          questionnaire6(),
                          questionnaire7(),
                          questionnaire8(),
                          questionnaire9(),
                          questionnaire10()
                        ],
                      );
                    }).paddingSymmetric(horizontal: 16.w)),
                33.verticalSpace,
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                      color: AppColor.color2EBD87.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: [
                      MyImage(
                        'flow/flag'.svgAssets(),
                        width: 20.w,
                        height: 20.w,
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          LocaleKeys.follow400
                              .tr,
                          // 'Financial regulations require us to collect this information to verify your identity. Your information is encrypted on our secure servers.',
                          style: AppTextStyle.f_10_400.color999999,
                        ),
                      )
                    ],
                  ),
                ).paddingSymmetric(horizontal: 16.w),
                12.verticalSpace,
                Obx(() {
                  if (controller.canNext()) {
                    return MyButton.borderWhiteBg(
                      height: 48.w,
                      text: controller.count.value == 9
                          ? LocaleKeys.follow401.tr //'Submit'
                          : LocaleKeys.follow402.tr, //'Next',
                      onTap: () {
                        controller.increment();
                      },
                    );
                  } else {
                    return MyButton(
                      height: 48.w,
                      text: controller.count.value == 9
                          ? LocaleKeys.follow401.tr //'Submit'
                          : LocaleKeys.follow402.tr,
                      //'Next',
                      onTap: () {
                        controller.increment();
                      },
                      backgroundColor: AppColor.color34373B,
                      color: AppColor.color666666,
                    );
                  }
                }).paddingSymmetric(horizontal: 16.w),
                16.verticalSpace
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget questionnaire1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow340.tr, // 'Basic Information',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow341
              .tr,
          // 'Do you have an educational background in finance, economics or investments?',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelect = index == controller.selectIndexByQ1.value;
                  return itemContainer(
                    isSelect: isSelect,
                    onTap: () {
                      controller.selectIndexByQ1.value = index;
                    },
                    child: Text(
                      '${controller.q1[index]['title']}',
                      style: AppTextStyle.f_14_400.colorDDDDDD,
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q1.length),
        )
      ],
    );
  }

  Widget questionnaire2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow340.tr, // 'Basic Information',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow399.tr, //'What is your main source of funding?',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelect =
                  controller.selectIndexListByQ2.contains(index);
                  Map model = controller.q2[index];
                  return itemContainer(
                    isSelect: isSelect,
                    onTap: () {
                      if (isSelect) {
                        controller.selectIndexListByQ2.remove(index);
                      } else {
                        controller.selectIndexListByQ2.add(index);
                      }
                    },
                    child: Row(
                      children: [
                        MyImage(
                          // 'default/selected'.svgAssets(),
                          '${model['icon']}'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                        ),
                        8.horizontalSpace,
                        Expanded(
                            child: Text(
                              '${model['title']}',
                              style: AppTextStyle.f_14_400.colorDDDDDD,
                            )),
                        MyImage(
                          isSelect
                              ? 'flow/box_selected'.svgAssets()
                              : 'flow/box_select'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                        ),
                      ],
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q2.length),
        )
      ],
    );
  }

  Widget questionnaire3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow405.tr, //'投资知识',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow406.tr, //'我们希望评估以下您的理解程度。',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Obx(() {
                  Map model = controller.q3[index];
                  return itemContainer(
                    isSelect: false,
                    child: Column(
                      children: [
                        Text(
                          '${model['title']}',
                          style: AppTextStyle.f_14_400.colorDDDDDD,
                        ),
                        12.verticalSpace,
                        Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                model['select'] = true;
                                controller.q3.refresh();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColor.color222222,
                                    borderRadius: BorderRadius.circular(100)),
                                child: MyImage(
                                  'flow/select_true'.svgAssets(),
                                  width: 16.w,
                                  height: 16.w,
                                  color: model['select'] == null
                                      ? AppColor.colorDDDDDD
                                      : (model['select']
                                      ? AppColor.color2EBD87
                                      : AppColor.color7E7E7E),
                                ),
                              ),
                            ),
                            12.horizontalSpace,
                            InkWell(
                              onTap: () {
                                model['select'] = false;
                                controller.q3.refresh();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColor.color222222,
                                    borderRadius: BorderRadius.circular(100)),
                                child: MyImage('flow/select_false'.svgAssets(),
                                    width: 16.w,
                                    height: 16.w,
                                    color: model['select'] == null
                                        ? AppColor.colorDDDDDD
                                        : (!model['select']
                                        ? AppColor.downColor
                                        : AppColor.color7E7E7E)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q3.length),
        )
      ],
    );
  }

  Widget questionnaire4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow407.tr, // '资金流动性',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow408.tr, //'您打算持有这些头寸多长时间?',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelect = index == controller.selectIndexByQ4.value;
                  Map model = controller.q4[index];
                  return itemContainer(
                    onTap: () {
                      controller.selectIndexByQ4.value = index;
                    },
                    isSelect: isSelect,
                    child: Text(
                      '${model['title']}',
                      style: AppTextStyle.f_14_400.colorDDDDDD,
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q4.length),
        )
      ],
    );
  }

  Widget questionnaire5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow407.tr, // '资金流动性',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow409.tr, // '您的现金和流动资产总额是多少?',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelect = index == controller.selectIndexByQ5.value;
                  Map model = controller.q5[index];
                  return itemContainer(
                    onTap: () {
                      controller.selectIndexByQ5.value = index;
                    },
                    isSelect: isSelect,
                    child: Text(
                      '${model['title']}',
                      style: AppTextStyle.f_14_400.colorDDDDDD,
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q5.length),
        )
      ],
    );
  }

  Widget questionnaire6() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow410.tr, //'风险承受能力',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow411.tr, //'以下哪种风险回报率更能描述您的期望?',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelect = index == controller.selectIndexByQ6.value;
                  bool isSelected = controller.selectIndexByQ6.value != null;
                  if (isSelect) {
                    isSelected = false;
                  }
                  if (controller.q6.length == index) {
                    if (controller.selectIndexByQ6.value == null) {
                      return Container();
                    }
                    Map model =
                    controller.q6[controller.selectIndexByQ6.value!];
                    num money = controller.q5[controller.selectIndexByQ5.value!]
                    ['money'] *
                        model['moneyPercent'];
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                LocaleKeys.follow412.tr, //'我期望最高收益为',
                                style: AppTextStyle.f_11_400.colorCCCCCC,
                              ),
                              Text(
                                '\$${NumberUtil.mConvert(money, isEyeHide: true,
                                    isRate: null,
                                    count: 0)}',
                                style: AppTextStyle.f_16_500.color2EBD87,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                LocaleKeys.follow413.tr, //'风险不超过',
                                style: AppTextStyle.f_11_400.colorCCCCCC,
                              ),
                              Text(
                                '-\$${NumberUtil.mConvert(
                                    money, isEyeHide: true,
                                    isRate: null,
                                    count: 0)}',
                                style: AppTextStyle.f_16_500.colorF6465D,
                              ),
                            ],
                          ),
                        )
                      ],
                    ).paddingOnly(top: 20);
                  }
                  Map model = controller.q6[index];
                  return itemContainer(
                    isSelect: isSelect,
                    onTap: () {
                      controller.selectIndexByQ6.value = index;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+${model['percent']}',
                          style: AppTextStyle.f_12_500.color2EBD87.copyWith(
                            color: AppColor.color2EBD87
                                .withOpacity(isSelected ? 0.2 : 1),
                          ),
                        ),
                        // 6.horizontalSpace,
                        ClipPath(
                          clipper: TrianglePath(),
                          child: Container(
                            height: 5.w,
                            width: model['width'],
                            decoration: BoxDecoration(
                                color: AppColor.color2EBD87
                                    .withOpacity(isSelected ? 0.2 : 1),
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(5.w))),
                          ),
                        ),
                        ClipPath(
                          clipper: RedTrianglePath(),
                          child: Container(
                            height: 5.w,
                            width: model['width'],
                            decoration: BoxDecoration(
                                color: AppColor.colorF6465D
                                    .withOpacity(isSelected ? 0.2 : 1),
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(5.w))),
                          ),
                        ),
                        // 6.horizontalSpace,
                        Text(
                          '-${model['percent']}',
                          style: AppTextStyle.f_12_500.colorF6465D.copyWith(
                            color: AppColor.colorF6465D
                                .withOpacity(isSelected ? 0.2 : 1),
                          ),
                        )
                      ],
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q6.length + 1),
        )
      ],
    );
  }

  Widget questionnaire7() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow410.tr, //'风险承受能力',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow414.tr, //'您如何看待高风险高收益的投资?',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelect = index == controller.selectIndexByQ7.value;
                  Map model = controller.q7[index];
                  return itemContainer(
                    isSelect: isSelect,
                    onTap: () {
                      controller.selectIndexByQ7.value = index;
                    },
                    child: Text(
                      '${model['title']}',
                      style: AppTextStyle.f_14_400.colorDDDDDD,
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q7.length),
        )
      ],
    );
  }

  Widget questionnaire8() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow410.tr, //'风险承受能力',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow415.tr, //'您是否了解复制交易员的风险和收益特征?',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelect = index == controller.selectIndexByQ8.value;
                  Map model = controller.q8[index];
                  return itemContainer(
                    onTap: () {
                      controller.selectIndexByQ8.value = index;
                    },
                    isSelect: isSelect,
                    child: Text(
                      '${model["title"]}',
                      style: AppTextStyle.f_14_400.colorDDDDDD,
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q8.length),
        )
      ],
    );
  }

  Widget questionnaire9() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow416.tr, //'投资偏好',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow417.tr, //'您对交易品种的偏好是？',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelect =
                  controller.selectIndexListByQ9.contains(index);
                  Map model = controller.q9[index];
                  return itemContainer(
                    isSelect: isSelect,
                    onTap: () {
                      if (isSelect) {
                        controller.selectIndexListByQ9.remove(index);
                      } else {
                        controller.selectIndexListByQ9.add(index);
                      }
                    },
                    child: Row(
                      children: [
                        MyImage(
                          //'default/selected'.svgAssets(),
                          '${model['icon']}'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                        ),
                        8.horizontalSpace,
                        Expanded(
                            child: Text(
                              '${model['title']}',
                              style: AppTextStyle.f_14_400.colorDDDDDD,
                            )),
                        MyImage(
                          isSelect
                              ? 'flow/box_selected'.svgAssets()
                              : 'flow/box_select'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                        ),
                      ],
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q9.length),
        )
      ],
    );
  }

  Widget questionnaire10() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(
                color: AppColor.colorTextSecondary,
                borderRadius: BorderRadius.circular(4.w)),
            child: Text(
              LocaleKeys.follow416.tr, // '投资偏好',
              style: AppTextStyle.f_10_500.colorCCCCCC,
            )),
        24.verticalSpace,
        Text(
          LocaleKeys.follow418.tr, //'您在复制交易时更倾向选择哪类交易员?',
          style: AppTextStyle.f_20_600.colorFFFFFF,
        ),
        24.verticalSpace,
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelect = index == controller.selectIndexByQ10.value;
                  Map model = controller.q10[index];
                  return itemContainer(
                    onTap: () {
                      controller.selectIndexByQ10.value = index;
                    },
                    isSelect: isSelect,
                    child: Text(
                      '${model["title"]}',
                      style: AppTextStyle.f_14_400.colorDDDDDD,
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemCount: controller.q10.length),
        )
      ],
    );
  }

  Widget itemContainer({
    required Widget child,
    required bool isSelect,
    Function? onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: isSelect
            ? BoxDecoration(
            color: AppColor.color2EBD87.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.color2EBD87, width: 1.w))
            : BoxDecoration(
            color: AppColor.color2C2E33,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.transparent, width: 1.w)),
        child: child,
      ),
    );
  }

  Widget quitDialog() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
        width: 280,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: AppColor.colorFFFFFF),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.follow419.tr, //'提示',
              style: AppTextStyle.f_16_600.color111111,
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.follow420.tr, //'退出后测试进度将被清空,\n确定要退出测试吗?',
              style: AppTextStyle.f_13_400.color4D4D4D,
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            MyButton(
              onTap: () {
                Get.back();
                Get.back();
                Get.back();
              },
              height: 36,
              backgroundColor: AppColor.downColor,
              text: LocaleKeys.public1.tr,
              //'确定',
              textStyle: AppTextStyle.f_14_600.colorFFFFFF,
            ),
            4.verticalSpace,
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 36,
                color: AppColor.colorFFFFFF,
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.public2.tr, //'取消',
                  style: AppTextStyle.f_14_600.color666666,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrianglePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.height, size.width - 2.w);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class RedTrianglePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(5.w, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
