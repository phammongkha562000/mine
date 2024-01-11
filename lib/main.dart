import 'package:bmi_pj/app.dart';
import 'package:bmi_pj/data/services/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await EasyLocalization.ensureInitialized();
  configureInjection();

  runApp(const ProviderScope(child: MyApp()));
}
