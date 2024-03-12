import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static const categoryKey = 'categoryKey';
  static const themeKey = 'themeKey';

  static Future<int?> getCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(categoryKey);
  }

  static Future<void> setCategory(int selectedId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(categoryKey, selectedId);
  }

  static Future<bool?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey);
  }

  static Future<void> setTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDarkMode);
  }
}
