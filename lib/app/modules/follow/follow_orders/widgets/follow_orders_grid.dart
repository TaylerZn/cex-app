import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/controllers/follow_orders_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_data_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_item.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_tabbar.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FollowOrdersGridView extends StatelessWidget {
  const FollowOrdersGridView({super.key, required this.controller, this.type = TraderType.daily});
  final FollowOrdersController controller;
  final TraderType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TraderType.highest:
        return FollowGridStackList(controller: controller);

      case TraderType.focused:
        return FollowGridGroupList(controller: controller);

      case TraderType.daily:
        return SliverToBoxAdapter(
          child: list.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    FollowOrdersGridViewTop(controller: controller, type: type),
                    Container(
                        // color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: controller.isTrader ? 238.w : 290.w,
                        child: CardSwiper(
                            cardsCount: list.length,
                            allowedSwipeDirection: const AllowedSwipeDirection.symmetric(horizontal: true),
                            maxAngle: 0,
                            padding: EdgeInsets.zero,
                            onSwipe: (
                              int previousIndex,
                              int? currentIndex,
                              CardSwiperDirection direction,
                            ) {
                              if (direction == CardSwiperDirection.right) {
                                var model = list[previousIndex];
                                Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': model.uid});
                              }
                              return true;
                            },
                            numberOfCardsDisplayed: 3,
                            scale: 0.9,
                            backCardOffset: Offset(25.w, 0),
                            cardBuilder: (
                              context,
                              index,
                              horizontalThresholdPercentage,
                              verticalThresholdPercentage,
                            ) {
                              return FollowOrdersItem(
                                  model: list[index],
                                  controller: controller,
                                  paddingBottom: 0,
                                  index: index,
                                  takeType: TraderType.daily);
                            }))
                  ],
                ),
        );
      default:
        return SliverToBoxAdapter(
          child: list.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    FollowOrdersGridViewTop(controller: controller, type: type),
                    Container(
                      // color: Colors.green,
                      height: controller.isTrader ? 238.w : 290.w,

                      child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return FollowOrdersItem(
                              model: list[index],
                              controller: controller,
                              left: type == TraderType.focused ? 12 : 0,
                              right: (type.model.isStack || index == list.length - 1) ? 0 : 12,
                              paddingBottom: 0,
                            );
                          },
                          itemCount: list.length,
                          // onIndexChanged: (value) {
                          //   if (type.model.isStack) {
                          //     var model = list[value];
                          //     if (controller.model.stackpreviousIndex == 0 && value == list.length - 1) {
                          //       Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': model.uid});
                          //     } else if (controller.model.stackpreviousIndex - value == 1) {
                          //       Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': model.uid});
                          //     } else {}
                          //     controller.model.stackpreviousIndex = value;
                          //   }
                          // },
                          viewportFraction: type == TraderType.focused ? 1.0 : 0.9,
                          itemWidth: type.model.isStack ? 343.w : null,
                          layout: type.model.isStack ? SwiperLayout.STACK : SwiperLayout.DEFAULT,
                          loop: type.model.isStack ? true : false,
                          axisDirection: AxisDirection.right),
                    ),
                  ],
                ),
        );
    }

    // type == TraderType.highest
    //     ? FollowGridStackList(controller: controller)
    //     : type == TraderType.focused
    //         ? FollowGridGroupList(controller: controller)
    //         :
  }

  List<FollowKolInfo> get list {
    if (type == TraderType.daily) {
      return controller.gridModel.popularTrader ?? [];
    } else if (type == TraderType.investor) {
      return controller.gridModel.timesTrader ?? [];
    } else {
      return controller.gridModel.steadyTrader ?? [];
    }
  }
}

class FollowOrdersGridViewTop extends StatelessWidget {
  const FollowOrdersGridViewTop(
      {super.key, required this.controller, this.type = TraderType.daily, this.callback, this.selectIndex = 0});
  final FollowOrdersController controller;
  final TraderType type;
  final Function(int)? callback;
  final int selectIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (type == TraderType.focused) {
            controller.jumpWithType();
          } else {
            controller.jumpWithType(type: type, filter: selectIndex);
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            type.model.icon == null
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: MyImage(type.model.icon!.svgAssets(), width: 20.w, height: 20.w),
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(type.model.title, style: AppTextStyle.f_16_600.color111111),
                      type.model.selectStr == null
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                showFollowFilterSheetView(type.model.dataArr!, selectIndex, callback);
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 4.w),
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
                                  decoration: ShapeDecoration(
                                    color: AppColor.colorF9F9F9,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(type.model.dataArr![selectIndex], style: type.model.selectStrStyle),
                                      MyImage(
                                        'flow/follow_order_arrow'.svgAssets(),
                                        width: 20.w,
                                        height: 20.w,
                                        color: type.model.selectStrStyle!.color,
                                      )
                                    ],
                                  )),
                            )
                    ],
                  ),
                  type.model.des == null ? const SizedBox() : Text(type.model.des!, style: AppTextStyle.f_10_400.color999999),
                ],
              ),
            ),
            type.model.haveRight
                ? MyImage(
                    'default/go'.svgAssets(),
                    width: 12.w,
                  )
                : const SizedBox()
          ],
        ).paddingOnly(left: 16.w, right: 16.w, bottom: 12.w, top: 24.w));
  }
}

class FollowGridGroupList extends StatelessWidget {
  const FollowGridGroupList({super.key, required this.controller});
  final FollowOrdersController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var dataModel = controller.model.exploreTabsModelArr[controller.model.focusCurrentIndex.value];
      return SliverMainAxisGroup(
          slivers: dataModel.value.list?.isNotEmpty == true
              ? [
                  SliverToBoxAdapter(
                    child: FollowOrdersGridViewTop(
                      controller: controller,
                      type: TraderType.focused,
                      selectIndex: controller.model.focusCurrentIndex.value,
                      callback: (i) {
                        controller.model.focusCurrentIndex.value = i;
                        controller.getExploreFocusedData();
                      },
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.w),
                        child: FollowOrdersItem(
                          model: dataModel.value.list![index],
                          controller: controller,
                        ),
                      );
                    }, childCount: dataModel.value.list!.length),
                  )
                ]
              : [
                  FollowOrdersLoading(
                      isError: dataModel.value.isError,
                      onTap: () {
                        controller.getExploreFocusedData(isPullDown: true);
                      })
                ]);
    });
  }
}

class FollowGridStackList extends StatelessWidget with FollowTag {
  const FollowGridStackList({super.key, required this.controller});
  final FollowOrdersController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SliverMainAxisGroup(
        slivers: dataList.isNotEmpty
            ? [
                SliverToBoxAdapter(
                    child: FollowOrdersGridViewTop(
                  controller: controller,
                  type: TraderType.highest,
                  selectIndex: controller.model.showCurrentIndex.value,
                  callback: (i) {
                    controller.model.showCurrentIndex.value = i;
                  },
                )),
                SliverToBoxAdapter(child: Column(children: getView())),
              ]
            : []));
  }

  List<Widget> getView() {
    List<Widget> array = [];
    for (var i = 0; i < dataList.length; i++) {
      var model = dataList[i];
      array.add(InkWell(
        onTap: () {
          Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': model.uid});
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
          child: Row(
            children: [
              Text('${i + 1}', style: AppTextStyle.f_16_600.color111111),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: UserAvatar(
                  model.icon,
                  width: 34.w,
                  height: 34.w,
                  levelType: model.levelType,
                  isTrader: true,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                            // color: Colors.amber,
                            constraints: BoxConstraints(maxWidth: 115.w),
                            child: Text(model.userName,
                                style: AppTextStyle.f_14_500.color111111.copyWith(overflow: TextOverflow.ellipsis))),
                        ...getIcon([model.flagIcon])
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      children: <Widget>[...getTag(model.tradingPairList)],
                    )
                  ],
                ),
              ),
              SizedBox(
                  height: 35.w,
                  width: 60.w,
                  child: StockChart(
                    profitRateList: model.profitRateList,
                  )).marginOnly(right: 16.w),
              SizedBox(
                width: 75.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(model.monthProfitRateStr, style: AppTextStyle.f_16_600.copyWith(color: model.monthProfitRateColor)),
                    Text(LocaleKeys.follow451.tr, style: AppTextStyle.f_9_400.color999999),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }

    return array;
  }

  List<FollowKolInfo> get dataList {
    if (controller.model.showCurrentIndex.value == 0) {
      return controller.gridModel.comprehensiveRating ?? [];
    } else if (controller.model.showCurrentIndex.value == 1) {
      return controller.gridModel.follow ?? [];
    } else {
      return controller.gridModel.orderNumber ?? [];
    }
  }
}
