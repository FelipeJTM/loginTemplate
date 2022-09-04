import '../services/secure_storage_service.dart';

class LoginHelper {
  final String userName;
  final String password;

  LoginHelper(this.userName, this.password);

  Future<bool> verifyPassword() async {
    var userData = await getStoredUserData();
    if (userName == userData['user'] && password == userData['password']) return true;
    return false;
  }

  Future<Map<String, dynamic>> getStoredUserData() async {
    final String? storedUser = await SecureStorageService.getUserName();
    final String? storedPassword = await SecureStorageService.getPassword();
    return {
      "user": storedUser ?? "",
      "password": storedPassword ?? "",
    };
  }
}
