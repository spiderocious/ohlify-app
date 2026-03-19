import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Tokens are stored in Keychain (iOS) / EncryptedSharedPreferences (Android).
// An in-memory cache provides a synchronous accessToken getter for the
// AuthInterceptor, which runs outside of async context.
class TokenService {
  TokenService(this._storage);
  final FlutterSecureStorage _storage;

  static const _tokenKey = 'access_token';

  String? _accessToken;

  // Sync — reads in-memory cache (populated by init or setAccessToken)
  String? get accessToken => _accessToken;

  // Call once on app start (e.g. in AppProviders or a startup notifier)
  Future<void> init() async {
    _accessToken = await _storage.read(key: _tokenKey);
  }

  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getAccessToken() => _storage.read(key: _tokenKey);

  Future<void> clear() async {
    _accessToken = null;
    await _storage.delete(key: _tokenKey);
  }
}
