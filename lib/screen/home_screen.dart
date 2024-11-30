import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:stylesphere/controllers/firebase_func.dart';
import 'package:stylesphere/models/Item.dart';
import 'package:stylesphere/screen/sign_proccess/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Style Sphere',
          style: TextStyle(
            fontFamily: 'cairo',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == '1') {
                // Handle "Home" action
              } else if (value == '2') {
                // Handle "Settings" action
              } else if (value == '3') {
                try {
                  await logoutUser();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout failed: ${e.toString()}')),
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: '1',
                  child: Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 10),
                      Text('Home', style: TextStyle(fontFamily: 'cairo', fontSize: 16)),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: '2',
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text('Settings', style: TextStyle(fontFamily: 'cairo', fontSize: 16)),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: '3',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Log Out', style: TextStyle(fontFamily: 'cairo', fontSize: 16)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Item>?>(
        // fetchData() Gets all data from the first parameter eg. 'Users' or 'Products',
        // if you want to find smth eg. ['Products', byCategory: "Top", byGender: "Female"]
        // or ['Users', byPhone: "01553961060"]
        // LOOK DEBUG CONSOLE FOR OUTPUT
        future: fetchData('Products', byPrice: 99.9),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items found.'));
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return ListTile(
                  title: Text(
                    item.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    '\$${item.price?.toStringAsFixed(2).toString()} | '
                        'Category: ${item.category} | '
                        'Description: ${item.description}',
                  ),
                  leading: item.image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      item.image.toString(),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Icon(Icons.image_not_supported),
                );
              },
            );
          }
        },
      ));
  }
}
