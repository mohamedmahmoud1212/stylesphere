import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stylesphere/controllers/sharedpre.dart';
import 'package:stylesphere/screen/profile/AddresDetail.dart';

class Address extends StatefulWidget {
  Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  cache.getData(key: "address");
  }
  final LinearGradient _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[HexColor("9A7FF1"), HexColor("746EB7")],
  );

var cache=CacheHelper();
User? myUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text("Address"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 35.0,right: 35,top: 42),
        child: Container(
          height: 96,
          width: 390,
          child: Card(
            color: HexColor("f4f4f4").withOpacity(0.9),
            child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cache.getData(key: "address"),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return _gradient.createShader(rect);
                      },
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddresDetail()));
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                          ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
