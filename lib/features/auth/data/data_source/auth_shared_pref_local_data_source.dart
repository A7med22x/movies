import 'package:injectable/injectable.dart';
import 'package:movies/core/constants.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AuthSharedPrefLocalDataSource {
  final SharedPreferences _sharedPref;

  AuthSharedPrefLocalDataSource(this._sharedPref);
  
  Future<void> saveUserId(String userId) async {
    try {
      await _sharedPref.setString(CacheKeys.userId, userId);
    } catch (exceptin) {
      throw const LocalException('Failed to save userId');
    }
  }

  Future<String> getUserId() async {
    try {
      return _sharedPref.getString(CacheKeys.userId) ?? '';
    } catch (exceptin) {
      throw const LocalException('Failed to get userId');
    }
  }
}