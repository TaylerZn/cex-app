import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/widgets/components/community/text/coin_text.dart';
import 'package:nt_app_flutter/app/widgets/components/community/text/topic_text.dart';

import 'at_text.dart';

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  MySpecialTextSpanBuilder(
      {this.showAtBackground = false, this.defaultTextStyle});

  /// whether show background for @somebody
  final bool showAtBackground;
  final TextStyle? defaultTextStyle;

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      int? index}) {
    if (flag == '') {
      return null;
    }
    if (validateText(flag)) {
      return null;
    }
    print('textSpan-flag - $flag');

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, AtText.flag)) {
      return AtText(
        defaultTextStyle ?? textStyle,
        onTap,
        start: index! - (AtText.flag.length - 1),
        showAtBackground: showAtBackground,
      );
    }

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, PostCoinText.flag)) {
      return PostCoinText(
        defaultTextStyle ?? textStyle,
        onTap,
        start: index! - (PostCoinText.flag.length - 1),
        showAtBackground: showAtBackground,
      );
    }

    if (isStart(flag, TopicText.flag)) {
      return TopicText(
        defaultTextStyle ?? textStyle,
        onTap,
        start: index! - (TopicText.flag.length - 1),
        showAtBackground: showAtBackground,
      );
    }
    //  else if (isStart(flag, EmojiText.flag)) {
    //   return EmojiText(textStyle!, start: index! - (EmojiText.flag.length - 1));
    // } else if (isStart(flag, DollarText.flag)) {
    //   return DollarText(textStyle!, onTap,
    //       start: index! - (DollarText.flag.length - 1));
    // }
    return null;
  }

  // 识别为何种文本（@、#、币种、普通）
  bool validateText(String text) {
    // 找到最后一个符号的位置
    int lastAtIndex = text.lastIndexOf('[25738CEBDAC49C49{');
    int lastHashIndex = text.lastIndexOf('#');
    int lastCoinIndex = text.lastIndexOf('[0f250d4882f9ebb9{');

    if (lastCoinIndex > lastAtIndex && lastCoinIndex > lastHashIndex) {
      // 匹配标识 币种 [0f250d4882f9ebb9{ 之后的文本
      String bracketText = text.substring(lastCoinIndex);
      // RegExp bracketRegex = RegExp(r'^\[0f250d4882f9ebb9\{\S*\]$');
      RegExp bracketRegex = RegExp(r'^\[0f250d4882f9ebb9{(\S{0,30})$');
      if (bracketRegex.hasMatch(bracketText)) {
        // print('识别textSpan- 币种 Text');
        return false;
      }
    } else if (lastAtIndex > lastHashIndex) {
      // 只匹配最后一个 @ 符号之后的文本
      String atText = text.substring(lastAtIndex);
      RegExp atRegex = RegExp(r'^\[25738CEBDAC49C49{(\S{0,10})$');
      if (atRegex.hasMatch(atText)) {
        // print('识别textSpan- 艾特 Text');
        return false;
      }
    } else if (lastHashIndex > lastAtIndex) {
      // 只匹配最后一个 # 符号之后的文本
      String hashText = text.substring(lastHashIndex);
      RegExp hashRegex = RegExp(r'^#(\S{0,64})$');
      if (hashRegex.hasMatch(hashText)) {
        // print('识别textSpan- 话题 Text');
        return false;
      }
    }

    // 如果没有匹配到 @、# 或标识
    // print('peyton- 普通 Text');
    return true;
  }
}
