import 'dart:ui' as ui;

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

  /// Get system locale, falling back to uzbek if not supported
  static Locale getSystemLocale() {
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    // Check if system locale is supported
    final supported = supportedLocales.firstWhere(
      (l) => l.languageCode == systemLocale.languageCode,
      orElse: () => uzbek, // Default fallback
    );
    return supported;
  }

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

  /// Get flag emoji for a locale
  static String getFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'uz':
        return '🇺🇿';
      case 'ru':
        return '🇷🇺';
      case 'en':
        return '🇺🇸';
      case 'ko':
        return '🇰🇷';
      default:
        return '🌐';
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

/// Locale state with user preference tracking
class LocaleState {
  final Locale locale;
  final bool isUserSelected; // true if user explicitly selected, false if using system

  const LocaleState({
    required this.locale,
    this.isUserSelected = false,
  });

  LocaleState copyWith({
    Locale? locale,
    bool? isUserSelected,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
      isUserSelected: isUserSelected ?? this.isUserSelected,
    );
  }
}

/// Locale state notifier that persists the selected locale
/// Defaults to system language, allows user override
class LocaleNotifier extends StateNotifier<LocaleState> {
  LocaleNotifier() : super(LocaleState(locale: AppLocale.getSystemLocale())) {
    _loadSavedLocale();
  }

  /// Load saved locale from shared preferences
  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCode = prefs.getString(AppLocale._prefsKey);
      if (savedCode != null) {
        // User has explicitly set a locale
        final locale = AppLocale.supportedLocales.firstWhere(
          (l) => l.languageCode == savedCode,
          orElse: () => AppLocale.getSystemLocale(),
        );
        state = LocaleState(locale: locale, isUserSelected: true);
      } else {
        // No saved preference, use system locale
        state = LocaleState(locale: AppLocale.getSystemLocale(), isUserSelected: false);
      }
    } catch (e) {
      // If loading fails, use system locale
      state = LocaleState(locale: AppLocale.getSystemLocale(), isUserSelected: false);
    }
  }

  /// Change the current locale and persist it
  Future<void> setLocale(Locale locale) async {
    if (!AppLocale.supportedLocales.contains(locale)) return;

    state = LocaleState(locale: locale, isUserSelected: true);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppLocale._prefsKey, locale.languageCode);
    } catch (e) {
      // If saving fails, locale is still changed in memory
    }
  }

  /// Reset to system locale (remove user preference)
  Future<void> resetToSystemLocale() async {
    state = LocaleState(locale: AppLocale.getSystemLocale(), isUserSelected: false);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppLocale._prefsKey);
    } catch (e) {
      // If removing fails, state is still reset in memory
    }
  }

  /// Set locale by language code
  Future<void> setLocaleByCode(String code) async {
    final locale = AppLocale.supportedLocales.firstWhere(
      (l) => l.languageCode == code,
      orElse: () => AppLocale.getSystemLocale(),
    );
    await setLocale(locale);
  }
}

/// Provider for the locale state (includes user preference info)
final localeStateProvider = StateNotifierProvider<LocaleNotifier, LocaleState>((ref) {
  return LocaleNotifier();
});

/// Provider for just the current locale (for backward compatibility)
final localeProvider = Provider<Locale>((ref) {
  return ref.watch(localeStateProvider).locale;
});
