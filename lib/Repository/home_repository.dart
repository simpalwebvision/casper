import 'package:caspro_enterprises/Models/technician_dashboard_model.dart';
import 'package:caspro_enterprises/Utils/app_base_api_services.dart';
import 'package:caspro_enterprises/Utils/app_exceptions.dart';
import 'package:caspro_enterprises/Utils/app_failure.dart';
import 'package:caspro_enterprises/Utils/local_shared_preferences.dart';
import 'package:caspro_enterprises/Utils/remote_urls.dart';
import 'package:dartz/dartz.dart';

import '../Utils/app_network_api_services.dart';

class HomeRepository {
  BaseApiService apiService = NetworkAPIService();

  Future<Either<Failure, TechnicianDashboardExpenseModel>>
      technicianAllExpense() async {
    String techId = await LocalPreferences().getUserid() ?? "";
    try {
      var response = await apiService.getGetApiResponse(
        "${RemoteUrls.technicianAllExpense}=$techId",
      );

      return right(TechnicianDashboardExpenseModel.fromJson(response['data']));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, double>> getClaimSheetAmt() async {
    String techId = await LocalPreferences().getUserid() ?? "";
    try {
      var response = await apiService.getGetApiResponse(
        "${RemoteUrls.getClaimSheetAmt}=$techId",
      );

      String total = response['data']['total'].toString();

      return right(double.parse(total == "null" ? "0.0" : total));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
