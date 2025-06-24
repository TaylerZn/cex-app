import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/home/quick_entry_info.dart';
import 'package:nt_app_flutter/app/modules/my/quick_entry/controllers/favorite_quick_entry_controller.dart';
import 'package:nt_app_flutter/app/modules/my/quick_entry/widgets/entry_container.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../controllers/quick_entry_controller.dart';
import '../widgets/home_entry_container.dart';

class QuickEntryView extends GetView<QuickEntryController> {
  const QuickEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('QuickEntryView'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 0) {
          if (FavoriteQuickEntryController.to.editHasSave == false) {
            FavoriteQuickEntryController.to.loadDb();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: MyPageBackWidget(
            onTap: () {
              if (FavoriteQuickEntryController.to.editHasSave == false) {
                FavoriteQuickEntryController.to.loadDb();
              }
              Get.back();
            },
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            LocaleKeys.other44.tr,
            style: AppTextStyle.f_16_500.color111111,
          ),
        ),
        body: SafeArea(
          child: GetBuilder<QuickEntryController>(
            builder: (_) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child:
                        commonUse(isMain: false, isEdit: controller.isEditing),
                  ),
                  ..._list(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _list() {
    List<Widget> list = [];
    for (var element in controller.quickEntryList) {
      list.add(
        SliverToBoxAdapter(
          child: Container(
            child: EntryContainer(
              isEdit: controller.isEditing,
              title: element.title.tr,
              quickEntryInfos: element.list,
            ),
          ),
        ),
      );
    }
    return list;
  }
}

Widget commonUse({required bool isMain, required bool isEdit}) {
  return Obx(() {
    List<QuickEntryInfo> quickEntryInfos = List<QuickEntryInfo>.from(
        FavoriteQuickEntryController.to.quickEntryInfos);
    QuickEntryInfo more = QuickEntryInfo(
      icon: 'assets/images/home/quick_entry/quick_more.svg',
      title: LocaleKeys.other40.tr,
      route: '/quick-entry',
    );

    if (isMain && !quickEntryInfos.contains(more)) {
      quickEntryInfos.add(more);
    }

    return Stack(
      children: [
        isMain
            ? HomeEntryContainer(
                title: LocaleKeys.other41.tr,
                quickEntryInfos: quickEntryInfos,
                isEdit: isEdit,
                isDraggable: !isMain && isEdit,
                onDragAccept: (beforeIndex, afterIndex) {
                  FavoriteQuickEntryController.to.beforeIndex = beforeIndex;
                  FavoriteQuickEntryController.to.afterIndex = afterIndex;
                },
              )
            : EntryContainer(
                title: LocaleKeys.other41.tr,
                quickEntryInfos: quickEntryInfos,
                isEdit: isEdit,
                isDraggable: !isMain && isEdit,
                onDragAccept: (beforeIndex, afterIndex) {
                  FavoriteQuickEntryController.to.beforeIndex = beforeIndex;
                  FavoriteQuickEntryController.to.afterIndex = afterIndex;
                },
              ),
        if (!isMain)
          Positioned(
            top: 16.w,
            right: 16.w,
            child: InkWell(
              onTap: () {
                QuickEntryController.to.changeEdit();
              },
              child: Row(
                children: [
                  QuickEntryController.to.isEditing
                      ? 0.verticalSpace
                      : Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: MyImage(
                            'assets/images/home/quick_entry/quick_entry_edit.svg',
                            width: 14.w,
                            height: 14.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                  Text(
                    QuickEntryController.to.isEditing
                        ? LocaleKeys.other42.tr
                        : LocaleKeys.other43.tr,
                    style: AppTextStyle.f_14_400.color666666,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
      ],
    );
  });
}
