import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../constants/api_constants.dart';
import '../preferences/preferences.dart';

class HttpRequestServices {
  static const baseUrl = ApiConstants.BASE_URL_PRODUCT;
  final token = Prefer.prefs?.getString('token');

  final http.Client httpClient;

  HttpRequestServices({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  var httpDio = Dio();

  // ignore: non_constant_identifier_names
  Future<http.Response> HttpRequestPost(String url, String parameter) async {
    final orderListResponse = await httpClient.post(
      Uri.parse('$baseUrl/api/$url'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: parameter,
    );
    return orderListResponse;
  }

  // ignore: non_constant_identifier_names
  Future<http.Response> HttpRequestGet(String url, String parameter) async {
    final orderListResponse =
        await httpClient.get(Uri.parse('$baseUrl/api/$url'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return orderListResponse;
  }

  // ignore: non_constant_identifier_names
  Future<Response> DioRequestGet(
      String url, Map<String, dynamic>? parameter) async {
    final response =
        await httpDio.get('$baseUrl/api/$url', queryParameters: parameter);
    return response;
  }
}
