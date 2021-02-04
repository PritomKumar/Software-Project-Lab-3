import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  SharedPreferences _sharedPreferences;
  String _theme_data_color_key = "theme_data_color";
  String _theme_data_text_key = "theme_data_text";

  ThemeChanger(ThemeData _themeData) {
    this._themeData = _themeData;
    _loadFromPrefs();
  }

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    ThemeData.from(colorScheme: ColorScheme(primary: Colors.blue));
    _themeData = ThemeData.from(
            colorScheme: ColorScheme(
                primary:
                    Color(_sharedPreferences.getInt(_theme_data_color_key)))) ??
        ThemeData(primarySwatch: Colors.blue);
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _sharedPreferences.setInt(
        _theme_data_color_key, _themeData.primaryColor.value);
  }
}
