import 'package:flutter/material.dart';
import 'package:stylesphere/controllers/functions.dart';
import 'package:stylesphere/module/Items.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Item>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = fetchItems();
  }

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
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: '1',
                  child: Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 10),
                      Text(
                        'Home',
                        style: TextStyle(fontFamily: 'cairo', fontSize: 16),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: '2',
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text(
                        'Settings',
                        style: TextStyle(fontFamily: 'cairo', fontSize: 16),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: '3',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text(
                        'Log Out',
                        style: TextStyle(fontFamily: 'cairo', fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: _futureItems,
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
                      '\$${"${item.price.toStringAsFixed(2)} TransID: ${genTransactionId()}"}'),
                  leading: item.imageUrl.isNotEmpty
                      ? Flexible(
                          fit: FlexFit.tight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              item.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : Icon(Icons.image_not_supported),
                );
              },
            );
          }
        },
      ),
    );
  }
}
