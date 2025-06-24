import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class VideoLoadingWidget extends StatefulWidget {
  VideoLoadingWidget({super.key});
  late VideoLoadingWidgetState? state;

  /// 加载视频loading
  void showVideoLoading({String? progress}) {
    if (state != null) {
      state!.showVideLoading(progress: progress);
    }
  }

  /// 关闭视频loading
  void dismissVideoLoading() {
    if (state != null) {
      state!.dismissVideoLoading();
    }
  }

  @override
  State<VideoLoadingWidget> createState() => state = VideoLoadingWidgetState();
}

class VideoLoadingWidgetState extends State<VideoLoadingWidget> {
  bool bufferEnd = true;
  String? progress;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !bufferEnd,
      child: Container(
        width: 80.w,
        child: Column(
          children: [
            CupertinoActivityIndicator(
              radius: 15.w,
              color: Colors.white,
            ),
            Visibility(
                visible: progress != null,
                child: Container(
                  margin: EdgeInsets.only(top: 20.w),
                  child: Text(
                    progress ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void showVideLoading({String? progress}) {
    bufferEnd = false;
    this.progress = progress;
    if (mounted) setState(() {});
  }

  void dismissVideoLoading() {
    bufferEnd = true;
    progress = null;
    if (mounted) setState(() {});
  }
}
