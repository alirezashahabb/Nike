import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/constant.dart';

import 'package:flutter_application_1/common/validator_responce.dart';
import 'package:flutter_application_1/data/module/auth_info.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String userName, String password);
  Future<AuthInfo> register(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource with Validator implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);
  @override

  /// =======================================================>>>>. this is for login
  Future<AuthInfo> login(String username, String password) async {
    final response = await httpClient.post(
      "auth/token",
      data: {
        "grant_type": "password",
        "client_id": 2,
        "client_secret": Constant.clientSecret,
        "username": username,
        "password": password
      },
    );
    validatorResponse(response);
    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"]);
  }

  @override

  /// =======================================================>>>> this is for refreshToken
  Future<AuthInfo> refreshToken(String token) async {
    final response = await httpClient.post(
      "/auth/token",
      data: {
        "grant_type": "refresh_token",
        "refresh_token": token,
        "client_id": 2,
        "client_secret": Constant.clientSecret,
      },
    );
    validatorResponse(response);

    return AuthInfo(
        response.data['access_token'], response.data['refresh_token']);
  }

  @override

  /// =======================================================>>>>. this is for register
  Future<AuthInfo> register(String username, String password) async {
    final response = await httpClient.post("user/register", data: {
      "email": username,
      "password": password,
    });
    validatorResponse(response);
    return login(username, password);
  }
}
