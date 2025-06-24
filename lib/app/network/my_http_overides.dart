import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';

class MyHttpOverrides extends HttpOverrides {
  String? localhost;

  MyHttpOverrides({this.localhost});

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    var http = super.createHttpClient(context);

    if (localhost != null && localhost!.isNotEmpty) {
      http.findProxy = (uri) {
        return "PROXY $localhost";
      };

      http.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    }
    return http;
  }
}
