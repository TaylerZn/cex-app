import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/videoEditor_Getx.dart';
import 'package:nt_app_flutter/app/modules/community/video_cover/video_cover_selection.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:video_editor/domain/entities/cover_data.dart';
import 'package:video_editor/video_editor.dart';

//-------------------//
//VIDEO EDITOR SCREEN//
//-------------------//
class VideoEditorSetCoverPage extends StatefulWidget {
  final List<CoverData>? preCoverDataList;
  var videoFile;

  VideoEditorSetCoverPage({Key? key, this.preCoverDataList, this.videoFile});
  @override
  State<VideoEditorSetCoverPage> createState() =>
      _VideoEditorSetCoverPageState();
}

class _VideoEditorSetCoverPageState extends State<VideoEditorSetCoverPage>
    with TickerProviderStateMixin {
  final double height = 60;

  bool offstage = true;

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    animation = Tween(begin: 160.w, end: 0.0).animate(controller)
      ..addListener(() {
        // if (animation.status == AnimationStatus.dismissed &&
        //     animation.value == 0.0) {
        //   offstage = !offstage;
        // }
        setState(() => {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return GetBuilder<VideoEditorGetx>(builder: (videoEditorGetx) {
      return Scaffold(
        backgroundColor: AppColor.colorBlack,
        body: videoEditorGetx.controller!.initialized
            ? SafeArea(
                child: Column(
                  children: [
                    _topNavBar(),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: CoverViewer(
                                controller: videoEditorGetx.controller!),
                          ),
                          Container(
                            height: 70.w,
                            margin: EdgeInsets.symmetric(
                                vertical: 20.w, horizontal: 20.w),
                            child: Row(
                              children: [
                                VideoCoverSelection(
                                  controller: videoEditorGetx.controller!,
                                  quantity: 30,
                                  preCoverDataList: widget.preCoverDataList,
                                ),
                                Expanded(child: Container()),
                                _nextBtn(videoEditorGetx)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: loadingWidget()),
      );
    });
  }

  Widget _topNavBar() {
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 5.w),
                  child: MyImage(
                    'default/page_back'.svgAssets(),
                    width: 24.w,
                    height: 24.w,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _nextBtn(videoEditorGetx) {
    return MyButton(
      width: 62.w,
      height: 26.w,
      text: LocaleKeys.public3.tr,
      textStyle: AppTextStyle.f_12_400,
      color: AppColor.colorSuccess,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      border: Border.all(width: 1, color: AppColor.colorSuccess),
      onTap: () async {
        await videoEditorGetx.controller?.extractCover(
          onError: (e, s) {
            UIUtil.showToast('Error on video :(');
          },
          onCompleted: (cover) {
            EasyLoading.dismiss();
            Get.back(result: cover);
            // Get.to(
            //   PostIndexPage(
            //     videoFile: widget.videoFile,
            //     videoCoverFile: cover,
            //     isVideo: true,
            //   ),
            //   transition: Transition.cupertino,
            // );
          },
        );
      },
    );
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");
}

class loadingWidget extends StatefulWidget {
  const loadingWidget({super.key});

  @override
  State<loadingWidget> createState() => _loadingWidgetState();
}

class _loadingWidgetState extends State<loadingWidget>
    with TickerProviderStateMixin {
  var oneValue = 1 / 200;
  late final AnimationController _controller;
  late final AnimationController _twoController;
  var twoLoading = false;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this)
      ..value = oneValue * 85
      ..addListener(() {
        if (_controller.value >= oneValue * 200) {
          print('twoLoading=======');
          setState(() {
            twoLoading = true;
          });
          // _twoController.forward();
          _twoController.repeat(min: 0, max: 1);
          // print(_controller.value);
          // isOne = false;
          // var start = oneValue * 129;
          // var stop = oneValue * 200;
          // _controller.repeat(
          //     min: start,
          //     max: stop,
          //     // reverse: true,
          //     period: _controller.duration! * (stop - start));
        }
        // }
        setState(() {
          // Rebuild the widget at each frame to update the "progress" label.
        });
      });

    _twoController = AnimationController(vsync: this)
      ..value = oneValue
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: Column(children: [
              Lottie.asset(
                'assets/json/loading.json',
                width: 64.w,
                // height: 36.w,
                controller: _twoController,
                onLoaded: (composition) {
                  // print(composition.duration);
                  setState(() {
                    _twoController.duration = composition.duration;
                  });
                  _twoController.duration = composition.duration;
                },
              ),
            ])),
        twoLoading
            ? Container()
            : Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/json/loading.json',
                      controller: _controller,
                      width: 64.w,
                      // height: 28.w,
                      onLoaded: (composition) {
                        print(composition.duration);
                        setState(() {
                          _controller.duration = composition.duration;
                        });
                        _controller
                          ..duration = composition.duration
                          ..forward();
                      },
                    )
                  ],
                ),
              ),
      ],
    );
  }
}
