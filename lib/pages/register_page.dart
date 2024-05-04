import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigate = Navigator.of(context);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Регистрация прошла успешно!'),
        ),
      );
      navigate.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Некорректный email или пароль, попробуйте еще раз';
      if (e.code == 'email-already-in-use') {
        message = 'Этот email уже используется';
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
        backgroundColor: const Color.fromARGB(255, 4, 42, 73),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Регистрация',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.face_retouching_natural_outlined,
              size: 100, color: Colors.blue),
          const Text('Введите данные для регистрации',
              style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Почта',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              obscuringCharacter: '*',
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Пароль',
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: const Color.fromARGB(255, 4, 42, 73),
              ),
              onPressed: () {
                signUp();
              },
              child: const Text('Зарегистрироваться'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
