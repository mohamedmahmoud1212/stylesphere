import 'package:flutter/material.dart';

class ShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          titleSpacing: 0,
          title: Text(
            'Shop by Categories',
            style: TextStyle(
                fontFamily: "cairo",
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30, // Adjusted radius for the CircleAvatar
                child: Image.network(
                    'https://www.pngkey.com/png/detail/950-9503701_freetouse-sticker-hoodies-pic-poses-for-girls.png'),
              ),
              title: Text('Hoodies'),
              tileColor: Colors.grey[200], // Set tile color
            ),
            SizedBox(
              height: 9,
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30, // Adjusted radius for the CircleAvatar
                child: Image.network(
                    'https://ae01.alicdn.com/kf/Sdf1af184c9ee4053a9f74a425045bd759.jpg_960x960.jpg'),
              ),
              title: Text('Accessories'),
              tileColor: Colors.grey[200], // Set tile color
            ),
            SizedBox(
              height: 9,
            ),
            ListTile(
                leading: CircleAvatar(
                  radius: 30, // Adjusted radius for the CircleAvatar
                  child: Image.network(
                      'https://png.pngtree.com/png-vector/20240811/ourlarge/pngtree-makeup-collection-png-image_13447527.png'),
                ),
                title: Text('Makeup'),
                tileColor: Colors.grey[200]),
            SizedBox(
              height: 9,
            ),
            ListTile(
                leading: CircleAvatar(
                  radius: 30, // Adjusted radius for the CircleAvatar
                  child: Image.network(
                      'https://png.pngtree.com/png-vector/20240811/ourlarge/pngtree-makeup-collection-png-image_13447527.png'),
                ),
                title: Text('Shoses'),
                tileColor: Colors.grey[200]),
          ],
        ),
      ),
    );
  }
}
