import 'package:flutter/material.dart';

class AppTheme {
  static const ThemeMode themeMode = ThemeMode.dark;
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: _primaryColor,
    primaryColorDark: _primaryColor,
    accentColor: _accentColor,
    /*buttonColor: _buttonColor,
    buttonTheme: ThemeData.dark().buttonTheme.copyWith(
          buttonColor: buttonColor,
        ),*/
  );

  static const MaterialColor _primaryColor = Colors.green;
  static const MaterialColor _accentColor = Colors.teal;
  //static const MaterialColor _buttonColor = Colors.orange; // TODO Button-Color -> accentColor
}
