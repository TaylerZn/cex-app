import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MessageTipWidget extends StatefulWidget {
  const MessageTipWidget({
    super.key,
    required this.seller,
  });
  final Buyer? seller;

  @override
  State<MessageTipWidget> createState() => _MessageTipWidgetState();
}

class _MessageTipWidgetState extends State<MessageTipWidget>
    with SingleTickerProviderStateMixin {
  bool isExpand = true;

  @override
  Widget build(BuildContext context) {
    if (widget.seller == null) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        10.verticalSpace,
        Offstage(
          offstage: !isExpand,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColor.bgColorLight,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              LocaleKeys.c2c311.trArgs([widget.seller?.realName ?? '']),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.color4D4D4D,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: MyImage(
            isExpand
                ? 'assets/images/otc/c2c/c2c_message_tip_expand.svg'
                : 'assets/images/otc/c2c/c2c_message_tip_collapse.svg',
            width: 10.w,
            height: 10.h,
          ).marginAll(10.h),
        ),
      ],
    );
  }
}
