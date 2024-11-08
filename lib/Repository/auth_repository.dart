import 'package:caspro_enterprises/Utils/app_base_api_services.dart';
import 'package:caspro_enterprises/Utils/app_exceptions.dart';
import 'package:caspro_enterprises/Utils/app_failure.dart';
import 'package:caspro_enterprises/Utils/app_network_api_services.dart';
import 'package:caspro_enterprises/Utils/remote_urls.dart';
import 'package:dartz/dartz.dart';

class AuthRepository {
  BaseApiService apiService = NetworkAPIService();
  Future<Either<Failure, dynamic>> loginUser(data) async {
    try {
      var response = await apiService.loginRegisterApiResponse(
        RemoteUrls.loginUrl,
        data,
      );
      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
