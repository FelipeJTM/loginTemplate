import '../services/secure_storage_service.dart';

class RegisterHelper {
  final String email;
  final String password;
  final String userName;

  RegisterHelper(
      {required this.email, required this.password, required this.userName});

  Future<bool> saveUserData() async {
    SecureStorageService.setEmail(email);
    SecureStorageService.setPassword(password);
    SecureStorageService.setUserName(userName);
    return true;
  }
}
