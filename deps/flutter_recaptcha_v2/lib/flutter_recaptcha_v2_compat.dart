library flutter_recaptcha_v2_compat_compat;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class RecaptchaV2 extends StatefulWidget {
  final String apiKey;
  final String apiSecret;
  final String pluginURL = "https://recaptcha-flutter-plugin.firebaseapp.com/";
  final RecaptchaV2Controller controller;

  final ValueChanged<bool>? onVerifiedSuccessfully;
  final ValueChanged<String>? onVerifiedError;

  RecaptchaV2({
    required this.apiKey,
    required this.apiSecret,
    required this.controller,
    this.onVerifiedSuccessfully,
    this.onVerifiedError,
  });

  @override
  State<StatefulWidget> createState() => _RecaptchaV2State();
}

class _RecaptchaV2State extends State<RecaptchaV2> {
  late RecaptchaV2Controller controller;
  late WebViewController webViewController;

  void verifyToken(String token) async {
    String url = "https://www.google.com/recaptcha/api/siteverify";
    http.Response response = await http.post(Uri.parse(url), body: {
      "secret": widget.apiSecret,
      "response": token,
    });

    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if (json['success']) {
        widget.onVerifiedSuccessfully?.call(true);
      } else {
        widget.onVerifiedSuccessfully?.call(false);
        widget.onVerifiedError?.call(json['error-codes'].toString());
      }
    }

    // hide captcha
    controller.hide();
  }

  void onListen() {
    if (controller.visible) {
      webViewController.clearCache();
      webViewController.reload();
    }
    setState(() {
      controller.visible;
    });
  }

  @override
  void initState() {
    controller = widget.controller;
    controller.addListener(onListen);
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..addJavaScriptChannel(
        'RecaptchaFlutterChannel',
        onMessageReceived: (JavaScriptMessage receiver) {
          String _token = receiver.message;
          if (_token.contains("verify")) {
            _token = _token.substring(7);
          }
          verifyToken(_token);
        },
      )
      ..loadRequest(Uri.parse("${widget.pluginURL}?api_key=${widget.apiKey}"));
  }

  @override
  void didUpdateWidget(RecaptchaV2 oldWidget) {
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(onListen);
      controller = widget.controller;
      controller.removeListener(onListen);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(onListen);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.visible
        ? Stack(
            children: <Widget>[
              WebViewWidget(controller: webViewController),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          child: Text("CANCEL RECAPTCHA"),
                          onPressed: () {
                            controller.hide();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}

class RecaptchaV2Controller extends ChangeNotifier {
  bool isDisposed = false;
  List<VoidCallback> _listeners = [];

  bool _visible = false;
  bool get visible => _visible;

  void show() {
    _visible = true;
    if (!isDisposed) notifyListeners();
  }

  void hide() {
    _visible = false;
    if (!isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _listeners = [];
    isDisposed = true;
    super.dispose();
  }

  @override
  void addListener(listener) {
    _listeners.add(listener);
    super.addListener(listener);
  }

  @override
  void removeListener(listener) {
    _listeners.remove(listener);
    super.removeListener(listener);
  }
}
