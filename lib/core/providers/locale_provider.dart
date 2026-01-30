import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported locales in the app
class AppLocale {
  static const Locale uzbek = Locale('uz');
  static const Locale russian = Locale('ru');
  static const Locale english = Locale('en');
  static const Locale korean = Locale('ko');

  static const List<Locale> supportedLocales = [uzbek, russian, english, korean];

  static const String _prefsKey = 'app_locale';

  /// Get display name for a locale
  static String getDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'uz':
        return "O'zbek";
      case 'ru':
        return 'Русский';
      case 'en':
        return 'English';
      case 'ko':
        return '한국어';
      default:
        return locale.languageCode;
    }
  }

  /// Get short display name for a locale (for compact UI)
  static String getShortName(Locale locale) {
    switch (locale.languageCode) {
      case 'uz':
        return "O'zbek";
      case 'ru':
        return 'Русский';
      case 'en':
        return 'English';
      case 'ko':
        return '한국어';
      default:
        return locale.languageCode;
    }
  }
}

/// Locale state notifier that persists the selected locale
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(AppLocale.uzbek) {
    _loadSavedLocale();
  }

  /// Load saved locale from shared preferences
  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCode = prefs.getString(AppLocale._prefsKey);
      if (savedCode != null) {
        final locale = AppLocale.supportedLocales.firstWhere(
          (l) => l.languageCode == savedCode,
          orElse: () => AppLocale.uzbek,
        );
        state = locale;
      }
    } catch (e) {
      // If loading fails, keep default locale
    }
  }

  /// Change the current locale and persist it
  Future<void> setLocale(Locale locale) async {
    if (!AppLocale.supportedLocales.contains(locale)) return;

    state = locale;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppLocale._prefsKey, locale.languageCode);
    } catch (e) {
      // If saving fails, locale is still changed in memory
    }
  }

  /// Set locale by language code
  Future<void> setLocaleByCode(String code) async {
    final locale = AppLocale.supportedLocales.firstWhere(
      (l) => l.languageCode == code,
      orElse: () => AppLocale.uzbek,
    );
    await setLocale(locale);
  }
}

/// Provider for the current locale
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
