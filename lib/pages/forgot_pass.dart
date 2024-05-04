import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/pages/login_page.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future forgotPass() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Сообщение успешно отправлено'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Произошла ошибка';
      if (e.code == 'user-not-found') {
        message = 'Пользователь не найден';
      } else if (e.code == 'invalid-email') {
        message = 'Некорректный email';
      }
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 4, 42, 73),
        centerTitle: true,
        title: const Text(
          'Восстановление пароля',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Введите ваш email для восстановления пароля'),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Введите почту',
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                forgotPass();
              },
              child: const Text('Отправить'),
            ),
          ],
        ),
      ),
    );
  }
}
