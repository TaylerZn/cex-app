import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../generated/locales.g.dart';

class MySelect extends StatefulWidget {
  String? value;
  final String nameField;
  final String valueField;
  final ValueChanged<String?>? onChanged;
  final List<String?> list;
  final String hint;
  final TextStyle? textStyle;
  final bool checkIndex;
  BoxBorder? border;
  EdgeInsets? padding;
  bool maxWidth;

  MySelect(
      {super.key,
      this.hint = '',
      this.list = const [],
      this.nameField = 'name',
      this.valueField = 'id',
      this.onChanged,
      this.border,
      this.padding,
      this.maxWidth = false,
      this.textStyle,
      this.checkIndex = true,
      this.value});

  @override
  State<MySelect> createState() => _MySelectState();
}

class _MySelectState extends State<MySelect> {
  ValueNotifier<String?> current = ValueNotifier('');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (ObjectUtil.isNotEmpty(widget.value) && widget.checkIndex) {
      current.value = widget.list[int.parse(widget.value!)];
    } else {
      current.value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          border: widget.border ??
              Border.all(color: AppColor.colorECECEC, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(6.r))),
      height: 44.h,
      child: InkWell(
        onTap: () async {
          await showModalBottomSheet(
            context: Get.context!,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.list.length < 6
                      ? getTypeListView(context)
                      : Expanded(child: getTypeListView(context)),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(height: 1.h, color: AppColor.colorECECEC),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        color: Colors.white,
                        alignment: Alignment.center,
                        height: 110.h,
                        child: Column(
                          children: [
                            16.h.verticalSpace,
                            MyButton(
                              backgroundColor: AppColor.colorWhite,
                              textStyle: AppTextStyle.f_14_600.color111111,
                              border: Border.all(color: AppColor.colorABABAB),
                              text: LocaleKeys.public2.tr,
                              color: AppColor.color111111,
                              height: 48.h,
                              onTap: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: Row(
          mainAxisSize: widget.maxWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder(
                valueListenable: current,
                builder: (_, value, __) => value?.isEmpty == true
                    ? Text(widget.hint,
                        style: AppTextStyle.f_14_500.colorABABAB)
                    : Text(value ?? '',
                        style: widget.textStyle ?? AppTextStyle.f_14_500)),
            MyImage('otc/c2c/bottom_arrow'.svgAssets(), width: 16.w)
          ],
        ),
        //child: ,
      ),
    );
  }

  Widget getTypeListView(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            16.verticalSpace,
            ...widget.list.map((e) => InkWell(
                  onTap: () {
                    Get.back();
                    int index = widget.list.indexOf(e);

                    widget.onChanged?.call('$index');
                    current.value = e;
                    current.value = e;
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                        color: current.value == e
                            ? AppColor.colorF5F5F5
                            : AppColor.colorWhite,
                      ),
                      margin: EdgeInsets.only(
                          bottom: 12.h, right: 16.w, left: 16.w),
                      height: 44.h,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e ?? '', style: AppTextStyle.f_16_500),
                          Visibility(
                              visible: current.value == e,
                              child: MyImage(
                                'community/checkmark'.svgAssets(),
                                width: 16.w,
                              ))
                        ],
                      )),
                )),
            // 30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
