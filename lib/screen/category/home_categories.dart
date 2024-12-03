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
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            _buildCategoryTile(
                'Hoodie', 'https://i.ibb.co/Mp36DHm/image.png', context),
            _buildCategoryTile(
                'Shirt', 'https://i.ibb.co/Q985R7M/image.png', context),
            _buildCategoryTile(
                'Dress', 'https://i.ibb.co/WGXb90D/image.png', context),
            _buildCategoryTile(
                'Trousers', 'https://i.ibb.co/F7DwqHP/image.png', context),
            _buildCategoryTile(
                'Shoes', 'https://i.ibb.co/FVQsGXc/image.png', context),
            _buildCategoryTile(
                'Accessory', 'https://i.ibb.co/d5KMz0D/image.png', context),
            _buildCategoryTile(
                'Make up', 'https://i.ibb.co/3pj5FGY/image.png', context),
            _buildCategoryTile(
                'Skin care', 'https://i.ibb.co/dB15rc2/image.png', context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(
      String title, String imageUrl, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Space between tiles
      child: InkWell(
        onTap: () {
          // Navigate to a new screen (replace with your target screen)
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryDetailScreen(title: title)),
          );
        },
        child: ListTile(
          minTileHeight: 70,

          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0), // Padding inside the tile
          leading: ClipOval(
            child: Image.network(
              imageUrl,
              width: 50, // Avatar size
              height: 50,
              fit: BoxFit.cover, // Make sure the image fits the circle properly
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18, // Font size for the title
              fontWeight: FontWeight.bold,
            ),
          ),

          tileColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          trailing: Icon(
            Icons
                .arrow_forward_ios, // Optional icon for better interaction feel
            size: 20,
          ),
        ),
      ),
    );
  }
}

// Dummy screen for category detail
class CategoryDetailScreen extends StatelessWidget {
  final String title;

  CategoryDetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Welcome to the $title category!'),
      ),
    );
  }
}
