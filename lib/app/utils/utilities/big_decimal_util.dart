import 'dart:math';

import 'package:decimal/decimal.dart';

class BigDecimalUtil {
  static String canBuyStr({
    required bool isOpen,
    required bool isLimit, // Currently not used
    required bool isForward,
    required String price,
    required String parValue,
    required String canUseAmount,
    required String canCloseVolume,
    required String nowLevel,
    required String rate,
    required int scale,
    required String unit,
  }) {
    final defaultStr = "0.00 $unit";
    final parValueBig = Decimal.parse(parValue);
    final canCloseVolumeBig = Decimal.parse(canCloseVolume);
    Decimal buff;

    if (!isOpen) {
      // Assuming getContractUint returns an integer like in Java.
      if (getContractUint() == 0) {
        return "${canCloseVolumeBig.toStringAsFixed(scale)} $unit";
      } else {
        return (parValueBig * canCloseVolumeBig).toStringAsFixed(scale) +
            " $unit";
      }
    }
    if (price == "0") {
      return defaultStr;
    }
    final priceBig = Decimal.parse(price);
    final canUseAmountBig = Decimal.parse(canUseAmount);
    final nowLevelBig = Decimal.parse(nowLevel);
    final rateBig = Decimal.parse(rate);

    if (isForward) {
      buff = ((canUseAmountBig * nowLevelBig / priceBig)
                  .toDecimal(scaleOnInfinitePrecision: scale) /
              rateBig)
          .toDecimal(scaleOnInfinitePrecision: scale);
    } else {
      buff = (canUseAmountBig * nowLevelBig * priceBig / rateBig)
          .toDecimal(scaleOnInfinitePrecision: scale);
    }
    if (getContractUint() == 0) {
      buff = (buff / parValueBig).toDecimal(scaleOnInfinitePrecision: scale);
      scale = 0;
    }
    return buff.toStringAsFixed(scale) + " $unit";
  }

  static String canOpenStr({
    required bool isForward,
    required bool isLimit,
    required String price,
    required String maxOpenLimit,
    required String positionValue,
    required String entrustedValue,
    required String parValue,
    required String rate,
    required int scale,
    required String unit,
  }) {
    final defaultStr = "0.00 $unit";
    if (parValue.isEmpty) parValue = "0";
    if (price.isEmpty) price = "0";
    if (maxOpenLimit.isEmpty) maxOpenLimit = "0";
    if (positionValue.isEmpty) positionValue = "0";
    if (entrustedValue.isEmpty) entrustedValue = "0";
    final parValueBig = Decimal.parse(parValue);
    final priceBig = Decimal.parse(price);
    final rateBig = Decimal.parse(rate);
    final maxOpenLimitBig = Decimal.parse(maxOpenLimit); //（币的单位）
    final positionValueBig = Decimal.parse(positionValue); //（币的单位）
    final entrustedValueBig = Decimal.parse(entrustedValue); //（币的单位）

    Decimal buff;
    if (price == "0") {
      return defaultStr;
    }
    //Zhang
    //Forward/Price * Face value
    //Reverse * Price/face value
    //Coins
    //Forward/Price
    //Reverse * Price
    if (getContractUint() == 0) {
      if (isForward) {
        if (isLimit) {
          buff = ((maxOpenLimitBig - positionValueBig - entrustedValueBig) /
                  (priceBig * parValueBig))
              .toDecimal(scaleOnInfinitePrecision: scale);
        } else {
          buff = ((maxOpenLimitBig - positionValueBig - entrustedValueBig) *
                  rateBig /
                  (priceBig * parValueBig))
              .toDecimal(scaleOnInfinitePrecision: scale);
        }
      } else {
        if (isLimit) {
          buff = ((maxOpenLimitBig - positionValueBig - entrustedValueBig) *
                  priceBig /
                  parValueBig)
              .toDecimal(scaleOnInfinitePrecision: scale);
        } else {
          buff = ((maxOpenLimitBig - positionValueBig - entrustedValueBig) *
                  priceBig /
                  parValueBig)
              .toDecimal(scaleOnInfinitePrecision: scale);
        }
      }
      return buff.toStringAsFixed(0) + " " + unit;
    } else {
      if (isForward) {
        if (isLimit) {
          buff = ((maxOpenLimitBig - positionValueBig - entrustedValueBig) /
                  priceBig)
              .toDecimal(scaleOnInfinitePrecision: scale);
        } else {
          buff = ((maxOpenLimitBig - positionValueBig - entrustedValueBig) *
                  rateBig /
                  priceBig)
              .toDecimal(scaleOnInfinitePrecision: scale);
        }
      } else {
        if (isLimit) {
          buff = ((maxOpenLimitBig - positionValueBig - entrustedValueBig) *
              priceBig);
        } else {
          buff = ((maxOpenLimitBig - positionValueBig - entrustedValueBig) *
              priceBig);
        }
      }
      return buff.toStringAsFixed(scale) + " " + unit;
    }
  }

  static int getContractUint() {
    // Implement this function based on your application's context

    return 0; // Example context
  }

  /// Calculate the median of three strings
  /// @param buyOne The first string
  /// @param sellOne The second string
  /// @param latestPrice The third string
  static String median(String buyOne, String sellOne, String latestPrice) {
    if (buyOne == "0" && sellOne == "0") {
      if (latestPrice == "0") {
        return "0";
      } else {
        return latestPrice;
      }
    }
    List<String> arr = [buyOne, sellOne, latestPrice];
    arr.sort();
    return arr[1];
  }

  static String getUIMaxOpen({
    required bool isForward,
    required bool isOpen,
    required String multiplier,
    required String price,
    required String maxValue,
    required String canCloseVolume,
    required int coUnit,
    required int scale,
    required String unit,
  }) {
    String value = canUSDTPositionStr(
      isForward: isForward,
      value: maxValue,
      price: price,
      scale: 8,
      unit: unit,
    );
    String tempValue = value.split(" ")[0];
    double bgCanCloseVolume = double.parse(canCloseVolume);

    bool isZhang = coUnit == 0;
    if (!isOpen) {
      if (isZhang) {
        return bgCanCloseVolume.toStringAsFixed(0).trim() + unit;
      } else {
        return (double.parse(multiplier) * bgCanCloseVolume)
                .toStringAsFixed(scale)
                .trim() +
            unit;
      }
    }

    if (isZhang) {
      return divStr(tempValue, multiplier, 0) + unit;
    } else {
      return divForDown(tempValue, scale) + unit;
    }
  }

  static String canUSDTPositionStr({
    required bool isForward,
    required String value,
    required String price,
    required int scale,
    required String unit,
  }) {
    if (!isNumeric(value) || !isNumeric(price)) return "0 $unit";
    double bgValue = double.parse(value);
    double bgPrice = double.parse(price);
    String result;

    if (bgPrice == 0 || bgValue == 0) {
      result = 0.toStringAsFixed(scale);
    } else {
      if (isForward) {
        result = (bgValue / bgPrice).toStringAsFixed(scale);
      } else {
        result = (bgValue * bgPrice).toStringAsFixed(scale);
      }
    }

    return "$result $unit";
  }

  static String divStr(String v1, String v2, int scale) {
    if (!isNumeric(v1)) v1 = "0";
    if (!isNumeric(v2)) v2 = "0";

    if (v2 == "0") return v1;

    if (scale < 0) scale = 0;

    double b1 = double.parse(v1);
    double b2 = double.parse(v2);

    return (b1 / b2).toStringAsFixed(scale);
  }

  static String divForDown(String v1, int scale) {
    if (!checkStr(v1)) {
      v1 = "0";
    }
    if (!isNumeric(v1)) {
      v1 = "0";
    }
    if (scale < 0) scale = 0;

    double b1 = double.parse(v1);

    return b1.toStringAsFixed(scale);
  }

  /**
   * 合约最大可开价值计算
   * 1）根据风险限额计算的最大可开：
   * 正向&反向：最大可开价值 = 当前合约最大可开额度-当前合约所有持仓仓位价值-当前合约所有未成交开仓委托价值
   * The maximum open value of the contract is calculated
   * 1) Maximum open based on the risk limit:
   * Forward & Reverse: Max Open Value = Max Open Value of current contract - Value of all open positions of current contract - Value of all open orders of current contract
   * */
  static String calcMaxValueByRisk(
      String maxOpenLimit, String positionValue, String entrustedValue) {
    double maxOpenLimitBig = double.parse(maxOpenLimit);
    double positionValueBig = double.parse(positionValue);
    double entrustedValueBig = double.parse(entrustedValue);
    double resultValue = maxOpenLimitBig - positionValueBig - entrustedValueBig;
    return resultValue.toStringAsFixed(2).trim();
  }

  /**
   * 2）根据可用余额计算的最大可开
   * 根据可用余额计算的最大可开（价值）：
   * 正向&反向：最大可开 = 可用余额 *杠杆
   * 2) Maximum available based on available balance
   * Maximum open (value) based on available balance:
   * Forward & Reverse: Maximum open = available balance * Leverage
   * */
  static String calcMaxValueByMarginCoinAmount(
      String canUseAmount, String nowLevel) {
    double canUseAmountBig = double.parse(canUseAmount);
    double nowLevelBig = double.parse(nowLevel);
    double resultValue = canUseAmountBig * nowLevelBig;
    return resultValue.toStringAsFixed(2).trim();
  }

  static bool checkStr(String s) {
    // Implement this function based on your application's context
    return s.isNotEmpty; // Example context
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  /**
   * 最大可开价值 = min{风险限额计算的可开价值，保证金计算的可开价值}
   * Maximum open value = min{open value calculated for risk limit, open value calculated for margin}
   * */
  static String getMaxCanOpenValue(
      String maxRiskCanOpenValue, String maxMarginCoinCanOpenValue) {
    // return min(maxValueByRisk,maxValueByMarginCoinAmount).trim();
    return openMin(maxRiskCanOpenValue, maxMarginCoinCanOpenValue).trim();
  }

  static String openMin(String oneStr, String twoStr) {
    double num1 = double.parse(oneStr);
    double num2 = double.parse(twoStr);
    return min(num1, num2).toString();
  }

  /// 计算保证金
  static String canCostStr(
      {required bool isOpen,
      required bool isForward,
      required int orderType,
      required String price,
      required String position,
      required String parValue,
      required String nowLevel,
      required String rate,
      required int coUnit,
      required bool isMarketPrice,
      required int scale,
      required String unit}) {
    String defaultStr = "0" + " " + unit;
    if (!isOpen) {
      return "0" + " " + unit;
    }
    if (position.isEmpty) {
      return defaultStr;
    }
    if (double.tryParse(position) == null) return defaultStr;
    String sheets = "0";

    if (coUnit == 0) {
      sheets = position;
    } else {
      sheets =
          (double.parse(position) / double.parse(parValue)).toStringAsFixed(0);
    }

    double positionBig = double.parse(position);
    double sheetsBig = double.parse(sheets);
    double nowLevelBig = double.parse(nowLevel);
    double parValueBig = double.parse(parValue);
    double rateBig = double.parse(rate);

    double buff;

    if (orderType == 1 || orderType == 4 || orderType == 5 || orderType == 6) {
      if (price.isEmpty) {
        return defaultStr;
      }
      if (double.parse(price) <= 0) {
        return defaultStr;
      }
      double priceBig = double.parse(price);
      if (isForward) {
        buff = sheetsBig * parValueBig * priceBig / nowLevelBig * rateBig;
      } else {
        buff = sheetsBig * parValueBig / priceBig / nowLevelBig * rateBig;
      }
    } else if (orderType == 2) {
      buff = positionBig / nowLevelBig * rateBig;
    } else if (orderType == 3) {
      if (isMarketPrice) {
        buff = positionBig / nowLevelBig * rateBig;
      } else {
        if (price.isEmpty) {
          return defaultStr;
        }
        if (double.parse(price) <= 0) {
          return defaultStr;
        }
        double priceBig = double.parse(price);
        if (isForward) {
          buff = sheetsBig * parValueBig * priceBig / nowLevelBig * rateBig;
        } else {
          buff = sheetsBig * parValueBig / priceBig / nowLevelBig * rateBig;
        }
      }
    } else {
      return "0" + " " + unit;
    }
    return "${buff.toStringAsFixed(scale)} $unit";
  }
}
