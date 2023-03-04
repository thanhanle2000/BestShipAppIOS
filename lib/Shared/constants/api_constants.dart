import 'dart:io';

class ApiConstants {
  // api thử nghiệm
  // static const BASE_URL = 'http://thunghiem.bestship.com.vn';

  // api prooduct v1
  // ignore: constant_identifier_names
  static const BASE_URL = 'https://hochiminh.bestship.com.vn';

  // api product v2
  // ignore: constant_identifier_names
  static const BASE_URL_PRODUCT = 'https://portal.bestship.com.vn';
}

// cấu hình cho header => get token
Map<String, String> requestHeaders(String token) {
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
}

/*Had to use localhost (10.0.3.2 for Genymotion, 10.0.2.2 for official emulator) 
  because websocket port 6001 cannot be setup on expose or ngrok. 
*/


