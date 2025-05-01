import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  //Write Key
  static Future<void> writeKey(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read Data
  static Future<String?> readValue(String key) async {
    return await _storage.read(key: key);
  }

  // Delete Data
  static Future<void> deleteKey(String key) async {
    await _storage.delete(key: key);
  }

  // Remove All Data
  static Future<void> removeValue() async {
    await _storage.deleteAll();
  }
}
