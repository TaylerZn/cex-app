enum MarketSarchType {
  optional,
  spot,
  contract,
  stocks,
  bulk,
  forex,
  exponent;

  String get value => ['自选', '现货', '合约', '股票', '大宗', '外汇', '指数'][index];
}
