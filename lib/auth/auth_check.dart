import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/pages/home_page.dart';
import 'package:firebase_project/pages/login_page.dart';
import 'package:flutter/material.dart';

class AuthCheckWidget extends StatelessWidget {
  const AuthCheckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        }),
      ),
    );
  }
}
