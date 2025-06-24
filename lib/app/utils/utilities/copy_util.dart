import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CopyUtil {
  //复制内容
  static copyText(String content) {
    try {
      ClipboardData data = ClipboardData(text: content);
      Clipboard.setData(data);
      UIUtil.showSuccess(LocaleKeys.public30.tr);
    } catch (e) {
      UIUtil.showError(LocaleKeys.public31.tr);
    }
  }

  //获取粘贴板内容
  static getText({int? amount}) async {
    var clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null && clipboardData.text != null) {
      String text = clipboardData.text!;
      // 限制内容长度不超过某个长度
      if (amount != null && text.length > amount) {
        text = text.substring(0, amount);
      }
      return text;
    } else {
      UIUtil.showToast(LocaleKeys.user218.tr);
    }
  }
}
