
import 'package:flutter/foundation.dart';
import 'package:shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool _enableGpt = false;
  String _language = 'English';
  bool _isLoading = false;

  bool get enableGpt => _enableGpt;
  String get language => _language;
  bool get isLoading => _isLoading;

  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    _enableGpt = prefs.getBool('enable_gpt') ?? false;
    _language = prefs.getString('language') ?? 'English';

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateSettings({bool? enableGpt, String? language}) async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    
    if (enableGpt != null) {
      _enableGpt = enableGpt;
      await prefs.setBool('enable_gpt', enableGpt);
    }

    if (language != null) {
      _language = language;
      await prefs.setString('language', language);
    }

    _isLoading = false;
    notifyListeners();
  }
}
