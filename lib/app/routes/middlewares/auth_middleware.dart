import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';

/// AuthMiddleware 中间件
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!UserGetx.to.isLogin) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    return null;
  }
}
