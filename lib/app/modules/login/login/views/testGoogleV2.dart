import 'package:flutter/material.dart';
import 'package:flutter_recaptcha_v2_compat/flutter_recaptcha_v2_compat.dart';

class testGoogleV2 extends StatefulWidget {
  testGoogleV2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _testGoogleV2State createState() => _testGoogleV2State();
}

class _testGoogleV2State extends State<testGoogleV2> {
  String verifyResult = "";

  RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      recaptchaV2Controller.show(); // 自动触发 reCAPTCHA
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("SHOW ReCAPTCHA"),
                  onPressed: () {
                    recaptchaV2Controller.show();
                  },
                ),
                Text(verifyResult),
              ],
            ),
          ),
          RecaptchaV2(
            apiKey: "6LcyLx0qAAAAADdrChRCWdMndQYjaA5dnxy0CgSU",
            apiSecret: "6LcyLx0qAAAAAAURjaSsCgh5YRO-CT1yhXTNC3yY",
            controller: recaptchaV2Controller,
            onVerifiedError: (err) {
              print(err);
            },
            onVerifiedSuccessfully: (success) {
              setState(() {
                if (success) {
                  verifyResult = "You've been verified successfully.";
                } else {
                  verifyResult = "Failed to verify.";
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
