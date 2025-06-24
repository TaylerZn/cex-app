import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class PinInputController extends ChangeNotifier {
  int length;
  String text;
  PinInputController({required this.length, this.text = ''});

  changeText(String text) {
    this.text = text;
    notifyListeners();
  }
}

enum KeyboardButtonShape { circular, rounded, defaultShape }

enum InputShape { circular, rounded, defaultShape }

enum InputType { dash, box }

class MyPinKeyBoard extends StatefulWidget {
  final KeyboardButtonShape keyboardButtonShape;
  final InputShape inputShape;
  final double keyboardMaxWidth;
  final double keyboardhorizontalPadding;
  final double keyboardVerticalPadding;
  // final double spacing;
  final Color? buttonFillColor;
  final Color? buttonBorderColor;
  final Color? btnTextColor;
  final bool btnHasBorder;
  final double? btnBorderThickness;
  final double? btnElevation;
  final Color? btnShadowColor;
  final double? inputWidth;
  final bool isInputHidden;
  final Color inputHiddenColor;
  final double inputsMaxWidth;
  final PinInputController pinInputController;
  final Function() onSubmit;
  final Color? inputFillColor;
  final Color? inputBorderColor;
  final Color? inputTextColor;
  final bool inputHasBorder;
  final double? inputBorderThickness;
  final double? inputElevation;
  final Color? inputShadowColor;
  final Color errorColor;
  final double? keyboardFontSize;
  final BorderRadius? inputBorderRadius;
  final double? inputHeight;
  final Color? cancelColor;
  final String? extraInput;
  final Icon? backButton;
  final Icon? doneButton;
  final InputType inputType;
  final BorderRadius? keyoardBtnBorderRadius;
  final TextStyle? inputTextStyle;
  final Widget? leftExtraInputWidget;
  final double? keyboardBtnSize;
  final Color? focusColor;
  final String? keyboardFontFamily;
  final double? paddingBottom;

  const MyPinKeyBoard({
    Key? key,
    this.keyboardButtonShape = KeyboardButtonShape.defaultShape,
    this.inputShape = InputShape.defaultShape,
    this.keyboardMaxWidth = 80,
    this.keyboardhorizontalPadding = 8,
    this.keyboardVerticalPadding = 8,
    // required this.spacing,
    this.buttonFillColor,
    this.buttonBorderColor,
    this.btnHasBorder = true,
    this.btnTextColor,
    this.btnBorderThickness,
    this.btnElevation,
    this.btnShadowColor,
    this.inputWidth,
    this.isInputHidden = false,
    this.inputHiddenColor = Colors.black,
    this.inputsMaxWidth = 70,
    required this.pinInputController,
    required this.onSubmit,
    this.inputFillColor,
    this.inputBorderColor,
    this.inputTextColor,
    this.inputHasBorder = true,
    this.inputBorderThickness,
    this.inputElevation,
    this.inputShadowColor,
    this.errorColor = Colors.red,
    this.keyboardFontSize,
    this.inputBorderRadius,
    this.inputHeight,
    this.cancelColor,
    required this.keyboardFontFamily,
    this.extraInput,
    this.backButton,
    this.doneButton,
    this.inputType = InputType.box,
    this.keyoardBtnBorderRadius,
    this.inputTextStyle,
    this.leftExtraInputWidget,
    this.keyboardBtnSize,
    this.focusColor,
    this.paddingBottom,
  }) : super(key: key);

  @override
  State<MyPinKeyBoard> createState() => _MyPinKeyBoardState();
}

class _MyPinKeyBoardState extends State<MyPinKeyBoard> {
  List<int> inputNumbers = [];
  String res = "";
  String errorText = '';
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.pinInputController.length; i++) {
      inputNumbers.add(i);
    }
    widget.pinInputController.addListener(() {
      inputNumbers.clear();
      for (int i = 0; i < widget.pinInputController.length; i++) {
        inputNumbers.add(i);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: size.width * (widget.inputsMaxWidth / 100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: inputNumbers.map((e) => inputWidget(e)).toList(),
          ),
        ),
        errorText.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorText,
                  style: TextStyle(color: widget.errorColor),
                ),
              )
            : Container(),
        Expanded(child: SizedBox()),
        MyButton(
          width: 315.w,
          height: 48.w,
          text: '确定',
        ),
        SizedBox(
          height: 24.h,
        ),
        customKeyboard(size: size),
      ],
    );
  }

  Widget keyboardButtons(String number) {
    double _sizeW = MediaQuery.of(context).size.width;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: widget.keyboardVerticalPadding,
            horizontal: widget.keyboardhorizontalPadding),
        child: GestureDetector(
          onTap: () {
            btnClicked(number);
          },
          child: Container(
            alignment: Alignment.center,
            width: widget.keyboardBtnSize ??
                (widget.keyboardButtonShape == KeyboardButtonShape.circular
                    ? _sizeW * 0.13
                    : _sizeW * 0.1),
            height: widget.keyboardBtnSize ??
                (widget.keyboardButtonShape == KeyboardButtonShape.circular
                    ? _sizeW * 0.13
                    : _sizeW * 0.1),
            decoration: BoxDecoration(
                color: widget.buttonFillColor ?? Colors.transparent,
                border: widget.btnHasBorder == true
                    ? Border.all(
                        color: widget.buttonBorderColor ?? Colors.black,
                        width: widget.btnBorderThickness ?? 1,
                      )
                    : null,
                borderRadius: widget.keyoardBtnBorderRadius ??
                    (widget.keyboardButtonShape == KeyboardButtonShape.rounded
                        ? BorderRadius.circular(_sizeW)
                        : null),
                boxShadow: [
                  BoxShadow(
                    color: widget.btnElevation == null
                        ? Colors.transparent
                        : widget.btnShadowColor?.withOpacity(0.6) ??
                            widget.buttonFillColor?.withOpacity(0.6) ??
                            Colors.black.withOpacity(0.6),
                    spreadRadius: 4,
                    blurRadius: 16,
                    offset: Offset(0,
                        widget.btnElevation ?? 0), // changes position of shadow
                  ),
                ],
                shape:
                    widget.keyboardButtonShape == KeyboardButtonShape.circular
                        ? BoxShape.circle
                        : BoxShape.rectangle),
            child: Text(
              number,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: widget.keyboardFontFamily ??
                      Theme.of(context).textTheme.titleMedium?.fontFamily,
                  color: widget.btnTextColor ?? Colors.black,
                  fontSize: widget.keyboardFontSize ?? _sizeW * 0.05),
            ),
          ),
        ),
      ),
    );
  }

  void btnClicked(String btnText) {
    if (res.length < widget.pinInputController.length) {
      setState(() {
        res = res + btnText;
        widget.pinInputController.changeText(res);

        /// textToDisplay = res;
      });
    }
    if (res.length >= widget.pinInputController.length) {
      widget.onSubmit();
      setState(() {
        errorText = '';
      });
    }
  }

  Widget inputWidget(int position) {
    try {
      return Container(
        height: widget.inputHeight ??
            widget.inputWidth ??
            MediaQuery.of(context).size.width * 0.1,
        width: widget.inputWidth ?? MediaQuery.of(context).size.width * 0.1,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
            border: widget.inputType == InputType.dash
                ? Border(
                    bottom: BorderSide(
                        color: widget.focusColor ??
                            widget.inputBorderColor ??
                            Colors.black,
                        width: widget.inputBorderThickness ?? 0))
                : widget.inputHasBorder == false
                    ? null
                    : Border.all(
                        color: widget.focusColor ??
                            widget.inputBorderColor ??
                            Colors.black,
                        width: widget.inputBorderThickness ?? 0),
            color: widget.isInputHidden == true
                ? widget.inputHiddenColor
                : Colors.transparent,
            borderRadius: widget.inputBorderRadius ??
                (widget.inputShape == InputShape.rounded
                    ? const BorderRadius.all(Radius.circular(100))
                    : null),
            boxShadow: [
              // BoxShadow(
              //   color: widget.inputElevation == null
              //       ? Colors.transparent
              //       : widget.inputShadowColor?.withOpacity(0.6) ??
              //           widget.inputFillColor?.withOpacity(0.6) ??
              //           Colors.black.withOpacity(0.6),
              //   spreadRadius: 3,
              //   blurRadius: 9,
              //   offset: Offset(0,
              //       widget.inputElevation ?? 0), // changes position of shadow
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 16, //阴影范围
                spreadRadius: 0, //阴影浓度
                color: Color(0x04000000), //阴影颜色
              ),
            ],
            shape: widget.inputShape == InputShape.circular
                ? BoxShape.circle
                : BoxShape.rectangle),
        child: Center(
            child: Text(
          res[position],

          /// ignore: prefer_const_constructors
          style: widget.inputTextStyle ??
              TextStyle(
                color: widget.isInputHidden == true
                    ? widget.inputHiddenColor
                    : widget.inputTextColor ?? Colors.black,
              ),
        )),
      );
    } catch (e) {
      return Container(
        height: widget.inputHeight ??
            widget.inputWidth ??
            MediaQuery.of(context).size.width * 0.1,
        width: widget.inputWidth ?? MediaQuery.of(context).size.width * 0.1,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
            color: widget.inputFillColor ?? Colors.transparent,
            border: widget.inputType == InputType.dash
                ? Border(
                    bottom: BorderSide(
                        color: widget.inputBorderColor ?? Colors.black,
                        width: widget.inputBorderThickness ?? 0))
                : widget.inputHasBorder == false
                    ? null
                    : Border.all(
                        color: widget.inputBorderColor ?? Colors.black,
                        width: widget.inputBorderThickness ?? 0),
            borderRadius: widget.inputBorderRadius ??
                (widget.inputShape == InputShape.rounded
                    ? const BorderRadius.all(Radius.circular(100))
                    : null),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 16, //阴影范围
                spreadRadius: 0, //阴影浓度
                color: Color(0x04000000), //阴影颜色
              ),
            ],
            shape: widget.inputShape == InputShape.circular
                ? BoxShape.circle
                : BoxShape.rectangle),
      );
    }
  }

  Widget customKeyboard({required Size size}) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * (widget.keyboardMaxWidth / 100),
      ),
      padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 3.5.w),
      color: Color(0x90D1D5DB),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              keyboardButtons("1"),
              keyboardButtons("2"),
              keyboardButtons("3"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              keyboardButtons("4"),
              keyboardButtons("5"),
              keyboardButtons("6"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              keyboardButtons("7"),
              keyboardButtons("8"),
              keyboardButtons("9"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: SizedBox()),
              keyboardButtons("0"),

              ///  keyboardButtons("X"),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    /// ignore: prefer_is_empty
                    if (res.length > 0) {
                      setState(() {
                        res = res.substring(0, res.length - 1);
                        widget.pinInputController.changeText(res);
                      });
                    }
                  },

                  /// ignore: prefer_const_constructors
                  icon: widget.backButton ??
                      MyImage(
                        'keyboard_del'.svgAssets(),
                        width: 23.w,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: (widget.paddingBottom ?? 50.w) +
                MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
