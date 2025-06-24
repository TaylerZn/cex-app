import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/search/fold_wrap.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/search_index_controller.dart';

class SearchHistoryView extends GetView<SearchHistoryController> {
  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        child: GetBuilder<SearchHistoryController>(builder: (controller) {
      return controller.historyList.isNotEmpty
          ? Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(LocaleKeys.public41.tr,
                              style: AppTextStyle.f_16_500.color111111),
                        ],
                      ),
                      Positioned(
                          right: 0.w,
                          child: InkWell(
                            onTap: () {
                              controller.clearHistory();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyImage('default/his_clear'.svgAssets(),
                                      color: AppColor.colorABABAB, width: 16.w)
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                  14.verticalSpaceFromWidth,
                  Container(
                    constraints: BoxConstraints(minHeight: 28.w),
                    child: FoldWrap(
                      extentHeight: 28.w,
                      spacing: 10.w,
                      runSpacing: 10.w,
                      isFold: controller.isFold,
                      foldLine: 2,
                      foldWidget: GestureDetector(
                          onTap: () {
                            controller.isFold = !controller.isFold;
                            controller.update();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: 28.w,
                              height: 28.w,
                              decoration: ShapeDecoration(
                                color: AppColor.colorF5F5F5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: MyImage(
                                  (controller.isFold
                                          ? 'home/search_arrow'
                                          : 'home/search_arrow_up')
                                      .svgAssets(),
                                  width: 12.w))),
                      children: controller.historyList
                          .map((e) => InkWell(
                              onTap: () {
                                // 点击历史项时触发回调函数
                                if (controller.onHistoryItemClicked != null) {
                                  controller.onHistoryItemClicked!(e);
                                }
                              },
                              child: Container(
                                height: 28.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppColor.colorF5F5F5),
                                padding:
                                    EdgeInsets.fromLTRB(10.w, 3.w, 10.w, 0),
                                child: Text(e,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.f_14_400.color4D4D4D),
                              )))
                          .toList(),
                    ),
                  ),
                ],
              ))
          : 0.horizontalSpace;
    }));
  }
}
