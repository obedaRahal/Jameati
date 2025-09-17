import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/constant/theme.dart';
import 'package:project_manag_ite/core/services/services.dart';

class ThemeController extends GetxController {
  var theme = AppTheme.lightTheme.obs;
  
  static const String _themeKey = 'isDarkTheme';
  final _services = Get.find<MyServices>();


  bool get isDark => theme.value.brightness == Brightness.dark;

   @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
  }

   void toggleTheme() {
    if (isDark) {
      theme.value = AppTheme.lightTheme;
      _saveThemeToStorage(false);
    } else {
      theme.value = AppTheme.darkTheme;
      _saveThemeToStorage(true);
    }
  }

  void _loadThemeFromStorage() {
    final isDarkStored = _services.sharedPreferences.getBool(_themeKey) ?? false;
    theme.value = isDarkStored ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  void _saveThemeToStorage(bool isDark) {
    _services.sharedPreferences.setBool(_themeKey, isDark);
  }
}

