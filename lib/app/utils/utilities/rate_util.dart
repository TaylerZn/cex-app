
import '../../models/contract/res/symbol_rate_info.dart';

num? getRate(List<SymbolRateInfo> list, String quoteSymbol) {
  int index = list.indexWhere((element) => element.quoteSymbol == quoteSymbol);
  if(index == -1) return null;
  return list[index].rate;
}

String rateFormat(num rate) {
  if(rate >= 0) {
    return '+${(rate * 100).toStringAsFixed(2)}%';
  } else {
    return '${(rate * 100).toStringAsFixed(2)}%';
  }
}