import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import '../model/session.dart';

class SessionProvider {
  Session? _session;

  Session? get session => _session;

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppKeys.token);
    final userId = prefs.getString(AppKeys.userId);

    if (token != null && userId != null) {
      _session = Session(
        token: token,
        userId: userId,
      );

    }
  }

  Future<void> saveSession(String token, String userId) async {
    _session = Session(token: token, userId: userId,);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppKeys.token, token);
    await prefs.setString(AppKeys.userId, userId);

  }

  Future<void> clearSession() async {
    _session = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppKeys.token);
    await prefs.remove(AppKeys.userId);

  }

  bool get isAuthenticated {
    return _session != null;
  }
}
