import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stylesphere/controllers/firebase_func.dart';
import 'package:stylesphere/controllers/sharedpre.dart';
import 'package:stylesphere/models/Item.dart';
import 'package:stylesphere/screen/profile/Address.dart';
import 'package:stylesphere/screen/sign_proccess/signin_screen.dart';

class ProfileScreen extends StatefulWidget {


  // final String email;
  ProfileScreen({
    super.key,
    required this.userName,
  });
    String userName;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var cache = CacheHelper();

  // Item? myItem;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Center(
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      child: CircleAvatar(
                        radius: 45,
                        child: Image.asset(
                          "assets/download.jpg.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 96,
                    width: 342,
                    child: Card(
                      color: HexColor("f4f4f4").withOpacity(0.9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.userName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              cache.getData(key: "user"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  Container(
                    height: 56,
                    width: 342,
                    child: Card(
                      color: HexColor("f4f4f4").withOpacity(0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Address()));
                                },
                                icon: Icon(Icons.arrow_forward_ios)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: TextButton(
                    onPressed: () {
                      logoutUser();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
