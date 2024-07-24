import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/screens/auth/methods/upload_image_screen.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
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
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
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

                    // name input
                    TextFieldInput(
                      ispassword: false,
                      controller: usernameController,
                      hintText: "Full Name",
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

                    // confirm pass input
                    TextFieldInput(
                      ispassword: !_passwordVisible,
                      controller: passwordConfirmController,
                      hintText: "Confirm Password",
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

                    // Signup button
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddPicture(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        username: usernameController.text)));
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),

                    const SizedBox(height: 24),

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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text(
                              "Log in",
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
            ],
          ),
        ),
      ),
    );
  }
}
