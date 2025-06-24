import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/preinit/pre_init.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/splash/bindings/splash_binding.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/components/easy_loading_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/smart_refresher_footer.dart';
import 'package:nt_app_flutter/app/widgets/components/smart_refresher_header.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app/cache/app_cache.dart';
import 'app/config/lang/translation_service.dart';
import 'app/config/theme/app_theme.dart';
import 'app/utils/lang_cache/lang_cache_manager.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver();

Future<void> main() async {
  configLoading();
  await PreInit.init();
  Locale locale = TranslationService.getInitLocale();
  Get.addPages(AppPages.routes);

  runApp(MyApp(
    locale: locale,
  ));
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..lineWidth = 0.0
    ..radius = 8.0
    ..backgroundColor = AppColor.colorEDEDED
    // ..maskColor = Color(0xffEDEDED)
    ..indicatorColor = AppColor.colorEDEDED
    // ..progressColor = Color(0xffEDEDED)
    ..textColor = AppColor.color111111
    ..userInteractions = false
    ..dismissOnTap = false
    ..progressWidth = 0.0
    ..boxShadow = []
    ..indicatorWidget = Column(
      children: [EasyLoadingWidget()],
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => RefreshConfiguration(
        // 配置下拉刷新
        headerBuilder: () => const SmartRefresherHeader(),
        footerBuilder: () => const SmartRefresherFooter(),
        child: GetMaterialApp(
          title: 'CEX',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          defaultTransition: Transition.noTransition,
          // 默认无转场动画（解决其他方向的转入动画，原页面bug）
          themeMode: (BoolKV.darkTheme.get() ?? false)
              ? ThemeMode.dark
              : ThemeMode.light,
          translationsKeys: AppTranslation.translations,
          localizationsDelegates: const [
            RefreshLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LangCacheManager.supportLocals,
          locale: locale,
          fallbackLocale: TranslationService.fallbackLocale,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          // 自定义转场动画
          // defaultTransition: Transition.noTransition, // 默认无转场动画
          initialBinding: SplashBinding(),
          enableLog: kDebugMode,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.noScaling,
              ),
              child: FlutterEasyLoading(
                child: Intro(
                  child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: child!),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
