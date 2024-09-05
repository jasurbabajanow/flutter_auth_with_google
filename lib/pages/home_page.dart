import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("You already signed in"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            auth.signOut();
          },
          child: const Text(
            "LogOUT",
            style: TextStyle(fontSize: 36),
          ),
        ),
      ),
    );
  }
}
