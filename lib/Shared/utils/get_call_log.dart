// lấy danh sách cuộc gọi đã lưu ở db
// lấy log cuộc gọi
import 'package:shared_preferences/shared_preferences.dart';

// lưu danh sách cuộc gọi
Future<void> saveCallLog(int id, int seconds) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Lấy danh sách log cuộc gọi hiện tại từ SharedPreferences (nếu có)
  List<String>? callLogs = prefs.getStringList('call_logs');
  print("--------------------------");
  print("Call log được lưu:");
  print(seconds);
  print("--------------------------");
  // Tạo một entry mới với định dạng "id:seconds"
  String entry = '$id:$seconds';

  if (callLogs == null) {
    // Nếu danh sách log cuộc gọi chưa tồn tại, tạo một danh sách mới và thêm entry vào
    callLogs = [entry];
  } else {
    // Kiểm tra nếu đã có id trong danh sách
    bool hasExistingLog = false;

    for (int i = 0; i < callLogs.length; i++) {
      String log = callLogs[i];
      if (log.startsWith('$id:')) {
        // Nếu đã có id trong danh sách, thay thế giá trị số cuộc gọi cũ bằng giá trị mới
        callLogs[i] = entry;
        hasExistingLog = true;
        break;
      }
    }

    if (!hasExistingLog) {
      // Nếu chưa có id trong danh sách, thêm entry mới vào danh sách
      callLogs.add(entry);
    }
  }

  // Lưu danh sách log cuộc gọi mới vào SharedPreferences
  await prefs.setStringList('call_logs', callLogs);
}

// lấy danh sách cuộc gọi từ db
Future<int> getCallLogs(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Lấy danh sách log cuộc gọi từ SharedPreferences
  List<String>? callLogs = prefs.getStringList('call_logs');

  if (callLogs != null) {
    // Tìm entry với ID truyền vào
    String? logWithId;
    for (String log in callLogs) {
      List<String> logParts = log.split(':');
      String entryId = logParts[0];
      if (entryId == id.toString()) {
        logWithId = log;
        break;
      }
    }

    if (logWithId != null) {
      // Nếu tìm thấy entry, in thông tin của nó
      List<String> logParts = logWithId.split(':');
      String entryId = logParts[0];
      int seconds = int.tryParse(logParts[1]) ?? 0;
      print('-------------------------');
      print("Call log từ db");
      print('ID: $entryId');
      print('Seconds: $seconds');
      print('-------------------------');
      return seconds;
    } else {
      print('Không tìm thấy log cuộc gọi với ID: $id');
    }
  } else {
    print('Danh sách log cuộc gọi trống.');
  }

  return 0; // Giá trị mặc định nếu không tìm thấy log cuộc gọi
}
