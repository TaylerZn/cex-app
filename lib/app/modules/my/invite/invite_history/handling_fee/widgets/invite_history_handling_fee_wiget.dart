import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

// import 'package:k_chart/flutter_k_chart.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/number_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../../config/theme/app_color.dart';

class InviteHistoryHandlingFeeWidget extends StatelessWidget {
  final AgentBonusRecordItem item;

  const InviteHistoryHandlingFeeWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: AppColor.colorECECEC), // 全边框,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.user196.tr,
                        style: TextStyle(
                            color: AppColor.colorABABAB,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 4.0),
                    Text(item.nickName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColor.color111111,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.trade53.tr,
                        style: TextStyle(
                            color: AppColor.colorABABAB,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 4.0),
                    Text(item.returnTypeStr,
                        maxLines: 1,
                        style: TextStyle(
                            color: AppColor.color4D4D4D,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${LocaleKeys.user51.tr}(${item.coin ?? "USDT"})',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: AppColor.colorABABAB,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 4.0),
                    Text(
                      "+${NumberUtil.mConvert(item.amount, count: 6, isTruncate: true) ?? "0.00"}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: AppColor.colorSuccess,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
