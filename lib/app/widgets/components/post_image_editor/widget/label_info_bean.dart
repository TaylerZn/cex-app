import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/widgets/components/post_image_editor/widget/label_widget.dart';

class LabelInfoBean {
  double realXRatio = 0.0;
  double realYRatio = 0.0;
  int? nftIndex;
  String nftKey;

  ///标签大小
  late Size labelSize;

  ///图片大小，用于计算高比
  Size imgSize;

  ///标签名称
  String name;

  ///图片在容器的起点坐标
  Offset startOffset;
  Offset offset = Offset.zero;
  Offset lastOffset = Offset.zero;
  GlobalKey<LabelWidgetState> key = GlobalKey();

  LabelInfoBean(this.name,
      {this.startOffset = Offset.zero,
      this.imgSize = Size.zero,
      this.nftIndex = 0,
      this.nftKey = ''}) {
    offset = startOffset;
  }

  LabelWidgetState get state => key.currentState!;

  ///获取相对于容器左上角的offset
  Offset get relativeOffset => offset - startOffset;
}
