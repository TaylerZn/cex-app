import 'package:flutter/cupertino.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_extended_textfield.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';

class ComissionInputFieldWidget extends StatefulWidget {
  final String? title;
  final String? hint;
  final int? type;
  const ComissionInputFieldWidget(
      {super.key, this.title, this.hint, this.type});

  @override
  State<ComissionInputFieldWidget> createState() =>
      _ComissionInputFieldWidgetState();
}

class _ComissionInputFieldWidgetState extends State<ComissionInputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title ?? '', style: AppTextStyle.f_12_400.color666666),
        8.verticalSpace,
        buildInputContent(),
        30.verticalSpace
      ],
    );
  }

  Widget buildInputContent() {
    if (widget.type == 2) {
      return MyExtendedTextField();
    }
    return MyTextFieldWidget(hintText: widget.hint ?? '', isTopText: false);
  }
}
