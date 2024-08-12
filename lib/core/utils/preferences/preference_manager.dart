import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static String? _token ;

  static Future<void> saveToken(String token)  async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = token;
  }

  static String? getToken()  {
    return _token;
  }
}