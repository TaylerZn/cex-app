//library flutter_telegram_login;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class TelegramLogin {
  String? _botId;
  String? _botDomain;
  Map<String, String> userData = {};

  TelegramLogin(botId, botDomain) {
    _botId = botId;
    _botDomain = botDomain;
  }

  Future<void> telegramLaunch() async {
    if (!await launchUrl(
      Uri.parse("https://t.me/+42777"),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch Telegram';
    }
  }

  Future<String> loginTelegram() async {
    String ans =
        "https://oauth.telegram.org/auth?bot_id=$_botId&origin=$_botDomain&embed=1&request_access=write&return_to=https://www-pre.tradevert.co/login";

    var res = await Get.toNamed(Routes.WEBVIEW, arguments: {'url': ans});
    print("+++---${json.decode(res)}");
    // {id: xxx, first_name: xxx, username: xxx, photo_url: xxx, auth_date: xxx, hash: xxx}
    if (res != null) {
      return json.decode(res)['id'].toString();
    } else {
      return "";
    }
  }
}
