import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internship_task/screens/homePage.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final username = TextEditingController(text: "NCCSIntern");
  final password = TextEditingController(text: "2026");
  bool hidePassword = true;

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Welcome to NCCS  ",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Internship, Login now!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  style: TextStyle(fontSize: 14),
                  controller: username,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        !hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  obscureText: hidePassword,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: 90,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.purple),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    child: Text('Login', style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
