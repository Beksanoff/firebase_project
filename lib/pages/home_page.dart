import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/pages/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigate = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 42, 73),
        title: const Text('Главная', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Добро пожаловать!', style: TextStyle(fontSize: 20)),
            MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  navigate.pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Выйти из аккаунта'))
          ],
        ),
      ),
    );
  }
}
