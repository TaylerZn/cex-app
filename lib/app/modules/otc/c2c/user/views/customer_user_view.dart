import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/customer_user_controller.dart';

class CustomerUserView extends GetView<CustomerUserController> {
  const CustomerUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomerUserView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CustomerUserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
