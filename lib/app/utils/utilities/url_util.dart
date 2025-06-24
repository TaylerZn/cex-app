import 'package:url_launcher/url_launcher.dart';

class MyUrlUtil {
  //打开外部浏览器
  static openUrl(String url) async {
    Uri uriParse = Uri.parse(url);
    if (await canLaunchUrl(uriParse)) {
      await launchUrl(uriParse, mode: LaunchMode.externalApplication);
    }
  }

  static String adaptiveScheme(String? url) {
    if (url == null) {
      return '';
    }
    if (url.startsWith('//')) {
      return "http:${url}";
    } else {
      return url;
    }
  }

  static Map<String, dynamic>? parseParameters(String? url) {
    if (url != null && url != '') {
      var tempList = url.split('?');
      if (tempList.length == 2) {
        var atString = tempList.last;
        if (atString.contains('&')) {
          var subTempList = atString.split('&');
          var resultMap = <String, dynamic>{};
          subTempList.forEach((parameterStr) {
            if (parameterStr.contains('=')) {
              var paramList = parameterStr.split('=');
              if (paramList.length == 2) {
                resultMap['${paramList.first}'] = paramList.last;
              }
            }
          });
          if (resultMap.isNotEmpty) {
            return resultMap;
          }
        }
      }
    }
    return null;
  }
}
