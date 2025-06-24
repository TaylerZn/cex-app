import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';

class MyImage extends StatelessWidget {
  final String image;
  double? width;
  double? height;
  final Color? color;
  final BoxFit fit;
  final bool isTransparent;
  final bool enableSlideOutPage;
  final bool isDefaultSize;
  final LoadStateChanged? loadStateChanged;
  final double? radius;
  final VoidCallback? onTap;

  MyImage(
    this.image, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.isTransparent = false,
    this.loadStateChanged,
    this.enableSlideOutPage = false,
    this.isDefaultSize = false,
    this.radius,
    this.onTap,
  }) {
    if (isDefaultSize == true) {
      height = height != null && width != null
          ? getImageSize(Get.width / width!, height)
          : null;
      width = Get.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        clipBehavior: Clip.antiAlias,
        child: _body(),
      ),
    );
  }

  Widget _body() {
    if (image.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
          color: color,
        ),
      );
    } else {
      if (image.endsWith('.svg')) {
        if (image.contains('assets/images')) {
          return SvgPicture.asset(
            image,
            width: width,
            height: height,
            fit: fit,
            color: color,
          );
        } else {
          return SvgPicture.network(
            image,
            width: width,
            height: height,
            fit: fit,
            color: color,
            placeholderBuilder: (BuildContext context) => Lottie.asset(
              'assets/json/image_loading.json',
              fit: BoxFit.fill,
            ),
          );
        }
      } else if (image.startsWith('http')) {
        return ExtendedImage.network(
          image,
          cache: true,
          width: width,
          height: height,
          enableSlideOutPage: enableSlideOutPage,
          clearMemoryCacheWhenDispose: true,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: (state) {
            return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: false,
              cacheGesture: false,
            );
          },
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return Lottie.asset(
                  'assets/json/image_loading.json',
                  fit: BoxFit.fill,
                );

              case LoadState.failed:
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.colorF5F5F5,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/assets/network_error_light.svg',
                      width: width,
                      height: height,
                      fit: fit,
                    ),
                  ),
                  onTap: () {
                    state.reLoadImage();
                  },
                );
              case LoadState.completed:
                return ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  // width: width,
                  // height: height,
                  fit: fit,
                );
            }
          },
          fit: fit,
        );
      } else {
        if (image.contains('assets/images')) {
          return Image.asset(
            image,
            width: width,
            height: height,
            fit: fit,
          );
        } else {
          return const SizedBox();
        }
      }
    }
  }

  double? getImageSize(ratio, size) {
    if (ratio != null) {
      return size * ratio;
    } else {
      return 0.0;
    }
  }
}
