import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailControl=TextEditingController();
  TextEditingController passwordControl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
  height: MediaQuery.of(context).size.height,
  width: 400.w,
  child: Column(
    children: [
      Text("Sign in",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
      TextFormField(
        controller: emailControl,
        decoration: InputDecoration(
          hintText:"Email Address" ,
        ),
      ),
      SizedBox(height: 16,),
      TextFormField(
        controller: emailControl,
        decoration: InputDecoration(
          hintText:"Email Address" ,
        ),
      ),
    ],
  ),
),
    );
  }
}
//8678B2,,,9A7FF1
//635EA4,,,746EB7