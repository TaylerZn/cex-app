import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:intl/intl.dart';
/// 字符串扩展方法
extension StringX on String {
  /// 将数字格式化为指定小数位数的字符串。
  /// '1234.5678'.toPrecision(2) => '1234.56'
  /// '2372.234'.toPrecision(0) => '2372'
  /// '0.12345'.toPrecision(4) => '0.1234'
  /// '12123'.toPrecision(3) => '12123.000'
  /// '1234.5678'.toPrecision(2) => '1234.56'
  /// '2372.234'.toPrecision(0) => '2372'
  String toPrecision(int fractionDigits) {
    return num.tryParse(this)?.toPrecision(fractionDigits) ?? this;
  }


  String toThousands(){
   NumberFormat format = NumberFormat('#,##,000');
   return format.format(int.parse(this));
  }

  removeInvalidZero(){//去掉无效0
    return Decimal.parse(this);
  }

  /// 字符串中只允许有个.
  String formatDot() {
    if (contains('.')) {
      var strList = split('.');
      if (strList.length > 2) {
        return '${strList[0]}.${strList[1]}';
      }
    }
    return this;
  }

  double toDouble() {
    return toNum().toDouble() ?? 0.0;
  }

  int toInt() {
    return toNum().toInt() ?? 0;
  }

  num toNum() {
    return num.tryParse(this) ?? 0;
  }

  Decimal toDecimal() {
    return Decimal.tryParse(this) ?? Decimal.zero;
  }

  String toFixed(int length) {
    return num.tryParse(this)?.toStringAsFixed(length) ?? this;
  }

  String pngAssets() {
    return "assets/images/$this.png";
  }

  String svgAssets() {
    return "assets/images/$this.svg";
  }

  // 缩短钱包地址长度
  String walletAddress({int? start, int? end}) {
    if (isNotEmpty) {
      return "${substring(0, start ?? 6)}...${substring(length - (end ?? 6), this.length)}";
    } else {
      return '--';
    }
  }

  String stringSplit() {
    return Characters(this).join('\u{200B}');
  }

  String commentSplit() {
    if (endsWith('\n')) {
      // 如果字符串以 \n 结尾，则移除它
      return substring(0, length - 1);
    }
    return Characters(this).join('\u{200B}');
  }

  String formatSymbol([String replace = '']) {
    return replaceAll('-', replace);
  }

  /// 币对 第一个
  String symbolFirst() {
    return split('-').safeFirst ?? '-';
  }

  /// 币对 第二个
  String symbolLast() {
    return split('-').safeLast ?? '-';
  }


  // 手机、邮箱脱敏
  String accountMask() {
    // 检查是否已经脱敏，如果是则直接返回
    if (contains('*')) {
      return this;
    }

    if (contains('@')) {
      // 邮箱脱敏处理
      List<String> parts = split('@');
      String username = parts[0];
      String domain = parts[1];

      // 用户名脱敏处理
      if (username.length > 4) {
        return '${username[0]}****${username[username.length - 1]}@$domain';
      } else if (username.length == 3) {
        return '${username[0]}*${username[2]}@$domain';
      } else if (username.length == 2) {
        return '${username[0]}*@$domain';
      } else if (username.length == 1) {
        return '${username[0]}*@$domain';
      } else {
        return this;
      }
    } else {
      // 手机号码脱敏处理
      if (startsWith('+')) {
        // 提取国际区号和号码
        int countryCodeEndIndex = indexOf(' ') + 1;
        String countryCode = substring(0, countryCodeEndIndex);
        String numberPart = substring(countryCodeEndIndex);

        // 根据号码长度进行脱敏处理
        if (numberPart.length > 7) {
          return '$countryCode${numberPart.substring(0, 3)}***${numberPart.substring(numberPart.length - 4)}';
        } else if (numberPart.length > 2) {
          return '$countryCode ${numberPart.substring(0, 2)}**${numberPart.substring(numberPart.length - 2)}';
        } else {
          return this;
        }
      } else {
        // 不包含国际区号的情况
        if (length > 7) {
          return '${substring(0, 3)}***${substring(length - 4)}';
        } else if (length > 2) {
          return '${substring(0, 2)}**${substring(length - 2)}';
        } else {
          return this;
        }
      }
    }
  }
}
