import 'package:flutter/material.dart';

class Shorts extends StatefulWidget {
  const Shorts({super.key});

  @override
  State<Shorts> createState() => _ShortsState();
}

class _ShortsState extends State<Shorts> {
  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/Shorts/ai-generated-3d-rendering-of-a-man-shorts-on-transparent-background-ai-generated-free-png.webp", 
      "name": "Cool Short 1",
      "price": "\$50.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shorts/pngtree-black-shorts-mockup-cutout-png-file-png-image_11588907.png",
      "name": "Cool Short 2",
      "price": "\$55.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shorts/black_shortNS.png",
      "name": "Cool Short 3",
      "price": "\$60.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shorts/short_army.png",
      "name": "Cool Short 4",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shorts/short2.png",
      "name": "Cool Short 5",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shorts/shorts-115690514940tsfkz9cnc.png",
      "name": "Cool Short 6",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shorts/Shorts-PNG.png",
      "name": "Cool Short 7",
      "price": "\$45.00",
      "isFavorite": false,
    },
    {
      "image": "assets/Shorts/shorts.webp",
      "name": "Cool Short 8",
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
                  "Shorts (${products.length})",
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
