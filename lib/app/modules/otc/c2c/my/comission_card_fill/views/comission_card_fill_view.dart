import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/bean/input_bean.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/widget/content_option_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/footer_widget.dart';
import 'package:nt_app_flutter/app/utils/utilities/app_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/comission_card_fill_controller.dart';

class ComissionCardFillView extends GetView<ComissionCardFillController> {
  const ComissionCardFillView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyPageBackWidget(),
        centerTitle: true,
      ),
      body: InkWell(onTap: () {
        AppUtil.hideKeyboard(context);
      }, child:
          GetBuilder<ComissionCardFillController>(builder: (assetsController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.c2c51.tr, style: AppTextStyle.f_24_600),
                    24.verticalSpace,
                    ...content(),
                    Text(LocaleKeys.c2c62.tr),
                    10.verticalSpace,
                    Text(LocaleKeys.c2c63.tr,
                        style: AppTextStyle.f_12_400.color666666),
                    36.verticalSpace
                  ],
                ),
              ),
            )),
            CustomerFooterWidget(
              onTap: () {
                controller.addBank();
              },
              text: LocaleKeys.public57.tr,
            )
          ],
        );
      })),
    );
  }

  List<Widget> content() {
    InputBean? input = controller.inputBean;

    return controller.inputBean?.data
            ?.map((e) => Container(
                margin: EdgeInsets.only(bottom: 30.h),
                child: ContentFillWidget(
                    showSign: false,
                    match: e.match ?? true,
                    imageCallback: (value) {
                      e.images = value;
                    },
                    callback: (value) {
                      e.value = value;
                    },
                    keyboardType: e.keyboardType,
                    errorTxt: e.errorTxt?.tr,
                    value: e.value,
                    onFocus: (stat) {},
                    question: e.question?.tr ?? '',
                    mandatory: e.mandatory ?? false,
                    showError: e.showError ?? false,
                    hint: e.hintText?.tr,
                    inputType: e.type ?? 0,
                    optionList: e.optionList)))
            .toList() ??
        [];
  }
}
