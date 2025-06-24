import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/my/question/controllers/question_index_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_list_dialog.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/common/widget/pic_swiper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class QuestionIndexView extends GetView<QuestionIndexController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionIndexController>(builder: (controller) {
      return MySystemStateBar(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              leading: const MyPageBackWidget(),
              title: Text(
                LocaleKeys.user92.tr,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              elevation: 0),
          bottomNavigationBar: controller.loadingController.isSuccess
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(
                      height: 1,
                      color: AppColor.colorF5F5F5,
                    ),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                      child: MyButton(
                        height: 48.h,
                        text: LocaleKeys.public1.tr,
                        onTap: () async {
                          controller.submitOntap();
                        },
                      ),
                    ),
                  ],
                )
              : 0.verticalSpace,
          body: MyPageLoading(
            controller: controller.loadingController,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsetsDirectional.all(16.w),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.reportList.isNotEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: AppColor.colorFFFFFF,
                                borderRadius: BorderRadius.circular(6)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.user113.tr,
                                    style: AppTextStyle.f_12_400.color666666,
                                  ),
                                  8.verticalSpace,
                                  InkWell(
                                    onTap: () async {
                                      int res = await showMyBottomListDialog(
                                        dataList: controller.reportList,
                                        initIndex: controller.reportIndex,
                                        getDisplayText: (item) {
                                          return item.value;
                                        },
                                      );
                                      controller.reportIndex = res;
                                      controller.update();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.fromLTRB(
                                          16.w, 12.h, 16.w, 12.h),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: AppColor.colorF5F5F5),
                                          borderRadius:
                                              BorderRadius.circular(6.r)),
                                      child: Row(
                                        children: [
                                          Text(
                                            controller.currentReport.value ??
                                                '',
                                            style: AppTextStyle.f_14_500,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          MyImage(
                                            'default/arrow_bottom'.svgAssets(),
                                            width: 16.w,
                                            color: AppColor.color4D4D4D,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ]))
                        : 0.verticalSpace,
                    24.verticalSpace,
                    Text(
                      LocaleKeys.user114.tr,
                      style: AppTextStyle.f_11_400.colorDanger,
                    ),
                    14.verticalSpace,
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 160.w,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColor.colorF5F5F5),
                            borderRadius: BorderRadius.circular(6.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.zero,
                                  child: TextField(
                                    minLines: 1,
                                    maxLines: null,
                                    onChanged: (text) {
                                      controller.update();
                                    },
                                    textInputAction: TextInputAction.newline,
                                    controller: controller.descriptionControll,
                                    style: AppTextStyle.f_12_400_15,
                                    decoration: InputDecoration(
                                      hintText: LocaleKeys.user115.tr,
                                      hintMaxLines: 2,
                                      hintStyle:
                                          AppTextStyle.f_12_400_15.colorABABAB,
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.transparent)),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.transparent)),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  )),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      '${controller.descriptionControll.text.length}/200',
                                      style: AppTextStyle.f_14_400.colorABABAB),
                                )),
                              ],
                            ),
                          ],
                        )),
                    24.verticalSpace,
                    Text(
                      LocaleKeys.user116.tr,
                      style: AppTextStyle.f_11_400,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 64.w,
                        margin: EdgeInsets.only(top: 16.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width,
                                ),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.imageList.length <
                                            controller.imageMax
                                        ? controller.imageList.length + 1
                                        : controller.imageMax,
                                    itemBuilder: (context, index) {
                                      return index ==
                                              controller.imageList.length
                                          ? InkWell(
                                              child: Container(
                                                width: 64.w,
                                                height: 64.w,
                                                margin: EdgeInsets.only(
                                                    left: 0,
                                                    right: 8.w,
                                                    top: 0.w),
                                                decoration: BoxDecoration(
                                                    color: AppColor.colorF5F5F5,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r)),
                                                clipBehavior: Clip.antiAlias,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '+',
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.colorABABAB,
                                                      fontSize: 32.sp),
                                                ),
                                              ),
                                              onTap: () async {
                                                if (await requestPhotosPermission()) {
                                                  final List<AssetEntity>?
                                                      result = await AssetPicker
                                                          .pickAssets(
                                                    context,
                                                    pickerConfig:
                                                        AssetPickerConfig(
                                                            requestType:
                                                                RequestType
                                                                    .image,
                                                            maxAssets: controller
                                                                    .imageMax -
                                                                controller
                                                                    .imageList
                                                                    .length),
                                                  );
                                                  if (result != null) {
                                                    for (var i = 0;
                                                        i < result.length;
                                                        i++) {
                                                      controller.imageList
                                                          .add(result[i]);
                                                    }

                                                    // imageList = result;

                                                    controller.update();
                                                  }
                                                }
                                              },
                                            )
                                          : InkWell(
                                              onTap: () {
                                                Get.dialog(
                                                  Material(
                                                    type: MaterialType
                                                        .transparency,
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      child: PicSwiper(
                                                        index: index,
                                                        pics: controller
                                                            .imageList,
                                                        isEntityImage: true,
                                                      ),
                                                    ),
                                                  ),
                                                  barrierDismissible: true,
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                        width: 64.w,
                                                        height: 64.w,
                                                        margin: EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.w,
                                                            top: 0.w),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.r)),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child: AssetEntityImage(
                                                          controller
                                                              .imageList[index],
                                                          isOriginal: false,
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Positioned(
                                                    right: 0.w,
                                                    top: 0.w,
                                                    child: InkWell(
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 14.w,
                                                                  top: 6.w),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 12.w,
                                                                height: 12.w,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(3
                                                                            .w),
                                                                decoration: BoxDecoration(
                                                                    color: AppColor
                                                                        .colorBlack
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            34)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    MyImage(
                                                                      'default/close'
                                                                          .svgAssets(),
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          6.w,
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                      onTap: () {
                                                        controller.imageList
                                                            .removeAt(index);
                                                        controller.update();
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                    }))
                          ],
                        )),
                    SizedBox(
                      height: 20.w,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
