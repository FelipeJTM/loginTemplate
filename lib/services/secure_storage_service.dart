import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  static const _usernameKey = "USER";
  static const _emailKey = "EMAIL";
  static const _passwordKey = "PASS";

  static Future setUserName(String username) async =>
      await _storage.write(key: _usernameKey, value: username);

  static Future<String?> getUserName() async =>
      await _storage.read(key: _usernameKey);

  static Future setEmail(String email) async =>
      await _storage.write(key: _emailKey, value: email);

  static Future<String?> getEmail() async =>
      await _storage.read(key: _emailKey);

  static Future setPassword(String pass) async =>
      await _storage.write(key: _passwordKey, value: pass);

  static Future<String?> getPassword() async =>
      await _storage.read(key: _passwordKey);
}
