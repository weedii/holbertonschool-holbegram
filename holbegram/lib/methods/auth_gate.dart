import 'package:flutter/material.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  void loadPreferences() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isLoggedIn = userProvider.user == null ? false : true;

    return Scaffold(
      body: isLoggedIn ? const Home() : const LoginScreen(),
    );
  }
}
