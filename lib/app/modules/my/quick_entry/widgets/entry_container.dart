import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/home/quick_entry_info.dart';
import 'package:nt_app_flutter/app/modules/my/quick_entry/controllers/favorite_quick_entry_controller.dart';
import 'package:nt_app_flutter/app/modules/my/quick_entry/widgets/entry_item_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

typedef FunctionEntryStatus = void Function(int beforeIndex, int afterIndex);

class EntryContainer extends StatelessWidget {
  const EntryContainer(
      {super.key,
      required this.title,
      required this.quickEntryInfos,
      required this.isEdit,
      this.isDraggable = false,
      this.onDragAccept});

  final String title;
  final List<QuickEntryInfo> quickEntryInfos;
  final bool isEdit;
  final bool isDraggable;
  final FunctionEntryStatus? onDragAccept;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.f_15_500.color111111,
          ).marginOnly(bottom: 20.w),
          DraggableGridViewBuilder(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 4.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12.w,
              childAspectRatio: 86 / 49,
            ),
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(isDraggable ? 9 : quickEntryInfos.length,
                (index) {
              QuickEntryInfo? quickEntryInfo = quickEntryInfos.safe(index);
              if (quickEntryInfo == null) {
                return DraggableGridItem(
                  isDraggable: false,
                  child: Center(
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        border: Border.all(
                          width: 1.w,
                          color: AppColor.colorF5F5F5,
                        ),
                      ),
                    ).marginOnly(bottom: 20.w),
                  ),
                );
              }
              EntryStatus status = EntryStatus.none;
              try {
                if (isEdit) {
                  if (FavoriteQuickEntryController.to.quickEntryInfos
                      .contains(quickEntryInfo)) {
                    status = EntryStatus.sub;
                  } else {
                    status = EntryStatus.add;
                  }
                } else {
                  status = EntryStatus.none;
                }
              } catch (error) {}

              return DraggableGridItem(
                isDraggable: isDraggable,
                child: EntryItemWidget(
                  isMain: false,
                  quickEntryInfo: quickEntryInfo,
                  status: status,
                  onTap: (status) {
                    if (status == EntryStatus.add) {
                      FavoriteQuickEntryController.to
                          .addQuickEntry(quickEntryInfo);
                    } else if (status == EntryStatus.sub) {
                      FavoriteQuickEntryController.to
                          .removeQuickEntry(quickEntryInfo);
                    }
                  },
                ),
              );
            }),
            isOnlyLongPress: true,
            dragCompletion: (List<DraggableGridItem> list, int beforeIndex,
                int afterIndex) {
              // 根据调整顺序修改
              onDragAccept?.call(beforeIndex, afterIndex);
            },
            dragFeedback: (List<DraggableGridItem> list, int index) {
              return Container(
                color: AppColor.colorF5F5F5,
                width: 84.w,
                height: 66.h,
                child: list[index].child,
              );
            },
            dragPlaceHolder: (List<DraggableGridItem> list, int index) {
              return PlaceHolderWidget(
                child: Container(
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
