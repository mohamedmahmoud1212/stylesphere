import 'package:flutter/material.dart';
import 'package:stylesphere/controllers/firebase_func.dart';
import 'package:stylesphere/controllers/sharedpre.dart';
import 'package:stylesphere/screen/home_screen.dart';
import 'package:stylesphere/screen/profile/profile_screen.dart';

class AddresDetail extends StatefulWidget {
  AddresDetail({super.key});

  @override
  State<AddresDetail> createState() => _AddresDetailState();
}

class _AddresDetailState extends State<AddresDetail> {
  TextEditingController AddressCont = TextEditingController();

var cache=CacheHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Address"),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back_ios) ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: AddressCont,
              decoration: InputDecoration(
                  hintText: "Edit Address", border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4)),),
            ),
          ),
          TextButton(onPressed: () async{
            final username= await getUserNameByEmail(cache.getData(key: "user"));
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ProfileScreen(userName:username )));
            cache.setData(key: "address", value: AddressCont.text);
            cache.getData(key: "address");
          }, child: Text("Confirm Edit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),))
        ],
      ),
    );
  }
}
