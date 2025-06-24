import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/assets/assets_contract.dart';
import 'package:nt_app_flutter/app/models/assets/assets_overview.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/models/assets/assets_transfer_record.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:retrofit/http.dart';

import '../../network/bika/bika_app_dio.dart';

part 'assets_standard_contract_api.g.dart';

@RestApi()
abstract class AssetsStandardContractApi {
  factory AssetsStandardContractApi(Dio dio, {String baseUrl}) =
      _AssetsStandardContractApi;

  factory AssetsStandardContractApi.instance() => AssetsStandardContractApi(
        BikaAppDio.getInstance().dio,
        baseUrl: BestApi.getApi().standardUrl,
      );

  /// 获取合约账户余额
  @POST('/fe-sdd-api/position/get_assets_list')
  Future<AssetsContract> getStandardContractAccountBalance();
}
