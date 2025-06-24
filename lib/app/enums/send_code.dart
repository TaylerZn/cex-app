// 1:手机号码注册
// 2:绑定手机号码
// 3:更换手机，原手机号验证
// 4:绑定邮箱
// 5:修改登录密码
// 6:设置资金密码
// 7:修改资金密码
// 8:设置交易验证
// 9:修改密码
// 10:提币
// 11:添加数字货币地址
// 12:修改数字货币地址
// 13:数字货币提现
// 14:关闭手机验证
// 15:修改邮箱
// 16:操作OpenApi
// 21:删除地址
// 22:场外账户划转
// 23:二次登录
// 24:找回密码
// 25:手机登陆
// 26:关闭Google认证
// 27:操作手势密码
// 28:操作支付方式
// 29:绑定钱包
// 30:添加银行卡
// 31:修改银行卡
// 32:法币提现
// 33:开启Google认证
// 34:内部转账/站内直转
// 101:授权商家支付
// 201:领取红包
// 210:扫码登录
// 301:注销账号
// 20:解绑第三方
class SendSmsEnum {
  static const int RegistByMobile = 1;
  static const int BindMobileNum = 2;
  static const int ChangeMobileNum = 3;
  static const int BindEmail = 4;
  static const int UpdateLoginPassword = 5;
  static const int SetCapitalPassword = 6;
  static const int UpdateCapitalPassword = 7;
  static const int SetTradeValid = 8;
  static const int ModifyPwd = 9;
  static const int Withdraw = 10;
  static const int AddCryptoAddr = 11;
  static const int ModifyCryptoAddr = 12;
  static const int CryptoWithdraw = 13;
  static const int CloseMobileValid = 14;
  static const int ModifyEmail = 15;
  static const int OperateOpenApi = 16;
  static const int DelAddr = 21;
  static const int OtcTransfer = 22;
  static const int LoginAgain = 23;
  static const int FindPassword = 24;
  static const int PhoneLogin = 25;
  static const int CloseGoogleValid = 26;
  static const int HandleHandPwd = 27;
  static const int HandlePayment = 28;
  static const int BindWallet = 29;
  static const int AddBankCard = 30;
  static const int EditBankCard = 31;
  static const int FiatWithdraw = 32;
  static const int OpenGoogleValid = 33;
  static const int InnerWithdraw = 34;
  static const int OPEN_BEFORE_PAY_VALID = 101;
  static const int OPEN_RED_PACKET = 201;
  static const int scanQRCodeLogin = 210;
  static const int DeleteAccountByMobile = 301;
  static const int authUnBind = 20;
}

// 1:邮箱注册
// 2:绑定邮箱
// 3:找回密码
// 4:邮箱登录
// 9:二次登录
// 13:添加提现地址
// 15:修改邮箱
// 16:登录提醒
// 17:数字货币提现
// 21:IEO新币申购
// 18:异常登录
// 19:内部转账/站内直转
// 30:注销账号
// 210:扫码登录-邮件
// 211:修改密码
// 212:关闭谷歌
// 213:关闭手机验证
// 20:解绑第三方,

class SendEmailEnum {
  static const int RegistByEmail = 1;
  static const int BindEmail = 2;
  static const int FindPassword = 3;
  static const int EmailLogin = 4;
  static const int LoginAgain = 9;
  static const int AddCryptoAddr = 13;
  static const int ModifyEmail = 15;
  static const int LoginReminding = 16;
  static const int CryptoWithdraw = 17;
  static const int NewCoinPurchase = 21;
  static const int UnusualLoginReminding = 18;
  static const int InnerWithdraw = 19;
  static const int DeleteAccountByEmail = 30;
  static const int scanQRCodeLogin = 210;
  static const int authUnBind = 20;
}
