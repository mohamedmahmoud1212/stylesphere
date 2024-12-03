import 'package:flutter/material.dart';

class Hoodies extends StatefulWidget {
  const Hoodies({super.key});

  @override
  State<Hoodies> createState() => _HoodiesState();
}

class _HoodiesState extends State<Hoodies> {

  // Defining product data in the same screen
  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/hoodies/adidas_hoodiee.png", // Ensure this image exists in your assets
      "name": "Cool Hoodie 1",
      "price": "\$50.00",
      "isFavorite": false,
    },
    {
      "image": "assets/hoodies/hoodiee_black.webp",
      "name": "Cool Hoodie 2",
      "price": "\$55.00",
      "isFavorite": false,
    },
    {
      "image": "assets/hoodies/hoddiee_topselling.jpg",
      "name": "Cool Hoodie 3",
      "price": "\$60.00",
      "isFavorite": false,
    },
    {
      "image": "assets/hoodies/hoodie_brown.webp",
      "name": "Cool Hoodie 4",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/hoodies/flat_grey.png",
      "name": "Cool Hoodie 5",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/hoodies/hoodies1.png",
      "name": "Cool Hoodie 6",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/hoodies/HoodieTNHeatherGrey.webp",
      "name": "Cool Hoodie 7",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/hoodies/Nike-Sb-Hoodie-PNG-HD-Quality.png",
      "name": "Cool Hoodie 8",
      "price": "\$45.00",
      "isFavorite": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get the screen width and height for spacing adjustments
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02), // Adjusting padding based on screen size
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
                  "Hoodies (${products.length})",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 15),

                // GridView of Products
                GridView.builder(
                  padding: EdgeInsets.all(screenWidth * 0.02), // Adjusting padding based on screen size
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Set 2 items per row
                    crossAxisSpacing: 10, // Space between columns
                    mainAxisSpacing: 10, // Space between rows
                    childAspectRatio: 0.8, // Aspect ratio for each item (height/width)
                  ),
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Prevent scroll conflicts with ListView
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
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
                                product["isFavorite"]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
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
