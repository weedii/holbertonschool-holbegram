import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:holbegram/methods/auth_gate.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/screens/signup_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp();

  try {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest,
    );
    print("Firebase App Check activated successfully");
  } catch (e) {
    print("Error activating Firebase App Check: $e");
  }

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: AuthGate(),
        ),
      ),
      routes: {
        "/home": (context) => const Home(),
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const SignUp(),
      },
    );
  }
}
