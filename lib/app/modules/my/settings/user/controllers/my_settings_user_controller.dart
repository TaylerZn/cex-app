import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/api/file/file_interface.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/kyc.dart';
import 'package:nt_app_flutter/app/enums/my.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/user_setting.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_tab_underline_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/app/widgets/dialog/dialog_topWidget.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_dialog.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/pages/complex/image_avatar_page.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MySettingsUserController extends GetxController with GetSingleTickerProviderStateMixin {
  TextEditingController nikenameControll = TextEditingController();
  TextEditingController descriptionControll = TextEditingController();
  MyPageLoadingController picturesLoadingController = MyPageLoadingController();
  late TabController tabController;
  File? image;
  int imageType = KycImageEnum.NOT_UPLOADED;
  int? beforeByteLength;

  final List<String> tabs = [
    LocaleKeys.user261,
    LocaleKeys.user262,
  ];
  double avatarMax = 10;
  int nikenameMaxLenght = 60;

  List defaultPictures = [];
  int? defaultIndex;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: tabs.length);
    var user = Get.find<UserGetx>().user?.info;
    nikenameControll.text = user?.nickName ?? '';
    descriptionControll.text = user?.signatureInfo ?? '';
    getConfigdefaultPictures();
    super.onInit();
  }

  List<MenuEntry> entries(BuildContext context) {
    return [
      MenuEntry(
          name: LocaleKeys.user195.tr,
          height: 108.w,
          rightWidget: Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: UserAvatar(
              UserGetx.to.avatar,
              width: 60.w,
              height: 60.w,
            ),
          ),
          goIcon: true,
          onTap: () async {
            showMyBottomDialog(context, avatarDialog(), isDismissible: true);
          }),
    ];
  }

  List<MenuEntry> entriesTwo(BuildContext context) {
    var authUserGetx = Get.find<UserGetx>().user;
    var name = authUserGetx?.info?.nickName;
    var signature = authUserGetx?.info?.signatureInfo;
    var isName = name != null && name.isNotEmpty;
    var isSignature = signature != null && signature.isNotEmpty;

    return [
      MenuEntry(
          name: LocaleKeys.user196.tr,
          behindName: isName ? name : LocaleKeys.user157.tr,
          showNewPoint: isName ? false : true,
          behindNameColor: isName ? AppColor.color111111 : AppColor.color666666,
          onTap: () {
            showMyBottomDialog(context, nikenameDialog(), padding: EdgeInsets.zero, isDismissible: true);
          }),
      if (UserGetx.to.isKol)
        MenuEntry(
            name: LocaleKeys.user325.tr,
            behindName: isSignature ? signature : LocaleKeys.user157.tr,
            showNewPoint: isSignature ? false : true,
            behindNameColor: isSignature ? AppColor.color111111 : AppColor.color666666,
            onTap: () {
              showMyBottomDialog(context, descriptionDialog(), padding: EdgeInsets.zero, isDismissible: true);
            }),
      // MenuEntry(
      //     name: '个人标识',
      //     behindName: '',
      //     icon: '',
      //     onTap: () {
      //       Get.toNamed(Routes.USER_TAG);
      //     }),
      MenuEntry(
          name: 'UID',
          behindName: '${authUserGetx?.info?.id}',
          goIcon: false,
          onTap: () {
            CopyUtil.copyText('${authUserGetx?.info?.id}');
          }),
    ];
  }

  submitOntap(c, MySettingUserEnum type) async {
    EasyLoading.show();
    dynamic data;
    if (type == MySettingUserEnum.avatar) {
      try {
        await UserApi.instance().userPersonPictureUpdate(c);
        UserGetx.to.user?.info?.profilePictureUrl = '$c';
        UserGetx.to.update();

        UIUtil.showSuccess(LocaleKeys.user198.tr);
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
      }
    } else if (type == MySettingUserEnum.nickName) {
      if (Get.find<UserGetx>().user?.info?.nickName == c) {
        Get.back();
        EasyLoading.dismiss();
        UIUtil.showSuccess(LocaleKeys.user198.tr);
        return;
      }
      data = {
        'nickname': c,
      };

      try {
        await UserApi.instance().usernicknameupdate(data);
        Get.find<UserGetx>().user?.info?.nickName = '$c';
        Get.find<UserGetx>().update();
        Get.back();
        UIUtil.showSuccess(LocaleKeys.user198.tr);
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
      }
    } else if (type == MySettingUserEnum.signature) {
      data = {
        'signatureData': c,
      };
      try {
        await UserApi.instance().userPersonSignatureUpdate(data);
        Get.find<UserGetx>().user?.info?.signatureInfo = '$c';
        Get.find<UserGetx>().update();
        Get.back();
        UIUtil.showSuccess(LocaleKeys.user198.tr);
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
      }
    }
    EasyLoading.dismiss();
  }

  //获取默认头像
  getConfigdefaultPictures() async {
    DefaultPicturesModel? res = await UserApi.instance().configdefaultPictures();
    if (res != null && res.url != null && res.url!.isNotEmpty) {
      defaultPictures = res.url!;
      picturesLoadingController.setSuccess();
      update();
    } else {
      picturesLoadingController.setEmpty();
      update();
    }
  }

  getAvatarImage() async {
    if (await requestPhotosPermission()) {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        Get.context!,
        pickerConfig: const AssetPickerConfig(requestType: RequestType.image, maxAssets: 1),
      );
      if (result != null) {
        var file = await result[0].file;
        Get.to(ImageAvatarPage(file: file!))?.then((value) {
          if (value != null) {
            var beforeByteLength = value?.readAsBytesSync().length;
            if (beforeByteLength != null) {
              beforeByteLength = beforeByteLength;
              if (beforeByteLength < avatarMax * 1024 * 1024) {
                image = value;
                imageType = KycImageEnum.UPLOADED;
              } else {
                UIUtil.showError(LocaleKeys.other97.tr);
                imageType = KycImageEnum.LIMIT;
              }
            } else {
              UIUtil.showToast(
                LocaleKeys.user91.tr,
              );
            }
            update();
          }
        });
      }
    }
  }

  avatarDialog() {
    return GetBuilder<MySettingsUserController>(builder: (controller) {
      return DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              dialogTopWidget(LocaleKeys.user199.tr, LocaleKeys.user200.tr),
              16.verticalSpace,
              UserGetx.to.isKol
                  ? SizedBox(
                      height: 38.h,
                      child: TabBar(
                        controller: controller.tabController,
                        padding: const EdgeInsets.all(0),
                        indicatorPadding: const EdgeInsets.all(0),
                        labelPadding: EdgeInsets.only(left: 0, right: 20.w, top: 0, bottom: 0),
                        isScrollable: true,
                        indicator: const MyUnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColor.color111111,
                          ),
                        ),
                        labelColor: AppColor.color111111,
                        unselectedLabelColor: AppColor.colorABABAB,
                        labelStyle: AppTextStyle.f_14_500,
                        unselectedLabelStyle: AppTextStyle.f_14_500,
                        tabAlignment: TabAlignment.start,
                        tabs: controller.tabs
                            .map((e) => Tab(
                                  text: e.tr,
                                ))
                            .toList(),
                      ),
                    )
                  : 0.verticalSpace,
              12.verticalSpace,
              SizedBox(
                height: Get.height * 0.6,
                child:
                    TabBarView(physics: const NeverScrollableScrollPhysics(), controller: controller.tabController, children: [
                  MyPageLoading(
                      controller: picturesLoadingController,
                      body: Container(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: SingleChildScrollView(
                              child: WaterfallFlow.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  shrinkWrap: true,
                                  itemCount: defaultPictures.length,
                                  gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 12.w,
                                    mainAxisSpacing: 24.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    var item = defaultPictures[index];
                                    return InkWell(
                                        onTap: () {
                                          defaultIndex = index;
                                          update();
                                        },
                                        child: Container(
                                            width: 66.w,
                                            height: 66.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2.w,
                                                color: defaultIndex == index ? AppColor.color111111 : AppColor.transparent,
                                              ),
                                              borderRadius: BorderRadius.circular(6.r),
                                            ),
                                            child: MyImage(
                                              '$item',
                                            )));
                                  })))),
                  UserGetx.to.isKol
                      ? Center(
                          child: InkWell(
                              onTap: () {
                                controller.getAvatarImage();
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 100.w,
                                    height: 100.w,
                                    decoration: const BoxDecoration(
                                      color: AppColor.colorF5F5F5,
                                      shape: BoxShape.circle,
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: Alignment.center,
                                    child: imageType == KycImageEnum.UPLOADED
                                        ? Image.file(
                                            image!,
                                            fit: BoxFit.cover,
                                          )
                                        : Text(
                                            '+',
                                            style: AppTextStyle.f_38_400.copyWith(height: 1),
                                          ),
                                  ),
                                  imageType == KycImageEnum.UPLOADED
                                      ? Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 28.w,
                                            height: 28.w,
                                            decoration: BoxDecoration(
                                              color: AppColor.colorWhite,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 8, //阴影范围
                                                  spreadRadius: 0, //阴影浓度
                                                  color: AppColor.colorBlack.withOpacity(0.08), //阴影颜色
                                                ),
                                              ],
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '+',
                                              style: AppTextStyle.f_20_400.copyWith(height: 1),
                                            ),
                                          ))
                                      : 0.verticalSpace
                                ],
                              )))
                      : Container(),
                ]),
              ),
              12.verticalSpace,
              Container(
                  padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
                  decoration: const BoxDecoration(border: Border(top: BorderSide(width: 1, color: AppColor.colorECECEC))),
                  child: Row(children: [
                    Expanded(
                      child: MyButton.borderWhiteBg(
                        height: 48.w,
                        text: LocaleKeys.public2.tr,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    7.horizontalSpace,
                    tabController.index == 0
                        ? Expanded(
                            child: MyButton(
                            height: 48.w,
                            text: LocaleKeys.public1.tr,
                            color: Colors.white,
                            backgroundColor: defaultIndex != null ? AppColor.color111111 : AppColor.colorCCCCCC,
                            onTap: () {
                              Get.back();
                              if (defaultIndex != null) {
                                submitOntap(defaultPictures[defaultIndex!], MySettingUserEnum.avatar);
                              } else {
                                UIUtil.showToast(LocaleKeys.user201.tr);
                              }
                            },
                          ))
                        : Expanded(
                            child: MyButton(
                            height: 48.w,
                            text: LocaleKeys.public1.tr,
                            color: Colors.white,
                            backgroundColor: image != null ? AppColor.color111111 : AppColor.colorCCCCCC,
                            onTap: () async {
                              EasyLoading.show();
                              Get.back();
                              String? res = await communitystorageupload(image, fileType: FileType.Image);
                              EasyLoading.dismiss();
                              if (res != null) {
                                image = null;
                                imageType = KycImageEnum.NOT_UPLOADED;
                                submitOntap(res, MySettingUserEnum.avatar);
                              }
                            },
                          )),
                  ])),
            ],
          ));
    });
  }

  nikenameDialog() {
    return GetBuilder<MySettingsUserController>(builder: (controller) {
      return Container(
          padding: EdgeInsets.fromLTRB(0, 19.h, 0, 16.h + Get.mediaQuery.padding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              dialogTopWidget(LocaleKeys.user202.tr, LocaleKeys.user203.tr).marginSymmetric(horizontal: 24.w),
              28.verticalSpace,
              Container(
                height: 58.w,
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColor.colorF5F5F5,
                    border: Border.all(width: 1.w, color: AppColor.color111111)),
                child: TextField(
                  onChanged: (text) {
                    update();
                  },
                  controller: nikenameControll,
                  maxLength: nikenameMaxLenght,
                  style: AppTextStyle.f_15_600,
                  decoration: InputDecoration(
                    counterText: '', // 取消角标
                    contentPadding: EdgeInsets.only(top: 16.w, left: 0.w, right: 0.w, bottom: 0.h),
                    border: const OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Container(
                      width: 20.w,
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${nikenameControll.text.length}/$nikenameMaxLenght',
                        style: AppTextStyle.f_14_400.colorABABAB,
                      ),
                    ),
                    hintText: LocaleKeys.user204.tr,
                    hintStyle: AppTextStyle.f_15_500.colorABABAB,
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.transparent)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.transparent)),
                  ),
                ),
              ),
              23.verticalSpace,
              Container(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0.h),
                  decoration: const BoxDecoration(border: Border(top: BorderSide(width: 1, color: AppColor.colorECECEC))),
                  child: Row(children: [
                    Expanded(
                      child: MyButton.borderWhiteBg(
                        height: 48.w,
                        text: LocaleKeys.public2.tr,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    7.horizontalSpace,
                    Expanded(
                      child: MyButton(
                        height: 48.w,
                        text: LocaleKeys.public1.tr,
                        color: Colors.white,
                        backgroundColor: nikenameControll.text.isNotEmpty ? AppColor.color111111 : AppColor.colorCCCCCC,
                        onTap: () {
                          if (nikenameControll.text.isNotEmpty && nikenameControll.text.length <= nikenameMaxLenght) {
                            submitOntap(nikenameControll.text, MySettingUserEnum.nickName);
                          } else if (nikenameControll.text.length > nikenameMaxLenght) {
                            UIUtil.showToast(LocaleKeys.user205.tr);
                          }
                        },
                      ),
                    ),
                  ])),
            ],
          ));
    });
  }

  descriptionDialog() {
    return GetBuilder<MySettingsUserController>(builder: (controller) {
      return Container(
          padding: EdgeInsets.fromLTRB(0, 24.h, 0, 16.h + Get.mediaQuery.padding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dialogTopWidget('设置简介'.tr, LocaleKeys.user207.tr).marginSymmetric(horizontal: 24.w),
              22.verticalSpace,
              Container(
                  height: 198.w,
                  padding: EdgeInsets.all(16.w),
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(color: AppColor.colorF5F5F5, borderRadius: BorderRadius.circular(6.r)),
                  child: TextField(
                    maxLines: 8,
                    onChanged: (text) {
                      update();
                    },
                    textInputAction: TextInputAction.done,
                    maxLength: 1000,
                    controller: descriptionControll,
                    style: AppTextStyle.f_14_500,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      hintText: LocaleKeys.user208.tr,
                      hintStyle: AppTextStyle.f_14_400.colorABABAB,
                      helperStyle: AppTextStyle.f_14_400.colorABABAB,
                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.transparent)),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.transparent)),
                    ),
                  )),
              16.verticalSpace,
              Container(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0.h),
                  decoration: const BoxDecoration(border: Border(top: BorderSide(width: 1, color: AppColor.colorECECEC))),
                  child: Row(children: [
                    Expanded(
                      child: MyButton.borderWhiteBg(
                        height: 48.w,
                        text: LocaleKeys.public2.tr,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    7.horizontalSpace,
                    Expanded(
                      child: MyButton(
                        height: 48.w,
                        text: LocaleKeys.public1.tr,
                        color: Colors.white,
                        backgroundColor: descriptionControll.text.isNotEmpty ? AppColor.color111111 : AppColor.colorCCCCCC,
                        onTap: () {
                          if (descriptionControll.text.isNotEmpty) {
                            if (descriptionControll.text.length <= 1000) {
                              submitOntap(descriptionControll.text, MySettingUserEnum.signature);
                            } else {
                              UIUtil.showToast(LocaleKeys.user205.tr);
                            }
                          }
                        },
                      ),
                    ),
                  ])),
            ],
          ));
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
