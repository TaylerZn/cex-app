import 'dart:async';
import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:images_picker/images_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/permission_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

class MyScanView extends StatefulWidget {
  @override
  _MyScanViewState createState() => _MyScanViewState();
}

class _MyScanViewState extends State<MyScanView> with SingleTickerProviderStateMixin {
  StateSetter? stateSetter;
  IconData lightIcon = Icons.flash_on;
  QRViewController? scanControl;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late AnimationController animationController;
  late Animation<Offset> animation;
  StreamSubscription<Barcode>? streamSubscription;

  @override
  void reassemble() {
    super.reassemble();
    // if (Platform.isAndroid) {
    //   scanControl!.pauseCamera();
    // }
    scanControl!.resumeCamera();
  }

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2500), vsync: this);
    animation = Tween(begin: const Offset(0, 0), end: const Offset(0, 16)).animate(animationController);
    if (animationController.isCompleted || animationController.isDismissed) {
      animationController.repeat(); //动画开始执行
    }
    super.initState();
  }

  void getResult(String? result) async {
    print('扫码结果----$result');
    if (result != null) {
      streamSubscription?.cancel();
      scanControl!.stopCamera();
      Get.back(result: result);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    scanControl!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        color: SystemColor.white,
        child: Scaffold(
          body: Stack(children: [
            QRView(
              onQRViewCreated: _onQRViewCreated,
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
              key: qrKey,
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top + 60.w, //负的在屏幕外面
                child: Container(
                    alignment: Alignment.topCenter,
                    child: SlideTransition(
                        //平移控件
                        position: animation,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                          child: MyImage(
                            'default/scan_bg'.pngAssets(),
                            width: 343.w,
                          ),
                        )))),
            Positioned(
              child: Container(
                  // backgroundColor: Colors.transparent,
                  // centerTitle: true,
                  // elevation: 0.0,
                  height: 90.w,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff000000), Color(0x00000000)])),
                  padding: EdgeInsets.only(bottom: 16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MyPageBackWidget(
                        backColor: AppColor.colorWhite,
                      ),
                      Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () async {
                          ImagePicker _picker = ImagePicker();

                          if (await requestPhotosPermission()) {
                            var res = await _picker.pickImage(source: ImageSource.gallery);
                            if (res != null) {
                              var result = await Scan.parse(res.path);
                              if (result != null) {
                                getResult(result);
                              } else {
                                UIUtil.showToast(LocaleKeys.other46.tr);
                              }
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(4.w, 4.w, 16.w, 0.w),
                          child: Text(
                            LocaleKeys.other47.tr,
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ]),
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      scanControl = controller;
    });

    streamSubscription = controller.scannedDataStream.listen((scanData) {
      getResult(scanData.code);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
