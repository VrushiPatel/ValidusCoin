import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  // key names
  static const nameKey = "nameKey";
  static const emailKey = "emailKey";
  static const addressKey = "addressKey";

  final storage = new FlutterSecureStorage();

  setValue(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  clearData() async {
    await storage.deleteAll();
  }

  Future<String> readValue(String key) async {
    return await storage.read(key: key) ?? "";
  }
}
