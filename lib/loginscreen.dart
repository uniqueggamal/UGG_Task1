import 'package:flutter/material.dart';
import 'package:internship_task/homepage.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  void login() {
    if (username.text == 'NCCSIntern') {
      if (password.text == '2026') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Internship Login Page")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'username',
              ),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(onPressed: login, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
