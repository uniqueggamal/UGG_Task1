import 'package:flutter/material.dart';
import 'package:internship_task/loginscreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homepage")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset('assets/logo.png'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loginscreen()),
                  );
                },
                child: Text('Log out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
