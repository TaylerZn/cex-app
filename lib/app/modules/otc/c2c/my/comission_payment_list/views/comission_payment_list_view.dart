import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';

import '../controllers/comission_payment_list_controller.dart';

class ComissionPaymentListView extends GetView<ComissionPaymentListController> {
  const ComissionPaymentListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ComissionPaymentListView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: (OtcConfigUtils().publicInfo?.payments ?? []).map((e){
            return SizedBox();
          }).toList(),
        ),
      ),
    );
  }
}
