import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/http_clinet.dart';
import 'package:flutter_application_1/data/datasource/auth_data_source.dart';
import 'package:flutter_application_1/data/module/auth_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAthRepository {
  Future<void> login(String userName, String password);
  Future<void> register(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAthRepository {
  static final ValueNotifier<AuthInfo?> authChange = ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _presidentToken(authInfo);
    debugPrint('accsesc toke ${authInfo.accessToken}');
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo = await dataSource.refreshToken('');
    _presidentToken(authInfo);
  }

  @override
  Future<void> register(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.register(username, password);
      _presidentToken(authInfo);
      debugPrint('access toke ${authInfo.accessToken}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// this method for save access token and refreshToken
  Future<void> _presidentToken(AuthInfo authInfo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
  }

  /// this method for read access token
  Future<void> readAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString("access_token") ?? "";
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? "";
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChange.value = AuthInfo(accessToken, refreshToken);
    }
  }
}
