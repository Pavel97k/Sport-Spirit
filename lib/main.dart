import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportSpirit/app.dart';
import 'package:SportSpirit/features/data/global_service.dart';
import 'package:SportSpirit/features/utils/theme/theme_data.dart';
//import 'package:dcdg/dcdg.dart';

Future<void> main() async {
  await init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemesData(isDarkMode: 0),
    ),
  ], child: const App()));
}
