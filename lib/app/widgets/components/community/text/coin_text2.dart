// import 'package:extended_text_library/extended_text_library.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// class PostCoinText extends SpecialText {
//   PostCoinText(TextStyle? textStyle, SpecialTextGestureTapCallback? onTap,
//       {this.showAtBackground = false, this.start})
//       : super(flag, '}]', textStyle, onTap: onTap);
//   static const String flag = '[0f250d4882f9ebb9{';
//   final int? start;

//   /// whether show background for @somebody
//   final bool showAtBackground;

//   @override
//   InlineSpan finishText() {
//     final String postCoinText = toString();

//     return showAtBackground
//         ? BackgroundTextSpan(
//             background: Paint()..color = Colors.blue.withOpacity(0.15),
//             text: postCoinText,
//             actualText: postCoinText,
//             start: start!,

//             ///caret can move into special text
//             deleteAll: true,
//             style: textStyle,
//             recognizer: (TapGestureRecognizer()
//               ..onTap = () {
//                 if (onTap != null) {
//                   onTap!(postCoinText);
//                 }
//               }))
//         : SpecialTextSpan(
//             text: '${postCoinText.substring(1, postCoinText.indexOf('|'))} ',
//             actualText: postCoinText,
//             start: start!,
//             style: textStyle,
//             deleteAll: true,
//             recognizer: (TapGestureRecognizer()
//               ..onTap = () {
//                 if (onTap != null) {
//                   onTap!(postCoinText);
//                 }
//               }));
//   }
// }

// List<String> atList = <String>[
//   '@Nevermore ',
//   '@Dota2 ',
//   '@Biglao ',
//   '@艾莉亚·史塔克 ',
//   '@丹妮莉丝 ',
//   '@HandPulledNoodles ',
//   '@Zmtzawqlp ',
//   '@FaDeKongJian ',
//   '@CaiJingLongDaLao ',
// ];
