import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/no/loading_widget.dart';
import 'package:nt_app_flutter/app/widgets/no/network_error_widget.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class FollowOrdersLoading extends StatelessWidget {
  const FollowOrdersLoading({super.key, this.isError, this.isSliver = true, this.onTap});
  final bool? isError;
  final bool isSliver;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var widget = isError == null
        ? const LoadingWidget()
        : isError == true
            ? Center(
                child: NetworkErrorWidget(
                  onTap: onTap ?? () {},
                ),
              )
            : noDataWidget(context, text: LocaleKeys.public8.tr);

    return isSliver ? SliverFillRemaining(child: widget) : widget;
  }
}

double get maxDragOffset => 100;
double hideHeight = maxDragOffset / 2.3;

class PullToRefreshHeader extends StatefulWidget {
  const PullToRefreshHeader(this.info, {super.key});

  final PullToRefreshScrollNotificationInfo? info;

  @override
  State<PullToRefreshHeader> createState() => _PullToRefreshHeaderState();
}

class _PullToRefreshHeaderState extends State<PullToRefreshHeader> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..addListener(() {
        if (_controller.isCompleted) {
          _controller.reset();
          _controller.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final PullToRefreshScrollNotificationInfo? _info = widget.info;
    if (_info == null) {
      return Container();
    }

    if (_info.mode == PullToRefreshIndicatorMode.refresh || _info.mode == PullToRefreshIndicatorMode.snap) {
      _controller.forward();
    } else {
      _controller.reset();
    }

    final double dragOffset = widget.info?.dragOffset ?? 0.0;
    final double top = -hideHeight + dragOffset;
    return Container(
      height: dragOffset,
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            top: top,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Lottie.asset(
                    'assets/json/refresh.json',
                    width: 20.w,
                    height: 20.w,
                    controller: _controller,
                    repeat: true,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
