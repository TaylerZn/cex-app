import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class KLineTimeWidget extends StatelessWidget {
  const KLineTimeWidget(
      {super.key,
      required this.timeList,
      required this.selectIndex,
      required this.onValueChanged});

  final List<String> timeList;
  final int selectIndex;
  final ValueChanged<int> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200.h,
      width: Get.width,
      color: AppColor.colorWhite,
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h, bottom: 10.h),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 3,
        ),
        itemCount: timeList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onValueChanged(index);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectIndex == index
                    ? AppColor.color0075FF.withOpacity(0.1)
                    : Colors.transparent,
                border: Border.all(
                  color: selectIndex == index
                      ? AppColor.color0075FF
                      : AppColor.color999999 ,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: Text(
                timeList[index],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: index == selectIndex
                      ? AppColor.color0075FF
                      : AppColor.color999999,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
