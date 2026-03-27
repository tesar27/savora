import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/settings/app_settings_controller.dart';
import '../../../core/settings/app_settings_scope.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = AppLocalizations.of(context);
    final AppSettingsController settings = AppSettingsScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Text(
              t.settings,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1C1F2D),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      t.language,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF22252F),
                      ),
                    ),
                  ),
                  DropdownButton<AppLanguage>(
                    value: settings.language,
                    underline: const SizedBox.shrink(),
                    onChanged: (AppLanguage? value) {
                      if (value != null) {
                        settings.updateLanguage(value);
                      }
                    },
                    items: <DropdownMenuItem<AppLanguage>>[
                      DropdownMenuItem<AppLanguage>(
                        value: AppLanguage.system,
                        child: Text(t.languageSystem),
                      ),
                      DropdownMenuItem<AppLanguage>(
                        value: AppLanguage.english,
                        child: Text(t.languageEnglish),
                      ),
                      DropdownMenuItem<AppLanguage>(
                        value: AppLanguage.german,
                        child: Text(t.languageGerman),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
