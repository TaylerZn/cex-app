import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/community/post_index/controllers/post_index_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/select.dart';

import '../../../../generated/locales.g.dart';

class VoteWidget extends StatefulWidget {
  final Function(Widget)? removeTap;

  const VoteWidget({super.key, this.removeTap});

  @override
  State<VoteWidget> createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
  final controller = Get.find<PostIndexController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> time = [1, 12, 24, 72];
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          10.verticalSpaceFromWidth,
          Obx(() => Column(
                children: controller.voteList.map((element) {
                  int index = controller.voteList.indexOf(element);
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      color: AppColor.colorF5F5F5,
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (controller.voteList.length <= 2) {
                              UIUtil.showToast(
                                  LocaleKeys.community112.tr); //'投票选项最少2个');
                              return;
                            }
                            controller.voteList.remove(element);
                          },
                          child: MyImage('community/vote_remove'.svgAssets()),
                        ),
                        6.horizontalSpace,
                        Expanded(
                            child: MyTextFieldWidget(
                                isTopText: false,
                                enabledBorderColor: Colors.transparent,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                focusedBorderColor: Colors.transparent,
                                onChanged: (value) {
                                  controller.voteList[index] = value;
                                }))
                      ],
                    ),
                  );
                }).toList(),
              )),
          8.verticalSpaceFromWidth,
          InkWell(
              onTap: () {
                String? content = controller.voteList
                    .firstWhereOrNull((p0) => ObjectUtil.isEmpty(p0));
                if (content != null) {
                  UIUtil.showToast(LocaleKeys.community113.tr);

                  ///'请输入投票内容');
                  return;
                }
                if (controller.voteList.length == 5) {
                  UIUtil.showToast(LocaleKeys.community114.tr); //'最多只能添加5个选项');
                  return;
                }
                controller.voteList.add('');
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    border: Border.all(width: 1, color: AppColor.colorABABAB)),
                height: 48.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage('community/vote_add'.svgAssets()),
                    10.horizontalSpace,
                    Text(LocaleKeys.community115.tr,
                        style: AppTextStyle.f_16_600) //'添加选项')
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.community116.tr,
                    style: AppTextStyle.f_12_500,
                  ),
                  4.w.horizontalSpace,
                  MySelect(
                      textStyle: AppTextStyle.f_12_500,
                      padding: EdgeInsets.zero,
                      border: Border.all(color: Colors.transparent),
                      value: '1',
                      list: [
                        LocaleKeys.community126.tr,
                        LocaleKeys.community127.tr,
                        LocaleKeys.community128.tr,
                        LocaleKeys.community129.tr,
                      ],
                      onChanged: (value) {
                        controller.votingDeadline.value =
                            time[int.parse(value!)];
                      })
                ],
              ),
              InkWell(
                  onTap: () {
                    widget.removeTap?.call(widget);
                  },
                  child: Text(LocaleKeys.community117.tr, //'删除',
                      style: AppTextStyle.f_12_400.tradingYel))
            ],
          )
        ],
      ),
    );
  }
}
