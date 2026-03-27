import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/localization/app_localizations.dart';
import '../core/settings/app_settings_controller.dart';
import '../core/settings/app_settings_scope.dart';
import '../core/theme/app_theme.dart';
import 'navigation/main_scaffold.dart';

class SavoraApp extends StatefulWidget {
  const SavoraApp({super.key});

  @override
  State<SavoraApp> createState() => _SavoraAppState();
}

class _SavoraAppState extends State<SavoraApp> {
  final AppSettingsController _settingsController = AppSettingsController();

  @override
  void dispose() {
    _settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _settingsController,
      builder: (BuildContext context, Widget? child) {
        return AppSettingsScope(
          controller: _settingsController,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Savora',
            themeMode: ThemeMode.light,
            theme: AppTheme.light(),
            locale: _settingsController.localeOverride,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const MainScaffold(),
          ),
        );
      },
    );
  }
}
