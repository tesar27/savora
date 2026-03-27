import 'package:flutter/material.dart';

import 'navigation/main_scaffold.dart';

class SavoraApp extends StatelessWidget {
  const SavoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Savora',
      themeMode: ThemeMode.light,
      home: const MainScaffold(),
    );
  }
}
