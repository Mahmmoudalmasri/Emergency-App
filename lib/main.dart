import 'package:easy_localization/easy_localization.dart';
import 'package:emergency_app/screens/home_screen.dart';
import 'package:emergency_app/screens/login_screen.dart';
import 'package:emergency_app/screens/temp_login.dart';
import 'package:emergency_app/tracking.dart';
import 'package:emergency_app/translations/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('ar')],
      fallbackLocale: const Locale('en'),
      assetLoader: CodegenLoader(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: context.locale == Locale('en') ? 'Kyok' : 'Ubuntu'),
      home: HomeScreen(),
    );
  }
}
