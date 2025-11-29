import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String keyApiKey = 'gemini_api_key';
  static const String keyGeminiApiKey = 'gemini_api_key'; 
  static const String keyEmail = 'user_email';
  static const String keyThemeMode = 'theme_mode';
  static const String keyEditorFont = 'editor_font';
  static const String keyWritingMode = 'default_writing_mode';

  // --- FIX: Correct saveApiKey method ---
  Future<void> saveApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyApiKey, apiKey);
  }

  Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyApiKey);
  }
  
  Future<void> setGeminiApiKey(String apiKey) async => saveApiKey(apiKey);
  Future<String?> getGeminiApiKey() async => getApiKey();

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyEmail);
  }
  
  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyEmail, email);
  }
  
  Future<int> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyThemeMode) ?? 0;
  }
  
  Future<void> saveThemeMode(int mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyThemeMode, mode.toString());
  }
  
  Future<int> getEditorFont() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyEditorFont) ?? 0;
  }
  
  Future<void> saveEditorFont(int font) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyEditorFont, font);
  }
  
  Future<int> getWritingMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyWritingMode) ?? 0; 
  }
  
  Future<void> saveWritingMode(int mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyWritingMode, mode);
  }
}
