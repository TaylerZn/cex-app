import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/assets/assets_contract.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../../network/bika/bika_app_dio.dart';

part 'assets_contract_api.g.dart';

@RestApi()
abstract class AssetsContractApi {
  factory AssetsContractApi(Dio dio, {String baseUrl}) = _AssetsContractApi;

  factory AssetsContractApi.instance() => AssetsContractApi(
        BikaAppDio.getInstance().dio,
        baseUrl: BestApi.getApi().contractUrl,
      );

  /// 获取合约账户余额
  @POST('/position/get_assets_list')
  Future<AssetsContract> getContractAccountBalance();

  /// 现货账户之外的资产账户相互划转
  @Extra({showLoading: true})
  @POST('/futures/account_transfer')
  Future contractTransfer(
      @Field('amount') String amount,
      @Field('coinSymbol') String coinSymbol,
      @Field('transferType') String transferType);
}
