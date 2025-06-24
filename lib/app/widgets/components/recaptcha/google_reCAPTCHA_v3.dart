import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gcaptcha_v3/recaptca_config.dart';
import 'package:flutter_gcaptcha_v3/web_view.dart';
import 'package:get/get.dart';

class GoogleReCAPTCHAv3View extends StatefulWidget {
  final String siteKey;
  const GoogleReCAPTCHAv3View({super.key, required this.siteKey});

  @override
  _GoogleReCAPTCHAv3ViewState createState() => _GoogleReCAPTCHAv3ViewState();
}

class _GoogleReCAPTCHAv3ViewState extends State<GoogleReCAPTCHAv3View> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    RecaptchaHandler.instance.setupSiteKey(dataSiteKey: widget.siteKey);
    print(widget.siteKey);
    // 添加10秒后返回的逻辑
    _timer = Timer(const Duration(seconds: 30), () {
      if (mounted) {
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // https://static.uptx.com/google-recaptcha/google_recaptcha_v2.html
    return Opacity(
      opacity: 0,
      child: IgnorePointer(
        ignoring: true,
        child: ReCaptchaWebView(
          width: double.maxFinite,
          height: 200,
          onTokenReceived: _onTokenReceived,
          url:
              'https://static.uptx.com/google-recaptcha/recaptcha.html?siteKey=${widget.siteKey}',
        ),
      ),
    );
  }

  _onTokenReceived(String token) {
    log("CAPTCHA TOKEN===> $token");
    if (mounted) {
      _timer?.cancel();
      Get.back(result: token);
    }
  }
}
