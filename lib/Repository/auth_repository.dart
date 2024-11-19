import 'dart:convert';

import 'package:caspro_enterprises/Models/machine_model.dart';
import 'package:caspro_enterprises/Models/technician_recharge_model.dart';
import 'package:caspro_enterprises/Models/user_profile_model.dart';
import 'package:caspro_enterprises/Utils/app_base_api_services.dart';
import 'package:caspro_enterprises/Utils/app_exceptions.dart';
import 'package:caspro_enterprises/Utils/app_failure.dart';
import 'package:caspro_enterprises/Utils/app_network_api_services.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/local_shared_preferences.dart';
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

  Future<Either<Failure, TechnicianProfileModel>> getProfileData() async {
    String techId = await LocalPreferences().getUserid() ?? "";
    try {
      var response = await apiService.getGetApiResponse(
        "${RemoteUrls.getProfile}=$techId",
      );
      if (response['data'].isEmpty) {
        CommonFunctions().logOut();
        right(TechnicianProfileModel());
      }
      String profileData = jsonEncode(response['data'][0]);
      await LocalPreferences().setProfileData(profileData);
      return right(TechnicianProfileModel.fromJson(response['data'][0]));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateProfile(data) async {
    try {
      var response =
          await apiService.dioApiResponse(RemoteUrls.profileUpdate, data);

      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<TechnicianRechargeModel>>>
      getRechargeData() async {
    String techId = await LocalPreferences().getUserid() ?? "";
    try {
      var response = await apiService.getGetApiResponse(
        "${RemoteUrls.getRechargeData}=$techId",
      );

      List<TechnicianRechargeModel> claimList = [];
      List list = response['data'];

      claimList = list
          .map(
            (e) => TechnicianRechargeModel.fromJson(e),
          )
          .toList();

      return right(claimList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<MachineModel>>> getMachineList() async {
    try {
      var response = await apiService.getGetApiResponse(
        RemoteUrls.getMachineList,
      );

      String machineData = jsonEncode(response['data']);
      await LocalPreferences().setMachineList(machineData);

      return right([]);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<MachineModel>>> getBagList() async {
    try {
      var response = await apiService.getGetApiResponse(
        RemoteUrls.getBagList,
      );

      String bagData = jsonEncode(response['data']);
      await LocalPreferences().setBagList(bagData);

      return right([]);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<TechnicianProfileModel>>>
      getTechincianList() async {
    try {
      var response =
          await apiService.getGetApiResponse(RemoteUrls.getTechnicianList);

      List<TechnicianProfileModel> complaintList = [];
      List list = response['data'];

      complaintList =
          list.map((e) => TechnicianProfileModel.fromJson(e)).toList();

      // complaintList = complaintList.reversed.toList();

      return right(complaintList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
