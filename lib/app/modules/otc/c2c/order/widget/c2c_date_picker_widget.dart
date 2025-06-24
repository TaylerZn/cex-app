import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/controllers/customer_order_controller.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'models/c2c_filter_bean.dart';

enum C2CTimePickerType {
  selStartTime,
  selEndTime;
}

class C2CDatePickerWidget extends StatefulWidget {
  const C2CDatePickerWidget({super.key});

  @override
  State<C2CDatePickerWidget> createState() => _C2CDatePickerWidgetState();
}

class _C2CDatePickerWidgetState extends State<C2CDatePickerWidget> {
  List<String> list = [
    LocaleKeys.c2c147.tr,
    LocaleKeys.b2c8.tr,
    LocaleKeys.c2c13.tr
  ];
  List<String> pickType = [
    LocaleKeys.c2c153.tr,
    LocaleKeys.c2c154.tr,
    LocaleKeys.c2c155.tr,
    LocaleKeys.c2c156.tr
  ];
  late C2CFilterBean bean;
  CustomerOrderController controller = Get.find<CustomerOrderController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bean = controller.filterBean ?? C2CFilterBean();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 401.h,
      decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  19.verticalSpace,
                  Text(LocaleKeys.c2c182.tr, style: AppTextStyle.f_20_600),
                  19.verticalSpace,
                  Text(LocaleKeys.c2c152.tr,
                      style: AppTextStyle.f_11_500.color666666),
                  12.verticalSpace,
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: Get.context!,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (BuildContext context) {
                            return getTypeListView(context);
                          },
                        );
                      },
                      child: Container(
                        height: 40.h,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.colorF5F5F5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(bean.type().title(),
                                  style: AppTextStyle.f_14_500.color111111),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 14.w,
                              color: AppColor.color666666,
                            ),
                          ],
                        ),
                      )),
                  30.verticalSpace,
                  Text(LocaleKeys.c2c183.tr,
                      style: AppTextStyle.f_11_500.color666666),
                  12.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Expanded(
                            child: MyButton(
                              height: 36.h,
                              text: MyTimeUtil.getYMDime(bean.startTime.value),
                              backgroundColor: AppColor.colorF5F5F5,
                              color: AppColor.color111111,
                              textStyle: AppTextStyle.f_14_500,
                              onTap: () async {
                                await Get.bottomSheet(getTimeView(
                                    context,
                                    bean.startTime,
                                    C2CTimePickerType.selStartTime));
                              },
                            ),
                          )),
                      Container(
                          width: 35.w,
                          child: Center(
                            child: Text(LocaleKeys.assets78.tr,
                                style: AppTextStyle.f_14_500.color999999),
                          )),
                      Obx(() => Expanded(
                              child: MyButton(
                            height: 36.h,
                            text: MyTimeUtil.getYMDime(bean.endTime.value),
                            backgroundColor: AppColor.colorF5F5F5,
                            color: AppColor.color111111,
                            textStyle: AppTextStyle.f_14_500,
                            onTap: () async {
                              await Get.bottomSheet(getTimeView(context,
                                  bean.endTime, C2CTimePickerType.selEndTime));
                            },
                          ))),
                    ],
                  ),
                  12.verticalSpace,
                  Row(
                    children: pickType
                        .map((e) => Expanded(
                            child: Container(
                                margin: pickType.last != e
                                    ? EdgeInsets.only(right: 10.w)
                                    : null,
                                child: MyButton(
                                  onTap: () {
                                    int i = pickType.indexOf(e);
                                    resetTime(i);
                                  },
                                  height: 26.h,
                                  textStyle: AppTextStyle.f_11_400.colorABABAB,
                                  border:
                                      Border.all(color: AppColor.colorEEEEEE),
                                  backgroundColor: Colors.transparent,
                                  color: AppColor.color111111,
                                  text: e,
                                ))))
                        .toList(),
                  ),
                ],
              )),
          30.verticalSpace,
          Container(
            height: 1.h,
            color: AppColor.colorEEEEEE,
          ),
          16.verticalSpace,
          Row(
            children: [
              16.horizontalSpace,
              Expanded(
                  child: MyButton(
                      onTap: () {
                        setState(() {
                          bean = C2CFilterBean();
                        });
                      },
                      text: LocaleKeys.c2c157.tr,
                      textStyle: AppTextStyle.f_15_600,
                      color: AppColor.color111111,
                      height: 48.h,
                      backgroundColor: AppColor.colorWhite,
                      border: Border.all(color: AppColor.color111111))),
              7.horizontalSpace,
              Expanded(
                  child: MyButton(
                      text: LocaleKeys.public1.tr,
                      textStyle: AppTextStyle.f_15_600.colorFFFFFF,
                      height: 48.h,
                      onTap: () {
                        controller.filterBean = bean;
                        controller.reloadList();
                        Get.back();
                      })),
              16.horizontalSpace,
            ],
          )
        ],
      ),
    );
  }

  void resetTime(int index) {
    switch (index) {
      case 0:
        {
          bean.startTime.value = MyTimeUtil.old(7);
        }
        break;
      case 1:
        {
          bean.startTime.value = MyTimeUtil.old(90);
        }
        break;
      case 2:
        {
          bean.startTime.value = MyTimeUtil.old(180);
        }
        break;
      case 3:
        {
          bean.startTime.value = MyTimeUtil.old(365);
        }
        break;
    }
    bean.endTime.value = MyTimeUtil.now();
  }

  Widget getTypeListView(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          19.verticalSpace,
          Text(LocaleKeys.c2c184.tr, style: AppTextStyle.f_20_600),
          19.verticalSpace,
          ...list.map((e) => SizedBox(
              height: 43,
              child: InkWell(
                  child: Text(e, style: AppTextStyle.f_16_500),
                  onTap: () {
                    Get.back();
                    bean.current.value = list.indexOf(e);
                  }))),
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget getTimeView(
    BuildContext context,
    Rx<DateTime>? time,
    C2CTimePickerType pickerTimeType,
  ) {
    // DateTime dayDataTime = model.startTime;
    DateTime? dataTime;
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(LocaleKeys.public2.tr,
                          style: AppTextStyle.f_14_500.color4D4D4D))),
              Expanded(
                child: Center(
                  child: Text(LocaleKeys.assets129.tr,
                      style: AppTextStyle.f_16_600),
                ),
              ),
              InkWell(
                  onTap: () {
                    Get.back(result: true);
                    if (dataTime != null) {
                      time?.value = dataTime!;
                    }
                    // print(model.startTime);
                  },
                  child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(LocaleKeys.public1.tr,
                          style: AppTextStyle.f_14_500.color4D4D4D))),
            ],
          ),
          Container(
            height: 176.w,
            color: AppColor.colorWhite,
            margin: EdgeInsets.only(
                bottom: 16.h + MediaQuery.of(context).padding.bottom),
            child: Picker(
                adapter: DateTimePickerAdapter(
                    type: PickerDateTimeType.kYMD,
                    yearSuffix: LocaleKeys.public52.tr,
                    monthSuffix: LocaleKeys.public53.tr,
                    daySuffix: LocaleKeys.public54.tr,
                    isNumberMonth: true,
                    value: time?.value,
                    minValue: pickerTimeType == C2CTimePickerType.selEndTime
                        ? bean.startTime.value
                        : DateTime(2020, 1, 1),
                    maxValue: pickerTimeType == C2CTimePickerType.selStartTime
                        ? bean.endTime.value
                        : DateTime.now()),
                selectedTextStyle: AppTextStyle.f_18_600.copyWith(height: 1.3),
                hideHeader: true,
                onSelect: (Picker picker, int index, List<int> selected) {
                  dataTime =
                      DateFormat('yyyy-MM-dd').parse(picker.adapter.toString());
                }).makePicker(),
          ),
        ],
      ),
    );
  }
}
