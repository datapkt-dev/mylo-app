import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    print('save');
    await _storage.write(key: 'token', value: token);
    print('done');
  }

  Future<String?> getToken() async {
    try {
      return await _storage.read(key: 'token');
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }

  Future<void> saveAccount(String account) async {
    await _storage.write(key: 'account', value: account);
  }

  Future<void> savePassword(String password) async {
    await _storage.write(key: 'password', value: password);
  }

  Future<void> clearAccountAndPassword() async {
    try {
      await _storage.delete(key: 'account');
      await _storage.delete(key: 'password');
    } catch (e) {
      print('Error clearing account and password: $e');
    }
  }

  Future<String?> getAccount() async {
    try {
      return await _storage.read(key: 'account');
    } catch (e) {
      return '';
    }
  }

  Future<String?> getPassword() async {
    try {
      return await _storage.read(key: 'password');
    } catch (e) {
      return '';
    }
  }
}