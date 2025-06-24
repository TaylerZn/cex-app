import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_search_text_field.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/currency_select_controller.dart';

class B2cCurrencySelectView extends GetView<B2cCurrencySelectController> {
  const B2cCurrencySelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: _buildHeader()),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(), // 这将去除上拉时的黑边特性
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    _buildList(context),
                  ],
                ))),
      ),
    );
  }

  Widget _buildHeader() {
    return MySearchTextField(
        height: 32.h,
        textEditingController: controller.textController!,
        margin: EdgeInsets.zero,
        hintText: LocaleKeys.public11.tr,
        onCancelTap: () {
          Get.back();
        },
        onChanged: (val) {
          controller.searchAction(val);
        });
    return SizedBox(
      height: 44.h,
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
                color: AppColor.colorF5F5F5,
                borderRadius: BorderRadius.circular(6.r)),
            child: Row(
              children: [
                MyImage(
                  'default/search'.svgAssets(),
                ),
                SizedBox(width: 10.w),
                Expanded(
                    child: TextField(
                  controller: controller.textController,
                  style: TextStyle(fontSize: 12.sp),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      border: InputBorder.none,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: LocaleKeys.public11.tr,
                      hintStyle: AppTextStyle.f_13_400.colorABABAB),
                  onChanged: (val) {
                    controller.searchAction(val);
                  },
                  textAlignVertical: TextAlignVertical.center,
                ))
              ],
            ),
          )),
          SizedBox(width: 8.w),
          InkWell(
            child: Text(LocaleKeys.public2.tr,
                    style: AppTextStyle.f_14_500.color666666)
                .paddingOnly(left: 8.w),
            onTap: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.assets105.tr,
                  style: AppTextStyle.f_12_400
                      .copyWith(color: AppColor.colorTextDescription),
                ),
              ],
            ),
            controller.searchList.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(top: 16.h),
                    child: Wrap(
                        spacing: 10.w,
                        runSpacing: 24.h,
                        children: controller.searchList
                            .map(
                              (item) => InkWell(
                                child: Row(
                                  children: [
                                    MyImage(
                                      item.icon ?? '',
                                      width: 24.w,
                                      height: 24.w,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        child: Text(item.currency ?? '',
                                            style: AppTextStyle.f_14_500)),
                                  ],
                                ),
                                onTap: () {
                                  controller.onSelect(item);
                                },
                              ),
                            )
                            .toList()),
                  )
                : noDataWidget(context,
                    wigetHeight: 500.h,
                    noDateIcon: NoDataClass.noComment,
                    text: LocaleKeys.assets106.tr)
          ],
        ));
  }
}
