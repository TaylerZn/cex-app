import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_home_traker/widget/follow_orders_cell.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../utils/utilities/route_util.dart';
import '../controllers/follow_home_traker_controller.dart';

class FollowHomeTrakerView extends GetView<FollowHomeTrakerController> {
  const FollowHomeTrakerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (c) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 240.w,
            child: Row(
              children: [
                leftWidget(),
                11.horizontalSpace,
                rightWidget(),
              ],
            ),
          );
        });
  }

  Expanded rightWidget() {
    return Expanded(
        child: Column(
      children: <Widget>[
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(width: 0.6.r, color: AppColor.colorBorderSubtle)),
              width: 166.w,
              height: 170.w,
              child: controller.model.list != null
                  ? Swiper(
                      autoplayDelay: 5000,
                      duration: 1000,
                      itemBuilder: (BuildContext context, int index) {
                        return FollowOrdersCell(model: controller.model.list![index], isHome: true);
                      },
                      itemCount: controller.model.list!.length,
                      pagination: SwiperPagination(
                        margin: EdgeInsets.only(top: 19.w, right: 14.w),
                        alignment: Alignment.topRight,
                        builder: RectPagination(
                          activeColor: AppColor.color111111,
                          color: AppColor.colorD9D9D9,
                          size: const Size(3, 2),
                          activeSize: const Size(6, 2),
                        ),
                      ),
                      autoplay: true,
                      loop: true,
                    )
                  : const SizedBox(),
            ),
            Positioned(
              left: 14.w,
              top: 8.h,
              child: Row(
                children: [
                  SizedBox(
                    width: 110.w,
                    child: AutoSizeText(LocaleKeys.public74.tr,
                        maxLines: 1, minFontSize: 4, style: AppTextStyle.f_14_600.colorTextSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
        10.verticalSpaceFromWidth,
        buyCoinWidget(),
      ],
    ));
  }

  GestureDetector buyCoinWidget() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        RouteUtil.goTo('/otc-b2c');
      },
      child: Container(
          width: 166.w,
          height: 60.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r), border: Border.all(width: 0.6.r, color: AppColor.colorBorderSubtle)),
          padding: EdgeInsets.only(top: 8.w, bottom: 10.w, left: 14.w, right: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: AutoSizeText(LocaleKeys.public73.tr,
                        maxLines: 1, minFontSize: 4, style: AppTextStyle.f_14_600.colorTextSecondary),
                  ),
                  MyImage(
                    'default/icons_line'.svgAssets(),
                    width: 12.w,
                    height: 12.w,
                    fit: BoxFit.fill,
                  )
                ],
              ),
              Text(
                'Visa and Mastercard,etc.',
                style: AppTextStyle.f_11_400.colorTextDisabled,
              ),
            ],
          )),
    );
  }

  Expanded leftWidget() {
    return Expanded(
        child: Obx(() => controller.cmsModel.value.list?.isNotEmpty == true
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(width: 0.6.r, color: AppColor.colorBorderSubtle)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyActivityWidget(
                    height: 240.w,
                    horizontal: 0,
                    radius: 8.r,
                    fit: BoxFit.fitWidth,
                    pagination: SwiperPagination(
                      margin: EdgeInsets.only(left: 16.w),
                      alignment: Alignment.bottomLeft,
                      builder: RectPagination(
                        activeColor: AppColor.color111111,
                        color: AppColor.colorD9D9D9,
                        size: const Size(3, 2),
                        activeSize: const Size(3, 2),
                      ),
                    ),
                    list: controller.cmsModel.value.list!))
            : controller.cmsModel.value.list == null
                ? const SizedBox()
                : const FollowOrdersLoading(isSliver: false, isError: false)));
  }
}

class RectPagination extends SwiperPlugin {
  final Color activeColor;
  final Color color;
  final Size size;
  final Size activeSize;

  RectPagination({
    this.activeColor = Colors.white,
    this.color = Colors.white,
    this.size = const Size(3, 2),
    this.activeSize = const Size(3, 2),
  });

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    List<Widget> dots = [];

    for (int i = 0; i < config.itemCount; ++i) {
      bool active = i == config.activeIndex;

      dots.add(Container(
        key: Key("pagination_$i"),
        margin: const EdgeInsets.only(right: 2),
        child: Container(
          decoration: BoxDecoration(color: active ? activeColor : color, borderRadius: BorderRadius.circular(3.w)),
          width: active ? activeSize.width : size.width,
          height: active ? activeSize.height : size.height,
        ),
      ));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }
}
