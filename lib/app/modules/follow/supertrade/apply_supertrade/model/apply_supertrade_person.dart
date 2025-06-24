//

// class ApplySupertradePerson {
//   String avatarUrl = 'assets/images/my/apply_supertrade_testImage.png';

//   String name = 'ROSE';
//   String earnTitle = '总收益额USDT';
//   String earn = '+7263.23';
//   String earnRateTitle = '总收益率';
//   String earnRate = '+6563.23%';

//   String accountFundTitle = '账户资金USDT';
//   String accountFund = '7623.23';

//   String followTitle = '跟随人数';
//   String follow = '2K+';
// }

class ApplySupertradeStatesModel {
  String icon;
  String title;
  String des;
  bool isSuccess;

  ApplySupertradeStatesModel({
    this.icon = 'assets/images/my/apply_supertrade_testImage.png',
    this.title = '绑定个人身份信息',
    this.des = '去绑定',
    this.isSuccess = false,
  });
}
