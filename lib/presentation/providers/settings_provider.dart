import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends StateNotifier<String> {
  SettingsNotifier() : super('http://10.0.2.2:8000') {
    _loadUrl();
  }

  Future<void> _loadUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('server_url');
    if (url != null && url.isNotEmpty) {
      state = url;
    }
  }

  Future<void> setServerUrl(String url) async {
    state = url;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('server_url', url);
  }
}

final serverUrlProvider = StateNotifierProvider<SettingsNotifier, String>((ref) {
  return SettingsNotifier();
});
