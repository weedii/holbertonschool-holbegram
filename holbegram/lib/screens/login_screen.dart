import "package:flutter/material.dart";
import "package:holbegram/methods/auth_methods.dart";
import "package:holbegram/models/user.dart";
import "package:holbegram/providers/user_provider.dart";
import "package:holbegram/widgets/text_field.dart";
import "package:provider/provider.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;

  final AuthMethode authMethode = AuthMethode();

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }

    AuthMethode authMethods = AuthMethode();

    try {
      var res = await authMethode.login(
        email: emailController.text,
        password: passwordController.text,
      );

      var userDoc = await authMethods.getUserDetails(res);
      final userInfo = Users.fromSnap(userDoc);

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.setUser(userInfo);

      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$e")),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 28),
              const Text(
                "Holbegram",
                style: TextStyle(fontFamily: "Billabong", fontSize: 50),
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 80,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 28),

                    // email input
                    TextFieldInput(
                      ispassword: false,
                      controller: emailController,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 24),

                    // pass input
                    TextFieldInput(
                      ispassword: !_passwordVisible,
                      controller: passwordController,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.red,
                        ),
                        alignment: Alignment.bottomLeft,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // login button
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(218, 226, 37, 24),
                              ),
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ))),
                          onPressed: () {
                            handleLogin();
                          },
                          child: const Text(
                            "Log in",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),

                    const SizedBox(height: 24),

                    // forget pass
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Forgot your login details?"),
                        Text(
                          "Get help logging in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),

                    // flexible
                    Flexible(flex: 0, child: Container()),

                    const SizedBox(height: 24),

                    const Divider(thickness: 2),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "/signup");
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(218, 226, 37, 24)),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // OR
              const Row(
                children: [
                  Flexible(child: Divider(thickness: 2)),
                  Text(" OR "),
                  Flexible(child: Divider(thickness: 2)),
                ],
              ),

              // google button
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
                    width: 40,
                    height: 40,
                  ),
                  const Text("Sign in with Google")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
