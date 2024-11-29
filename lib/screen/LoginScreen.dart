// ignore: file_names
import 'package:flutter/material.dart';
import 'package:stylesphere/controllers/firebase_func.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Style Sphere")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  addProduct("test", "test", "test", 4.4, "test"), // working
              child: Text("Register"),
            ),
            ElevatedButton(
              onPressed: () => debugFetchin(),
              child: Text("Sign in with Google"), // working
            ),
            ElevatedButton(
              onPressed: () async {
                bool isLoggedIn = await isUserLoggedIn(); // working

                if (!isLoggedIn) {
                  loginUser(_emailController.text,
                      _passwordController.text); // working
                } else {
                  print("user is logged in!");
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
