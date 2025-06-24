import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_detail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/controllers/follow_taker_info_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_draw.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_mark.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_translate.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'dart:math';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowTakerUserRatingList extends StatelessWidget {
  const FollowTakerUserRatingList(
      {super.key,
      required this.controller,
      this.haveDecoration = true,
      this.maxLines = 4,
      this.haveAction = true,
      required this.model});
  final FollowTakerInfoController controller;
  final bool haveDecoration;
  final int maxLines;
  final bool haveAction;
  final FollowComment model;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
            child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 23.w,
                      child: Text(LocaleKeys.follow474.tr, style: AppTextStyle.f_15_600.color111111).marginOnly(right: 2.w),
                    ).paddingSymmetric(vertical: 16.w),
                  ],
                ),
                FollowTakerUserRatingTopView(model: model, haveDecoration: haveDecoration),
              ],
            ).paddingSymmetric(horizontal: 16.w),
          ],
        )),
        SliverList(
          delegate: SliverChildBuilderDelegate((content, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: FollowReviewCell(maxLines: maxLines, haveAction: haveAction, model: model.records![index]),
            );
          }, childCount: model.records!.length),
        ),
        SliverToBoxAdapter(
            child: InkWell(
          onTap: () {
            Get.toNamed(Routes.FOLLOW_USER_REVIEW, arguments: {'uid': controller.detailModel.value.uid});
          },
          child: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.w), child: Text('查看更多评价', style: AppTextStyle.f_12_500.tradingYel)),
          ),
        ))
      ],
    );
  }
}
//  Rx<FollowComment> overviewComment = FollowComment().obs;

class FollowTakerUserRatingCell extends StatelessWidget {
  const FollowTakerUserRatingCell({
    super.key,
    required this.controller,
    required this.model,
    this.haveDecoration = true,
  });
  final FollowTakerInfoController controller;
  final bool haveDecoration;
  final FollowComment model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(color: AppColor.colorF1F1F1, height: 8.w, margin: EdgeInsets.only(top: 16.w)),
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 23.w,
                  child: Text(LocaleKeys.follow443.tr, style: AppTextStyle.f_15_600.color111111).marginOnly(right: 2.w),
                ).paddingSymmetric(vertical: 16.w),
                GestureDetector(
                    onTap: () async {
                      UIUtil.showAlert(LocaleKeys.follow443.tr, content: LocaleKeys.follow505.tr);
                    },
                    child: SizedBox(
                      width: 14.w,
                      height: 14.w,
                      child: MyImage(
                        'flow/follow_setup_tip'.svgAssets(),
                      ),
                    ))
              ],
            ),
            FollowTakerUserRatingTopView(model: model, haveDecoration: haveDecoration),
            ...model.records!.map((e) => FollowReviewCell(maxLines: 2, haveAction: false, model: e)),
            InkWell(
              onTap: () {
                controller.goTabWithIndex(4);
              },
              child: Text(LocaleKeys.follow471.tr, textAlign: TextAlign.center, style: AppTextStyle.f_12_500.tradingYel)
                  .paddingOnly(top: 16.w),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ],
    );
  }
}

class FollowTakerUserRatingTopView extends StatelessWidget {
  const FollowTakerUserRatingTopView({super.key, required this.model, this.haveDecoration = true});
  final FollowComment model;
  final bool haveDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: haveDecoration ? 16.w : 0, vertical: 12.w),
      decoration: haveDecoration
          ? ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: AppColor.colorF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  MyImage(
                    'flow/wheat_left'.svgAssets(),
                    width: 13.w,
                    height: 20.w,
                  ),
                  Text('${model.ratingResult?.averageScore ?? 0}', style: AppTextStyle.f_28_600.color333333)
                      .marginOnly(right: 2.w)
                      .paddingSymmetric(horizontal: 4.w),
                  MyImage(
                    'flow/wheat_right'.svgAssets(),
                    width: 13.w,
                    height: 20.w,
                  ),
                ],
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '${LocaleKeys.follow467.tr} ', style: AppTextStyle.f_10_500.color666666),
                    TextSpan(text: '${model.ratingResult?.topRate ?? 0}%', style: AppTextStyle.f_10_500.upColor),
                    TextSpan(text: ' ${LocaleKeys.follow468.tr}', style: AppTextStyle.f_10_500.color666666),
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: [
                  const FollowScoreStarWidget(count: 5),
                  FollowScorePercentageWidget(percentage: model.ratingResult?.score5RateStr ?? 0)
                ],
              ),
              Row(
                children: [
                  const FollowScoreStarWidget(count: 4),
                  FollowScorePercentageWidget(percentage: model.ratingResult?.score4RateStr ?? 0)
                ],
              ),
              Row(
                children: [
                  const FollowScoreStarWidget(count: 3),
                  FollowScorePercentageWidget(percentage: model.ratingResult?.score3RateStr ?? 0)
                ],
              ),
              Row(
                children: [
                  const FollowScoreStarWidget(count: 2),
                  FollowScorePercentageWidget(percentage: model.ratingResult?.score2RateStr ?? 0)
                ],
              ),
              Row(
                children: [
                  const FollowScoreStarWidget(count: 1),
                  FollowScorePercentageWidget(percentage: model.ratingResult?.score1RateStr ?? 0)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FollowScoreStarWidget extends StatelessWidget {
  const FollowScoreStarWidget({super.key, required this.count, this.size = 6});
  final int count;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ...List.generate(
            count,
            (index) => Padding(
                  padding: EdgeInsets.only(right: index < count - 1 ? 2.w : 0),
                  child: MyImage('flow/follow_start'.svgAssets(), width: size.w, height: size.w, color: AppColor.upColor),
                )),
        Text('$count'.tr, style: AppTextStyle.f_8_500.colorFunctionBuy).paddingSymmetric(horizontal: 4.w)
      ],
    );
  }
}

class FollowScorePercentageWidget extends StatelessWidget {
  const FollowScorePercentageWidget({super.key, required this.percentage, this.width = 73, this.height = 2});

  final double percentage;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: width.w,
              height: height.w,
              decoration: ShapeDecoration(
                color: AppColor.colorF1F1F1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            ),
            Container(
              width: width.w * (percentage * 0.01),
              height: height.w,
              decoration: ShapeDecoration(
                color: AppColor.upColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            )
          ],
        ),
        SizedBox(
            width: 28.w, child: Text('$percentage %', style: AppTextStyle.f_8_500.color666666.ellipsis).paddingOnly(left: 4.w))
      ],
    );
  }
}

class FollowReviewCell extends StatelessWidget {
  const FollowReviewCell({super.key, this.maxLines = 2, this.haveAction = false, required this.model});

  final int maxLines;
  final bool haveAction;
  final FollowCommentModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColor.colorF5F5F5, width: 1.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyImage(model.icon, width: 24.w, height: 24.w),
          6.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 24.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(model.userName, style: AppTextStyle.f_12_500.color4D4D4D),
                      Text(model.timeStr, style: AppTextStyle.f_10_400.color999999),
                    ],
                  ),
                ),
                FollowStarWidget(score: model.rating.toDouble(), size: 12),
                10.verticalSpace,
                FollowFoldText(
                  model,
                  maxLines: maxLines,
                  haveAction: haveAction,
                  style: AppTextStyle.f_13_400_15.color333333,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FollowFoldText extends StatefulWidget {
  const FollowFoldText(
    this.model, {
    super.key,
    this.expanded = false,
    this.style,
    this.maxLines = 4,
    this.haveAction = false,
  });

  final FollowCommentModel model;
  final bool expanded;
  final TextStyle? style;
  final int maxLines;
  final bool haveAction;

  @override
  State createState() => _FollowFoldTextState();
}

class _FollowFoldTextState extends State<FollowFoldText> with TickerProviderStateMixin {
  bool _expanded = false;
  int _maxLines = 4;
  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded;
    _maxLines = widget.maxLines;
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    var effectiveTextStyle = widget.style;
    if (widget.style == null || widget.style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final link = TextSpan(
      children: [
        if (!_expanded)
          TextSpan(
            text: '\u2026 ',
            style: effectiveTextStyle,
          ),
      ],
    );

    final text = TextSpan(text: widget.model.rxComentStr.value);
    final content = TextSpan(children: <TextSpan>[text], style: effectiveTextStyle);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        const textAlign = TextAlign.start;
        final textDirection = Directionality.of(context);
        final locale = Localizations.maybeLocaleOf(context);

        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          maxLines: _maxLines,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        textPainter.text = content;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          widget.model.haveExpansion = true;

          final position = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          final endOffset = (textPainter.getOffsetBefore(position.offset) ?? 0);

          final text = TextSpan(
            text: _expanded ? widget.model.rxComentStr.value : widget.model.rxComentStr.value.substring(0, max(endOffset, 0)),
          );

          textSpan = TextSpan(
            style: effectiveTextStyle,
            children: <TextSpan>[
              text,
              link,
            ],
          );
        } else {
          textSpan = content;
        }

        final richText = RichText(
          text: textSpan,
          softWrap: true,
          textDirection: textDirection,
          textAlign: textAlign,
          overflow: TextOverflow.clip,
        );

        return widget.haveAction
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  richText,
                  10.verticalSpace,
                  Row(
                    children: [
                      widget.model.haveExpansion
                          ? Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _maxLines = _maxLines == widget.maxLines ? 100000 : widget.maxLines;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: Text(
                                        _maxLines == widget.maxLines ? LocaleKeys.follow112.tr : LocaleKeys.follow113.tr,
                                        style: AppTextStyle.f_12_500.tradingYel),
                                  ),
                                ),
                                Container(
                                    height: 12, width: 1, color: AppColor.colorEEEEEE, padding: EdgeInsets.only(right: 12.w)),
                              ],
                            )
                          : const SizedBox(),
                      FollowTranslateView(
                        sourceStr: widget.model.commentStr,
                        sourceRXStr: widget.model.rxComentStr,
                        callback: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              )
            : richText;
      },
    );
  }
}
