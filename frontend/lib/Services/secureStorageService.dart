import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<String?> readSecureStorageData(String key) async {
    String? data =
        await _secureStorage.read(key: key, aOptions: _getAndroidOptions());

    return data;
  }

  Future<void> writeSecureStorageData(String key, String value) async {
    await _secureStorage.write(
        key: key, value: value, aOptions: _getAndroidOptions());
  }

  Future<void> deleteSecureStorageData(String key) async {
    await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  }
}
