import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/user/user_repository.dart';
import 'package:get/get.dart';
import '../../Pages/auth/auth_screen.dart';
import '../../Pages/connect/connectofff.dart';
import '../../presentation/services/dialogs/dialog_service.dart';
import '../../presentation/services/navigations/navigation_service.dart';
import '../blocs/theme/color.dart';

void actionError(DialogService _dialogService,
    NavigationService _navigationService, int code, String messsenger) {
  switch (code) {
    case 1002:
      // Máy không có Kết nối internet
      // _navigationService.replaceWith(ROUTE_CONNECTOFF);
      Get.to(ConnectOffPage());
      break;
    case 1004:
      // Kết nối đường truyền yếu hoặc không ổn định
      _dialogService.showDialog(
          description: 'Kết nối của bạn đường truyền yếu hoặc không ổn định!');
      break;
    case 500:
      // Kết nối đường truyền yếu hoặc không ổn định
      _dialogService.showDialog(description: 'Lỗi Server!');
      break;
    case 401:
      // Đăng nhập hết hạn
      Get.to(AuthScreen(userRepository: UserRepository()));
      // _navigationService
      //     .replaceWith();
      break;
    case 5000:
      // Kết nối đường truyền yếu hoặc không ổn định
      // ignore: unnecessary_string_interpolations
      _dialogService.showDialog(description: '${messsenger.toString()}');
      break;
    default:
      {
        // Các lỗi khác
        _dialogService.showDialog(description: '${messsenger.toString()}!');
      }
  }
}

void showNotiCopy(String text, BuildContext context) {
  // ignore: unnecessary_new
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      elevation: 0,
      backgroundColor: Colors.greenAccent,
      duration: const Duration(seconds: 3),
      content: Wrap(children: [
        Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colours.textDefault))
      ])));
}

Color fromHexColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

// ignore: non_constant_identifier_names
bool IsNullOrEmpty(String key) {
  var _isNull = false;
  if (key == '' || key == null) _isNull = true;

  return _isNull;
}

MaterialColor fromHexColorMater(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  var _colorMater = Color(int.parse(buffer.toString(), radix: 16));
  return MaterialColor(_colorMater.value, getSwatch(_colorMater));
}

Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  final lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  final highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}
