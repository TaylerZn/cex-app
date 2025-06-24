part of 'app_pages.dart';
// 忽略大些lint

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const MAIN_TAB = _Paths.MAIN_TAB;
  static const NOTIFY = _Paths.NOTIFY;
  static const COMMUNITY_NOTIFY = _Paths.COMMUNITY_NOTIFY;

  static const NOTICE = _Paths.NOTICE;
  // static const OFFICE_NOTIFY_LIST = _Paths.OFFICE_NOTIFY_LIST;
  // static const SYSTEM_NOTIFY_LIST = _Paths.SYSTEM_NOTIFY_LIST;

  //登录
  static const LOGIN = _Paths.LOGIN;
  // 传入数据： arguments: {'verificatioData': xxx,"third_type": xxx,"third_data": xxx} verificatioData:验证信息，可选： third_type： 第三方类型 third_data:第三方账号
  static const LOGIN_VERIFICATION = _Paths.LOGIN_VERIFICATION;

  static const LOGIN_REGISTERED = _Paths.LOGIN_REGISTERED;
  static const LOGIN_REGISTERED_PWD = _Paths.LOGIN_REGISTERED_PWD;
  static const LOGIN_REGISTERED_VERIFICATION =
      _Paths.LOGIN_REGISTERED_VERIFICATION;

  // 传入数据： arguments: {"type": xxx, "data": xxx} type:第三方类型，data:第三方账号
  static const ASSOCIATED_ACCOUNT = _Paths.ASSOCIATED_ACCOUNT;
  // 传入数据： arguments: {"type": xxx, "data": xxx} type:第三方类型，data:第三方账号
  static const ASSOCIATED_HAS_ACCOUNT = _Paths.ASSOCIATED_HAS_ACCOUNT;

  static const LOGIN_FORGOT = _Paths.LOGIN_FORGOT;
  static const LOGIN_FORGOT_PWD = _Paths.LOGIN_FORGOT_PWD;
  static const COMMUNITY_MESSAGE = _Paths.COMMUNITY_MESSAGE;
  //我的
  static const MY_ME_INDEX = _Paths.MY_ME_INDEX;
  static const MY_SETTINGS_INDEX = _Paths.MY_SETTINGS_INDEX;
  static const MY_SETTINGS_USER = _Paths.MY_SETTINGS_USER;
  static const MY_SAFE = _Paths.MY_SAFE;
  static const MY_SAFE_GOOGLE = _Paths.MY_SAFE_GOOGLE;
  static const MY_SAFE_GOOGLE_BIND = _Paths.MY_SAFE_GOOGLE_BIND;
  static const MY_SAFE_MOBILE = _Paths.MY_SAFE_MOBILE;
  static const MY_SAFE_MOBILE_BIND = _Paths.MY_SAFE_MOBILE_BIND;
  static const MY_SAFE_EMAIL = _Paths.MY_SAFE_EMAIL;
  static const MY_SAFE_EMAIL_BIND = _Paths.MY_SAFE_EMAIL_BIND;
  static const MY_SAFE_PWD_CHANGE = _Paths.MY_SAFE_PWD_CHANGE;
  static const KYC_INDEX = _Paths.KYC_INDEX;
  static const MY_SAFE_WITHDRAWAL_VERIFICATION =
      _Paths.MY_SAFE_WITHDRAWAL_VERIFICATION;
  static const DEL_ACCOUNT = _Paths.DEL_ACCOUNT;
  static const DEL_ACCOUNT_SUCCESS = _Paths.DEL_ACCOUNT_SUCCESS;
  // static const USER_TAG = _Paths.USER_TAG;
  static const REPORT = _Paths.REPORT;
  static const THIRD_ACCOUNT = _Paths.THIRD_ACCOUNT;
  static const BINDING_VERIFICATION = _Paths.BINDING_VERIFICATION;

  static const WEBVIEW = _Paths.WEBVIEW;
  static const TRADE = _Paths.TRADE;
  static const STOCK_KCHART = _Paths.STOCK_KCHART;
  static const APPLY_SUPERTRADE = _Paths.APPLY_SUPERTRADE;
  static const MY_INVITE = _Paths.MY_INVITE;
  static const INVITE_HISTORY_MAIN = _Paths.INVITE_HISTORY_MAIN;

  //资产
  static const ASSETS_MAIN = _Paths.ASSETS_MAIN;
  static const ASSETS_WITHDRAWAL_FIRST = _Paths.ASSETS_WITHDRAWAL_FIRST;
  static const ASSETS_DEPOSIT = _Paths.ASSETS_DEPOSIT;
  static const ASSETS_DEPOSIT_NATIVEURL = _Paths.ASSETS_DEPOSIT_NATIVEURL;

  static const CURRENCY_SELECT = _Paths.CURRENCY_SELECT;

  static const COUPON_CARD_LIST = _Paths.COUPON_CARD_LIST; // 优惠券列表

  //跟单
  static const FOLLOW_ORDERS = _Paths.FOLLOW_ORDERS;
  static const FOLLOW_TAKER_INFO = _Paths.FOLLOW_TAKER_INFO;
  static const FOLLOW_TAKER_LIST = _Paths.FOLLOW_TAKER_LIST;
  static const FOLLOW_MY_STAR = _Paths.FOLLOW_MY_STAR;
  static const MY_TAKE_MANAGE = _Paths.MY_TAKE_MANAGE;
  static const MY_TAKE_SHIELD = _Paths.MY_TAKE_SHIELD;
  static const MY_TAKE_PARTING = _Paths.MY_TAKE_PARTING;
  static const FOLLOW_SETUP_SUCCESS = _Paths.FOLLOW_SETUP_SUCCESS;
  static const FOLLOW_SETUP = _Paths.FOLLOW_SETUP;
  static const MY_FOLLOW = _Paths.MY_FOLLOW;
  static const MY_TAKE = _Paths.MY_TAKE;
  static const MY_TAKE_BLOCK = _Paths.MY_TAKE_BLOCK;

  // 行情
  static const MARKETS_INDEX = _Paths.MARKETS_INDEX;
  static const MARKETS_HOME = _Paths.MARKETS_HOME;
  static const MARKETS_SEARCH = _Paths.MARKETS_SEARCH;

  // 社区
  static const COMMUNITY_INFO = _Paths.COMMUNITY_INFO;
  static const COMMUNITY_INFO_NATIVEURL = _Paths.COMMUNITY_INFO_NATIVEURL;
  static const COMMUNITY_VIDEO_INFO = _Paths.COMMUNITY_VIDEO_INFO;
  static const COMMUNITY_VIDEO_INFO_NATIVEURL =
      _Paths.COMMUNITY_VIDEO_INFO_NATIVEURL;

  static const COMMUNITY_POST = _Paths.COMMUNITY_POST;
  static const CONTRACT_TRANSACTION = _Paths.CONTRACT_TRANSACTION;
  static const ENTRUST = _Paths.ENTRUST;
  static const WALLET_HISTORY = _Paths.WALLET_HISTORY;
  static const ASSETS_TRANSFER = _Paths.ASSETS_TRANSFER;

  /// 现货
  static const SPOT_GOODS = _Paths.SPOT_GOODS;
  static const SPOT_DETAIL = _Paths.SPOT_DETAIL;

  /// 币种详情
  static const CONTRACT_DETAIL = _Paths.CONTRACT_DETAIL;
  static const ASSETS_WITHDRAWAL_CONFIRM = _Paths.ASSETS_WITHDRAWAL_CONFIRM;
  static const ASSETS_WITHDRAWAL_RESULT = _Paths.ASSETS_WITHDRAWAL_RESULT;
  static const ASSETS_SPOTS_INFO = _Paths.ASSETS_SPOTS_INFO;
  static const ASSETS_FUNDS_INFO = _Paths.ASSETS_FUNDS_INFO;

  static const ASSETS_WITHDRAWAL = _Paths.ASSETS_WITHDRAWAL;
  static const COMMONDITY = _Paths.COMMONDITY;
  static const TRADES = _Paths.TRADES;
  static const COMMONDITY_DETAIL = _Paths.COMMONDITY_DETAIL;
  static const LANGUAGE_SET = _Paths.LANGUAGE_SET;
  static const SET_HTTPOVERRIDES = _Paths.SET_HTTPOVERRIDES;
  static const SPOT_HISTORY_MAIN = _Paths.SPOT_HISTORY_MAIN;
  static const CURRENT_ENTRUST = _Paths.CURRENT_ENTRUST;
  static const DEAL = _Paths.DEAL;
  static const HISTORY_ENTRUST = _Paths.HISTORY_ENTRUST;
  static const COMMODITY_CURRENT_ENTRUST = _Paths.COMMODITY_CURRENT_ENTRUST;
  static const COMMODITY_HISTORY_MAIN = _Paths.COMMODITY_HISTORY_MAIN;
  static const SEARCH_INDEX = _Paths.SEARCH_INDEX;
  static const SEARCH_RESULT_MAIN = _Paths.SEARCH_RESULT_MAIN;
  static const FOLLOW_HOME_TRAKER = _Paths.FOLLOW_HOME_TRAKER;
  static const APPLY_SUPERTRADER_STATES = _Paths.APPLY_SUPERTRADER_STATES;
  static const APPLY_SUPERTRADER_SUCCESS = _Paths.APPLY_SUPERTRADER_SUCCESS;
  static const OPEN_CONTRACT = _Paths.OPEN_CONTRACT;
  static const OPEN_CONTRACT_ANSWER = _Paths.OPEN_CONTRACT_ANSWER;
  static const COUPONS_INDEX = _Paths.COUPONS_INDEX;
  static const QUICK_ENTRY = _Paths.QUICK_ENTRY;
  static const CUSTOMER_TOC = _Paths.CUSTOMER_TOC;
  static const CUSTOMER_ORDER = _Paths.CUSTOMER_ORDER;
  static const CUSTOMER_MY = _Paths.CUSTOMER_MY;
  static const CUSTOMER_INDEX = _Paths.CUSTOMER_INDEX;
  static const C2C_APPLY = _Paths.C2C_APPLY;
  static const SALES_COMISSION = _Paths.SALES_COMISSION;
  static const COMISSION_METHOD = _Paths.COMISSION_METHOD;
  static const COMISSION_CARD_FILL = _Paths.COMISSION_CARD_FILL;
  static const ORDER_DETAIL = _Paths.ORDER_DETAIL;
  static const COMMISSION_RECORD = _Paths.COMMISSION_RECORD;
  static const CUSTOMER_APPLY = _Paths.CUSTOMER_APPLY;
  static const CUSTOMER_MAIN = _Paths.CUSTOMER_MAIN;
  static const MERCHANT_APPLY = _Paths.MERCHANT_APPLY;
  static const ASSISTANCE = _Paths.ASSISTANCE;
  static const B2C_ORDER_HISTORY = _Paths.B2C_ORDER_HISTORY;
  static const B2C_CURRENCY_SELECT = _Paths.B2C_CURRENCY_SELECT;
  static const B2C = _Paths.B2C;
  static const COMMUNITY_MESSAGE_NOTIFICATION =
      _Paths.COMMUNITY_MESSAGE_NOTIFICATION;
  static const FAVOURITE_TOPIC = _Paths.FAVOURITE_TOPIC;
  static const TOPIC_NOTIF = _Paths.TOPIC_NOTIF;
  static const FOLLOW_MEMBER = _Paths.FOLLOW_MEMBER;
  static const FAVOURITE_LIST = _Paths.FAVOURITE_LIST;
  static const FAVOURITE_LIST_DETAIL = _Paths.FAVOURITE_LIST_DETAIL;
  static const CUSTOMER_USER = _Paths.CUSTOMER_USER;
  static const CUSTOMER_DEAL = _Paths.CUSTOMER_DEAL;
  static const CUSTOMER_DEAL_ORDER = _Paths.CUSTOMER_DEAL_ORDER;
  static const INTERESTED_LIST = _Paths.INTERESTED_LIST;

  /// 申诉
  static const C2C_APPEAL = _Paths.C2C_APPEAL;
  static const COMISSION_PAYMENT_LIST = _Paths.COMISSION_PAYMENT_LIST;
  static const PAYMENT_CHANNEL = _Paths.PAYMENT_CHANNEL;
  static const SECOND_ORDER_DETAIL = _Paths.SECOND_ORDER_DETAIL;
  static const PERSONAL_PROFILE = _Paths.PERSONAL_PROFILE;
  static const CUSTOMER_ORDER_HANDLE = _Paths.CUSTOMER_ORDER_HANDLE;
  static const CUSTOMER_ORDER_WAIT = _Paths.CUSTOMER_ORDER_WAIT;
  static const CUSTOMER_ORDER_CANCEL = _Paths.CUSTOMER_ORDER_CANCEL;
  static const CUSTOMER_ORDER_APPEAL = _Paths.CUSTOMER_ORDER_APPEAL;

  /// C2C聊天 参数：订单id Get.toNamed(Routes.C2C_CHAT, arguments: '12');
  static const C2C_CHAT = _Paths.C2C_CHAT;
  static const HOT_DETAIL_TOPIC = _Paths.HOT_DETAIL_TOPIC;

  // 路由测试
  static const ROUTES_TEST = _Paths.ROUTES_TEST;
  // static const MEMBER_INFO = _Paths.MEMBER_INFO;
  static const IMMEDIATE_EXCHANGE = _Paths.IMMEDIATE_EXCHANGE;
  static const IMMEDIATE_EXCHANGE_DETAIL = _Paths.IMMEDIATE_EXCHANGE_DETAIL;
  static const WITHDRAW_DETAIL = _Paths.WITHDRAW_DETAIL;
  static const WEAL_INDEX = _Paths.WEAL_INDEX;
  static const NEW_USER_ACTIVITY_PAGE = _Paths.NEW_USER_ACTIVITY_PAGE;
  static const FOLLOW_QUESTIONNAIRE = _Paths.FOLLOW_QUESTIONNAIRE;
  static const FOLLOW_QUESTIONNAIRE_DETAILS =
      _Paths.FOLLOW_QUESTIONNAIRE_DETAILS;
  static const FOLLOW_QUESTIONNAIRE_RESULT = _Paths.FOLLOW_QUESTIONNAIRE_RESULT;
  static const TRADER_REFERRAL_VIEW = _Paths.TRADER_REFERRAL_VIEW;

  static const FOLLOW_USER_REVIEW = _Paths.FOLLOW_USER_REVIEW;
}

abstract class _Paths {
  _Paths._();

  static const SPLASH = '/splash';
  static const MAIN_TAB = '/main-tab';
  static const NOTIFY = '/notify';
  static const NOTICE = '/notice';
  static const COMMUNITY_NOTIFY = '/community_notify-list';
  // static const OFFICE_NOTIFY_LIST = '/office-notify-list';
  // static const SYSTEM_NOTIFY_LIST = '/system-notify-list';

  //登录
  static const LOGIN = '/login';
  static const LOGIN_VERIFICATION = '/login-verification';
  static const LOGIN_REGISTERED = '/login-registered';
  static const LOGIN_REGISTERED_PWD = '/login-registered-pwd';
  static const LOGIN_REGISTERED_VERIFICATION = '/login-registered-verification';
  static const LOGIN_FORGOT = '/login-forgot';
  static const LOGIN_FORGOT_PWD = '/login-forgot-pwd';
  static const ASSOCIATED_ACCOUNT = '/associated_account';
  static const ASSOCIATED_HAS_ACCOUNT = '/associated_has_account';

  //我的
  static const MY_ME_INDEX = '/my-me-index';
  static const MY_SETTINGS_INDEX = '/my-settings-index';
  static const MY_SETTINGS_USER = '/my-settings-user';
  static const MY_SAFE = '/my-safe';
  static const MY_SAFE_GOOGLE = '/my-safe-google';
  static const MY_SAFE_GOOGLE_BIND = '/my-safe-google-bind';
  static const MY_SAFE_MOBILE = '/my-safe-mobile';
  static const MY_SAFE_MOBILE_BIND = '/my-safe-mobile-bind';
  static const MY_SAFE_EMAIL = '/my-safe-email';
  static const MY_SAFE_EMAIL_BIND = '/my-safe-email-bind';
  static const MY_SAFE_PWD_CHANGE = '/my-safe-pwd-change';
  static const KYC_INDEX = '/kyc-index';
  static const MY_SAFE_WITHDRAWAL_VERIFICATION =
      '/my-safe-withdrawal-verification';
  static const DEL_ACCOUNT = '/my-safe-del-account';
  static const DEL_ACCOUNT_SUCCESS = '/my-safe-del-account-success';
  // static const USER_TAG = '/user_tag';
  static const REPORT = '/report';
  static const THIRD_ACCOUNT = '/third_account';

  static const WEBVIEW = '/webview';
  static const TRADE = '/trade';
  static const STOCK_KCHART = '/stock-kchart';
  static const APPLY_SUPERTRADE = '/apply-supertrade';
  static const MY_INVITE = '/my-invite';
  static const INVITE_HISTORY_MAIN = '/my-invite-history';
  static const BINDING_VERIFICATION = '/binding-verification';

  //资产
  static const ASSETS_MAIN = '/assets-main';
  static const ASSETS_WITHDRAWAL_FIRST = '/assets-withdrawal-first';
  static const ASSETS_DEPOSIT = '/assets-deposit';
  static const ASSETS_DEPOSIT_NATIVEURL = '/assets-deposit/:symbol';

  //跟单
  static const FOLLOW_ORDERS = '/follow-orders';
  static const MY_TAKE = '/my-take';
  static const FOLLOW_SETUP = '/follow-setup';
  static const MY_FOLLOW = '/my-follow';

  static const FOLLOW_TAKER_INFO = '/follow-taker-info';
  static const FOLLOW_SETUP_SUCCESS = '/follow-setup-success';
  static const APPLY_SUPERTRADER_STATES = '/apply-supertrader-states';

  //行情
  static const MARKETS_INDEX = '/markets-index';

  //社区

  static const COMMUNITY_INFO = '/community-info';
  static const COMMUNITY_INFO_NATIVEURL = '/community-info/topicNo=:topicNo';
  static const COMMUNITY_VIDEO_INFO = '/community-video-info';
  static const COMMUNITY_VIDEO_INFO_NATIVEURL =
      '/community-video-info/topicNo=:topicNo';
  static const COMMUNITY_POST = '/community-post';
  static const CONTRACT_TRANSACTION = '/contract-transaction';
  static const ENTRUST = '/entrust';

  static const WALLET_HISTORY = '/wallet-history';
  static const ASSETS_TRANSFER = '/assets-transfer';
  static const SPOT_GOODS = '/spot-goods';
  static const SPOT_DETAIL = '/spot-detail';
  static const CONTRACT_DETAIL = '/contract-detail';
  static const CURRENCY_SELECT = '/currency-select';
  static const ASSETS_WITHDRAWAL_CONFIRM = '/assets-withdrawal-confirm';
  static const ASSETS_WITHDRAWAL_RESULT = '/assets-withdrawal-result';

  static const ASSETS_SPOTS_INFO = '/assets-spots-info';
  static const ASSETS_FUNDS_INFO = '/assets-funds-info';
  static const MARKETS_SEARCH = '/markets-search';
  static const ASSETS_WITHDRAWAL = '/assets-withdrawal';
  static const MARKETS_HOME = '/markets-home';
  static const FOLLOW_TAKER_LIST = '/follow-taker-list';
  static const FOLLOW_MY_STAR = '/follow-my-star';
  static const MY_TAKE_MANAGE = '/my-take-manage';
  static const MY_TAKE_SHIELD = '/my-take-shield';
  static const MY_TAKE_PARTING = '/my-take-parting';
  static const COMMONDITY = '/commondity';
  static const TRADES = '/trades';
  static const COMMONDITY_DETAIL = '/commondity-detail';
  static const LANGUAGE_SET = '/language-set';
  static const SET_HTTPOVERRIDES = '/set-http-overrides';
  static const MY_TAKE_BLOCK = '/my-take-block';
  static const SPOT_HISTORY_MAIN = '/spot-history-main';
  static const CURRENT_ENTRUST = '/current-entrust';
  static const DEAL = '/deal';
  static const HISTORY_ENTRUST = '/history-entrust';
  static const COMMODITY_CURRENT_ENTRUST = '/commodity-current-entrust';
  static const COMMODITY_HISTORY_MAIN = '/commodity-history-main';
  //大搜索
  static const SEARCH_INDEX = '/search-index';
  static const SEARCH_RESULT_MAIN = '/search-result-main';
  static const FOLLOW_HOME_TRAKER = '/follow-home-traker';
  static const APPLY_SUPERTRADER_SUCCESS = '/apply-supertrader-success';
  static const OPEN_CONTRACT = '/open-contract';
  static const OPEN_CONTRACT_ANSWER = '/open-contract-answer';
  static const COUPONS_INDEX = '/coupons-index';
  static const COUPON_CARD_LIST = '/coupon-card-list';
  static const QUICK_ENTRY = '/quick-entry';
  static const CUSTOMER_TOC = '/customer-toc';
  static const CUSTOMER_ORDER = '/customer-order';
  static const CUSTOMER_MY = '/customer-my';
  static const CUSTOMER_INDEX = '/customer-index';
  static const CUSTOMER_MAIN = '/customer-main';
  static const C2C_APPLY = '/c2c-apply';
  static const SALES_COMISSION = '/sales-comission';
  static const COMISSION_METHOD = '/comission_method';
  static const COMISSION_CARD_FILL = '/comission_card_fill';
  static const ORDER_DETAIL = '/order_detail';

  static const COMMISSION_RECORD = '/comission_record';
  static const CUSTOMER_APPLY = '/customer_apply';
  static const ASSISTANCE = '/assistance';

  ///Otc
  //b2c
  static const B2C_ORDER_HISTORY = '/b2c-order-history';
  static const B2C_CURRENCY_SELECT = '/b2c-currency-select';
  static const B2C = '/b2c';
  static const CUSTOMER_USER = '/customer-user';
  static const CUSTOMER_DEAL = '/customer-deal';
  static const CUSTOMER_DEAL_ORDER = '/customer-deal-order';
  static const C2C_APPEAL = '/c2c_appeal';
  static const PAYMENT_CHANNEL = '/PAYMENT_CHANNEL';
  static const COMISSION_PAYMENT_LIST = '/comission-payment-list';
  static const SECOND_ORDER_DETAIL = '/second-order-detail';
  static const PERSONAL_PROFILE = '/PERSONAL_PROFILE';
  static const CUSTOMER_ORDER_HANDLE = '/customer-order-handle';
  static const CUSTOMER_ORDER_WAIT = '/customer-order-wait';
  static const CUSTOMER_ORDER_CANCEL = '/customer-order-cancel';
  static const CUSTOMER_ORDER_APPEAL = '/customer-order-appeal';
  static const C2C_CHAT = '/c2c_chat';
  static const COMMUNITY_MESSAGE = '/community-message'; //社区站内信
  static const COMMUNITY_MESSAGE_NOTIFICATION =
      '/community-message-notification'; //社区站内信社区消息通知
  static const FAVOURITE_TOPIC = '/favourite-topic';
  static const TOPIC_NOTIF = '/topic-notif';
  static const FOLLOW_MEMBER = '/follow-member';
  static const FAVOURITE_LIST = '/favourite-list';
  static const FAVOURITE_LIST_DETAIL = '/favourite-list-detail';
  static const HOT_DETAIL_TOPIC = '/hot-detail-topic';
  //路由测试
  static const ROUTES_TEST = '/routes_test';
  static const INTERESTED_LIST = '/interested_list';
  static const IMMEDIATE_EXCHANGE = '/immediate-exchange'; //闪兑
  static const IMMEDIATE_EXCHANGE_DETAIL = '/immediate-exchange-detail';
  static const MERCHANT_APPLY = '/merchant-apply';
  static const WITHDRAW_DETAIL = '/withdraw-detail';
  static const WEAL_INDEX = '/weal-index';
  static const NEW_USER_ACTIVITY_PAGE = '/new-user-activity-page';
  static const FOLLOW_QUESTIONNAIRE = '/follow-questionnaire';
  static const FOLLOW_QUESTIONNAIRE_DETAILS = '/follow-questionnaire-details';
  static const FOLLOW_QUESTIONNAIRE_RESULT = '/follow-questionnaire-result';
  static const TRADER_REFERRAL_VIEW = '/trader-referral-view';

  static const FOLLOW_USER_REVIEW = '/follow-user-review';
}
