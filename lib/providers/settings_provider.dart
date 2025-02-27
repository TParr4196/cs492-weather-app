import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  SharedPreferences? prefs;
  Color currentColor = Colors.amber;

  void changeColor(Color color) {
     currentColor = color;
     prefs!.setInt('Color', currentColor.toARGB32());
     notifyListeners();
  }

  bool get darkMode => _darkMode;

  void toggleMode() {
    _darkMode = !_darkMode;
    if (prefs != null) {
      prefs!.setBool('darkMode', _darkMode);
    }

    notifyListeners();
  }

  SettingsProvider() {
    initPreferences();
  }

  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      _darkMode = prefs!.getBool('darkMode') ?? false;
      //https://www.edureka.co/community/229252/how-do-i-use-hexadecimal-color-strings-in-flutter#:~:text=To%20use%20a%20hexadecimal%20color,Color%20color%20%3D%20Color(int.
      int colorInt = prefs!.getInt('Color') ?? 0;
      currentColor = Color(colorInt);
    }
    notifyListeners();
  }
}
