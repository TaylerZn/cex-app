import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageController extends GetxController {
  String title;
  String url;

  WebPageController({required this.url, this.title = ''});
  late WebViewController controller;

  var progress = 0.obs;
  var barTitle = ''.obs;
  RxBool isLoading = true.obs;
  final key = UniqueKey();

  @override
  void onInit() {
    url = validateAndFixUrl(url);
    if (url.isNotEmpty) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) async {
              this.progress.value = progress;
              if (progress == 100 && (title).isEmpty) {
                var webTitle = await controller.getTitle();
                barTitle.value = webTitle ?? '';
              }
            },
            onWebResourceError: (WebResourceError error) {
              print('progress error --- ${error.description}');
            },
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onPageFinished: (url) {
              isLoading.value = false;
              try {
                final pattern = RegExp(r'#tgAuthResult=(.+)');
                final match = pattern.firstMatch(url);
                if (match != null) {
                  final authResult = match.group(1);
                  // 确保字符串长度为4的倍数
                  final paddedBase64String = authResult!
                      .padRight((authResult.length + 3) ~/ 4 * 4, '=');
                  final decodedBytes = base64Url.decode(paddedBase64String);
                  final decodedString = utf8.decode(decodedBytes);
                  Get.back(result: decodedString);
                }
              } catch (e) {
                AppLogUtil.e(e);
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    } else {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) async {
              this.progress.value = progress;
              if (progress == 100 && (title).isEmpty) {
                var webTitle = await controller.getTitle();
                barTitle.value = webTitle ?? '';
              }
            },
            onWebResourceError: (WebResourceError error) {
              print('progress error --- ${error.description}');
            },
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onPageFinished: (url) {
              isLoading.value = false;
            },
          ),
        );
    }

    if ((title).isNotEmpty) {
      barTitle.value = title;
    }
    super.onInit();
  }

  String validateAndFixUrl(String url) {
    if (!url.startsWith(RegExp(r'https?://'))) {
      url = 'http://$url';
    }
    return Uri.tryParse(url)?.toString() ?? '';
  }
}
