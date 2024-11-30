import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 155,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: 400,
          child: Column(
            children: [
              Center(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(100)),
                  child: CircleAvatar(
                    radius: 45,
                    child: Image.asset("assets/download.jpg.jpeg",fit: BoxFit.cover,),
                  ),
                ),
              ),
              SizedBox(height: 32,),
              Container(
                height: 96,
                width: 342,
              child: Card(
                child: Column(
                  children: [
                    Text("data")
                  ],
                ),
              ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
