import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/config/system_message_res.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class SystemNotifyItemWidget extends StatelessWidget {
  const SystemNotifyItemWidget({Key? key, required this.messageInfo}) : super(key: key);
  final SystemMessageInfo messageInfo;

  @override
  Widget build(BuildContext context) {
    Map<int,String> map = {1:'充值',2:'提现',3:'开单',4:'平单'};

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorEEEEEE,
            width: 1.h,
          ),
        ),
      ),
      child: Row(
        children: [
          MyImage(
            'assets/images/notify/office_notify_icon.png',
            width: 36.w,
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                map[messageInfo.type] ?? '-',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.color111111,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                messageInfo.content,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.color666666,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                messageInfo.createTime,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.colorA3A3A3,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
