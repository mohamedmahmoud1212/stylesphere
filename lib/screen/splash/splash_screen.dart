import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stylesphere/screen/sign_proccess/signin_screen.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset('assets/Main Scene.json',repeat: false,onLoaded: (v){
       Future.delayed((v.duration),(){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
       });
              }),
    );
  }
}
