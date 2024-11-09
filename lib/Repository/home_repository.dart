import 'package:caspro_enterprises/Models/inventory_models.dart';
import 'package:caspro_enterprises/Models/tech_history_model.dart';
import 'package:caspro_enterprises/Models/technician_dashboard_model.dart';
import 'package:caspro_enterprises/Models/user_profile_model.dart';
import 'package:caspro_enterprises/Utils/app_base_api_services.dart';
import 'package:caspro_enterprises/Utils/app_exceptions.dart';
import 'package:caspro_enterprises/Utils/app_failure.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/local_shared_preferences.dart';
import 'package:caspro_enterprises/Utils/remote_urls.dart';
import 'package:dartz/dartz.dart';

import '../Utils/app_network_api_services.dart';

class HomeRepository {
  BaseApiService apiService = NetworkAPIService();

  Future<Either<Failure, List<TechnicianStockModel>>>
      getTechnicianStockList() async {
    TechnicianProfileModel userProfileModel =
        await CommonFunctions().getTechnicianProfileData();
    try {
      var response = await apiService.getGetApiResponse(
        "${RemoteUrls.technicianStockList}${userProfileModel.id}",
      );

      List<TechnicianStockModel> inventoryList = [];
      List list = response['data'];

      inventoryList = list
          .map(
            (e) => TechnicianStockModel.fromJson(e),
          )
          .toList();

      return right(inventoryList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

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

  Future<Either<Failure, List<TechHistoryModel>>> getHistoryByType(
      String type) async {
    TechnicianProfileModel userProfileModel =
        await CommonFunctions().getTechnicianProfileData();
    try {
      var response = await apiService.getGetApiResponse(
        "${RemoteUrls.techHistory}${userProfileModel.id}&expenses=$type",
      );

      List<TechHistoryModel> historyList = [];
      List list = response['data'];

      historyList = list
          .map(
            (e) => TechHistoryModel.fromJson(e),
          )
          .toList();

      return right(historyList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<TechHistoryModel>>> getHistoryReturn() async {
    TechnicianProfileModel userProfileModel =
        await CommonFunctions().getTechnicianProfileData();
    try {
      var response = await apiService.getGetApiResponse(
        "${RemoteUrls.techLoanHistory}${userProfileModel.id}",
      );

      List<TechHistoryModel> historyList = [];
      List list = response['data'];

      historyList = list
          .map(
            (e) => TechHistoryModel.fromJson(e),
          )
          .toList();

      return right(historyList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
