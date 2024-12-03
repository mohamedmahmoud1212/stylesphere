import 'package:flutter/material.dart';

class Shoes extends StatefulWidget {
  const Shoes({super.key});

  @override
  State<Shoes> createState() => _ShoesState();
}

class _ShoesState extends State<Shoes> {
  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/Shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png", 
      "name": "Cool Shoes 1",
      "price": "\$50.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shoes/nike_shoes.webp",
      "name": "Cool Shoes 2",
      "price": "\$55.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shoes/png-clipart-shoe-nike-free-air-force-nike-shoes-image-file-formats-fashion-thumbnail.png",
      "name": "Cool Shoes 3",
      "price": "\$60.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shoes/pngtree-black-sneaker-with-laces-on-transparent-background-png-image_12913809.png",
      "name": "Cool Shoes 4",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shoes/shoes_new.png",
      "name": "Cool Shoes 5",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shoes/shoes.png",
      "name": "Cool Shoes 6",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shoes/Shoes1.png",
      "name": "Cool Shoes 7",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shoes/Shoes2.png",
      "name": "Cool Shoes 8",
      "price": "\$45.00",
      "isFavorite": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height for dynamic layout
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                  "Shoes (${products.length})",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 15),

                // GridView of Products with dynamic crossAxisCount and item sizes
                GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 600 ? 3 : 2, // 2 items per row on small screens, 3 on larger ones
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: screenWidth > 600 ? 0.7 : 0.8, // Adjust aspect ratio for larger screens
                  ),
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                                  height: screenHeight * 0.2, // Dynamic height based on screen height
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
