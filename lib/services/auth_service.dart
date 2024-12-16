```dart
import 'package:dio/dio.dart';
import 'package:shared_preferences.dart';
import 'package:smart_chat/models/user.dart';
import 'package:smart_chat/utils/api.dart';

class AuthService {
  final _api = Api();
  final _prefs = SharedPreferences.getInstance();

  Future<User> login(String clientId, String username, String password) async {
    try {
      final response = await _api.post('/org/loginauthnew', data: {
        'username': username,
        'password': password,
        'clientid': clientId,
        'ctype': 'YES',
        'lang': 'EN',
        'sessionId': '',
        'domain': 'https://smartchat.sentient.io',
        'auth': 'yes',
      });

      if (response.data['error'] != null) {
        throw response.data['error'];
      }

      final user = User.fromJson(response.data);
      
      // Store session data
      final prefs = await _prefs;
      await prefs.setString('apikey', response.data['userApiKey']);
      await prefs.setString('session', response.data.toString());
      
      return user;
    } on DioException catch (e) {
      throw 'Login failed: ${e.message}';
    }
  }

  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      final response = await _api.post('/verify_otp', data: {
        'otp': int.parse(otp),
      });

      if (response.data['status'] == 'Success') {
        final prefs = await _prefs;
        await prefs.setString('otp', 'success');
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
```