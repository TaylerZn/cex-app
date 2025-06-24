import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/un_login_tips/un_login_tips_logic.dart';

class UnLoginTipsWidget extends StatefulWidget {
  const UnLoginTipsWidget({Key? key}) : super(key: key);

  @override
  State<UnLoginTipsWidget> createState() => _UnLoginTipsWidgetState();
}

class _UnLoginTipsWidgetState extends State<UnLoginTipsWidget> {
  double bottom = -80.sp;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      bottom = 10.sp;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnLoginTipsLogic>(builder: (tipsLogic) {
      return GetBuilder<UserGetx>(builder: (authLogic) {
        bool showLoginTips = !authLogic.isLogin && !tipsLogic.close;
        return AnimatedPositioned(
          left: 16.sp,
          right: 16.sp,
          bottom: bottom,
          duration: const Duration(milliseconds: 500),
          child: Visibility(
            visible: showLoginTips,
            child: Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.sp),
                color: Colors.black.withOpacity(0.8),
              ),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          bottom = -80.sp;
                        });
                        Future.delayed(const Duration(milliseconds: 500), () {
                          tipsLogic.close = true;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: MyImage(
                          'default/close'.svgAssets(),
                          fit: BoxFit.fill,
                          width: 10.w,
                          height: 10.w,
                          color: Colors.white,
                        ),
                      )),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      '登录后探索更多内容',
                      minFontSize: 12,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  InkWell(
                      onTap: () async {
                        Get.find<UserGetx>().goIsLogin();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(6.w)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 6.w),
                        child: Text(
                          '登录',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
