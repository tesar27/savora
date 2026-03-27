import 'package:flutter/material.dart';

enum AppLanguage {
  system,
  english,
  german,
}

class AppSettingsController extends ChangeNotifier {
  AppLanguage _language = AppLanguage.system;

  AppLanguage get language => _language;

  Locale? get localeOverride {
    switch (_language) {
      case AppLanguage.system:
        return null;
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.german:
        return const Locale('de');
    }
  }

  void updateLanguage(AppLanguage value) {
    if (_language == value) {
      return;
    }

    _language = value;
    notifyListeners();
  }
}
