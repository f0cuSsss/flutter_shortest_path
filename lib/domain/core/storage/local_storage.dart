import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ILocalStorage {
  Future saveBaseUrl(String url);
  Future<String?> getBaseUrl();
}

class SecurePrefsStorage extends ILocalStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const String baseUrlStorageKey = 'base_url_storage';

  @override
  Future saveBaseUrl(String url) async {
    await storage.write(
      key: baseUrlStorageKey,
      value: url,
    );
  }

  @override
  Future<String?> getBaseUrl() async {
    return await storage.read(key: baseUrlStorageKey);
  }
}
