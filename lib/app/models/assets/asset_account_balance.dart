// class AssetAccountBalance {
//   String? platformCoin;
//   Map<String, AllCoinMap> allCoinMap;
//   String? totalBalanceSymbol;
//   String? totalBalance;

//   AssetAccountBalance({
//     this.platformCoin,
//     required this.allCoinMap,
//     this.totalBalanceSymbol,
//     this.totalBalance,
//   });

//   factory AssetAccountBalance.fromJson(Map<String?, dynamic> json) =>
//       AssetAccountBalance(
//         platformCoin: json["platformCoin"],
//         allCoinMap: Map.from(json["allCoinMap"]).map(
//             (k, v) => MapEntry<String, AllCoinMap>(k, AllCoinMap.fromJson(v))),
//         totalBalanceSymbol: json["totalBalanceSymbol"],
//         totalBalance: json["totalBalance"],
//       );

//   Map<String?, dynamic> toJson() => {
//         "platformCoin": platformCoin,
//         "allCoinMap": Map.from(allCoinMap)
//             .map((k, v) => MapEntry<String?, dynamic>(k, v.toJson())),
//         "totalBalanceSymbol": totalBalanceSymbol,
//         "totalBalance": totalBalance,
//       };
// }

// class AllCoinMap {
//   int? walletTransactionOpen;
//   int? innerTransferFee;
//   String? allBalance;
//   String? exchangeSymbol;
//   int? presentCoinBalance;
//   String? lockPositionBalance;
//   int? innerTransferOpen;
//   int? depositOpen;
//   int? otcOpen;
//   double? depositMin;
//   String? checked;
//   String? allBtcValuatin;
//   String? lockPositionV2Amount;
//   int? withdrawOpen;
//   String? lockIncrementAmount;
//   int? isFiat;
//   String? normalBalance;
//   String? btcValuatin;
//   int? sort;
//   String? lockGrantDividedBalance;
//   String? totalBalance;
//   String? ncLockBalance;
//   String? coinName;
//   String? lockBalance;
//   String? overchargeBalance;

//   AllCoinMap({
//     this.walletTransactionOpen,
//     this.innerTransferFee,
//     this.allBalance,
//     this.exchangeSymbol,
//     this.presentCoinBalance,
//     this.lockPositionBalance,
//     this.innerTransferOpen,
//     this.depositOpen,
//     this.otcOpen,
//     this.depositMin,
//     this.checked,
//     this.allBtcValuatin,
//     this.lockPositionV2Amount,
//     this.withdrawOpen,
//     this.lockIncrementAmount,
//     this.isFiat,
//     this.normalBalance,
//     this.btcValuatin,
//     this.sort,
//     this.lockGrantDividedBalance,
//     this.totalBalance,
//     this.ncLockBalance,
//     this.coinName,
//     this.lockBalance,
//     this.overchargeBalance,
//   });

//   factory AllCoinMap.fromJson(Map<String?, dynamic> json) => AllCoinMap(
//         walletTransactionOpen: json["walletTransactionOpen"],
//         innerTransferFee: json["innerTransferFee"],
//         allBalance: json["allBalance"],
//         exchangeSymbol: json["exchange_symbol"],
//         presentCoinBalance: json["present_coin_balance"],
//         lockPositionBalance: json["lock_position_balance"],
//         innerTransferOpen: json["innerTransferOpen"],
//         depositOpen: json["depositOpen"],
//         otcOpen: json["otcOpen"],
//         depositMin: json["depositMin"]?.toDouble(),
//         checked: json["checked"],
//         allBtcValuatin: json["allBtcValuatin"],
//         lockPositionV2Amount: json["lock_position_v2_amount"],
//         withdrawOpen: json["withdrawOpen"],
//         lockIncrementAmount: json["lock_increment_amount"],
//         isFiat: json["isFiat"],
//         normalBalance: json["normal_balance"],
//         btcValuatin: json["btcValuatin"],
//         sort: json["sort"],
//         lockGrantDividedBalance: json["lock_grant_divided_balance"],
//         totalBalance: json["total_balance"],
//         ncLockBalance: json["nc_lock_balance"],
//         coinName: json["coinName"],
//         lockBalance: json["lock_balance"],
//         overchargeBalance: json["overcharge_balance"],
//       );

//   Map<String?, dynamic> toJson() => {
//         "walletTransactionOpen": walletTransactionOpen,
//         "innerTransferFee": innerTransferFee,
//         "allBalance": allBalance,
//         "exchange_symbol": exchangeSymbol,
//         "present_coin_balance": presentCoinBalance,
//         "lock_position_balance": lockPositionBalance,
//         "innerTransferOpen": innerTransferOpen,
//         "depositOpen": depositOpen,
//         "otcOpen": otcOpen,
//         "depositMin": depositMin,
//         "checked": checked,
//         "allBtcValuatin": allBtcValuatin,
//         "lock_position_v2_amount": lockPositionV2Amount,
//         "withdrawOpen": withdrawOpen,
//         "lock_increment_amount": lockIncrementAmount,
//         "isFiat": isFiat,
//         "normal_balance": normalBalance,
//         "btcValuatin": btcValuatin,
//         "sort": sort,
//         "lock_grant_divided_balance": lockGrantDividedBalance,
//         "total_balance": totalBalance,
//         "nc_lock_balance": ncLockBalance,
//         "coinName": coinName,
//         "lock_balance": lockBalance,
//         "overcharge_balance": overchargeBalance,
//       };
// }
