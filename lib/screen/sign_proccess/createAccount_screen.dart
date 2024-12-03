import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stylesphere/controllers/firebase_func.dart';
import 'package:stylesphere/screen/sign_proccess/signin_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController NameControl = TextEditingController();
  TextEditingController PhoneControl = TextEditingController();

  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

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
                        "Create Account",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 65),
                      TextFormField(
                        controller: NameControl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          hintText: "Name",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: PhoneControl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          hintText: "Phone",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
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
                            gradient: LinearGradient(colors: [
                              HexColor("9A7FF1"),
                              HexColor("746EB7")
                            ])),
                        child: TextButton(
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            registerUser(
                                email: emailControl.text,
                                password: passwordControl.text,
                                name: NameControl.text,
                                phone: PhoneControl.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: [
                            Text("Already have an Account   "),
                            InkWell(
                              enableFeedback: false,
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              child: Text(
                                "Log In",
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
