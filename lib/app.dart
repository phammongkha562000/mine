// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bmi_pj/config/theme/app_theme.dart';
import 'package:bmi_pj/data/services/injection/injection.dart';
import 'package:bmi_pj/generate_route.dart' as router;
import 'package:bmi_pj/menu.dart';
import 'package:flutter/material.dart';

import 'data/services/navigator/navigation_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: Colors.deepPurple,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Demo',
      theme: AppTheme.light,
      home: MenuView(),
      navigatorKey: getIt<NavigationService>().navigatorKey,
      onGenerateRoute: router.generateRoute,
    );
  }
}
