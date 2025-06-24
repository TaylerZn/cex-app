import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/home/quick_entry_info.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

enum EntryStatus { add, sub, none }

class EntryItemWidget extends StatelessWidget {
  const EntryItemWidget({
    super.key,
    required this.quickEntryInfo,
    required this.status,
    required this.onTap,
    required this.isMain,
  });

  final bool isMain;
  final QuickEntryInfo quickEntryInfo;
  final EntryStatus status;
  final ValueChanged<EntryStatus> onTap;

  @override
  Widget build(BuildContext context) {
    String icon;
    if (status == EntryStatus.add) {
      icon = 'assets/images/home/quick_entry_add.svg';
    } else if (status == EntryStatus.sub) {
      icon = 'assets/images/home/quick_entry_sub.svg';
    } else {
      icon = '';
    }
    return InkWell(
      onTap: () {
        if (status == EntryStatus.none) {
          RouteUtil.goTo(quickEntryInfo.route,
              requireLogin: quickEntryInfo.requireLogin);
        } else {
          onTap(status);
        }
      },
      child: Stack(
        children: [
          isMain
              ? SizedBox(
                  width: 71.8.w,
                  height: 53.2.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 40.w,
                        height: 40.w,
                        child: MyImage(
                          quickEntryInfo.icon,
                          width: 24.w,
                          height: 24.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          quickEntryInfo.title.tr,
                          style: AppTextStyle.f_11_500.colorTextTertiary,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              : item(),
          if (quickEntryInfo.logo.isNotEmpty && isMain)
            Positioned(
              left: 36.w,
              top: 3.w,
              child: MyImage(
                quickEntryInfo.logo,
                fit: BoxFit.fitHeight,
                height: 10.w,
              ),
            ),
          if (status != EntryStatus.none)
            Positioned(
              right: 9.w,
              top: 0,
              child: MyImage(
                icon,
                width: 12.w,
                height: 12.w,
              ),
            ),
        ],
      ),
    );
  }

  item() {
    return SizedBox(
      width: 86.w,
      height: 49.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyImage(
            quickEntryInfo.icon,
            width: 24.w,
            height: 24.w,
            fit: BoxFit.fill,
          ),
          4.verticalSpaceFromWidth,
          Text(
            quickEntryInfo.title.tr,
            style: AppTextStyle.f_11_400.colorTextTertiary,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
