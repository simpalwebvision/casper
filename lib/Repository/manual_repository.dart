import 'package:caspro_enterprises/Models/manuals_model.dart';
import 'package:caspro_enterprises/Utils/app_exceptions.dart';
import 'package:caspro_enterprises/Utils/app_failure.dart';
import 'package:caspro_enterprises/Utils/app_network_api_services.dart';
import 'package:caspro_enterprises/Utils/remote_urls.dart';
import 'package:dartz/dartz.dart';

import '../Utils/app_base_api_services.dart';

class ManualsRepository {
  BaseApiService apiService = NetworkAPIService();
  Future<Either<Failure, List<ManualsModel>>> getManualsList() async {
    try {
      var response = await apiService.getGetApiResponse(
        RemoteUrls.getManualsList,
      );

      List<ManualsModel> manualsList = [];
      List list = response['data'];

      manualsList = list
          .map(
            (e) => ManualsModel.fromJson(e),
          )
          .toList()
          .reversed
          .toList();

      return right(manualsList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
