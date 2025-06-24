import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/greed_voting.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/controllers/community_list_controller.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/bullish_bearish_widget.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/fear_greed_index_widget.dart';
import 'package:nt_app_flutter/app/modules/community/enum.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/utilities/ui_util.dart';

class CommunityMarketCombinedWidget extends StatefulWidget {
  const CommunityMarketCombinedWidget({super.key});

  @override
  State<CommunityMarketCombinedWidget> createState() =>
      _CommunityMarketCombinedWidgetState();
}

class _CommunityMarketCombinedWidgetState
    extends State<CommunityMarketCombinedWidget> {
  final CommunityListController controller =
      Get.find<CommunityListController>(tag: 'Market1');

  int index = 0;

  @override
  void initState() {
    super.initState();
    index = controller.voteWrapper.value?.value ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    // double angle = _mapIndexToAngle(index);

    return Obx(() {
      return Column(
        children: [
          16.verticalSpaceFromWidth,
          FearGreedIndexWidget(
            onTapCallback: () {},
            index: controller.voteWrapper.value?.value ?? 0,
          ),
          16.verticalSpaceFromWidth,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.w,
                color: AppColor.colorBorderGutter,
              ),
              borderRadius: BorderRadius.circular(12.w),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(255, 212, 41, 0.1),
                  Color.fromRGBO(255, 212, 41, 0)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                24.verticalSpaceFromWidth,
                progressWidget(),
                18.verticalSpaceFromWidth,
                BullishBearishWidget(
                  bullishPercentage: controller
                          .voteWrapper.value?.model?.records
                          ?.firstWhere(
                              (element) =>
                                  element.votingOption == TrendDirection.up.key,
                              orElse: () => VoteRecord(
                                  votingOption: '', votingPercentage: 50))
                          .votingPercentage ??
                      50,
                  bearishPercentage: controller
                          .voteWrapper.value?.model?.records
                          ?.firstWhere(
                              (element) =>
                                  element.votingOption ==
                                  TrendDirection.down.key,
                              orElse: () => VoteRecord(
                                  votingOption: '', votingPercentage: 50))
                          .votingPercentage ??
                      50,
                  voted: ObjectUtil.isNotEmpty(
                      controller.voteWrapper.value?.voting),
                  onBullishTap: () {
                    startVote(controller.voteWrapper.value?.model?.records
                        ?.firstWhere(
                            (element) =>
                                element.votingOption == TrendDirection.up.key,
                            orElse: () =>
                                VoteRecord(votingOption: '', topicVoteId: -1))
                        .topicVoteId);
                  },
                  onBearishTap: () {
                    startVote(controller.voteWrapper.value?.model?.records
                        ?.firstWhere(
                            (element) =>
                                element.votingOption == TrendDirection.down.key,
                            orElse: () =>
                                VoteRecord(votingOption: '', topicVoteId: -1))
                        .topicVoteId);
                  },
                ),
                24.verticalSpaceFromWidth,
              ],
            ),
          ),
          16.verticalSpaceFromWidth,
          Container(
            height: 1,
            color: AppColor.colorF5F5F5,
          )
        ],
      );
    });
  }

  Widget progressWidget() {
    double angle = index / 100 * pi + pi;
    double height = 51.5.w;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        MyImage(
          'community/community_market_sentiment'.svgAssets(),
          width: 126.w,
          height: 66.w,
          fit: BoxFit.fill,
        ),
        Positioned(
          top: height + 5.w,
          child: Transform.translate(
            offset: Offset(
              (height + 5.w) * cos(angle), // X坐标
              (height) * sin(angle), // Y坐标
            ),
            child: Transform.rotate(
              angle: angle + pi / 2,
              child: MyImage(
                'community/community_market_arrow'.svgAssets(),
                width: 4.w,
                height: 4.w,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Column(
            children: [
              Text(index.toString(),
                  style: AppTextStyle.f_28_600.colorTextPrimary),
              Text(getSentiment(index),
                  style: AppTextStyle.f_11_400.colorTextDescription),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> startVote(int? votingOptionId) async {
    try {
      EasyLoading.show();
      await CommunityApi.instance().topicVote('${votingOptionId}');
      await controller.getBearishData();
      EasyLoading.dismiss();
      setState(() {});
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
  }

  String getSentiment(num index) {
    if (index <= 20) {
      return LocaleKeys.community46.tr; //'极度恐惧';
    } else if (index <= 40) {
      return LocaleKeys.community47.tr; //'恐惧';
    } else if (index <= 60) {
      return LocaleKeys.community48.tr; //'中立';
    } else if (index <= 80) {
      return LocaleKeys.community49.tr; //'贪婪';
    } else {
      return LocaleKeys.community50.tr; //'极度贪婪';
    }
  }
}

class ArcPainter extends CustomPainter {
  final Color color;

  ArcPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: size.height),
      pi, // 起始角度（逆时针）
      pi, // 圆弧长度
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
