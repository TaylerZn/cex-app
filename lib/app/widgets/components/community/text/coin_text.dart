import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';

class PostCoinText extends SpecialText {
  PostCoinText(TextStyle? textStyle, SpecialTextGestureTapCallback? onTap,
      {this.showAtBackground = false, this.start})
      : super(flag, '}]', textStyle, onTap: onTap);
  static const String flag = '[0f250d4882f9ebb9{';
  final int? start;

  /// whether show background for @somebody
  final bool showAtBackground;

  @override
  InlineSpan finishText() {
    final String postCoinText = toString();
    ContractInfo? postCoinData = CommodityDataStoreController.to
        .getContractInfoByContractId(num.parse(
            (postCoinText.split('{')[1].split('}')[0]).split('|')[1]));

    return SpecialTextSpan(
        text: '${postCoinData?.firstName}${postCoinData?.secondName} ',
        actualText: postCoinText,
        start: start!,
        style: textStyle,
        deleteAll: true,
        recognizer: (TapGestureRecognizer()
          ..onTap = () {
            if (onTap != null) {
              onTap!(postCoinText);
            }
          }));
  }
}

List<String> atList = <String>[
  '@Nevermore ',
  '@Dota2 ',
  '@Biglao ',
  '@艾莉亚·史塔克 ',
  '@丹妮莉丝 ',
  '@HandPulledNoodles ',
  '@Zmtzawqlp ',
  '@FaDeKongJian ',
  '@CaiJingLongDaLao ',
];
