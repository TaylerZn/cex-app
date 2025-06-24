import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/widget/content_option_widget.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/customer_apply_controller.dart';

class CustomerApplyView extends GetView<CustomerApplyController> {
  const CustomerApplyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        title: const Text(''),
        centerTitle: true,
      ),
      body: InkWell(
        onTap: () {
          AppUtil.hideKeyboard(context);
        },
        child: GetBuilder<CustomerApplyController>(builder: (controller) {
          return Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ObjectUtil.isNotEmpty(controller.inputBean)
                    ? _buildContent()
                    : SizedBox(),
              )),
              Container(
                color: AppColor.colorF1F1F1,
                height: 110.h,
                alignment: Alignment.center,
                child: MyButton(
                  width: 327.w,
                  height: 44.w,
                  goIcon: true,
                  text: LocaleKeys.trade256.tr,
                  onTap: () async {
                    controller.validateForm();
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildContent() {
    List<Widget> content() {
      return controller.inputBean?.data?.map((e) {
            int index = (controller.inputBean?.data?.indexOf(e) ?? 0) + 1;

            return Container(
                margin: EdgeInsets.only(bottom: 30.h),
                child: ContentFillWidget(
                    match: e.match ?? true,
                    imageCallback: (value) {
                      e.images = value;
                    },
                    callback: (value) {
                      e.value = value;
                      if (e.key == 'isOtherPlatformMerchant') {
                        controller.loadForm(int.parse(value!));
                      }
                    },
                    value: e.value,
                    onFocus: (stat) {
                      controller.isVisible.value = !stat;
                    },
                    question: '$index.${e.question?.tr ?? ''}',
                    mandatory: e.mandatory ?? false,
                    showError: e.showError ?? false,
                    hint: e.hintText?.tr,
                    inputType: e.type ?? 0,
                    optionList: e.optionList?.map((e) => e?.tr).toList()));
          }).toList() ??
          [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 22.h),
        Text(LocaleKeys.c2c72.tr, style: AppTextStyle.f_24_600),
        SizedBox(height: 24.h),
        ...content(),
        SizedBox(height: 110.h)
      ],
    );
  }
}
