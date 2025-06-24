import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/my/safe/binding_verification/bindings/binding_verification_binding.dart';
import 'package:nt_app_flutter/app/modules/my/safe/binding_verification/views/binding_verification_view.dart';

import '../modules/assets/assets_deposit/bindings/assets_deposit_binding.dart';
import '../modules/assets/assets_deposit/views/assets_deposit_view.dart';
import '../modules/assets/assets_funds_info/main/bindings/assets_funds_info_binding.dart';
import '../modules/assets/assets_funds_info/main/views/assets_funds_info_view.dart';
import '../modules/assets/assets_main/bindings/assets_main_binding.dart';
import '../modules/assets/assets_main/views/assets_main_view.dart';
import '../modules/assets/assets_spots_info/bindings/assets_spots_info_binding.dart';
import '../modules/assets/assets_spots_info/views/assets_spots_info_view.dart';
import '../modules/assets/assets_transfer/bindings/assets_transfer_binding.dart';
import '../modules/assets/assets_transfer/views/assets_transfer_view.dart';
import '../modules/assets/assets_withdrawal/bindings/assets_withdrawal_binding.dart';
import '../modules/assets/assets_withdrawal/views/assets_withdrawal_view.dart';
import '../modules/assets/assets_withdrawal_confirm/bindings/assets_withdrawal_confirm_binding.dart';
import '../modules/assets/assets_withdrawal_confirm/bindings/assets_withdrawal_result_binding.dart';
import '../modules/assets/assets_withdrawal_confirm/views/assets_withdrawal_confirm_view.dart';
import '../modules/assets/assets_withdrawal_confirm/views/assets_withdrawal_result_view.dart';
import '../modules/assets/coupon_card_list/bindings/coupon_card_list_binding.dart';
import '../modules/assets/coupon_card_list/views/coupon_card_list_view.dart';
import '../modules/assets/currency_select/bindings/currency_select_binding.dart';
import '../modules/assets/currency_select/views/currency_select_view.dart';
import '../modules/assets/wallet_history/bindings/wallet_history_binding.dart';
import '../modules/assets/wallet_history/views/wallet_history_view.dart';
import '../modules/assets/withdraw_detail/bindings/withdraw_detail_binding.dart';
import '../modules/assets/withdraw_detail/views/withdraw_detail_view.dart';
import '../modules/community/community_info/bindings/community_info_binding.dart';
import '../modules/community/community_info/views/community_info_view.dart';
import '../modules/community/community_message/bindings/community_message_binding.dart';
import '../modules/community/community_message/views/community_message_view.dart';
import '../modules/community/community_video_info/bindings/community_video_info_binding.dart';
import '../modules/community/community_video_info/views/community_video_info_view.dart';
import '../modules/community/favourite_topic/bindings/favourite_topic_binding.dart';
import '../modules/community/favourite_topic/views/favourite_topic_view.dart';
import '../modules/community/follow_member/bindings/follow_member_binding.dart';
import '../modules/community/follow_member/views/follow_member_view.dart';
import '../modules/community/hot_detail_topic/bindings/hot_detail_topic_binding.dart';
import '../modules/community/hot_detail_topic/views/hot_detail_topic_view.dart';
import '../modules/community/interested_list/bindings/interested_list_binding.dart';
import '../modules/community/interested_list/views/interested_list_view.dart';
import '../modules/community/post_index/bindings/post_index_binding.dart';
import '../modules/community/post_index/views/post_index_view.dart';
import '../modules/follow/follow_home_traker/bindings/follow_home_traker_binding.dart';
import '../modules/follow/follow_home_traker/views/follow_home_traker_view.dart';
import '../modules/follow/follow_my_star/bindings/follow_my_star_binding.dart';
import '../modules/follow/follow_my_star/views/follow_my_star_view.dart';
import '../modules/follow/follow_orders/bindings/follow_orders_binding.dart';
import '../modules/follow/follow_orders/views/follow_orders_view.dart';
import '../modules/follow/follow_questionnaire/bindings/follow_questionnaire_binding.dart';
import '../modules/follow/follow_questionnaire/bindings/follow_questionnaire_details_binding.dart';
import '../modules/follow/follow_questionnaire/bindings/follow_questionnaire_result_binding.dart';
import '../modules/follow/follow_questionnaire/bindings/trader_referral_binding.dart';
import '../modules/follow/follow_questionnaire/views/follow_questionnaire_details_view.dart';
import '../modules/follow/follow_questionnaire/views/follow_questionnaire_result_view.dart';
import '../modules/follow/follow_questionnaire/views/follow_questionnaire_view.dart';
import '../modules/follow/follow_questionnaire/views/trader_referral_view.dart';
import '../modules/follow/follow_setup/bindings/follow_setup_binding.dart';
import '../modules/follow/follow_setup/views/follow_setup_view.dart';
import '../modules/follow/follow_setup/widgets/follow_setup_success/bindings/follow_setup_success_binding.dart';
import '../modules/follow/follow_setup/widgets/follow_setup_success/views/follow_setup_success_view.dart';
import '../modules/follow/follow_taker_info/bindings/follow_taker_info_binding.dart';
import '../modules/follow/follow_taker_info/views/follow_taker_info_view.dart';
import '../modules/follow/follow_taker_info/wsubview/bindings/follow_user_review_binding.dart';
import '../modules/follow/follow_taker_info/wsubview/views/follow_user_review_view.dart';
import '../modules/follow/follow_taker_list/bindings/follow_taker_list_binding.dart';
import '../modules/follow/follow_taker_list/views/follow_taker_list_view.dart';
import '../modules/follow/my_follow/bindings/my_follow_binding.dart';
import '../modules/follow/my_follow/views/my_follow_view.dart';
import '../modules/follow/my_take/bindings/my_take_binding.dart';
import '../modules/follow/my_take/views/my_take_view.dart';
import '../modules/follow/my_take_block/bindings/my_take_block_binding.dart';
import '../modules/follow/my_take_block/views/my_take_block_view.dart';
import '../modules/follow/my_take_manage/bindings/my_take_manage_binding.dart';
import '../modules/follow/my_take_manage/views/my_take_manage_view.dart';
import '../modules/follow/my_take_parting/bindings/my_take_parting_binding.dart';
import '../modules/follow/my_take_parting/views/my_take_parting_view.dart';
import '../modules/follow/my_take_shield/bindings/my_take_shield_binding.dart';
import '../modules/follow/my_take_shield/views/my_take_shield_view.dart';
import '../modules/follow/open_contract/open_contract/bindings/open_contract_binding.dart';
import '../modules/follow/open_contract/open_contract/views/open_contract_view.dart';
import '../modules/follow/open_contract/open_contract_answer/bindings/open_contract_answer_binding.dart';
import '../modules/follow/open_contract/open_contract_answer/views/open_contract_answer_view.dart';
import '../modules/follow/supertrade/Apply_supertrader_states/bindings/apply_supertrader_states_binding.dart';
import '../modules/follow/supertrade/Apply_supertrader_states/views/apply_supertrader_states_view.dart';
import '../modules/follow/supertrade/Apply_supertrader_success/bindings/apply_supertrader_success_binding.dart';
import '../modules/follow/supertrade/Apply_supertrader_success/views/apply_supertrader_success_view.dart';
import '../modules/follow/supertrade/apply_supertrade/bindings/apply_supertrade_binding.dart';
import '../modules/follow/supertrade/apply_supertrade/views/apply_supertrade_view.dart';
import '../modules/home/bindings/main_tab_binding.dart';

import '../modules/login/forgot/bindings/login_forgot_binding.dart';
import '../modules/login/forgot/views/login_forgot_view.dart';
import '../modules/login/forgot_pwd/bindings/login_forgot_pwd_binding.dart';
import '../modules/login/forgot_pwd/views/login_forgot_pwd_view.dart';
import '../modules/login/login/bindings/login_binding.dart';
import '../modules/login/login/views/login_view.dart';
import '../modules/login/login_verification/bindings/login_verification_binding.dart';
import '../modules/login/login_verification/views/login_verification_view.dart';
import '../modules/login/registered/bindings/login_registered_binding.dart';
import '../modules/login/registered/views/login_registered_view.dart';
import '../modules/login/registered_pwd/bindings/login_registered_pwd_binding.dart';
import '../modules/login/registered_pwd/views/login_registered_pwd_view.dart';
import '../modules/login/registered_verification/bindings/login_registered_verification_binding.dart';
import '../modules/login/registered_verification/views/login_registered_verification_view.dart';
import '../modules/main_tab/bindings/main_tab_binding.dart';
import '../modules/main_tab/views/main_tab_view.dart';
import '../modules/markets/market/bindings/markets_index_binding.dart';
import '../modules/markets/market/views/markets_index_view.dart';
import '../modules/markets/markets_home/bindings/markets_home_binding.dart';
import '../modules/markets/markets_home/views/markets_home_view.dart';
import '../modules/my/coupons/bindings/coupons_index_binding.dart';
import '../modules/my/coupons/views/coupons_index_view.dart';
import '../modules/my/http_overrides/bindings/http_overrides_binding.dart';
import '../modules/my/http_overrides/views/http_overrides_view.dart';
import '../modules/my/invite/index/bindings/my_invite_binding.dart';
import '../modules/my/invite/index/views/my_invite_view.dart';
import '../modules/my/invite/invite_history/main/bindings/invite_history_main_binding.dart';
import '../modules/my/invite/invite_history/main/views/invite_history_main_view.dart';
import '../modules/my/kyc/bindings/kyc_index_binding.dart';
import '../modules/my/kyc/views/kyc_index_view.dart';
import '../modules/my/language_set/bindings/language_set_binding.dart';
import '../modules/my/language_set/views/language_set_view.dart';
import '../modules/my/me/bindings/me_index_binding.dart';
import '../modules/my/me/views/me_index_view.dart';
import '../modules/my/question/bindings/question_index_binding.dart';
import '../modules/my/question/views/question_index_view.dart';
import '../modules/my/quick_entry/bindings/quick_entry_binding.dart';
import '../modules/my/quick_entry/views/quick_entry_view.dart';
import '../modules/my/safe/del_account/bindings/del_account_binding.dart';
import '../modules/my/safe/del_account/views/del_account_view.dart';
import '../modules/my/safe/del_account_success/bindings/del_account_success_binding.dart';
import '../modules/my/safe/del_account_success/views/del_account_success_view.dart';
import '../modules/my/safe/email/bind/bindings/email_bind_binding.dart';
import '../modules/my/safe/email/bind/views/email_bind_view.dart';
import '../modules/my/safe/email/index/bindings/email_index_binding.dart';
import '../modules/my/safe/email/index/views/email_index_view.dart';
import '../modules/my/safe/google/bind/bindings/google_bind_binding.dart';
import '../modules/my/safe/google/bind/views/google_bind_view.dart';
import '../modules/my/safe/google/index/bindings/google_index_binding.dart';
import '../modules/my/safe/google/index/views/google_index_view.dart';
import '../modules/my/safe/index/bindings/my_safe_binding.dart';
import '../modules/my/safe/index/views/my_safe_view.dart';
import '../modules/my/safe/mobile/bind/bindings/mobile_bind_binding.dart';
import '../modules/my/safe/mobile/bind/views/mobile_bind_view.dart';
import '../modules/my/safe/mobile/index/bindings/mobile_index_binding.dart';
import '../modules/my/safe/mobile/index/views/mobile_index_view.dart';
import '../modules/my/safe/pwd/bindings/pwd_change_binding.dart';
import '../modules/my/safe/pwd/views/pwd_change_index_view.dart';
import '../modules/my/safe/third_account/bindings/third_account_binding.dart';
import '../modules/login/associated_has_account/bindings/associated_has_account_binding.dart';
import '../modules/login/associated_has_account/views/associated_has_account_view.dart';
import '../modules/login/associated_account/bindings/associated_account_binding.dart';
import '../modules/login/associated_account/views/associated_account_view.dart';
import '../modules/my/safe/third_account/views/third_account_view.dart';
import '../modules/my/safe/withdrawal/verification/bindings/withdrawal_verification_binding.dart';
import '../modules/my/safe/withdrawal/verification/views/withdrawal_verification_view.dart';
import '../modules/my/settings/index/bindings/settings_index_binding.dart';
import '../modules/my/settings/index/views/settings_index_view.dart';
import '../modules/my/settings/user/bindings/my_settings_user_binding.dart';
import '../modules/my/settings/user/views/my_settings_user_view.dart';
import '../modules/my/weal_index/bindings/weal_index_binding.dart';
import '../modules/my/weal_index/views/weal_index_view.dart';
import '../modules/new_user_activity_page/bindings/new_user_activity_page_binding.dart';
import '../modules/new_user_activity_page/views/new_user_activity_page_view.dart';
import '../modules/notify/communnity_notify/bindings/communnity_notify_binding.dart';
import '../modules/notify/communnity_notify/views/communnity_notify_view.dart';
import '../modules/notify/message/bindings/message_binding.dart';
import '../modules/notify/message/views/message_view.dart';
import '../modules/notify/notice/bindings/notice_binding.dart';
import '../modules/notify/notice/views/notice_view.dart';
import '../modules/notify/system_notify/bindings/system_notify_list_binding.dart';
import '../modules/otc/b2c/currency_select/bindings/currency_select_binding.dart';
import '../modules/otc/b2c/currency_select/views/currency_select_view.dart';
import '../modules/otc/b2c/main/bindings/b2c_binding.dart';
import '../modules/otc/b2c/main/views/b2c_view.dart';
import '../modules/otc/b2c/order_history/bindings/order_history_binding.dart';
import '../modules/otc/b2c/order_history/views/order_history_view.dart';
import '../modules/otc/c2c/apply/apply_index.dart';
import '../modules/otc/c2c/apply/bindings/customer_apply_binding.dart';
import '../modules/otc/c2c/apply/merchant/bindings/merchant_apply_binding.dart';
import '../modules/otc/c2c/apply/merchant/views/merchant_apply_view.dart';
import '../modules/otc/c2c/apply/views/customer_apply_view.dart';
import '../modules/otc/c2c/assistance/bindings/assistance_binding.dart';
import '../modules/otc/c2c/assistance/views/assistance_view.dart';
import '../modules/otc/c2c/customer/bindings/customer_index_binding.dart';
import '../modules/otc/c2c/customer/views/customer_index_view.dart';
import '../modules/otc/c2c/deal/deal/bindings/customer_deal_binding.dart';
import '../modules/otc/c2c/deal/deal/views/customer_deal_view.dart';
import '../modules/otc/c2c/deal/deal_order/bindings/customer_deal_order_binding.dart';
import '../modules/otc/c2c/deal/deal_order/views/customer_deal_order_view.dart';
import '../modules/otc/c2c/deal/deal_order_appeal/bindings/customer_order_appeal_binding.dart';
import '../modules/otc/c2c/deal/deal_order_appeal/views/customer_order_appeal_view.dart';
import '../modules/otc/c2c/deal/deal_order_cancel/bindings/customer_order_cancel_binding.dart';
import '../modules/otc/c2c/deal/deal_order_cancel/views/customer_order_cancel_view.dart';
import '../modules/otc/c2c/deal/deal_order_handle/bindings/customer_handle_binding.dart';
import '../modules/otc/c2c/deal/deal_order_handle/views/customer_handle_view.dart';
import '../modules/otc/c2c/deal/deal_order_wait/bindings/customer_order_wait_binding.dart';
import '../modules/otc/c2c/deal/deal_order_wait/views/customer_order_wait_view.dart';
import '../modules/otc/c2c/home/bindings/customer_toc_binding.dart';
import '../modules/otc/c2c/home/views/customer_toc_view.dart';
import '../modules/otc/c2c/im/appeal/bindings/appeal_binding.dart';
import '../modules/otc/c2c/im/appeal/views/appeal_view.dart';
import '../modules/otc/c2c/im/chat/bindings/chat_binding.dart';
import '../modules/otc/c2c/im/chat/views/chat_view.dart';
import '../modules/otc/c2c/main/bindings/customer_main_binding.dart';
import '../modules/otc/c2c/main/views/customer_main_view.dart';
import '../modules/otc/c2c/my/bindings/customer_my_binding.dart';
import '../modules/otc/c2c/my/comission_card_fill/bindings/comission_card_fill_binding.dart';
import '../modules/otc/c2c/my/comission_card_fill/views/comission_card_fill_view.dart';
import '../modules/otc/c2c/my/comission_method/bindings/comission_method_binding.dart';
import '../modules/otc/c2c/my/comission_method/views/comission_method_view.dart';
import '../modules/otc/c2c/my/comission_payment_list/bindings/comission_payment_list_binding.dart';
import '../modules/otc/c2c/my/comission_payment_list/views/comission_payment_list_view.dart';
import '../modules/otc/c2c/my/comission_payment_list/views/payment_channel_list_view.dart';
import '../modules/otc/c2c/my/commission_record/bindings/commission_record_binding.dart';
import '../modules/otc/c2c/my/commission_record/views/commission_record_view.dart';
import '../modules/otc/c2c/my/sales_comission/bindings/sales_comission_binding.dart';
import '../modules/otc/c2c/my/sales_comission/views/sales_comission_view.dart';
import '../modules/otc/c2c/my/views/customer_my_view.dart';
import '../modules/otc/c2c/order/bindings/customer_order_binding.dart';
import '../modules/otc/c2c/order/views/customer_order_view.dart';
import '../modules/otc/c2c/personal_profile/bindings/personal_profile_binding.dart';
import '../modules/otc/c2c/personal_profile/views/personal_profile_view.dart';
import '../modules/otc/c2c/user/bindings/customer_user_binding.dart';
import '../modules/otc/c2c/user/views/customer_user_view.dart';
import '../modules/routes_test/bindings/routes_test_binding.dart';
import '../modules/routes_test/views/routes_test_view.dart';
import '../modules/search/search/bindings/search_index_binding.dart';
import '../modules/search/search/views/search_index_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/transation/commodity/bindings/commodity_binding.dart';
import '../modules/transation/commodity/views/commodity_view.dart';
import '../modules/transation/commodity_detail/detail/bindings/commodity_detail_binding.dart';
import '../modules/transation/commodity_detail/detail/views/commodity_detail_view.dart';
import '../modules/transation/commodity_detail/price/bindings/commodity_price_binding.dart';
import '../modules/transation/commodity_history/commodity_history_main/bindings/commodity_history_main_binding.dart';
import '../modules/transation/commodity_history/commodity_history_main/views/commodity_history_main_view.dart';
import '../modules/transation/commodity_history/commodity_history_order/bindings/commodity_history_order_binding.dart';
import '../modules/transation/commodity_history/commodity_history_trade/bindings/commodity_history_trade_binding.dart';
import '../modules/transation/commodity_history/commodity_history_transaction/bindings/commodity_history_transaction_binding.dart';
import '../modules/transation/commodity_history/commodity_open_order/bindings/commodity_open_order_binding.dart';
import '../modules/transation/contract/bindings/contract_binding.dart';
import '../modules/transation/contract/views/contract_view.dart';
import '../modules/transation/contract_detail/detail/bindings/contract_detail_binding.dart';
import '../modules/transation/contract_detail/detail/views/contract_detail_view.dart';
import '../modules/transation/contract_detail/price/bindings/contract_price_binding.dart';
import '../modules/transation/entrust/bindings/entrust_binding.dart';
import '../modules/transation/entrust/views/entrust_view.dart';
import '../modules/transation/immediate_exchange/immediate_exchange_detail/bindings/immediate_exchange_detail_binding.dart';
import '../modules/transation/immediate_exchange/immediate_exchange_detail/views/immediate_exchange_detail_view.dart';
import '../modules/transation/immediate_exchange/main/bindings/immediate_exchange_binding.dart';
import '../modules/transation/immediate_exchange/main/views/immediate_exchange_view.dart';
import '../modules/transation/spot_detail/detail/bindings/spot_detail_binding.dart';
import '../modules/transation/spot_detail/detail/views/spot_detail_view.dart';
import '../modules/transation/spot_goods/bindings/spot_goods_binding.dart';
import '../modules/transation/spot_goods/views/spot_goods_view.dart';
import '../modules/transation/spot_history/current_entrust/bindings/spot_current_entrust_binding.dart';
import '../modules/transation/spot_history/current_entrust/views/spot_current_entrust_view.dart';
import '../modules/transation/spot_history/deal/bindings/spot_deal_binding.dart';
import '../modules/transation/spot_history/deal/views/spot_deal_view.dart';
import '../modules/transation/spot_history/history_entrust/bindings/spot_history_entrust_binding.dart';
import '../modules/transation/spot_history/history_entrust/views/spot_history_entrust_view.dart';
import '../modules/transation/spot_history/spot_history_main/bindings/spot_history_main_binding.dart';
import '../modules/transation/spot_history/spot_history_main/views/spot_history_main_view.dart';
import '../modules/transation/trades/bindings/trades_binding.dart';
import '../modules/transation/trades/views/trades_view.dart';
import '../modules/webview/bindings/webview_binding.dart';
import '../modules/webview/views/webview_page.dart';
import '../utils/utilities/platform_util.dart';
import 'middlewares/auth_middleware.dart';

part 'app_routes.dart';

// 注*：每个page都单独加transition，是因为如果全局设置默认的transition，部分页面会很奇怪，比如我的页面从左滑到右打开，上一个页面会很奇怪
class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      bindings: [SplashBinding(), LanguageSetBinding()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MAIN_TAB,
      page: () => const MainTabView(),
      bindings: [
        MainTabBinding(),
        HomeIndexBinding(),
        MarketsIndexBinding(),
        FollowOrdersBinding(),
        TradesBinding(),
        ContractBinding(),
        SpotGoodsBinding(),
        if (!MyPlatFormUtil.isIOS()) CommodityBinding(),
        AssetsMainBinding(),
        MarketsHomeBinding(),
        FollowHomeTrakerBinding(),
        MyFollowBinding(),
        FollowTakerInfoBinding(),
      ],
    ),
    GetPage(
      name: _Paths.NOTIFY,
      page: () => const MessageListView(),
      bindings: [MessageBinding(), SystemNotifyListBinding()],
      // middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),

    //公告
    GetPage(
      name: _Paths.NOTICE,
      page: () => const NoticeListView(),
      bindings: [NoticeBinding()],
      transition: Transition.cupertino,
    ),
    //登录模块
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginIndexView(),
      binding: LoginIndexBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.LOGIN_REGISTERED,
      page: () => const LoginRegisteredView(),
      binding: LoginRegisteredBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.LOGIN_REGISTERED_PWD,
      page: () => const LoginRegisteredPwdView(),
      binding: LoginRegisteredPwdBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.LOGIN_VERIFICATION,
      page: () => const LoginVerificationView(),
      binding: LoginVerificationBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.LOGIN_REGISTERED_VERIFICATION,
      page: () => const LoginRegisteredVerificationView(),
      binding: LoginRegisteredVerificationBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.LOGIN_FORGOT,
      page: () => const LoginForgotView(),
      binding: LoginForgotBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.LOGIN_FORGOT_PWD,
      page: () => const LoginForgotPwdView(),
      binding: LoginForgotPwdBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ASSOCIATED_ACCOUNT,
      page: () => const AssociatedAccountView(),
      binding: AssociatedAccountBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ASSOCIATED_HAS_ACCOUNT,
      page: () => const AssociatedHasAccountView(),
      binding: AssociatedHasAccountBinding(),
      transition: Transition.cupertino,
    ),
    //我的模块
    GetPage(
      name: _Paths.MY_ME_INDEX,
      page: () => MeIndexView(),
      binding: MeIndexBinding(),
      transition: Transition.leftToRight,
      opaque: false,
    ),
    GetPage(
      name: _Paths.MY_SETTINGS_INDEX,
      page: () => MySettingsView(),
      binding: MySettingsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SETTINGS_USER,
      page: () => MySettingsUserView(),
      binding: MySettingsUserBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SAFE,
      page: () => MySafeView(),
      binding: MySafeBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SAFE_GOOGLE,
      page: () => const MySafeGoogleView(),
      binding: MySafeGoogleBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SAFE_GOOGLE_BIND,
      page: () => const MySafeGoogleBindView(),
      binding: MySafeGoogleBindBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SAFE_MOBILE,
      page: () => const MySafeMobileView(),
      binding: MySafeMobileBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SAFE_MOBILE_BIND,
      page: () => const MySafeMobileBindView(),
      binding: MySafeMobileBindBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SAFE_EMAIL,
      page: () => const MySafeEmailView(),
      binding: MySafeEmailBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SAFE_EMAIL_BIND,
      page: () => const MySafeEmailBindView(),
      binding: MySafeEmailBindBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SAFE_PWD_CHANGE,
      page: () => const MySafePwdChangeView(),
      binding: MySafePwdChangeBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.KYC_INDEX,
      page: () => KycIndexView(),
      binding: KycIndexBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_SAFE_WITHDRAWAL_VERIFICATION,
      page: () => const MySafeWithdrawalVerificationView(),
      binding: MySafeWithdrawalVerificationBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.DEL_ACCOUNT,
      page: () => DelAccountView(),
      binding: DelAccountBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.DEL_ACCOUNT_SUCCESS,
      page: () => DelAccountSuccessView(),
      binding: DelAccountSuccessBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => QuestionIndexView(),
      binding: QuestionIndexBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.THIRD_ACCOUNT,
      page: () => const ThirdAccountView(),
      binding: ThirdAccountBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.BINDING_VERIFICATION,
      page: () => const BindingVerificationView(),
      binding: BindingVerificationBinding(),
      transition: Transition.cupertino,
    ),

    //内部浏览器
    GetPage(
      name: _Paths.WEBVIEW,
      page: () => const WebviewPage(),
      binding: WebviewBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.APPLY_SUPERTRADE,
      page: () => const ApplySupertradeView(),
      binding: ApplySupertradeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_INVITE,
      page: () => MeInviteView(),
      binding: MeInviteBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.INVITE_HISTORY_MAIN,
      page: () => const InviteHistoryMainView(),
      binding: InviteHistoryMainBinding(),
      transition: Transition.cupertino,
    ),
    //资产模块
    GetPage(
      name: _Paths.ASSETS_MAIN,
      page: () => const AssetsMainView(),
      binding: AssetsMainBinding(),
    ),
    GetPage(
      name: _Paths.ASSETS_DEPOSIT,
      page: () => const AssetsDepositView(),
      binding: AssetsDepositBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ASSETS_DEPOSIT_NATIVEURL,
      page: () => const AssetsDepositView(),
      binding: AssetsDepositBinding(),
      transition: Transition.cupertino,
    ),

    //跟单模块
    GetPage(
      name: _Paths.FOLLOW_ORDERS,
      page: () => const FollowOrdersView(),
      binding: FollowOrdersBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.FOLLOW_TAKER_INFO,
      page: () => const FollowTakerInfoView(),
      binding: FollowTakerInfoBinding(),
      // middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.FOLLOW_SETUP,
      page: () => const FollowSetupView(),
      binding: FollowSetupBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    // GetPage(
    //   name: _Paths.MEMBER_INFO,
    //   page: () => const MemberInfoView(),
    //   transition: Transition.cupertino,
    // ),
    GetPage(
      name: _Paths.MY_FOLLOW,
      page: () => const MyFollowView(),
      binding: MyFollowBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_TAKE,
      page: () => const MyTakeView(),
      binding: MyTakeBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.FOLLOW_SETUP_SUCCESS,
      page: () => const FollowSetupSuccessView(),
      binding: FollowSetupSuccessBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.fade,
    ),

    // 行情
    GetPage(
      name: _Paths.MARKETS_INDEX,
      page: () => const MarketsIndexView(),
      binding: MarketsIndexBinding(),
    ),

    /// 社区

    // 帖子详情-图文
    GetPage(
      name: _Paths.COMMUNITY_INFO,
      page: () => const CommunityInfoView(),
      binding: CommunityInfoBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.COMMUNITY_INFO_NATIVEURL,
      page: () => const CommunityInfoView(),
      binding: CommunityInfoBinding(),
      transition: Transition.cupertino,
    ),
    // 帖子详情-视频
    GetPage(
      name: _Paths.COMMUNITY_VIDEO_INFO,
      page: () => const CommunityVideoInfoView(),
      binding: CommunityVideoInfoBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.COMMUNITY_VIDEO_INFO_NATIVEURL,
      page: () => const CommunityVideoInfoView(),
      binding: CommunityVideoInfoBinding(),
      transition: Transition.cupertino,
    ),
    // 社区-发帖
    GetPage(
      name: _Paths.COMMUNITY_POST,
      page: () => const PostIndexView(),
      binding: PostIndexBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.CONTRACT_TRANSACTION,
      page: () => const ContractView(),
      binding: ContractBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ENTRUST,
      page: () => const EntrustView(),
      binding: EntrustBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
      children: [
        GetPage(
          name: _Paths.ENTRUST,
          page: () => const EntrustView(),
          binding: EntrustBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.WALLET_HISTORY,
      page: () => const WalletHistoryView(),
      binding: WalletHistoryBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ASSETS_TRANSFER,
      page: () => const AssetsTransferView(),
      binding: AssetsTransferBinding(),
      transition: Transition.cupertino,
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.CURRENCY_SELECT,
      page: () => const CurrencySelectView(),
      binding: CurrencySelectBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ASSETS_WITHDRAWAL_CONFIRM,
      page: () => const AssetsWithdrawalConfirmView(),
      binding: AssetsWithdrawalConfirmBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ASSETS_WITHDRAWAL_RESULT,
      page: () => const AssetsWithdrawalResultView(),
      binding: AssetsWithdrawalResultBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ASSETS_SPOTS_INFO,
      page: () => const AssetsSpotsHistoryView(),
      binding: AssetsSpotsHistoryBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ASSETS_FUNDS_INFO,
      page: () => const AssetsFundsInfoView(),
      binding: AssetsFundsInfoBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.SPOT_GOODS,
      page: () => const SpotGoodsView(),
      binding: SpotGoodsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.SPOT_DETAIL,
      page: () => const SpotDetailView(),
      binding: SpotDetailBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.CONTRACT_DETAIL,
      page: () => const ContractDetailView(),
      bindings: [ContractDetailBinding(), ContractPriceBinding()],
      transition: Transition.cupertino,
    ),

    GetPage(
      name: _Paths.ASSETS_WITHDRAWAL,
      page: () => const AssetsWithdrawalView(),
      binding: AssetsWithdrawalBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MARKETS_HOME,
      page: () => const MarketsHomeView(),
      binding: MarketsHomeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.FOLLOW_TAKER_LIST,
      page: () => const FollowTakerListView(),
      binding: FollowTakerListBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.FOLLOW_MY_STAR,
      page: () => const FollowMyStarView(),
      binding: FollowMyStarBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_TAKE_MANAGE,
      page: () => const MyTakeManageView(),
      binding: MyTakeManageBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: _Paths.MY_TAKE_SHIELD,
      page: () => const MyTakeShieldView(),
      binding: MyTakeShieldBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_TAKE_PARTING,
      page: () => const MyTakePartingView(),
      binding: MyTakePartingBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.COMMONDITY,
      page: () => const CommodityView(),
      binding: CommodityBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.TRADES,
      page: () => const TradesView(),
      binding: TradesBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.COMMONDITY_DETAIL,
      page: () => const CommodityDetailView(),
      bindings: [CommodityDetailBinding(), CommodityPriceBinding()],
      transition: Transition.cupertino,
    ),

    GetPage(
      name: _Paths.LANGUAGE_SET,
      page: () => const LanguageSetView(),
      binding: LanguageSetBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: _Paths.SET_HTTPOVERRIDES,
      page: () => const SetHttpOverridesView(),
      binding: SetHttpOverridesBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MY_TAKE_BLOCK,
      page: () => const MyTakeBlockView(),
      binding: MyTakeBlockBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.SPOT_HISTORY_MAIN,
      page: () => const SpotHistoryMainView(),
      binding: SpotHistoryMainBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: _Paths.CURRENT_ENTRUST,
      page: () => const SpotCurrentEntrustView(),
      binding: SpotCurrentEntrustBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.DEAL,
      page: () => const SpotDealView(),
      binding: SpotDealBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.HISTORY_ENTRUST,
      page: () => const SpotHistoryEntrustView(),
      binding: SpotHistoryEntrustBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.COMMODITY_HISTORY_MAIN,
      page: () => const CommodityHistoryMainView(),
      bindings: [
        CommodityHistoryMainBinding(),
        CommodityOpenOrderBinding(),
        CommodityHistoryOrderBinding(),
        CommodityHistoryTradeBinding(),
        CommodityHistoryTransactionBinding(),
      ],
      transition: Transition.cupertino,
    ),

    //大搜索
    GetPage(
      name: _Paths.SEARCH_INDEX,
      page: () => const SearchIndexView(),
      binding: SearchIndexBinding(),
    ),
    // GetPage(
    //   name: _Paths.SEARCH_RESULT_MAIN,
    //   page: () => const SearchResultMainView(),
    //   binding: SearchResultMainBinding(),
    //   transition: Transition.cupertino,
    // ),
    GetPage(
      name: _Paths.FOLLOW_HOME_TRAKER,
      page: () => const FollowHomeTrakerView(),
      binding: FollowHomeTrakerBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.APPLY_SUPERTRADER_STATES,
      page: () => const ApplySupertraderStatesView(),
      binding: ApplySupertraderStatesBinding(),
    ),
    GetPage(
      name: _Paths.APPLY_SUPERTRADER_SUCCESS,
      page: () => const ApplySupertraderSuccessView(),
      binding: ApplySupertraderSuccessBinding(),
    ),
    GetPage(
      name: _Paths.OPEN_CONTRACT,
      page: () => const OpenContractView(),
      binding: OpenContractBinding(),
    ),
    GetPage(
      name: _Paths.OPEN_CONTRACT_ANSWER,
      page: () => const OpenContractAnswerView(),
      binding: OpenContractAnswerBinding(),
    ),
    GetPage(
      name: _Paths.COUPONS_INDEX,
      page: () => const CouponsIndexView(),
      binding: CouponsIndexBinding(),
    ),
    GetPage(
      name: _Paths.COUPON_CARD_LIST,
      page: () => const CouponCardListView(),
      binding: CouponCardListBinding(),
    ),
    // 快捷入口
    GetPage(
      name: _Paths.QUICK_ENTRY,
      page: () => const QuickEntryView(),
      binding: QuickEntryBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.CUSTOMER_TOC,
      page: () => const CustomerTocView(),
      binding: CustomerTocBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_ORDER,
      page: () => const CustomerOrderView(),
      binding: CustomerOrderBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.CUSTOMER_ORDER_HANDLE,
      page: () => const CustomerOrderHandleView(),
      binding: CustomerOrderHandleBinding(),
      transition: Transition.cupertino,
      preventDuplicates: false,
    ),
    GetPage(
      name: _Paths.CUSTOMER_ORDER_WAIT,
      page: () => const CustomerOrderWaitView(),
      binding: CustomerOrderWaitBinding(),
      transition: Transition.cupertino,
      preventDuplicates: false,
    ),
    GetPage(
      name: _Paths.CUSTOMER_ORDER_CANCEL,
      page: () => const CustomerOrderCancelView(),
      binding: CustomerOrderCancelBinding(),
      transition: Transition.cupertino,
      preventDuplicates: false,
    ),
    GetPage(
      name: _Paths.CUSTOMER_ORDER_APPEAL,
      page: () => const CustomerOrderAppealView(),
      binding: CustomerOrderAppealBinding(),
      transition: Transition.cupertino,
      preventDuplicates: false,
    ),

    GetPage(
      name: _Paths.CUSTOMER_MY,
      page: () => const CustomerMyView(),
      binding: CustomerMyBinding(),
    ),

    GetPage(
      name: _Paths.C2C_APPLY,
      page: () => const ApplyIndexView(),
      binding: CustomerApplyBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_APPLY,
      page: () => const CustomerApplyView(),
      binding: CustomerApplyBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.CUSTOMER_INDEX,
      page: () => const CustomerIndexView(),
      binding: CustomerMainBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_MAIN,
      page: () => const CustomerMainView(),
      transition: Transition.cupertino,
      bindings: [
        CustomerMainBinding(),
        CustomerIndexBinding(),
        CustomerTocBinding(),
        CustomerOrderBinding(),
        CustomerMyBinding(),
        B2cBinding(),
      ],
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: _Paths.SALES_COMISSION,
      page: () => const SalesComissionView(),
      binding: SalesComissionBinding(),
    ),
    GetPage(
      name: _Paths.COMISSION_METHOD,
      page: () => const ComissionMethodView(),
      binding: ComissionMethodBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.COMISSION_CARD_FILL,
      page: () => const ComissionCardFillView(),
      binding: ComissionCardFillBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.COMMISSION_RECORD,
      page: () => const CommissionRecordView(),
      binding: CommissionRecordBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ASSISTANCE,
      page: () => AssistanceView(),
      binding: AssistanceBinding(),
    ),

    ///Otc
    ///b2c
    //订单历史
    GetPage(
      name: _Paths.B2C_ORDER_HISTORY,
      page: () => const B2cOrderHistoryView(),
      binding: B2cOrderHistoryBinding(),
      transition: Transition.cupertino,
    ),
    //币种选择
    GetPage(
      name: _Paths.B2C_CURRENCY_SELECT,
      page: () => const B2cCurrencySelectView(),
      binding: B2cCurrencySelectBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.B2C,
      page: () => const B2cView(),
      binding: B2cBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_USER,
      page: () => const CustomerUserView(),
      binding: CustomerUserBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_DEAL,
      page: () => const CustomerDealView(),
      binding: CustomerDealBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.CUSTOMER_DEAL_ORDER,
      page: () => const CustomerDealOrderView(),
      binding: CustomerDealOrderBinding(),
      transition: Transition.cupertino,
      preventDuplicates: false,
    ),
    GetPage(
      name: _Paths.C2C_APPEAL,
      page: () => const AppealView(),
      binding: AppealBinding(),
    ),
    GetPage(
      name: _Paths.COMISSION_PAYMENT_LIST,
      page: () => const ComissionPaymentListView(),
      binding: ComissionPaymentListBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_CHANNEL,
      page: () => const PaymentChannelListView(),
    ),
    GetPage(
      name: _Paths.PERSONAL_PROFILE,
      page: () => const PersonalProfileView(),
      binding: PersonalProfileBinding(),
    ),
    GetPage(
      name: _Paths.C2C_CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.ROUTES_TEST,
      page: () => const RoutesTestView(),
      binding: RoutesTestBinding(),
    ),
    GetPage(
      name: _Paths.HOT_DETAIL_TOPIC,
      page: () => const HotDetailTopicView(),
      binding: HotDetailTopicBinding(),
    ),
    GetPage(
        name: _Paths.INTERESTED_LIST,
        page: () => const InterestedListView(),
        binding: InterestedListBinding()),
    GetPage(
      name: _Paths.FOLLOW_MEMBER,
      page: () => const FollowMemberView(),
      binding: FollowMemberBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITE_TOPIC,
      page: () => const FavouriteTopicView(),
      binding: FavouriteTopicBinding(),
    ),
    GetPage(
      name: _Paths.IMMEDIATE_EXCHANGE,
      page: () => const ImmediateExchangeView(), //闪兑
      binding: ImmediateExchangeBinding(),
    ),
    GetPage(
      name: _Paths.IMMEDIATE_EXCHANGE_DETAIL,
      page: () => ImmediateExchangeDetailView(),
      binding: ImmediateExchangeDetailBinding(),
    ),
    GetPage(
      name: _Paths.MERCHANT_APPLY,
      page: () => const MerchantApplyView(),
      binding: MerchantApplyBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.COMMUNITY_NOTIFY,
      page: () => const CommunnityNotifyView(),
      binding: CommunnityNotifyBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: _Paths.COMMUNITY_MESSAGE,
      page: () => const CommunityMessageView(),
      binding: CommunityMessageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.WEAL_INDEX,
      page: () => const WealIndexView(),
      binding: WealIndexBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.WITHDRAW_DETAIL,
      page: () => WithdrawDetailView(),
      binding: WithdrawDetailBinding(),
    ),
    GetPage(
      name: _Paths.NEW_USER_ACTIVITY_PAGE,
      page: () => const NewUserActivityPageView(),
      binding: NewUserActivityPageBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOW_QUESTIONNAIRE,
      page: () => const FollowQuestionnaireView(),
      binding: FollowQuestionnaireBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOW_QUESTIONNAIRE_DETAILS,
      page: () => const FollowQuestionnaireDetailsView(),
      binding: FollowQuestionnaireDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOW_QUESTIONNAIRE_RESULT,
      page: () => FollowQuestionnaireResultView(),
      binding: FollowQuestionnaireResultBinding(),
    ),
    GetPage(
      name: _Paths.TRADER_REFERRAL_VIEW,
      page: () => const TraderReferralView(),
      binding: TraderReferralBinding(),
    ),

    GetPage(
      name: _Paths.FOLLOW_USER_REVIEW,
      page: () => const FollowUserReviewView(),
      binding: FollowUserReviewBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
