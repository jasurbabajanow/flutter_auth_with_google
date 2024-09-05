import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_verify/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    _auth.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
    super.initState();
  }

  void signIn() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();

      _auth.signInWithProvider(googleAuthProvider);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Google Auth',
                style: TextStyle(fontSize: 24),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                key: _formKey,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: loginController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _obscure,
                        child: _isObscure
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(height: 28),
                  GestureDetector(
                    onTap: signIn,
                    child: Image.network(
                        "https://img.icons8.com/color/48/google-logo.png"),
                  )
                ],
              ),
            ),
          )
        : const HomePage();
  }

  void _obscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }
}
