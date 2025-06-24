import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TopicText extends SpecialText {
  TopicText(TextStyle? textStyle, SpecialTextGestureTapCallback? onTap,
      {this.showAtBackground = false, this.start})
      : super(flag, ' ', textStyle, onTap: onTap);
  static const String flag = '#';
  final int? start;

  /// whether show background for @somebody
  final bool showAtBackground;
  // \s$：匹配字符串的结尾必须是一个空格。
  RegExp hashRegex = RegExp(r'^#(\S{0,64})\s$');
  @override
  InlineSpan finishText() {
    final String topicText = toString();
    // 确保 # 后有字符
    if (topicText.length > 2 &&
        topicText.endsWith(' ') &&
        hashRegex.hasMatch(topicText)) {
      return SpecialTextSpan(
          text: topicText,
          actualText: topicText,
          start: start!,
          style: textStyle,
          deleteAll: true,
          recognizer: (TapGestureRecognizer()
            ..onTap = () {
              if (onTap != null) {
                onTap!(topicText);
              }
            }));
    }
    // 如果不满足条件，返回普通文本
    return TextSpan(text: topicText);
  }
}
