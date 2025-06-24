import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/basic/my_image.dart';

class HomeButtonWidget extends StatefulWidget {
  final bool selected;
  final Function(bool)? onTap;

  const HomeButtonWidget({super.key, this.selected = true, this.onTap});

  @override
  State<HomeButtonWidget> createState() => HomeButtonWidgetState();
}

class HomeButtonWidgetState extends State<HomeButtonWidget>
    with TickerProviderStateMixin {
  int current = 0;
  late final AnimationController animationController;
  LottieComposition? composition;
  bool isSendExpand = false;
  bool _show = true;

  @override
  void initState() {
    super.initState();
    loadLottieComposition();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))..forward();
    if(widget.selected) {
      changeMode(3);
    } else {
      changeMode(0);
    }
    // Future.delayed(Duration(milliseconds: 300)).then((value) {
    //   changeMode(3);
    // });
  }

  Future<void> loadLottieComposition() async {
    final bytes =
        await DefaultAssetBundle.of(Get.context!).load('assets/json/top.json');
    final compositionDate =
        await LottieComposition.fromBytes(bytes.buffer.asUint8List());

    composition = compositionDate;
    animationController.duration = composition?.duration;
    setState(() {});
  }

  void changeMode(int status) {
    print('status:$status');
    if (current == status) {
      return;
    }
    switch (status) {
      case 0:
        playAnimation(0, 0);
        break;
      case 1:
        playAnimation(30, 60);
        break;
      case 2:
        playAnimation(60, 80);
        break;
      case 3:
        playAnimation(0, 20);
        break;
    }
    current = status;
  }

  void playAnimation(int startFrame, int endFrame) {
    print('startFrame:$startFrame,$endFrame');
    if (composition == null) return;
    final frameCount = composition!.endFrame - composition!.startFrame;
    print('frameCount:$frameCount');
    final startProgress = startFrame / frameCount;
    final endProgress = endFrame / frameCount;
    animationController.animateTo(
      endProgress,
      duration: Duration(
          milliseconds: ((endProgress - startProgress) *
                  composition!.duration.inMilliseconds)
              .round()),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return     InkWell(onTap: (){

      widget.onTap?.call(current == 1);
    }, child:Lottie(
      width: 24.w,
      height: 24.w,
      composition: composition,
      controller: animationController,
    ));
  }

  @override
  void didUpdateWidget(covariant HomeButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.selected != widget.selected){
      if(widget.selected) {
        changeMode(3);
      }else{
        changeMode(0);
      }
    }
  }
}
