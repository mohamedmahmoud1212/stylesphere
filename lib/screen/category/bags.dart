import 'package:flutter/material.dart';

class Bags extends StatefulWidget {
  const Bags({super.key});

  @override
  State<Bags> createState() => _BagsState();
}

class _BagsState extends State<Bags> {
  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/Bags/442-4425959_women-bag-png-image-download-pink-handbag-for.png", 
      "name": "Cool Bag 1",
      "price": "\$50.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Bags/35929-3-purse.png",
      "name": "Cool Bag 2",
      "price": "\$55.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Bags/Bag-PNG-Image.png",
      "name": "Cool Bag 3",
      "price": "\$60.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Bags/bag.png",
      "name": "Cool Bag 4",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Bags/Ladies-Bag-PNG-Free-Download.png",
      "name": "Cool Bag 5",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Bags/png-clipart-handbag-messenger-bags-luxury-goods-tote-bag-bag-zipper-luggage-bags-thumbnail.png",
      "name": "Cool Bag 6",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Bags/png-clipart-tote-bag-amazon-com-canvas-messenger-bags-bag-blue-beach-thumbnail.png",
      "name": "Cool Bag 7",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Bags/png-transparent-tote-bag-shopping-bags-trolleys-handbag-canvas-bag-blue-white-luggage-bags-thumbnail.png",
      "name": "Cool Bag 8",
      "price": "\$45.00",
      "isFavorite": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                
                // Heading Text
                Text(
                  "Bags (${products.length})",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 15),

                // GridView of Products
                GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row (unchanged)
                    crossAxisSpacing: 10, // Space between columns (unchanged)
                    mainAxisSpacing: 10, // Space between rows (unchanged)
                    childAspectRatio: 0.8, // Aspect ratio for each item (unchanged)
                  ),
                  itemCount: products.length,
                  shrinkWrap: true, // Ensures that GridView doesn't take up too much space
                  physics: NeverScrollableScrollPhysics(), // Prevent scroll conflicts with ListView
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle the favorite state for the selected product only
                          product["isFavorite"] = !product["isFavorite"];
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 229, 228, 228),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(product["image"]!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    product["name"]!,
                                    style: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    product["price"]!,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  product["isFavorite"] = !product["isFavorite"];
                                });
                              },
                              child: Icon(
                                product["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                color: product["isFavorite"] ? Colors.red : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
