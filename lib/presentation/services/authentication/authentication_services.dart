import 'dart:convert';
import 'dart:io';
import 'package:flutter_app_best_shipp/Shared/models/auth/list_user/list_user_models.dart';
import 'package:http/http.dart' as http;

import '../../../Shared/constants/api_constants.dart';
import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/preferences/preferences.dart';
import '../../../Shared/utils/httpRequest.dart';

class UserServices {
  static const baseUrl = ApiConstants.BASE_URL;
  static final userName = Prefer.prefs?.getString('userName');
  final http.Client httpClient;
  final HttpRequestServices httpRequest;

  UserServices({http.Client? httpClient, required this.httpRequest})
      : httpClient = httpClient ?? http.Client();

  Future<AuthModels> login({String? username, String? password}) async {
    const loginUrl = '$baseUrl/api/authenticate/login';
    final loginResponse = await httpClient.post(
      Uri.parse(loginUrl),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        // HttpHeaders.authorizationHeader:
      },
      body: jsonEncode(
        <String, String>{
          'username': username!,
          'password': password!,
        },
      ),
    );

    if (loginResponse.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    final loginJson = jsonDecode(loginResponse.body);
    return AuthModels.fromJson(loginJson);
  }

  // lấy thông tin danh sách user
  Future<ListUserModels> getDataListUser(String? key) async {
    if (key == null && key!.isEmpty) {
      key = "";
    } else {}

    var response = await httpRequest.DioRequestGet(
        // ignore: prefer_interpolation_to_compose_strings
        'Users/Get_users_by_key?key=' + key,
        {});
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    var data = ListUserModels.fromJson(response.data);
    return data;
  }
}
