import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_spirit/app.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/utils/theme/theme_data.dart';

Future<void> main() async {
  await init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemesData(isDarkMode: 0),
    ),
  ], child: const App()));
}
