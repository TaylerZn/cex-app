import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/common/model/pic_swiper_item.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/common/widget/pic_swiper.dart';

class ImageSelectionWidget extends StatelessWidget {
  final int? index;
  final String imgPath;
  final Function? onDelete;
  const ImageSelectionWidget({required this.imgPath, this.index, this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      child: Container(
        width: 64.w,
        height: 64.w,
        child: Stack(
          children: [
            Positioned.fill(child: InkWell(onTap: (){
              viewImage();
            },child: Image.file(
              File(imgPath),
              fit: BoxFit.cover,
            ))),
            Positioned(
              right: 0.w,
              top: 0.h,
              child: InkWell(
                child: Padding(
                    padding:
                    EdgeInsets.all(4.w),
                    child: Row(
                      children: [
                        Container(
                          width: 14.w,
                          height: 14.w,
                          padding:
                          EdgeInsets.all(
                              3.w),
                          decoration: BoxDecoration(
                              color: AppColor
                                  .color111111
                                  .withOpacity(
                                  0.4),
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  6.r)),
                          child: MyImage(
                            'default/close'
                                .svgAssets(),
                            color:
                            Colors.white,
                            width: 9.w,
                          ),
                        )
                      ],
                    )),
                onTap: (){
                  onDelete?.call();

                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void viewImage(){
    Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: PicSwiper(
            isImageFile: true,
            index: index,
            pics: [
              imgPath
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
