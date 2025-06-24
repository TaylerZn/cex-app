import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_editor/domain/bloc/controller.dart';
import 'package:video_editor/domain/entities/cover_data.dart';
import 'package:video_editor/domain/entities/transform_data.dart';
import 'package:video_editor/domain/helpers.dart';
import 'package:video_editor/domain/thumbnails.dart';

class VideoCoverSelection extends StatefulWidget {
  /// Slider that allow to select a generated cover
  const VideoCoverSelection({
    key,
    required this.controller,
    this.size = 60,
    this.quality = 10,
    this.quantity = 5,
    this.wrap,
    this.selectedCoverBuilder,
    this.preCoverDataList,
  });

  /// The [controller] param is mandatory so every change in the controller settings will propagate in the cover selection view
  final VideoEditorController controller;

  /// The [size] param specifies the size to display the generated thumbnails
  ///
  /// Defaults to `60`
  final double size;

  /// The [quality] param specifies the quality of the generated thumbnails, from 0 to 100 ([more info](https://pub.dev/packages/video_thumbnail))
  ///
  /// Defaults to `10`
  final int quality;

  /// The [quantity] param specifies the quantity of thumbnails to generate
  ///
  /// Default to `5`
  final int quantity;

  /// Specifies a [wrap] param to change how should be displayed the covers thumbnails
  /// the `children` param will be ommited
  final Wrap? wrap;

  /// Returns how the selected cover should be displayed
  final Widget Function(Widget selectedCover, Size)? selectedCoverBuilder;

  final List<CoverData>? preCoverDataList;

  @override
  State<VideoCoverSelection> createState() => _VideoCoverSelectionState();
}

class _VideoCoverSelectionState extends State<VideoCoverSelection>
    with AutomaticKeepAliveClientMixin {
  Duration? _startTrim, _endTrim;

  Size _layout = Size.zero;
  final ValueNotifier<Rect> _rect = ValueNotifier<Rect>(Rect.zero);
  final ValueNotifier<TransformData> _transform =
      ValueNotifier<TransformData>(const TransformData());

  late Stream<List<CoverData>> _stream = (() => _generateCoverThumbnails())();

  double _coverSize = 50.w;
  double? _dragX;
  double? _dragY;
  DragStatus? _dragStatus;
  int? _selectIndex;

  List _globalKeys = [];
  List<CoverData>? coverDataList = [];
  List<CoverData>? _totalCoverDataList = [];
  List<CoverData> _showCoverDataList = [];

  @override
  void initState() {
    super.initState();
    _startTrim = widget.controller.startTrim;
    _endTrim = widget.controller.endTrim;
    widget.controller.addListener(_scaleRect);

    if (widget.preCoverDataList == null || widget.preCoverDataList!.isEmpty) {
      _stream.listen((coverList) {
        _totalCoverDataList = coverList;
        _showCoverDataList = [];
        if (_totalCoverDataList != null)
          _totalCoverDataList!.forEach((coverData) {
            var index = _totalCoverDataList!.indexOf(coverData);
            if (index % 6 == 0) {
              _showCoverDataList.add(coverData);
            }
          });
        _globalKeys = [];
        setState(() {});
      });
    } else {
      _totalCoverDataList = widget.preCoverDataList;
      _showCoverDataList = [];
      if (_totalCoverDataList != null)
        _totalCoverDataList!.forEach((coverData) {
          var index = _totalCoverDataList!.indexOf(coverData);
          if (index % 6 == 0) {
            _showCoverDataList.add(coverData);
          }
        });
      _globalKeys = [];
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scaleRect);
    _transform.dispose();
    _rect.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _scaleRect() {
    _rect.value = calculateCroppedRect(widget.controller, _layout);

    _transform.value = TransformData.fromRect(
      _rect.value,
      _layout,
      Size.square(widget.size), // the maximum size to show the thumb
      null, // controller rotation should not affect this widget
    );

    // if trim values changed generate new thumbnails
    if (!widget.controller.isTrimming &&
        (_startTrim != widget.controller.startTrim ||
            _endTrim != widget.controller.endTrim)) {
      _startTrim = widget.controller.startTrim;
      _endTrim = widget.controller.endTrim;
      setState(() => _stream = _generateCoverThumbnails());
    }
  }

  Stream<List<CoverData>> _generateCoverThumbnails() => generateCoverThumbnails(
        widget.controller,
        quantity: widget.quantity,
        quality: widget.quality,
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildCoverList();
  }

  Widget _buildCoverList() {
    final wrap = widget.wrap ?? Wrap();
    _globalKeys = [];
    return GestureDetector(
      onPanDown: (panDetail) {
        _dragStatus = DragStatus.DragStart;
        _dragX = panDetail.globalPosition.dx;
        _dragY = panDetail.globalPosition.dy;
        _updateNewIndex();
        print('---- panDetails:' + panDetail.toString());
      },
      onTap: () {
        _dragStatus = DragStatus.DragEnd;
        _updateNewIndex();
      },
      onHorizontalDragStart: (dragStart) {
        _dragStatus = DragStatus.DragStart;
        _dragX = dragStart.globalPosition.dx;
        _dragY = dragStart.globalPosition.dy;
        _updateNewIndex();
        print('---- dragStartDetails:' + dragStart.toString());
      },
      onHorizontalDragUpdate: (dragUpdate) {
        _dragStatus = DragStatus.DragUpdate;
        _dragX = dragUpdate.globalPosition.dx;
        _dragY = dragUpdate.globalPosition.dy;
        _updateNewIndex();
        print('---- dragUpdateDetails:' + dragUpdate.toString());
      },
      onHorizontalDragEnd: (dragEnd) {
        _dragStatus = DragStatus.DragEnd;
        _updateNewIndex();
        print('---- dragEndDetails:' + dragEnd.toString());
      },
      onPanEnd: (panEndDetail) {
        print('---- panEndDetails:' + panEndDetail.toString());
      },
      child: Container(
        width: 5 * _coverSize,
        height: _coverSize,
        child: Stack(
          children: [
            Wrap(
              direction: wrap.direction,
              alignment: wrap.alignment,
              spacing: 0,
              runSpacing: 0,
              runAlignment: wrap.runAlignment,
              crossAxisAlignment: wrap.crossAxisAlignment,
              textDirection: wrap.textDirection,
              verticalDirection: wrap.verticalDirection,
              clipBehavior: wrap.clipBehavior,
              children: _showCoverDataList.map((cover) {
                if (cover.thumbData == null) return Container();
                return Container(
                  width: _coverSize,
                  height: _coverSize,
                  child: Stack(
                    children: [
                      FadeInImage(
                        fadeInDuration: const Duration(milliseconds: 400),
                        image: MemoryImage(cover.thumbData!),
                        fit: BoxFit.fill,
                        placeholder: MemoryImage(kTransparentImage),
                        width: _coverSize,
                        height: _coverSize,
                      ),
                      Builder(builder: (_) {
                        var subWidget = <Widget>[];
                        for (int i = 0; i < 6; i++) {
                          var globalKey = RectGetter.createGlobalKey();
                          _globalKeys.add(globalKey);
                          subWidget.add(RectGetter(
                              key: globalKey,
                              child: Container(
                                height: _coverSize,
                                width: _coverSize / 6,
                              )));
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: subWidget,
                        );
                      })
                    ],
                  ),
                );
              }).toList(),
            ),
            Builder(builder: (_) {
              return ValueListenableBuilder<CoverData?>(
                  valueListenable: widget.controller.selectedCoverNotifier,
                  builder: (context, selectedCover, __) {
                    if (selectedCover == null) return Container();
                    if (_totalCoverDataList == null) {
                      return Container();
                    } else if (_totalCoverDataList!.isEmpty) {
                      return Container();
                    }
                    var index = _totalCoverDataList!.indexOf(selectedCover);
                    var onFrameWidth = _coverSize / 6.0;
                    var left = onFrameWidth * index;
                    if (left < 0) {
                      left = 0;
                    } else if (left >= _coverSize * 4) {
                      left = _coverSize * 4;
                    }
                    return Positioned(
                      left: left,
                      child: Transform.scale(
                        scale: (_dragStatus == DragStatus.DragStart ||
                                _dragStatus == DragStatus.DragUpdate)
                            ? 1.1
                            : 1,
                        child: Container(
                          width: _coverSize,
                          height: _coverSize,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.w),
                              borderRadius: BorderRadius.circular(4.w)),
                          child: FadeInImage(
                            fadeInDuration: const Duration(milliseconds: 400),
                            image: MemoryImage(selectedCover.thumbData!),
                            fit: BoxFit.fill,
                            placeholder: MemoryImage(kTransparentImage),
                            width: _coverSize,
                            height: _coverSize,
                          ),
                        ),
                      ),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }

  void _updateNewIndex() {
    if (_dragStatus == DragStatus.DragStart ||
        _dragStatus == DragStatus.DragUpdate) {
      if (_globalKeys.isNotEmpty) {
        _globalKeys.forEach((gk) {
          var index = _globalKeys.indexOf(gk);
          var rect = RectGetter.getRectFromKey(gk);
          print('-----> cover index:$index rect :${rect.toString()}');
          print('-----> gx:$_dragX gy:$_dragY');
          if (rect != null) {
            var isContains = rect.contains(Offset(_dragX ?? 0, _dragY ?? 0));
            if (isContains) {
              print('-----> isContains index:$index');
              if (_totalCoverDataList != null &&
                  (_totalCoverDataList!.length > index)) {
                if (_selectIndex != index) {
                  var coverData = _totalCoverDataList![index];
                  widget.controller.updateSelectedCover(coverData);
                  _selectIndex = index;
                }
              }
            }
          }
        });
      }
    } else {
      if (mounted) setState(() {});
    }
  }
}

enum DragStatus { DragStart, DragUpdate, DragEnd }
