import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartRefresherFooter extends StatefulWidget {
  final bool showNoDataWidget;

  const SmartRefresherFooter({Key? key, this.showNoDataWidget = true})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SmartRefresherFooterState();
  }
}

class SmartRefresherFooterState extends State<SmartRefresherFooter> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text(
            "",
            style: TextStyle(height: 1, color: AppColor.color111111),
          );
        } else if (mode == LoadStatus.loading) {
          body = _buildLoading();
        } else if (mode == LoadStatus.failed) {
          body = Text(LocaleKeys.public47.tr,
              style: const TextStyle(height: 1, color: AppColor.color111111));
        } else if (mode == LoadStatus.canLoading) {
          body = Text(LocaleKeys.public48.tr,
              style: const TextStyle(height: 1, color: AppColor.color111111));
        } else {
          body = Text(LocaleKeys.public49.tr,
              style: TextStyle(
                  height: 1, fontSize: 12.sp, color: AppColor.colorABABAB));
          if (widget.showNoDataWidget == false) {
            return Container();
          }
        }
        return SizedBox(
          height: 55,
          child: Center(child: body),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Container(
      height: 55.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/json/refresh.json',
            width: 26.w,
            height: 12.w,
            repeat: true,
          ),
          Text(LocaleKeys.public50.tr, style: AppTextStyle.f_12_400.colorA3A3A3)
        ],
      ),
    );
  }
}
