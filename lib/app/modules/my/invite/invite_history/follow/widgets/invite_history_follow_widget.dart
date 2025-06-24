import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../../config/theme/app_color.dart';

class InviteHistoryFollowWidget extends StatelessWidget {
  const InviteHistoryFollowWidget({super.key, required this.item});

  final AgentFollowProfitRecordMapList item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(width: 1.0, color: AppColor.colorECECEC),
      ),
      child: Row(
        children: <Widget>[
          UserAvatar(
            item.pictureUrl ?? '',
            width: 36.w,
            height: 36.w,
          ),
          10.horizontalSpace,
          Expanded(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${item.nickName ?? '--'}",
                    style: AppTextStyle.f_15_500,
                  ),
                  Text(
                    LocaleKeys.user51.tr,
                    style: AppTextStyle.f_12_400.colorABABAB,
                  ),
                ],
              ),
              4.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.time != null
                        ? MyTimeUtil.timestampToStr(item.time)
                        : '',
                    style: AppTextStyle.f_11_400.color999999,
                  ),
                  16.horizontalSpace,
                  Flexible(
                    child: Text("${item.amount ?? '--'}".stringSplit(),
                        style: AppTextStyle.f_13_600.colorSuccess),
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
