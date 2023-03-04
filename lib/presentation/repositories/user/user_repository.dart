import 'package:flutter_app_best_shipp/Shared/models/auth/list_user/list_user_models.dart';
import 'package:flutter_app_best_shipp/Shared/utils/httpRequest.dart';

import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/preferences/preferences.dart';
import '../../services/authentication/authentication_services.dart';

class UserRepository {
  final UserServices userServices;

  UserRepository({UserServices? userServices})
      : userServices =
            userServices ?? UserServices(httpRequest: HttpRequestServices());
  // hàm xử lí đăng nhập
  Future<AuthModels> loginWithCredentials(
      String username, String password) async {
    return userServices.login(username: username, password: password);
  }

  // Có đang đăng nhập hay là không
  Future<bool> isSignedIn() async {
    final token = Prefer.prefs?.getString('token');
    return token != null;
  }

  // Đăng xuất
  Future<void> logOut() async {
    Prefer.prefs?.clear();
  }

  // hàm xử lí lấy danh sách user
  Future<ListUserModels> listDataUser(String key) async {
    return userServices.getDataListUser(key);
  }
}
