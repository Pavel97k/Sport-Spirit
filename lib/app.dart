import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportSpirit/features/utils/router/getrouters.dart';
import 'package:SportSpirit/features/utils/theme/theme_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemesData>(
      builder: (BuildContext context, value, Widget? child) {
        value.getThemes();
        return MaterialApp.router(
          theme: value.getTheme,
          routerConfig: router,
        );
      },
    );
  }
}
