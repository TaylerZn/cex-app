import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/widgets/no/network_error_widget.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:get/get.dart';

enum MyLoadingStatus {
  loading,
  success,
  empty,
  error,
}

class MyPageLoadingController extends GetxController {
  var status = MyLoadingStatus.loading.obs;

  bool get isSuccess => status.value == MyLoadingStatus.success;
  bool get isEmpty => status.value == MyLoadingStatus.empty;
  bool get isLoading => status.value == MyLoadingStatus.loading;
  bool get isError => status.value == MyLoadingStatus.error;

  late VoidCallback? onRetryRefresh;

  /// 重试
  void setOnRetryRefresh(VoidCallback refreshCallback) {
    onRetryRefresh = refreshCallback;
  }

  void setLoading() {
    status.value = MyLoadingStatus.loading;
  }

  void setSuccess() {
    status.value = MyLoadingStatus.success;
  }

  void setEmpty() {
    status.value = MyLoadingStatus.empty;
  }

  void setError() {
    status.value = MyLoadingStatus.error;
  }
}

class MyPageLoading extends StatelessWidget {
  final MyPageLoadingController controller;
  final Widget? onLoading;
  final Widget body;
  final Widget? onEmpty;
  final Widget? onError;
  final double? loadingSize;

  const MyPageLoading({
    super.key,
    required this.controller,
    this.onLoading,
    required this.body,
    this.onEmpty,
    this.onError,
    this.loadingSize,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return onLoading ??
            Center(
              child: Lottie.asset(
                'assets/json/loading.json',
                repeat: true,
                width: loadingSize ?? 42.w,
                height: loadingSize ?? 42.w,
              ),
            );
      } else if (controller.isSuccess) {
        return body;
      } else if (controller.isError) {
        return onError ?? noDataWidget(context, text: '发生了某种错误');
      } else {
        return onEmpty ?? noDataWidget(context);
      }
    });
  }
}
