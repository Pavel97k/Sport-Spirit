import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:SportSpirit/features/data/global_service.dart';
import 'package:SportSpirit/features/utils/storage/shared_preferences_helper.dart';

class ThemesData extends ChangeNotifier {
  late ThemeData themeData;

  static final darkTheme = ThemeData(
      colorScheme: const ColorScheme.dark(),
      textTheme: GoogleFonts.robotoFlexTextTheme(
        const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      useMaterial3: true);

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      textTheme: GoogleFonts.robotoFlexTextTheme(),
      brightness: Brightness.light,
      useMaterial3: true);

  static final lightThemeModOne = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(128, 36, 199, 30),
      ),
      textTheme: GoogleFonts.robotoFlexTextTheme(),
      brightness: Brightness.light,
      useMaterial3: true);

  static final lightThemeModTwo = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(128, 16, 134, 188),
      ),
      textTheme: GoogleFonts.robotoFlexTextTheme(),
      brightness: Brightness.light,
      useMaterial3: true);

  static final lightThemeModThree = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(128, 198, 50, 193),
      ),
      textTheme: GoogleFonts.robotoFlexTextTheme(),
      brightness: Brightness.light,
      useMaterial3: true);

  ThemesData({required int isDarkMode}) {
    switch (isDarkMode) {
      case 0:
        themeData = lightTheme;
        break;
      case 1:
        themeData = darkTheme;
        break;
      case 2:
        themeData = lightThemeModOne;
        break;
      case 3:
        themeData = lightThemeModTwo;
        break;
      case 4:
        themeData = lightThemeModThree;
        break;
      default:
    }
  }

  Future<void> swapTheme(int value) async {
    switch (value) {
      case 0:
        themeData = lightTheme;
        break;
      case 1:
        themeData = darkTheme;
        break;
      case 2:
        themeData = lightThemeModOne;
        break;
      case 3:
        themeData = lightThemeModTwo;
        break;
      case 4:
        themeData = lightThemeModThree;
        break;
      default:
    }
    service<SharedPreferencesHelper>().setInt('isTheme', value);
    notifyListeners();
  }

  Future<void> getThemes() async {
    final theme = await service<SharedPreferencesHelper>().getInt('isTheme');
    switch (theme) {
      case 0:
        themeData = lightTheme;
        break;
      case 1:
        themeData = darkTheme;
        break;
      case 2:
        themeData = lightThemeModOne;
        break;
      case 3:
        themeData = lightThemeModTwo;
        break;
      default:
    }
    notifyListeners();
  }

  ThemeData get getTheme => themeData;
}
