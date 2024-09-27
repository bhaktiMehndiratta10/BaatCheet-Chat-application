import 'package:baat_cheet/services/auth/auth_gate.dart';
import 'package:baat_cheet/services/auth/login_or_register.dart';
import 'package:baat_cheet/firebase_options.dart';
import 'package:baat_cheet/pages/login_page.dart';
import 'package:baat_cheet/pages/register_page.dart';
import 'package:baat_cheet/themes/light_mode.dart';
import 'package:baat_cheet/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}