import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/controllers/follow_setup_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'dart:math' as math;

enum AppGuideType {
  spot,
  perpetualContract,
  standardContract,
  follow,
  c2c;

  int get total => [4, 5, 5, 4, 5][index];
}

enum AppGuideArrowPosition {
  top,
  bottom,
  left,
  right;
}

var resMap = {};

class AppGuideView extends StatelessWidget {
  const AppGuideView(
      {super.key,
      required this.order,
      required this.child,
      required this.guideType,
      this.title = '',
      this.des = '',
      this.arrowPosition = AppGuideArrowPosition.bottom,
      this.padding,
      this.finishCallback,
      this.currentSetpCallback});

  final int order;
  final String title;
  final String des;
  final EdgeInsets? padding;

  ///引导在下方
  final AppGuideArrowPosition arrowPosition;
  final AppGuideType guideType;
  final Widget child;
  //完成后回调
  final VoidCallback? finishCallback;
  final VoidCallback? currentSetpCallback;

  @override
  Widget build(BuildContext context) {
    var array = getTitleAndDes();
    return checkFinish()
        ? child
        : IntroStepBuilder(
            group: guideTypeName,
            order: order,
            padding: padding ?? const EdgeInsets.all(8),
            overlayBuilder: (params) {
              var view = Container(
                padding: EdgeInsets.all(16.w),
                decoration: ShapeDecoration(
                  color: AppColor.colorWhite,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            array.first,
                            style: AppTextStyle.f_14_500.colorBlack,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Intro.of(context).dispose();
                            saveState();
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w, top: 6.w),
                            child: MyImage(
                              'default/guide_close'.svgAssets(),
                              width: 11.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.h, bottom: 20.h),
                      child: Text(
                        array.last,
                        style: AppTextStyle.f_12_400_15.color666666,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '$order/${guideType.total}',
                        ),
                        order == guideType.total
                            ? MyButton(
                                text: LocaleKeys.other33.tr,
                                textStyle: AppTextStyle.f_12_500,
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                                onTap: () {
                                  Intro.of(context).dispose();
                                  saveState();
                                },
                              )
                            : MyButton(
                                text: LocaleKeys.public3.tr,
                                textStyle: AppTextStyle.f_12_500,
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                                onTap: () {
                                  currentSetpCallback?.call();
                                  /// 下一帧率再执行
                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    if (guideType == AppGuideType.follow) {
                                      Intro.of(context).dispose();
                                      if (order == 1) {
                                        Get.toNamed(Routes.FOLLOW_SETUP,
                                            arguments: {'model': FollowKolInfo(), 'isSmart': true, 'isGuide': true});
                                      } else if (order == 2) {
                                        Get.delete<FollowSetupController>();
                                        Get.offAndToNamed(Routes.FOLLOW_SETUP,
                                            arguments: {'model': FollowKolInfo(), 'isSmart': false, 'isGuide': true});
                                      } else if (order == 3) {
                                        Get.back();
                                        Future.delayed(const Duration(milliseconds: 500), () {
                                          Intro.of(Get.context!).start(reset: true, group: '${AppGuideType.follow.name}4');
                                        });
                                      }
                                    } else {
                                      params.onNext?.call();
                                    }
                                  });
                                },
                              )
                      ],
                    )
                  ],
                ),
              );

              bool isleft = (params.offset?.dx ?? 0) <= params.screenSize.width * 0.5 ? true : false;
              double left = isleft
                  ? params.size.width * 0.5 - (params.offset?.dx ?? 0) < 0
                      ? (params.size.width * 0.5)
                      : (params.size.width * 0.5 - (params.offset?.dx ?? 0))
                  : 0;

              double right = isleft ? 0 : params.size.width * 0.5;

              return arrowPosition == AppGuideArrowPosition.left
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: view,
                        ),
                        Positioned(
                            left: 0,
                            child: Transform.rotate(
                              angle: -90 * math.pi / 180,
                              child: MyImage(
                                'default/guide_up'.svgAssets(),
                                width: 24.w,
                              ),
                            ))
                      ],
                    )
                  : Column(
                      crossAxisAlignment: isleft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        arrowPosition == AppGuideArrowPosition.bottom
                            ? Padding(
                                padding: EdgeInsets.only(left: left, right: right),
                                child: MyImage(
                                  'default/guide_up'.svgAssets(),
                                  width: 24.w,
                                ),
                              )
                            : const SizedBox(),
                        view,
                        arrowPosition == AppGuideArrowPosition.bottom
                            ? const SizedBox()
                            : Padding(
                                padding: EdgeInsets.only(left: left, right: right),
                                child: MyImage(
                                  'default/guide_down'.svgAssets(),
                                  width: 24.w,
                                ),
                              ),
                      ],
                    );
            },
            onHighlightWidgetTap: () {
              Intro.of(context).dispose();
              saveState();
            },
            // onWidgetLoad: () {
            //   Intro.of(context).refresh();
            // },
            builder: (context, key) => Container(key: key, child: child),
          );
  }

  bool checkFinish() {
    return !canShowButtonGuide(guideType);
  }

  void saveState() {
    finishCallback?.call();
    var typeStr = (guideType.index + 1).toString();
    resMap[typeStr] = true;
    PublicApi.instance().completeNewGuide(typeStr).then((value) {});
  }

  String get guideTypeName {
    return guideType == AppGuideType.follow ? guideType.name + order.toString() : guideType.name;
  }

  static bool canShowButtonGuide(AppGuideType type) {
    if (UserGetx.to.isLogin) {
      var typeStr = (type.index + 1).toString();
      return (resMap[typeStr] as bool?) == false ? true : false;
    } else {
      return false;
    }
  }

  static Future getUserNewGuide() async {
    resMap.clear();
    final results = await PublicApi.instance().getUserNewGuideV2([1, 2, 3, 4, 5]);
    for (var element in results) {
      bool v = element['guide'] == 1 ? true : false;
      var type = element['type'].toString();
      resMap[type] = v;
    }
    return results;
  }

  List<String> getTitleAndDes() {
    switch (guideType) {
      case AppGuideType.follow:
        if (title.isEmpty) {
          switch (order) {
            case 1:
              return [LocaleKeys.other27.tr, LocaleKeys.other28.tr];
            case 2:
              return [LocaleKeys.follow16.tr, LocaleKeys.other29.tr];
            case 3:
              return [LocaleKeys.other30.tr, LocaleKeys.other31.tr];
            case 4:
              return [LocaleKeys.follow47.tr, LocaleKeys.other32.tr];

            default:
              return ['', ''];
          }
        } else {
          return [title, des];
        }
      case AppGuideType.standardContract:
        if (title.isEmpty) {
          switch (order) {
            case 1:
              return [LocaleKeys.other8.tr, LocaleKeys.other9.tr];
            case 2:
              return [LocaleKeys.other10.tr, LocaleKeys.other11.tr];
            case 3:
              return [LocaleKeys.other12.tr, LocaleKeys.other13.tr];
            case 4:
              return [LocaleKeys.other14.tr, LocaleKeys.other15.tr];
            case 5:
              return [LocaleKeys.other16.tr, LocaleKeys.other17.tr];

            default:
              return ['', ''];
          }
        } else {
          return [title, des];
        }
      case AppGuideType.perpetualContract:
        if (title.isEmpty) {
          switch (order) {
            case 1:
              return [LocaleKeys.other8.tr, LocaleKeys.other18.tr];

            case 2:
              return [LocaleKeys.other19.tr, LocaleKeys.other20.tr];

            case 3:
              return [LocaleKeys.other21.tr, LocaleKeys.other22.tr];

            case 4:
              return [LocaleKeys.other23.tr, LocaleKeys.other24.tr];

            case 5:
              return [LocaleKeys.other25.tr, LocaleKeys.other26.tr];

            default:
              return ['', ''];
          }
        } else {
          return [title, des];
        }
      case AppGuideType.spot:
        if (title.isEmpty) {
          switch (order) {
            case 1:
              return [LocaleKeys.other1.tr, LocaleKeys.other2.tr];
            case 2:
              return [LocaleKeys.other3.tr, LocaleKeys.other4.tr];
            case 3:
              return [LocaleKeys.other5.tr, LocaleKeys.other6.tr];
            case 4:
              return [LocaleKeys.other5.tr, LocaleKeys.other7.tr];
            default:
              return ['', ''];
          }
        } else {
          return [title, des];
        }
      case AppGuideType.c2c:
        if (title.isEmpty) {
          switch (order) {
            case 1:
              return [LocaleKeys.c2c367.tr, LocaleKeys.c2c368.tr];
            case 2:
              return [LocaleKeys.c2c369.tr, LocaleKeys.c2c370.tr];
            case 3:
              return [LocaleKeys.c2c371.tr, LocaleKeys.c2c372.tr];
            case 4:
              return [LocaleKeys.c2c373.tr, LocaleKeys.c2c374.tr];
            default:
              return [LocaleKeys.c2c375.tr, LocaleKeys.c2c376.tr];
          }
        } else {
          return [title, des];
        }
      default:
        return ['', ''];
    }
  }
}
