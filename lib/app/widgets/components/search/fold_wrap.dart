import 'package:flutter/material.dart';

class FoldWrap extends StatefulWidget {
  const FoldWrap({
    super.key,
    required this.children,
    this.foldWidget,
    this.foldLine = 0,
    this.maxLine = 0,
    this.isFold = false,
    this.spacing = 0,
    this.runSpacing = 0,
    this.lineMaxLength = 0,
    required this.extentHeight,
    this.onCallLineNum,
    this.foldWidgetInEnd = false,
  });

  final List<Widget> children;
  final Widget? foldWidget;
  final int foldLine;
  final int maxLine;
  final bool isFold;
  final double spacing;
  final double runSpacing;
  final int lineMaxLength;
  final double extentHeight;
  final Function? onCallLineNum;
  final bool foldWidgetInEnd;

  @override
  State createState() => _FoldWrapState();
}

class _FoldWrapState extends State<FoldWrap> {
  int line = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FoldWrapDelegate(
          foldLine: widget.foldLine,
          extentHeight: widget.extentHeight,
          maxLine: widget.maxLine,
          isFold: widget.isFold,
          spacing: widget.spacing,
          runSpacing: widget.runSpacing,
          line: line,
          lineMaxLength: widget.lineMaxLength,
          foldWidgetInEnd: widget.foldWidgetInEnd,
          onLine: (int i) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              widget.onCallLineNum?.call(i);
              setState(() {
                line = i;
              });
            });
          }),
      children: _getChildren(),
    );
  }

  List<Widget> _getChildren() {
    List<Widget> children = [];
    children.addAll(widget.children);
    if (widget.foldWidget != null) {
      children.add(widget.foldWidget!);
    } else {
      children.add(Container());
    }

    return children;
  }
}

class FoldWrapDelegate extends FlowDelegate {
  FoldWrapDelegate({
    required this.foldLine,
    this.maxLine = 0,
    this.isFold = false,
    this.spacing = 0,
    this.runSpacing = 0,
    required this.extentHeight,
    this.line = 0,
    this.onLine,
    this.lineMaxLength = 0,
    this.foldWidgetInEnd = false,
  });
  final int foldLine;
  final int maxLine;
  final bool isFold;
  final double spacing;
  final double runSpacing;
  final double extentHeight;
  final int line;
  final ValueChanged<int>? onLine;
  final int lineMaxLength;
  final bool foldWidgetInEnd;

  @override
  void paintChildren(FlowPaintingContext context) {
    var screenW = context.size.width;
    double offsetX = 0;
    double offsetY = 0;
    int foldWidgetIndex = isFold ? context.childCount - 1 : context.childCount;
    int nowLine = 1;
    int lineLength = 0;
    bool hasPainFold = false;

    for (int i = 0; i < foldWidgetIndex; i++) {
      if (offsetX + (context.getChildSize(i)?.width ?? 0) <= screenW &&
          getLineLimit(lineLength)) {
        if (needChangeToFoldWidget(i, offsetX, screenW, nowLine, context)) {
          if (canAddToFoldWidget(
              i, offsetX, screenW, context, foldWidgetIndex)) {
            context.paintChild(i,
                transform: Matrix4.translationValues(offsetX, offsetY, 0));
            offsetX = offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
          }
          if (!hasPainFold) {
            context.paintChild(foldWidgetIndex,
                transform: Matrix4.translationValues(
                    getFoldWidgetOffsetX(
                        context.getChildSize(foldWidgetIndex)?.width ?? 0,
                        offsetX,
                        screenW),
                    offsetY,
                    0));
            offsetX = offsetX +
                (context.getChildSize(foldWidgetIndex)?.width ?? 0) +
                spacing;
            hasPainFold = true;
          }
          break;
        } else {
          context.paintChild(i,
              transform: Matrix4.translationValues(offsetX, offsetY, 0));
          offsetX = offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
          lineLength++;
        }
      } else {
        nowLine++;
        lineLength = 0;

        if ((isFold && (nowLine > foldLine))) {
          if (!hasPainFold) {
            context.paintChild(foldWidgetIndex,
                transform: Matrix4.translationValues(
                    getFoldWidgetOffsetX(
                        context.getChildSize(foldWidgetIndex)?.width ?? 0,
                        offsetX,
                        screenW),
                    offsetY,
                    0));
            offsetX = offsetX +
                (context.getChildSize(foldWidgetIndex)?.width ?? 0) +
                spacing;
            hasPainFold = true;
          }
          break;
        } else {
          if (maxLine != 0 && nowLine > maxLine) {
            break;
          } else {
            offsetX = 0;
            offsetY = offsetY + extentHeight + runSpacing;
            if (needChangeToFoldWidget(i, offsetX, screenW, nowLine, context)) {
              if (canAddToFoldWidget(
                  i, offsetX, screenW, context, foldWidgetIndex)) {
                context.paintChild(i,
                    transform: Matrix4.translationValues(offsetX, offsetY, 0));
                offsetX =
                    offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
              }
              if (!hasPainFold) {
                context.paintChild(foldWidgetIndex,
                    transform: Matrix4.translationValues(
                        getFoldWidgetOffsetX(
                            context.getChildSize(foldWidgetIndex)?.width ?? 0,
                            offsetX,
                            screenW),
                        offsetY,
                        0));
                offsetX = offsetX +
                    (context.getChildSize(foldWidgetIndex)?.width ?? 0) +
                    spacing;
                hasPainFold = true;
              }
            } else {
              context.paintChild(i,
                  transform: Matrix4.translationValues(offsetX, offsetY, 0));
            }
            offsetX = offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
          }
        }
      }
    }

    onLine?.call(nowLine);
  }

  bool getLineLimit(int lineLength) {
    if (lineMaxLength == 0) {
      return true;
    }
    if (lineLength >= lineMaxLength) {
      return false;
    } else {
      return true;
    }
  }

  bool needChangeToFoldWidget(int i, double offsetX, double screenW,
      int nowLine, FlowPaintingContext context) {
    if (!isFold) {
      return false;
    }
    if ((i + 1 < context.childCount - 1) &&
        ((offsetX +
                (context.getChildSize(i)?.width ?? 0) +
                spacing +
                (context.getChildSize(i + 1)?.width ?? 0)) >
            screenW)) {
      if ((isFold && ((nowLine + 1) > foldLine))) {
        return true;
      }
    }
    return false;
  }

  bool canAddToFoldWidget(int i, double offsetX, double screenW,
      FlowPaintingContext context, int lastIndex) {
    if ((offsetX +
            (context.getChildSize(i)?.width ?? 0) +
            spacing +
            (context.getChildSize(lastIndex)?.width ?? 0)) <=
        screenW) {
      return true;
    }
    return false;
  }

  double toMaxHeight(double oldMaxHeight, newMaxHeight) {
    if (oldMaxHeight > newMaxHeight) {
      return oldMaxHeight;
    } else {
      return newMaxHeight;
    }
  }

  double getFoldWidgetOffsetX(
      double foldWidgetWidth, double offsetX, double screenWidth) {
    if (!foldWidgetInEnd) {
      return offsetX;
    }
    return screenWidth - foldWidgetWidth;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    if (isFold) {
      int kLine = line;
      if (line > foldLine) {
        kLine = foldLine;
      }
      return Size(constraints.maxWidth,
          extentHeight * kLine + runSpacing * (kLine - 1));
    }
    int kLine = line;
    if (maxLine != 0 && line > maxLine) {
      kLine = maxLine;
    }
    return Size(
        constraints.maxWidth, extentHeight * kLine + runSpacing * (kLine - 1));
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints(
        maxWidth: constraints.maxWidth,
        minWidth: 0,
        maxHeight: extentHeight,
        minHeight: 0);
  }

  @override
  bool shouldRepaint(covariant FoldWrapDelegate oldDelegate) {
    if (isFold != oldDelegate.isFold) {
      return true;
    }
    if (line != oldDelegate.line) {
      return true;
    }
    return false;
  }

  @override
  bool shouldRelayout(covariant FoldWrapDelegate oldDelegate) {
    return (line != oldDelegate.line);
  }
}
