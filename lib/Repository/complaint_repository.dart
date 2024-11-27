import 'package:caspro_enterprises/Models/complaint_model.dart';
import 'package:caspro_enterprises/Utils/app_base_api_services.dart';
import 'package:caspro_enterprises/Utils/app_exceptions.dart';
import 'package:caspro_enterprises/Utils/app_failure.dart';
import 'package:caspro_enterprises/Utils/app_network_api_services.dart';
import 'package:caspro_enterprises/Utils/local_shared_preferences.dart';
import 'package:caspro_enterprises/Utils/remote_urls.dart';
import 'package:dartz/dartz.dart';

class ComplaintRepository {
  BaseApiService apiService = NetworkAPIService();

  Future<Either<Failure, List<ComplaintModel>>> getComplaint(
      String status) async {
    var userType = await LocalPreferences().getUserType() ?? "";
    var userId = await LocalPreferences().getUserid() ?? "";
    try {
      var response = await apiService.getGetApiResponse(
          "${RemoteUrls.getComplaint}?type=$userType&status=$status&id=$userId");

      List<ComplaintModel> complaintList = [];
      List list = response['data'];

      complaintList = list
          .map((e) => ComplaintModel.fromJson(e))
          .toList()
          .reversed
          .toList();

      return right(complaintList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> addComplaint(data) async {
    try {
      var response =
          await apiService.getPostApiResponse(RemoteUrls.addComplaint, data);

      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateComplaint(data) async {
    try {
      var response =
          await apiService.getPostApiResponse(RemoteUrls.updateComplaint, data);

      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<ComplaintModel>>> getComplaintHistory() async {
    try {
      var response =
          await apiService.getGetApiResponse(RemoteUrls.getComplaint);

      List<ComplaintModel> complaintList = [];
      List list = response['data'];

      complaintList = list.map((e) => ComplaintModel.fromJson(e)).toList();

      // complaintList = complaintList.reversed.toList();

      return right(complaintList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
