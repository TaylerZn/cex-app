import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/coupon_card_list_controller.dart';

class CouponCardListView extends GetView<CouponCardListController> {
  const CouponCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的卡券'),
        bottom: TabBar(
          controller: controller.tabController,
          tabs: const [
            Tab(text: '已领取'),
            Tab(text: '已失效'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          ReceivedCouponsTab(),
          ExpiredCouponsTab(),
        ],
      ),
    );
  }
}

class ReceivedCouponsTab extends GetView<CouponCardListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.receivedCoupons.isEmpty) {
        return Center(child: Text('没有已领取的卡券'));
      }
      return ListView.builder(
        itemCount: controller.receivedCoupons.length,
        itemBuilder: (context, index) {
          final card = controller.receivedCoupons[index];
          return CouponCard(
            amount: card.tokenNum ?? '0',
            type: card.cardType == 0 ? '永续合约赠金券' : '标准合约赠金券',
            expiryDate: card.expire ?? '',
            status: card.status == 0 ? '去交易' : '已使用',
            maxLeverage: card.maxLeverage ?? 0,
          );
        },
      );
    });
  }
}

class ExpiredCouponsTab extends GetView<CouponCardListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.expiredCoupons.isEmpty) {
        return Center(child: Text('没有已失效的卡券'));
      }
      return ListView.builder(
        itemCount: controller.expiredCoupons.length,
        itemBuilder: (context, index) {
          final card = controller.expiredCoupons[index];
          return CouponCard(
            amount: card.tokenNum ?? '0',
            type: card.cardType == 0 ? '永续合约赠金券' : '标准合约赠金券',
            expiryDate: card.expire ?? '',
            status: '已过期',
            isExpired: true,
            maxLeverage: card.maxLeverage ?? 0,
          );
        },
      );
    });
  }
}

class CouponCard extends StatelessWidget {
  final String amount;
  final String type;
  final String expiryDate;
  final String status;
  final bool isExpired;
  final int maxLeverage;
  CouponCard({
    required this.amount,
    required this.type,
    required this.expiryDate,
    required this.status,
    required this.maxLeverage,
    this.isExpired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Text(
          'USDT\n$amount',
          style: TextStyle(fontSize: 24),
        ),
        title: Text(type),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('最大杠杆: $maxLeverage'),
            Text('有效期至 $expiryDate'),
          ],
        ),
        trailing: isExpired
            ? Text(
                '已过期',
                style: TextStyle(color: Colors.grey),
              )
            : ElevatedButton(
                onPressed: () {},
                child: Text(status),
              ),
      ),
    );
  }
}
