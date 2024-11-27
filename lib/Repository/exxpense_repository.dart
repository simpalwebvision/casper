import 'dart:convert';

import 'package:caspro_enterprises/Models/expense_model.dart';
import 'package:caspro_enterprises/Models/user_profile_model.dart';
import 'package:caspro_enterprises/Utils/app_base_api_services.dart';
import 'package:caspro_enterprises/Utils/app_exceptions.dart';
import 'package:caspro_enterprises/Utils/app_failure.dart';
import 'package:caspro_enterprises/Utils/app_network_api_services.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/remote_urls.dart';
import 'package:dartz/dartz.dart';

class ExpenseRepository {
  BaseApiService apiService = NetworkAPIService();
  Future<Either<Failure, List<ExpenseModel>>> getAllExpenseListsheet() async {
    TechnicianProfileModel userProfileModel =
        await CommonFunctions().getTechnicianProfileData();
    try {
      var response = await apiService.getGetApiResponse(
        "${RemoteUrls.getExpenseSheet}${userProfileModel.id}",
      );

      List<ExpenseModel> expenseList = [];
      List list = response['data'];

      expenseList = list
          .map(
            (e) => ExpenseModel.fromJson(e),
          )
          .toList();

      expenseList = expenseList.reversed.toList();
      return right(expenseList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> addTechnicianExpense(data) async {
    try {
      var response = await apiService.dioApiResponse(
        RemoteUrls.addExpense,
        data,
      );

      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> editExpense(data) async {
    try {
      var response = await apiService.getPostApiResponse(
        RemoteUrls.editExpense,
        data,
      );

      return right(json.decode(response.body));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List>> getProblemList() async {
    try {
      var response = await apiService.getGetApiResponse(
        RemoteUrls.getProblemList,
      );

      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
