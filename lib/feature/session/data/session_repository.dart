import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../main.dart';

class SessionRepository {
  Future<bool> attemptAutoLogin() async {
    bool response = true;
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getString("uid") == null) {
      response = false;
    } else {}
    return response;
  }

  Future<String> signOut() async {
    String callback = "";
    // API ..
    callback = "{\"success\":true,\"message\":\"\", \"data\":{}}";
    return callback;
  }

  Future<String> login(String phone, String password) async {
    String callback = "";
    // API ..
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("phone", phone);
    prefs!.setString("uid", Uuid().v4());
    callback = "{\"success\":true,\"message\":\"\", \"data\":{}}";
    return callback;
  }
}
