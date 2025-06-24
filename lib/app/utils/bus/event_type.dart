enum EventType {
  /// 退出登录
  signOut,

  /// 登录
  login,

  /// 切换语言
  changeLang,
  removePostEvent,
  updateSuperTraderInfo,

  ///搜索记录
  searchHistory,

  /// 资产变更
  refreshAsset,
  openContract,

  /// 拉黑用户
  blockUser,

  /// 帖子-更新（目前：详情覆盖外部list）
  postUpdate,

  /// 帖子-删除
  delPost,

  /// 帖子-发布
  postSend,

  /// 提现
  withdraw,
  refreshContractOption,
  refreshSpotOption,
  refreshCommodityOption,

  /// ws的数据更新

  ///关闭交易资格
  closeKycDialog,

  ///首页移除快捷
  quicEntry,

  //跟单答题完成
  followAnswerDone
}
