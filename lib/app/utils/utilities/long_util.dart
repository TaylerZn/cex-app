// <必传>data（String?）要处理的数据
// <可选>decimalPlaces（int） K、M、B的位数
// <可选>showZero（bool） 为0时是否展示数据，（默认-不展示）
class MyLongDataUtil {
  static String convert(dynamic data,
      {int decimalPlaces = 1, bool showZero = false}) {
    if (data == null) {
      return '';
    }
    try {
      double dataValue = double.parse('$data');

      // 如果数值为0且showZero为false，则返回空字符串
      if (dataValue == 0 && !showZero) {
        return '';
      }

      // 使用四舍五入保留一位小数
      String formatNumber(double value, String suffix) {
        return '${value.toStringAsFixed(decimalPlaces)}$suffix';
      }

      if (dataValue >= 1000 && dataValue < 1000000) {
        // K: Thousand (千)
        return formatNumber(dataValue / 1000, 'K');
      } else if (dataValue >= 1000000 && dataValue < 1000000000) {
        // M: Million (百万)
        return formatNumber(dataValue / 1000000, 'M');
      } else if (dataValue >= 1000000000) {
        // B: Billion (十亿)
        return formatNumber(dataValue / 1000000000, 'B');
      } else {
        // 小于 1000 的直接显示整数
        return dataValue.toInt().toString();
      }
    } catch (e) {
      return '$data';
    }
  }
}

