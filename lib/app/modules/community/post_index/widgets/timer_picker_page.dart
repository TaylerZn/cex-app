import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class TimePickerPage extends StatefulWidget {
  Function(DateTime)? tapTime;
  Function()? onCancel;
  TimePickerPage({this.tapTime, this.onCancel});
  @override
  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  DateTime currentTime = DateTime.now();
  late DateTime initialTime;
  late DateTime minTime;
  late DateTime maxTime;
  late Picker picker;

  @override
  void initState() {
    super.initState();
    initialTime = currentTime.add(Duration(minutes: 30));
    minTime = currentTime.add(Duration(minutes: 30));
    maxTime = currentTime.add(Duration(days: 7));
    picker = Picker(
      adapter: DateTimePickerAdapter(
        type: PickerDateTimeType.kYMDHM,
        isNumberMonth: true,
        yearBegin: currentTime.year,
        yearEnd: currentTime.year + 1,
        minuteInterval: 1,
        value: initialTime,
        minValue: minTime,
        maxValue: maxTime,
      ),
      hideHeader:
          true, // Hide the default header with cancel and confirm buttons
    );
  }

  void _onConfirm() {
    DateTime? selectedTime = (picker.adapter as DateTimePickerAdapter).value;
    if (selectedTime != null &&
        selectedTime.isAfter(DateTime.now().add(Duration(minutes: 30))) &&
        selectedTime.isBefore(DateTime.now().add(Duration(days: 7)))) {
      print('选中的时间为: $selectedTime');
      widget.tapTime?.call(selectedTime);
    } else {
      print('选中的时间超出范围');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.colorFFFFFF,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r))),
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 5.h,
            decoration: ShapeDecoration(
              color: AppColor.color999999,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 23.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  LocaleKeys.community77.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.color111111,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          picker.makePicker(),
          Container(
            height: 1,
            color: AppColor.colorEEEEEE,
          ),
          Container(
            height: 110.h,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        widget.onCancel?.call();
                        Get.back();
                      },
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColor.colorABABAB, width: 1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(LocaleKeys.public2.tr,
                              style: AppTextStyle.f_16_600.color111111),
                        ),
                      )),
                ),
                7.w.horizontalSpace,
                Expanded(
                  child: InkWell(
                      onTap: () {
                        _onConfirm();
                        Get.back();
                      },
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: AppColor.color0C0D0F,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(LocaleKeys.public1.tr,
                              style: AppTextStyle.f_14_500.colorFFFFFF),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
