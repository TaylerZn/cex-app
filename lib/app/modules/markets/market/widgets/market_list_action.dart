import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class MarketAction extends StatefulWidget {
  const MarketAction({
    super.key,
    required this.actions,
    required this.child,
    this.marketInfo,
    this.contract,
    this.standardContract,
    this.callBack,
  });

  final Function(int)? callBack;
  final List<String> actions;
  final Widget child;
  final ContractInfo? contract;
  final ContractInfo? standardContract;
  final MarketInfoModel? marketInfo;

  @override
  State createState() => _MarketActionState();
}

class _MarketActionState extends State<MarketAction> {
  late double width;
  late double height;
  late RenderBox cell;
  late RenderBox overlay;
  late OverlayEntry entry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((call) {
      width = context.size!.width;
      height = context.size!.height;
      cell = context.findRenderObject() as RenderBox;
      overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColor.colorF4F4F4,
      child: widget.child,
      onTap: () {
        if (widget.contract != null) {
          goToContractKline(contractInfo: widget.contract!);
        } else if (widget.standardContract != null) {
          goToCommodityKline(contractInfo: widget.standardContract!);
        } else {
          // gotSpotKline(widget.marketInfo!);
        }
      },
      onLongPress: () {
        if (!UserGetx.to.isLogin) return;
        entry = OverlayEntry(builder: (context) {
          return _EditWidget(
            context,
            width,
            height,
            widget.actions,
            cell,
            overlay,
            (index) {
              if (index != null) widget.callBack?.call(index);
              entry.remove();
            },
          );
        });
        Overlay.of(context).insert(entry);
      },
    );
  }
}

class _EditWidget extends StatefulWidget {
  final BuildContext btnContext;
  final List<String> actions;
  final double width;
  final double height;
  final RenderBox button;
  final RenderBox overlay;
  final Function(int?)? callBack;

  const _EditWidget(
    this.btnContext,
    this.width,
    this.height,
    this.actions,
    this.button,
    this.overlay,
    this.callBack,
  );

  @override
  State createState() => _EditWidgetState();
}

class _EditWidgetState extends State<_EditWidget> {
  late RelativeRect position;

  @override
  void initState() {
    super.initState();
    position = RelativeRect.fromRect(
      Rect.fromPoints(
        widget.button.localToGlobal(Offset.zero, ancestor: widget.overlay),
        widget.button.localToGlobal(Offset.zero, ancestor: widget.overlay),
      ),
      Offset.zero & widget.overlay.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.callBack?.call(null),
      onPanStart: (details) => widget.callBack?.call(null),
      child: CustomSingleChildLayout(
        delegate: _EditWidgetLayout(
          position,
          widget.width,
        ),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: Container(
                  color: AppColor.color999999,
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.actions
                          .map((e) => GestureDetector(
                                onTap: () => widget.callBack
                                    ?.call(widget.actions.indexOf(e)),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    color: AppColor.colorWhite,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ).paddingSymmetric(horizontal: 10, vertical: 6),
                              ))
                          .toList()),
                ),
              ),
              CustomPaint(
                size: const Size(7, 5),
                painter: TrianglePainter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Paint _paint = Paint()
    ..style = PaintingStyle.fill
    ..color = AppColor.color999999
    ..strokeWidth = 10
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(size.width / 2 - 10 / 2, 0);
    path.lineTo(size.width / 2 + 10 / 2, 0);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _EditWidgetLayout extends SingleChildLayoutDelegate {
  _EditWidgetLayout(this.position, this.width);
  final RelativeRect position;
  final double width;

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double y = position.top +
        (size.height - position.top - position.bottom) / 2.0 -
        20;
    double x = position.right - width / 2 - childSize.width / 2 - 20;
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_EditWidgetLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}
