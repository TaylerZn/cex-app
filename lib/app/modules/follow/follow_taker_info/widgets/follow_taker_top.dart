import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_item.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/controllers/follow_taker_info_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_taker_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_mark.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class FollowTakerTop extends StatelessWidget with FollowTag {
  const FollowTakerTop({super.key, required this.controller});
  final FollowTakerInfoController controller;
  @override
  Widget build(BuildContext context) {
    Widget topView;

    if (controller.viewType == FollowViewType.customerToCustomer || controller.viewType == FollowViewType.traderToCustomer) {
      topView = Obx(() => Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 14.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  UserAvatar(controller.detailModel.value.icon,
                      width: 60.w,
                      height: 60.w,
                      levelType: controller.detailModel.value.levelType,
                      isTrader: true,
                      tradeIconSize: 20.w)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.w, bottom: 4.w),
                child: Text(controller.detailModel.value.userName, style: AppTextStyle.f_20_500.color111111),
              ),
              SizedBox(height: 10.h)
            ]),
          ));
    } else if (controller.viewType == FollowViewType.mySelfToCustomer) {
      topView = Obx(() => Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 14.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  UserAvatar(
                    controller.detailModel.value.icon,
                    width: 60.w,
                    height: 60.w,
                    levelType: controller.detailModel.value.levelType,
                    isTrader: true,
                    tradeIconSize: 20.w,
                  ),
                  MyButton.borderWhiteBg(
                    onTap: () {
                      Get.toNamed(Routes.MY_SETTINGS_USER);
                    },
                    text: LocaleKeys.follow159.tr,
                    height: 32.h,
                    width: 64.w,
                    border: Border.all(width: 1, color: AppColor.color111111),
                    textStyle: AppTextStyle.f_14_600.color111111,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.w, bottom: 4.w),
                child: Text(controller.detailModel.value.userName, style: AppTextStyle.f_20_500.color111111),
              ),
              buildFollowWidget(),
              // buildTraderDesc(),
              Visibility(
                  visible: ObjectUtil.isNotEmpty(controller.detailModel.value.signatureInfo),
                  child: Container(
                    margin: EdgeInsets.only(top: 4.h),
                    child: Text('${controller.detailModel.value.signatureInfo}', style: AppTextStyle.f_10_400.color666666),
                  )),
              SizedBox(height: 10.h)
            ]),
          ));
    } else {
      topView = Obx(() => Container(
            color: const Color(0xFF131516),
            child: Stack(
              children: [
                Positioned(
                    top: 20.w,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: MyImage(
                        'flow/follow_trader_bg'.svgAssets(),
                        height: 66.w,
                      ),
                    )),
                controller.detailModel.value.symbolIconList.first.isNotEmpty
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            // color: Colors.blue,
                            child: FollowIconAnimationView(
                                width: MediaQuery.of(context).size.width,
                                height: 94.w,
                                iconArr: controller.detailModel.value.symbolIconList.first)))
                    : const SizedBox(),
                controller.detailModel.value.symbolIconList.last.isNotEmpty
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            // color: Colors.blue,
                            child: FollowIconAnimationView(
                                width: MediaQuery.of(context).size.width,
                                height: 54.w,
                                floor: 1,
                                iconArr: controller.detailModel.value.symbolIconList.last)))
                    : const SizedBox(),
                Container(
                  margin: EdgeInsets.only(top: 94.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 16.w, top: 16.w, bottom: 3.w),
                            child: controller.viewType == FollowViewType.mySelfToTrader
                                ? MyButton(
                                    onTap: () {
                                      Get.toNamed(Routes.MY_SETTINGS_USER);
                                    },
                                    text: LocaleKeys.follow159.tr,
                                    height: 32.h,
                                    width: 64.w,
                                    color: AppColor.color111111,
                                    backgroundColor: AppColor.colorF5F5F5,
                                    textStyle: AppTextStyle.f_13_500.color111111,
                                  )
                                : Obx(() => MyButton(
                                      height: 28.w,

                                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      color: controller.detailModel.value.isFollow
                                          ? AppColor.color111111
                                          : AppColor.colorTextPrimary,
                                      borderRadius: BorderRadius.circular(60.r),
                                      textStyle: AppTextStyle.f_13_500,
                                      backgroundColor: controller.detailModel.value.isFollow
                                          ? AppColor.colorF5F5F5
                                          : AppColor.colorBackgroundSecondary,
                                      text: controller.detailModel.value.isFollow
                                          ? LocaleKeys.community111.tr //'正在关注'
                                          : LocaleKeys.community43.tr,
                                      //'关注',
                                      onTap: () async {
                                        if (UserGetx.to.goIsLogin()) {
                                          controller.setTraceUserRelation();
                                        }
                                      },
                                    ))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                                // color: Colors.amber,
                                constraints: BoxConstraints(maxWidth: 115.w),
                                child: Text(controller.detailModel.value.userName,
                                    style: AppTextStyle.f_18_600.color111111.copyWith(overflow: TextOverflow.ellipsis))),
                            ...getIcon(
                                [controller.detailModel.value.flagIcon, ...controller.detailModel.value.organizationIconList])
                          ],
                        ),
                        4.verticalSpace,
                        Wrap(
                          children: <Widget>[
                            ...getTag([controller.detailModel.value.tradingStyleStr],
                                bordeColor: AppColor.colorAbnormal, color: AppColor.colorAbnormal),
                            ...getTag(controller.detailModel.value.tradingPairList),
                            ...getTag(controller.detailModel.value.authenticationList,
                                color: AppColor.upColor, backgroundColor: const Color(0x192EBD87)),
                          ],
                        )
                      ],
                    ).paddingOnly(left: 16.w),
                    Padding(padding: EdgeInsets.only(left: 16.w, top: 8.w, bottom: 16.w), child: buildFollowWidget()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: FollowOrdersCellTopSignature(vertical: 0, signature: controller.detailModel.value.signatureStr),
                    ),
                    InkWell(
                      onTap: () {
                        showFollowMarkheetView(detailModel: controller.detailModel.value, currentContext: context);
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 9.w, 0, 13.w),
                        child: Text(LocaleKeys.follow472.tr, style: AppTextStyle.f_12_500.tradingYel),
                      ),
                    )
                  ]),
                ),
                Positioned(
                  top: 64.w,
                  left: 16.w,
                  child: UserAvatar(
                    controller.detailModel.value.icon,
                    width: 60.w,
                    height: 60.w,
                    levelType: controller.detailModel.value.levelType,
                    isTrader: true,
                    tradeIconSize: 20.w,
                  ),
                )
              ],
            ),
          ));
    }

    return SliverToBoxAdapter(child: topView);
  }

  Widget buildFollowWidget() {
    return Visibility(
        visible: controller.viewType.showFollowTab,
        child: Container(
          margin: EdgeInsets.only(top: 4.w),
          child: Row(
              children: controller.viewType.followTab.map((e) {
            return InkWell(
                onTap: () async {
                  if (UserGetx.to.goIsLogin()) {
                    await Get.toNamed(Routes.FOLLOW_MEMBER, arguments: {
                      'index': e,
                      'uid': '${controller.detailModel.value.uid}',
                      'viewType': controller.viewType,
                      'name': controller.detailModel.value.userName
                    });
                    controller.getInfoModel();
                  }
                },
                child: Row(
                  children: [
                    Text(
                        e == FollowAction.follow
                            ? '${controller.detailModel.value.focusNum ?? 0}'
                            : '${controller.detailModel.value.fanNum ?? 0}',
                        style: AppTextStyle.f_12_600),
                    4.w.horizontalSpace,
                    Text(e.title(), style: AppTextStyle.f_12_400.color999999),
                    10.horizontalSpace,
                  ],
                ));
          }).toList()),
        ));
  }

  // Widget buildTraderDesc() {
  //   return Visibility(
  //     visible: ObjectUtil.isNotEmpty(controller.detailModel.value.identityDesc),
  //     child: Container(
  //       margin: EdgeInsets.only(top: 4.w),
  //       child: Row(
  //         children: [
  //           MyImage('community/shield'.svgAssets()),
  //           4.w.horizontalSpace,
  //           Expanded(child: Text(controller.detailModel.value.identityDesc ?? '', style: AppTextStyle.f_10_400.color999999))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class FollowTakerMiddleView extends StatelessWidget {
  const FollowTakerMiddleView({super.key, required this.type, this.takerType = FollowTakerType.currentSingle});
  final FollowViewType type;
  final FollowTakerType takerType;

  @override
  Widget build(BuildContext context) {
    return type.index > 2
        ? Padding(
            padding: EdgeInsets.only(top: 64.h),
            child: Column(
              children: <Widget>[
                MyImage('flow/follow_position_hidden'.svgAssets(), width: 70.w),
                Text(
                  takerType == FollowTakerType.userReview
                      ? LocaleKeys.follow512.tr
                      : (takerType == FollowTakerType.follower ? LocaleKeys.follow305.tr : LocaleKeys.follow161.tr),
                  style: AppTextStyle.f_12_400.color999999,
                )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 48.h),
            child: Column(
              children: <Widget>[
                MyImage('flow/myselfToCustomer'.svgAssets(), width: 70.w),
                Text(
                  type == FollowViewType.mySelfToCustomer ? LocaleKeys.follow162.tr : LocaleKeys.follow163.tr,
                  style: AppTextStyle.f_12_400.color999999,
                )
              ],
            ),
          );
  }
}

class FollowIconAnimationView extends StatefulWidget {
  const FollowIconAnimationView({super.key, required this.width, required this.height, required this.iconArr, this.floor = 0});

  @override
  State createState() => _FollowIconAnimationViewState();
  final double width;
  final double height;
  final List<String> iconArr;
  final int floor;
}

class _FollowIconAnimationViewState extends State<FollowIconAnimationView> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  ParticleController pController = ParticleController();
  Map imageMap = {};

  @override
  void initState() {
    super.initState();
    initParticleController();
    animationController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..addListener(() {
        pController.update(animationController);
      });
    for (var name in widget.iconArr) {
      _loadImage(name);
    }
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.stop();
    animationController.dispose();
  }

  Future<void> _loadImage(String name) async {
    final NetworkImage networkImage = NetworkImage(name);
    final ImageStream stream = networkImage.resolve(const ImageConfiguration());
    final ImageStreamListener listener = ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        imageMap[name] = info.image;
      });
    });
    stream.addListener(listener);
  }

  void initParticleController() {
    pController.size = Size(widget.width, widget.height - 40);
    int length = widget.iconArr.length;
    for (var i = 0; i < widget.iconArr.length; i++) {
      var offsetX = widget.floor;

      var x = ((length > 7 || offsetX == 1) ? 65.0.w : 85.w) + offsetX * 20.w + (i % 8) * 40.0.w;

      pController.particles.add(Particle(
          x: x,
          yindex: offsetX,
          ay: (30 - (offsetX * 20) + Random().nextInt(30)).toDouble() / 60,
          maxY: widget.height,
          color: Colors.green,
          size: 8,
          name: widget.iconArr[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: CustomPaint(
        size: Size(widget.width, widget.height),
        painter: _BallMove(controller: pController, imageMap: imageMap),
      ),
    );
  }
}

class _BallMove extends CustomPainter {
  final ParticleController controller;
  Paint ballPaint = Paint();

  _BallMove({required this.controller, this.imageMap}) : super(repaint: controller);

  final Map? imageMap;

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in controller.particles) {
      var image = imageMap?[p.name];
      if (imageMap != null && image != null) {
        Rect srcRect = Rect.fromLTWH(0, 0, image!.width.toDouble(), image!.height.toDouble());
        Rect destRect = Rect.fromLTWH(p.x, p.y, 40.w, 40.w);

        final rrect = RRect.fromRectAndRadius(
          Rect.fromLTWH(p.x, p.y, 40.w, 40.w),
          Radius.circular(20.w),
        );

        canvas.save();
        canvas.clipRRect(rrect);
        canvas.drawImageRect(
          image!,
          srcRect,
          destRect,
          Paint()..isAntiAlias = true,
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BallMove oldDelegate) {
    return false;
  }
}

class ParticleController with ChangeNotifier {
  late Particle p;
  Size? size;

  ParticleController();
  List<Particle> particles = [];
  void update(AnimationController vc) {
    particles.forEach((element) {
      doUpdate(element, vc);
    });
    notifyListeners();
  }

  void doUpdate(Particle p, AnimationController vc) {
    p.y += p.vy;
    p.vy += p.ay;
    if (p.y > (size!.height)) {
      p.maxY = p.maxY * 0.2;
      p.y = size!.height;
      p.vy = -p.vy * 0.8;
    }
    if (p.y < size!.height - p.maxY) {
      p.y = size!.height - p.maxY;
      p.vy = 0;
    }
    // print('hhhhhhhhhhhhhh-----${p.y}');

    if (p.maxY < (0.01)) {
      p.y = size!.height;
      p.maxY = size!.height;
      // print('hhhhhhhhhhhhhh-----${p.y}');
      vc.stop();
    }
  }
}

class Particle {
  double x;
  double ax;
  double vx;

  double y;
  double ay;
  double vy;

  double maxY;
  int yindex;

  double size;
  Color color;
  String name;

  Particle(
      {this.x = 0,
      this.ax = 0,
      this.vx = 0,
      this.y = 0,
      this.ay = 0,
      this.vy = 0,
      this.size = 0,
      this.maxY = 0,
      this.yindex = 0,
      this.color = Colors.blue,
      this.name = ''});
}
