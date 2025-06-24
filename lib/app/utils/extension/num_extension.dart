import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

/// 安全数据组
extension SafeList<T> on List<T> {
  T? safe(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    }
    return null;
  }

  T? get safeLast {
    if (length > 0) {
      return this[length - 1];
    }
    return null;
  }

  T? get safeFirst {
    if (length > 0) {
      return this[0];
    }
    return null;
  }
}

extension IntX on int {
  /// 将正整数转换为指定小数点精度的 double 值。
  /// - [this] 是要转换的正整数，表示小数点后的位数。
  /// 返回值是转换后的 double 值。
  /// 如果输入不是非负整数，则抛出 [ArgumentError]。
  num toPrecision() {
    // 检查输入是否为非负整数
    if (this < 0) {
      throw ArgumentError('输入必须是非负整数');
    }

    // 处理特殊情况：当输入为 0 时，按照数学规则，1 / 10^0 应该返回 1.0
    if (this == 0) {
      return 1;
    }

    // 使用除法运算而不是 pow 函数来提高性能和准确性
    return 1.0 / pow(10, this);
  }
}

extension DoubleX on double {
  num toNum() {
    return num.parse(toString());
  }
}

extension DoubleExtension on double? {
  removeInvalidZero() {
    //去掉无效0
    return Decimal.parse('$this');
  }
}

extension DecimalX on Decimal {
  String toPrecision(int fractionDigits) {
    if (this == Decimal.zero) {
      return '0';
    }
    return toString().toNum().toPrecision(fractionDigits);
  }
}

extension NumFormat on num {
  /// 将数字格式化为指定小数位数的字符串。
  /// 1234.5678.toPrecision(2) => '1234.56'
  /// 2372.234.toPrecision(0) => '2372'
  /// 0.12345.toPrecision(4) => '0.1234'
  /// 12123.toPrecision(3) => '12123.000'
  String toPrecision(int fractionDigits) {
    num fac = pow(10, fractionDigits);
    num truncated = (this * fac).truncate() / fac;
    return truncated.toStringAsFixed(fractionDigits);
  }

  Decimal toDecimal() {
    return Decimal.parse(toString());
  }

  String formatOrderQuantity(int precision) {
    if (this <= 1) {
      return toPrecision(precision);
    } else if (this >= 0.001 && this < 1000) {
      return _formatDecimalWithDynamicPrecision(this);
    } else if (this >= 1000 && this < 1000000) {
      return _formatWithSuffix(this, 'k', 1000);
    } else if (this >= 1000000 && this < 1000000000) {
      return _formatWithSuffix(this, 'M', 1000000);
    } else if (this >= 1000000000 && this < 1000000000000) {
      return _formatWithSuffix(this, 'B', 1000000000);
    }
    return this.toPrecision(0);
  }

  String _formatDecimalWithDynamicPrecision(num num) {
    if (num < 10) {
      return num.toPrecision(3);
    } else if (num < 100) {
      return num.toPrecision(2);
    } else if (num < 1000) {
      return num.toPrecision(1);
    }
    return num.toPrecision(0);
  }

  String _formatWithSuffix(num quantity, String suffix, int divisor) {
    double newValue = quantity / divisor;
    String formattedValue;
    if (newValue < 10) {
      formattedValue = newValue.toPrecision(2);
    } else if (newValue < 100) {
      formattedValue = newValue.toPrecision(1);
    } else {
      formattedValue = newValue.toPrecision(0);
    }
    return formattedValue + suffix;
  }

  /// 小数点位数
  int numDecimalPlaces() {
    /// 返回小数点后有几位
    try {
      return toString().split('.')[1].length ?? 4;
    } catch (e) {
      return 0;
    }
  }

  /// 13232.123 -> 1.32w
  /// 10000 -> 1.00w
  String formatVolume() {
    return formatOrderQuantity(2);
  }

  // 123245.123 -> 123,245.12
  // 123.123 -> 123.12
  /// 0.23232 -> 0.2323
  String formatComma(int fractionDigits) {
    num fac = pow(10, fractionDigits);
    return ((this * fac).truncate() / fac).toString();
  }
}
