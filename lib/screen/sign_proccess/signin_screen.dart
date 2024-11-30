import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stylesphere/controllers/firebase_func.dart';
import 'package:stylesphere/screen/home_screen.dart';
import 'package:stylesphere/screen/sign_proccess/createAccount_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    if (await isUserLoggedIn()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print("User is not logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 190),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.only(left: 46, right: 46),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign in",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 65),
                TextFormField(
                  controller: emailControl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4)),
                    hintText: "Email Address",
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: passwordControl,
                  // Fix to use the correct controller
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  width: 344,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      gradient: LinearGradient(
                          colors: [HexColor("9A7FF1"), HexColor("746EB7")])),
                  child: TextButton(
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      loginUser(emailControl.text, passwordControl.text);
                      await _checkLoginStatus();
                    },
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    children: [
                      Text("Don't have an Account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccountScreen()));
                        },
                        child: Text("Create One"),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 70),
                InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () async {
                    await signInWithGoogle();
                    _checkLoginStatus();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: HexColor("f4f4f4"),
                        borderRadius: BorderRadius.circular(80)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Image.asset("assets/google.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Text(
                            "Sign in With Google",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
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

//8678B2,,,9A7FF1  9A7FF1
//635EA4,,,746EB7
