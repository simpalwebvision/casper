import 'package:caspro_enterprises/Models/customer_model.dart';
import 'package:caspro_enterprises/Utils/app_base_api_services.dart';
import 'package:caspro_enterprises/Utils/app_exceptions.dart';
import 'package:caspro_enterprises/Utils/app_failure.dart';
import 'package:caspro_enterprises/Utils/remote_urls.dart';
import 'package:dartz/dartz.dart';

import '../Utils/app_network_api_services.dart';

class CustomerRepository {
  BaseApiService apiService = NetworkAPIService();
  Future<Either<Failure, List<CustomerModel>>> getCustomers() async {
    try {
      var response =
          await apiService.getGetApiResponse(RemoteUrls.getCustomers);

      List<CustomerModel> complaintList = [];
      List list = response['data'];

      complaintList = list.map((e) => CustomerModel.fromJson(e)).toList();

      // complaintList = complaintList.reversed.toList();

      return right(complaintList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> addCustomer(var passedBody) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.addCustomers, passedBody);

      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
