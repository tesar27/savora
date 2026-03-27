import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(child: Center(child: Text(t.bookingsTitle))),
    );
  }
}
