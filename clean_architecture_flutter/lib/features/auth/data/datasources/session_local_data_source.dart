import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionLocalDataSource {
  Future<void> saveSession(String userId);
  Future<String?> getSession();
  Future<void> clearSession();
}

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const _key = 'user_session';

  SessionLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveSession(String userId) async {
    await sharedPreferences.setString(_key, userId);
  }

  @override
  Future<String?> getSession() async {
    return sharedPreferences.getString(_key);
  }

  @override
  Future<void> clearSession() async {
    await sharedPreferences.remove(_key);
  }
}
