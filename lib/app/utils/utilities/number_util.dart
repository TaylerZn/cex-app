import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

//大于3位数,分割 例如 1230.22 = 1,230.22
class NumberUtil {
// count 保留多少位小数（不传默认清除多余0，如果小数点后为0并展示两位小数）
// isEyeHide 是否跟随 统一隐藏资产小眼睛
// isRate 是否进行汇率计算 法币价格
// front 前拼接
// behind 后拼接
// isTruncate, // 舍位处理,是否四舍五入

  static String mConvert(
    dynamic number, {
    int? count,
    bool isEyeHide = false,
    IsRateEnum? isRate,
    bool isShowLogo = true,
    String front = '',
    String behind = '',
    bool isTruncate = false,
  }) {
    try {
      if (!AssetsGetx.to.isEyesOpen && isEyeHide == true) {
        return '******';
      }
      if (number == null || (number is String && number.isEmpty)) {
        return '--';
      }
      if (number is! String) number = number.toString();

      Decimal d = Decimal.parse(number);
      String rateLogo = '';
      String rateCoin = '';
      if (isShowLogo) {
        rateLogo = isRate != null ? AssetsGetx.to.rateLogo : '';
        rateCoin = isRate != null ? AssetsGetx.to.rateCoin : '';
      }
      if (d == Decimal.zero) {
        return '$rateLogo${front}0${count != null ? ".${"0" * count}" : ".00"}${rateLogo.isEmpty && rateCoin.isNotEmpty ? ' $rateCoin' : ''}';
      }

      // 如果isRate不为null，则乘以isRate.price
      if (isRate != null) {
        d = d * isRate.price;
      }

      var formattedNumber = d.toString();

      // 先判断是否截断，再判断count
      if (isTruncate) {
        if (count != null) {
          var dotIndex = formattedNumber.indexOf('.');
          if (dotIndex != -1) {
            // 小数点后的字符数
            int decimalsCount = formattedNumber.length - dotIndex - 1;
            // 如果小数点后的字符数少于所需位数，则补零
            if (decimalsCount < count) {
              formattedNumber += '0' * (count - decimalsCount);
            }
            // 如果小数点后的字符数多于所需位数，则截断
            else if (decimalsCount > count) {
              formattedNumber =
                  formattedNumber.substring(0, dotIndex + count + 1);
            }
          } else {
            // 不存在小数点，添加并根据 count 添加��
            formattedNumber += '.${List.filled(count, '0').join('')}';
          }
        }
      } else {
        if (count != null) {
          formattedNumber = d.toPrecision(count);
        } else {
          // 尾随零管理：截断所有零，同时保留必要的小数点和非零小数位，如果结果是整数则添加两个零
          formattedNumber =
              formattedNumber.replaceAll(RegExp(r'(?<=\..*?)0+$'), '');
          if (formattedNumber.endsWith('.')) {
            formattedNumber = "${formattedNumber}00";
          } else if (!formattedNumber.contains('.')) {
            formattedNumber = "$formattedNumber.00";
          }
        }
      }

      var negative = '';
      if (formattedNumber.startsWith('-')) {
        formattedNumber = formattedNumber.substring(1);
        negative = '-';
      }

      var parts = formattedNumber.split('.');
      var integerPart = parts[0];
      var decimalPart = parts.length > 1 ? parts[1] : '';

      var result = '';
      for (var i = integerPart.length; i > 0; i -= 3) {
        var start = i - 3 > 0 ? i - 3 : 0;
        result = integerPart.substring(start, i) +
            (result.isEmpty ? '' : ',') +
            result;
      }
      String amount = (rateLogo +
              front +
              negative +
              result +
              (decimalPart.isNotEmpty ? '.$decimalPart' : '') +
              behind)
          .stringSplit();
      return amount;
    } catch (e) {
      return '';
    }
  }

  static String format(String number, {int? count}) {
    if (number.isNotEmpty && number.toDouble() > 0) {
      var coin = AssetsGetx.to.rateLogo;
      var resClose =
          number.toDouble() * double.parse(AssetsGetx.to.rateUsdtPrice);
      return '$coin${getPrice(resClose, count ?? 4)}';
    } else {
      return '--';
    }
  }

  static String getPrice(num price, num d) {
    if(d == 0) {
      return NumberFormat("#,##0", "en_US").format(price);
    }
    String f = List<String>.generate(d.toInt(), (int index) => '0').join();
    return NumberFormat("#,##0.$f", "en_US").format(price);
  }
}

// 一.小数点前有有效小数
// 1.小数点前有两位以上有效数字，保留2位小数
// 2.小数点前有两位有效数字，保留3位小数
// 3.小数点前有一位有效数字，保留4位小数
// 二.小数点前没有有效数字
// 1. 默认展示6位小数
// 2. 如果6位小数内有效数字小于2个，则展示8位小数
// 待确认
