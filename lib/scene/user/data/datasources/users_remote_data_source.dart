import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:capco_app/base/constants/network/network_constants.dart';
import 'package:capco_app/base/exceptions/network/network_exceptions.dart';
import 'package:capco_app/scene/user/data/datasources/datasource_path.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsers() {
    try {
      return _getDataFromUrl(path: DataSourcePath.getUser.getPathString());
    } on NetworkException {
      rethrow;
    }
  }

  Future<List<UserModel>> _getDataFromUrl({required String path}) async {
    try {
      final response = await client.get(
          Uri.parse(
            baseUrl + path,
          ),
          headers: {
            HttpHeaders.contentTypeHeader: contentTypeHeader,
          }).timeout(const Duration(seconds: 5));
      switch (response.statusCode) {
        case 200:
          final results = (json.decode(response.body));
          final users =
              (results as List).map((e) => UserModel.fromJson(e)).toList();
          return users;
        case 400:
          throw const NetworkException(
            message: 'Bad Request',
          );
        case 401:
          throw const NetworkException(
            message: 'Unauthorized',
          );
        case 500:
          throw const NetworkException(
            message: 'Internal Server Error',
          );
        default:
          throw const NetworkException(
            message: 'Unknown Error',
          );
      }
    } catch (e) {
      if (e is NetworkException) rethrow;
      if (e is TimeoutException) {
        throw const NetworkException(message: "Request Timeout");
      }
      if (e is SocketException) {
        throw const NetworkException(message: "Connection Timeout");
      }
      throw NetworkException(message: e.toString());
    }
  }
}
