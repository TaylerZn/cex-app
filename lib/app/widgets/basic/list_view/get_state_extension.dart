import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/no/network_error_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/locales.g.dart';
import '../../no/loading_widget.dart';
import '../../no/no_data.dart';

extension GetStateExtension<T> on StateMixin<T> {
  /// 页面状态
  /// [widget] 页面构建
  /// [onLoading] 加载中
  /// [onError] 错误
  /// [onEmpty] 空数据
  /// [onRetryRefresh] 重试回调
  Widget pageObx(NotifierBuilder<T?> widget,
      {Widget? onLoading,
      Widget Function(String)? onError,
      Widget? onEmpty,
      VoidCallback? onRetryRefresh}) {
    return SimpleBuilder(builder: (_) {
      /// 加载中
      if (status.isLoading) {
        return onLoading ?? const Center(child: LoadingWidget());
      }
      /// 错误重试
      if (status.isError) {
        return onError != null
            ? onError(status.errorMessage ?? LocaleKeys.public55.tr)
            : Center(
                child: NetworkErrorWidget(
                  onTap: onRetryRefresh ?? () => {},
                ),
              );
      }
      /// 空数据
      if (status.isEmpty) {
        return onEmpty ??
            noDataWidget(
              Get.context,
              text: LocaleKeys.public8.tr,
            ); // Also can be widget(null); but is risky
      }
      /// 成功
      return widget(value);
    });
  }
}
