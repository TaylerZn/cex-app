import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/kyc.dart';
import 'package:nt_app_flutter/app/models/main/main.dart';
import 'package:nt_app_flutter/app/modules/login/widgets/Search_Country_Page.dart';
import 'package:nt_app_flutter/app/modules/my/kyc/controllers/kyc_index_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class KycIndexView extends GetView<KycIndexController> {
  const KycIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycIndexController>(builder: (controller) {
      return MySystemStateBar(
        color: SystemColor.black,
        child: Scaffold(
          appBar: AppBar(
              leading: MyPageBackWidget(
                onTap: () {
                  if (controller.pageIndex == 0) {
                    showKycBack(context);
                  } else {
                    controller.pageIndex--;
                    controller.childPageController
                        .jumpToPage(controller.pageIndex);
                    controller.update();
                  }
                },
              ),
              elevation: 0),
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w,
                16.h + MediaQuery.of(context).viewPadding.bottom),
            child: MyButton(
                height: 48.w,
                text: LocaleKeys.public3.tr,
                color: Colors.white,
                goIcon: true,
                backgroundColor: Color(controller.getNextButtonColor()),
                onTap: () async {
                  if (controller.canNextPage()) {
                    if (controller.pageIndex == 2) {
                      controller.onSubmit();
                    } else {
                      controller.pageIndex++;
                      controller.childPageController
                          .jumpToPage(controller.pageIndex);
                    }
                    controller.update();
                  }
                }),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.user60.tr,
                          style: AppTextStyle.f_24_600,
                        ),
                        10.verticalSpace,
                        Text(
                          LocaleKeys.user61.tr,
                          style: AppTextStyle.f_12_400.color999999,
                        ),
                      ],
                    )),
                28.verticalSpace,
                Expanded(
                    child: PageView(
                  physics: const NeverScrollableScrollPhysics(), // 禁止手势滑动
                  controller: controller.childPageController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.verticalSpace,
                          keyBoxWidget(
                            context,
                            LocaleKeys.user62.tr,
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return const SearchCountryPage();
                                  })).then((value) {
                                    if (value != null && value is CountryList) {
                                      controller.countryData = value;
                                      if (controller.countryData?.numberCode ==
                                          controller.chinaCode) {
                                        controller.idType =
                                            KycIdTypeEnum.idCard;
                                      } else {
                                        if (controller.idType ==
                                            KycIdTypeEnum.idCard) {
                                          controller.idType =
                                              KycIdTypeEnum.passport;
                                        }
                                      }
                                      controller.update();
                                    }
                                  });
                                },
                                child: Container(
                                  height: 44.h,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${controller.countryData != null ? controller.countryData?.enName : LocaleKeys.user34.tr}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(
                                                controller.countryData != null
                                                    ? 0xff111111
                                                    : 0xff999999),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      MyImage(
                                          'default/arrow_bottom'.svgAssets(),
                                          width: 16.w,
                                          color: AppColor
                                              .color4D4D4D //Color(0xff4D4D4D),
                                          )
                                    ],
                                  ),
                                )),
                          ),
                          30.verticalSpace,
                          Text(
                            LocaleKeys.user63.tr,
                            style: const TextStyle(color: AppColor.color666666),
                          ),
                          8.verticalSpace,
                          Column(
                            children: [
                              getItem(KycIdTypeEnum.idCard),
                              getItem(KycIdTypeEnum.passport),
                              getItem(KycIdTypeEnum.drvingLicense),
                              getItem(KycIdTypeEnum.other),
                            ],
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              keyBoxWidget(
                                  context,
                                  LocaleKeys.user64.tr,
                                  MyTextFieldWidget(
                                      onChanged: (s) {
                                        controller.update();
                                      },
                                      height: 44.w,
                                      controller:
                                          controller.surnameTextControll,
                                      focusedBorderColor: AppColor.transparent,
                                      hintText: LocaleKeys.user65.tr,
                                      isTopText: false,
                                      enabledBorderColor: AppColor.transparent,
                                      hintStyle:
                                          AppTextStyle.f_14_500.colorABABAB)),
                              SizedBox(
                                height: 30.w,
                              ),
                            ],
                          ),
                          keyBoxWidget(
                              context,
                              LocaleKeys.user66.tr,
                              MyTextFieldWidget(
                                  onChanged: (s) {
                                    controller.update();
                                  },
                                  height: 44.w,
                                  controller: controller.nameTextControll,
                                  focusedBorderColor: AppColor.transparent,
                                  hintText:
                                      controller.idType != KycIdTypeEnum.idCard
                                          ? LocaleKeys.user67.tr
                                          : LocaleKeys.user69.tr,
                                  isTopText: false,
                                  enabledBorderColor: AppColor.transparent,
                                  hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.colorABABAB))),
                          SizedBox(
                            height: 30.w,
                          ),
                          keyBoxWidget(
                              context,
                              LocaleKeys.user70.tr,
                              MyTextFieldWidget(
                                  onChanged: (s) {
                                    controller.update();
                                  },
                                  height: 44.w,
                                  controller: controller.documentsTextControll,
                                  focusedBorderColor: AppColor.transparent,
                                  hintText: LocaleKeys.user71.tr,
                                  isTopText: false,

                                  /// 限制只能输入数字和字母
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z0-9]')),
                                  ],
                                  enabledBorderColor: AppColor.transparent,
                                  hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.colorABABAB))),
                          SizedBox(
                            height: 10.w,
                          ),
                          Text(LocaleKeys.user72.tr,
                              style: AppTextStyle.f_12_400.colorDanger),
                          32.verticalSpace,
                          keyBoxWidget(
                              context,
                              LocaleKeys.user317.tr,
                              InkWell(
                                onTap: () {
                                  UIUtil.showDatePicker(
                                      context: context,
                                      onConfirm: (DateTime value) {
                                        controller.birthDate = value;
                                        controller.update();
                                      });
                                },
                                child: Container(
                                  height: 44.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.birthDate != null
                                              ? DateUtil.formatDate(
                                                  controller.birthDate,
                                                  format: DateFormats.y_mo_d)
                                              : LocaleKeys.user318.tr,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(
                                                controller.birthDate != null
                                                    ? 0xff111111
                                                    : 0xff999999),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      MyImage(
                                          'default/arrow_bottom'.svgAssets(),
                                          width: 16.w,
                                          color: AppColor
                                              .color4D4D4D //Color(0xff4D4D4D),
                                          )
                                    ],
                                  ),
                                ),
                              )),
                          32.verticalSpace,
                          Text(
                            LocaleKeys.user319.tr,
                            style: AppTextStyle.f_12_400.colorTextDescription,
                          ),
                          Text(
                            LocaleKeys.user320.tr,
                            style: AppTextStyle.f_12_400.colorTextDescription,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kycImageWidget(context, 1),
                        16.verticalSpace,
                        kycImageWidget(context, 2),
                        16.verticalSpace,
                        kycImageWidget(context, 0),
                        36.verticalSpace,
                        Text(
                          LocaleKeys.user73.tr,
                          style: AppTextStyle.f_14_600,
                        ),
                        9.verticalSpace,
                        Text(
                          LocaleKeys.user74.tr,
                          style: AppTextStyle.f_12_400_15.color999999,
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                      ],
                    )),
                  ],
                )),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getItem(int type) {
    return InkWell(
      onTap: (() async {
        controller.idType = type;
        controller.update();
      }),
      child: Container(
        width: double.infinity,
        height: 44.w,
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.colorBorderStrong,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 16.h),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Text(
                KycIdTypeEnum.getName(type),
                style:
                    AppTextStyle.f_14_600.colorTextPrimary, //Color(0xff4d4d4d)
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            controller.idType == type
                ? MyImage(
                    'default/selected_success'.svgAssets(),
                    width: 14.w,
                    height: 14.w,
                  )
                : Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                            width: 1.6.w, color: AppColor.colorBBBBBB)),
                  ),
          ],
        ),
      ),
    );
  }

  keyBoxWidget(context, text, child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$text',
          style: AppTextStyle.f_12_400.colorTextDescription,
        ),
        SizedBox(
          height: 10.w,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.colorBorderStrong),
              borderRadius: BorderRadius.circular(6),
            ),
            child: child)
      ],
    );
  }

  showKycBack(context) async {
    bool? res = await UIUtil.showConfirm(
      LocaleKeys.user75.tr,
      content: LocaleKeys.user76.tr,
      cancelText: LocaleKeys.public4.tr,
      confirmText: LocaleKeys.user77.tr,
    );
    print(res);
    if (res == false) {
      Get.back();
    }
  }

  selectIdType() {
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
            child: Text(
              KycIdTypeEnum.getName(KycIdTypeEnum.idCard),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.color4D4D4D), //Color(0xff4d4d4d)
            ),
            height: 50.w,
            alignment: Alignment.center,
          ),
          onTap: (() async {
            controller.idType = KycIdTypeEnum.idCard;

            Get.back();
          }),
        ),
        Divider(height: 0.5.w, color: AppColor.colorF5F5F5 //Color(0xffF5F5FA),
            ),
        InkWell(
          child: Container(
            child: Text(
              KycIdTypeEnum.getName(KycIdTypeEnum.passport),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.color4D4D4D), //Color(0xff4d4d4d)
            ),
            height: 50.w,
            alignment: Alignment.center,
          ),
          onTap: (() async {
            controller.idType = KycIdTypeEnum.passport;

            Get.back();
          }),
        ),
        Divider(
          height: 0.5.w,
          color: Color(0xffF5F5FA),
        ),
        InkWell(
          onTap: (() async {
            Get.back();
          }),
          child: Container(
            height: 50.w,
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.public2.tr,
              style: TextStyle(
                  color: AppColor.colorA3A3A3,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500), //Color(0xffA3A3A3)
            ),
          ),
        ),
      ],
    );
  }

  kycImageWidget(context, index) {
    var image;
    var imageType;
    var beforeByteLength;
    var bgImage;
    var bgText = '';
    //0、手持证件照 1、证件正面 2、证件反面
    if (index == 0) {
      image = controller.idHoldingImage;
      imageType = controller.idHoldingImageType;
      beforeByteLength = controller.passportBeforeByteLength;
      bgImage = 'my/setting/kyc_id_holding';
      bgText = LocaleKeys.user79.tr;
    } else if (index == 1) {
      image = controller.idFrontImage;
      imageType = controller.idFrontImageType;
      beforeByteLength = controller.idFrontBeforeByteLength;
      bgImage = 'my/setting/kyc_id_front';
      bgText = LocaleKeys.user78.tr;
    } else if (index == 2) {
      image = controller.idReverseImage;
      imageType = controller.idReverseImageType;
      controller.idReverseBeforeByteLength = controller.idFrontBeforeByteLength;
      bgImage = 'my/setting/kyc_id_reverse';
      bgText = LocaleKeys.user80.tr;
    }
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 184.w,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
        decoration: BoxDecoration(
            color: AppColor.colorF5F5F5,
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                controller.getKycImage(index);
              },
              child: Container(
                  height: 144.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(6)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      imageType == KycImageEnum.NOT_UPLOADED
                          ? MyImage(
                              '$bgImage'.svgAssets(),
                              width: 287.w,
                            )
                          : Container(
                              width: 287.w,
                              height: 144.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: AssetEntityImage(
                                image as AssetEntity,
                                fit: BoxFit.cover,
                              )),
                      imageType == KycImageEnum.LIMIT ||
                              imageType == KycImageEnum.NOT_UPLOADED
                          ? Positioned(
                              child: Container(
                                  width: 287.w,
                                  height: 144.w,
                                  child: imageType == KycImageEnum.NOT_UPLOADED
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MyImage(
                                              'my/setting/kyc_add'.svgAssets(),
                                              width: 40.w,
                                            ),
                                            SizedBox(
                                              height: 12.w,
                                            ),
                                            Text(
                                              bgText,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        )
                                      : ClipRect(
                                          child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10, sigmaY: 10),
                                              child: Container(
                                                  width: 283.w,
                                                  height: 144.w,
                                                  color: AppColor.colorBlack
                                                      .withOpacity(0.4),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      MyImage(
                                                        'my/setting/kyc_error'
                                                            .pngAssets(),
                                                        width: 50.w,
                                                      ),
                                                      SizedBox(
                                                        height: 10.w,
                                                      ),
                                                      Text(
                                                        LocaleKeys.user81.tr,
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .colorA3A3A3, //Color(0xffA3A3A3),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.sp),
                                                      ),
                                                      SizedBox(
                                                        height: 6.w,
                                                      ),
                                                      Text(
                                                          '${MyFileUtil.filesize(beforeByteLength)}',
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xffD90000))),
                                                    ],
                                                  ))))),
                            )
                          : SizedBox()
                    ],
                  )),
            )
          ],
        ));
  }
}
