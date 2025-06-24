// 邀请用户列表项
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:k_chart/flutter_k_chart.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/number_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class InviteUserItemWidget extends StatelessWidget {
  final InviteUserItem user;

  InviteUserItemWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 5.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: AppColor.colorECECEC), // 全边框
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.user196.tr, //should be replaced with '昵称',
                  style: TextStyle(color: AppColor.colorABABAB),
                ),
              ),
              Expanded(
                child: Text(
                  LocaleKeys
                      .trade89.tr, //'时间', //  should be replaced with '时间'
                  style: TextStyle(color: AppColor.colorABABAB),
                ),
              ),
              Expanded(
                child: Text(
                  '${LocaleKeys.user308.tr}(${user.coin ?? "USDT"})', // '收益贡献(USDT)', should be replaced with '收益贡献(USDT)'
                  textAlign: TextAlign.right,
                  style: TextStyle(color: AppColor.colorABABAB),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                child: Text(user.nickName ?? ''),
              ),
              Expanded(
                child: Text(MyTimeUtil.timestampToShortStr(user.iniviteDate,
                        toUtc: true) ??
                    ''),
              ),
              Expanded(
                child: Text(
                  '${'+' + NumberUtil.mConvert(user.bonusAmount, count: 6, isTruncate: true)}',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: AppColor.colorSuccess),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
