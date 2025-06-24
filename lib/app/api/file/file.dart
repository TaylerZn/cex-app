import 'package:nt_app_flutter/app/models/file/file.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'file.g.dart';

@RestApi()
abstract class FileApi {
  factory FileApi(Dio dio, {String baseUrl}) = _FileApi;

  factory FileApi.instance() => FileApi(BikaAppDio.getInstance().dio);

  @POST('/member/fileOss') //上传文件
  Future memberfileOss(@Body() request);

  @POST('/common/upload_file') //普通文件上传(登录状态)
  @Extra({isSign: false})
  @Extra({sendTimeout: 300000})
  Future<CommonuploadimgModel> commonuploadfile(@Body() request);

  @POST('/common/upload_img') //图片上传接口(登录状态)
  Future<CommonuploadimgModel> commonuploadimg(@Body() request);
}
