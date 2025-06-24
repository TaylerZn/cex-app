import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utilities/permission_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_extended_textfield.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/select.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum ContentFillType {
  dropdown(0),
  input(1),
  image(2),
  mobile(3),
  extendedField(4);

  const ContentFillType(this.value);
  final int value;
}

class ContentFillWidget extends StatefulWidget {
  final bool showError;
  final bool match;
  final bool mandatory;
  final String question;
  final String? fieldKey;
  final String? errorTxt;
  final String? value;
  final String? hint;
  final Function(String?)? callback;
  final Function(bool)? onFocus;
  final Function(List<AssetEntity?>? images)? imageCallback;
  final List<String?>? optionList;
  final int inputType;
  final int? keyboardType;
  final bool showSign;

  const ContentFillWidget(
      {super.key,
      required this.question,
      this.errorTxt,
      this.inputType = 0,
      this.value,
      this.onFocus,
      this.showSign = true,
      this.hint,
      this.keyboardType,
      this.fieldKey,
      this.optionList,
      this.match = true,
      this.showError = false,
      this.imageCallback,
      this.mandatory = false,
      this.callback});

  @override
  State<ContentFillWidget> createState() => _ContentFillWidgetState();
}

class _ContentFillWidgetState extends State<ContentFillWidget> {
  int imageMax = 3;
  List<AssetEntity?>? images = [];
  FocusNode node = FocusNode();
  String? value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = widget.value;
    node.addListener(() {
      widget.onFocus?.call(node.hasFocus);
    });
  }

  ContentFillType get fillType {
    switch (widget.inputType) {
      case 0:
        return ContentFillType.dropdown;
      case 1:
        return ContentFillType.input;
      case 2:
        return ContentFillType.image;
      case 3:
        return ContentFillType.dropdown;
      case 4:
        return ContentFillType.extendedField;
      default:
        return ContentFillType.dropdown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _question(),
        12.h.verticalSpace,
        _buildContent(),
        4.h.verticalSpace,
        Visibility(
            visible: widget.showError && widget.mandatory,
            child: Text(
                widget.match == false
                    ? LocaleKeys.c2c56.tr
                    : fillType == ContentFillType.image
                        ? LocaleKeys.c2c136.tr
                        : widget.errorTxt ?? widget.hint ?? LocaleKeys.c2c43.tr,
                style: AppTextStyle.f_12_400.colorE64F44))
      ],
    );
  }

  Widget _question() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: widget.mandatory && widget.showSign ? '*' : '',
              style: AppTextStyle.f_12_600.colorEA1F1F),
          TextSpan(
            text: widget.question,
            style: AppTextStyle.f_12_400.color666666,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (fillType) {
      case ContentFillType.dropdown:
        return MySelect(
            maxWidth: true,
            list: widget.optionList ?? [],
            hint: widget.hint ?? '',
            value: value,
            onChanged: (value) {
              this.value = value;
              widget.callback?.call(value);
            });
      case ContentFillType.input:
        return MyTextFieldWidget(
            keyboardType: widget.keyboardType == 1
                ? TextInputType.number
                : TextInputType.text,
            controller: TextEditingController()..text = value ?? '',
            hintText: widget.hint,
            focusNode: node,
            isTopText: false,
            style: AppTextStyle.f_14_500,
            onChanged: (value) {
              this.value = value;
              widget.callback?.call(value);
            });
      case ContentFillType.image:
        return buildImageContent();
      case ContentFillType.extendedField:
        return MyExtendedTextField();
      default:
    }
    return const SizedBox();
  }

  Widget buildImageContent() {
    Widget content(AssetEntity? entity, i) {
      return Container(
        width: 104.h,
        height: 104.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            border: Border.all(color: AppColor.colorECECEC)),
        child: ObjectUtil.isNotEmpty(entity)
            ? Stack(
                children: [
                  Positioned(
                    width: 104.w,
                    height: 104.h,
                    child: AssetEntityImage(
                      entity!,
                      isOriginal: false,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          widget.imageCallback?.call(images);
                          setState(() {
                            images?.removeAt(i);
                          });
                        },
                        child: Container(
                            width: 20.w,
                            height: 20.w,
                            child: Icon(Icons.close, size: 13.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.r)),
                              color: AppColor.colorWhite.withOpacity(0.8),
                            )),
                      ))
                ],
              )
            : images?.isEmpty == true && i == 0
                ? Icon(Icons.add, color: AppColor.color4D4D4D)
                : i == (images?.length ?? 0)
                    ? Icon(
                        Icons.add,
                        color: AppColor.color4D4D4D,
                      )
                    : SizedBox(),
      );
    }

    List<Widget> list = [];
    for (int i = 0; i < imageMax; i++) {
      AssetEntity? entity;
      if (images?.isNotEmpty == true) {
        if (i < (images?.length ?? 0)) {
          entity = images?[i];
        }
      }

      list.add(InkWell(
        child: ObjectUtil.isNotEmpty(entity)
            ? ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6.r)),
                child: content(entity, i))
            : content(entity, i),
        onTap: () {
          if (ObjectUtil.isNotEmpty(entity)) {
            return;
          }
          pickImage(context);
        },
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list),
        SizedBox(height: 8.h),
        Text(LocaleKeys.c2c163.tr, style: AppTextStyle.f_12_400.color666666)
      ],
    );
  }

  Future<void> pickImage(BuildContext context) async {
    if (await requestPhotosPermission()) {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
          pickerConfig: AssetPickerConfig(
            requestType: RequestType.image,
            maxAssets: imageMax - (images?.length ?? 0),
          ));
      if (result != null) {
        for (var i = 0; i < result.length; i++) {
          images?.add(result[i]);
        }
        widget.imageCallback?.call(images);
        setState(() {});
      }
    }
  }

  @override
  void didUpdateWidget(covariant ContentFillWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value ||
        oldWidget.showError != widget.showError ||
        oldWidget.match != widget.match) {
      value = widget.value;
      setState(() {});
    }
  }
}
