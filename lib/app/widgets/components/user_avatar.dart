import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class UserAvatar extends StatelessWidget {
  String? url;
  double? width;
  double? height;
  double? tradeIconSize;
  bool isTrader;
  int? levelType;
  BorderRadius? borderRadius;

  UserAvatar(this.url,
      {super.key,
      this.width,
      this.height,
      this.tradeIconSize,
      this.levelType,
      this.borderRadius,
      this.isTrader = false}) {
    width ??= 40.w;
    height ??= 40.w;
    tradeIconSize ??= 12.w;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(6.w)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: url != null && url?.isNotEmpty == true
            ? MyImage(
                url!,
                width: width,
                height: height,
                fit: BoxFit.fill,
              )
            : MyImage(
                "default/avatar_default".pngAssets(),
                width: width,
                height: height,
              ),
      ),
      buildEmblem()
    ];
    return Stack(
      clipBehavior: Clip.none,
      children: children,
    );
  }

  Widget buildEmblem() {
    if (ObjectUtil.isNotEmpty(levelType)) {
      String img = '';
      switch (levelType) {
        case 1:
          img = 'default/blackVerif'.svgAssets();
          break;
        case 2:
          img = 'default/blueVerif'.svgAssets();
          break;
        case 3:
          img = 'default/yellowVerif'.svgAssets();
          break;
      }
      return Positioned(
          right: -3.w,
          bottom: -2.w,
          child: MyImage(
            img,
            width: tradeIconSize,
            height: tradeIconSize,
          ));
    }
    return isTrader
        ? Positioned(
            right: 0,
            bottom: 0,
            child: MyImage(
              "trade/super".pngAssets(),
              width: tradeIconSize,
              height: tradeIconSize,
            ))
        : const SizedBox();
  }
}
