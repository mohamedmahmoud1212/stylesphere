import 'package:flutter/material.dart';
import 'package:stylesphere/controllers/firebase_func.dart';
import 'package:stylesphere/models/Item.dart';
import 'package:stylesphere/screen/category/accessories.dart';
import 'package:stylesphere/screen/category/bags.dart';
import 'package:stylesphere/screen/category/hoodies.dart';
import 'package:stylesphere/screen/category/shoes.dart';
import 'package:stylesphere/screen/category/shorts.dart';
import 'package:stylesphere/screen/home_screen.dart';
import 'package:stylesphere/screen/product/product_options_screen.dart';
import 'package:stylesphere/screen/profile/profile_screen.dart';

class Homepage1 extends StatefulWidget {
  const Homepage1({super.key});

  @override
  State<Homepage1> createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
  String searchQuery = '';
  int _selectedIndex = 0;
  //
  // void fetch() async {
  //   List<Item> items = await fetchProducts();
  // }

  final List<Widget> _pages = [
    const HomepageContent(
      searchQuery: '',
    ),
    ProfileScreen(userName: username.toString()),
    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _selectedIndex == 0
            ? HomepageContent(
                searchQuery: searchQuery,
                onSearchChanged: (query) {
                  setState(() {
                    searchQuery = query.toLowerCase();
                  });
                },
              )
            : _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color.fromRGBO(142, 108, 239, 1),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class HomepageContent extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String>? onSearchChanged;

  const HomepageContent(
      {super.key, required this.searchQuery, this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    // MediaQuery to adjust layout based on screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03, // 3% of screen width
        vertical: screenHeight * 0.02, // 2% of screen height
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color.fromARGB(255, 189, 189, 189),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/download.jpg.jpeg",
                      fit: BoxFit.cover,
                      width: screenWidth * 0.12, // 12% of screen width
                      height: screenWidth * 0.12, // 12% of screen width
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * 0.12, // 12% of screen width
                  height: screenWidth * 0.12, // 12% of screen width
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(142, 108, 239, 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: screenHeight * 0.07, // 7% of screen height
              decoration: BoxDecoration(
                color: const Color.fromRGBO(244, 244, 244, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: onSearchChanged,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            const CategoriesRow(),
            const SizedBox(height: 20),
            const Text(
              "Top Selling",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            TopSellingRow(searchQuery: searchQuery),
            const SizedBox(height: 20),
            const Text(
              "New In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromRGBO(142, 108, 239, 1),
              ),
            ),
            const SizedBox(height: 20),
            NewInRow(searchQuery: searchQuery),
          ],
        ),
      ],
    );
  }
}

class CategoriesRow extends StatefulWidget {
  const CategoriesRow({super.key});

  @override
  State<CategoriesRow> createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  late Future<List<Item>> itemsMaleFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemsMaleFuture = getProductsCat("Male") as Future<List<Item>>;
  }
  @override
  Widget build(BuildContext context) {
    // MediaQuery to scale layout for screen size
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, String>> categories = [
      {"image": "assets/hoodies/hoodie_brown.webp", "label": "Hoodies"},
      {
        "image":
            "assets/Shorts/ai-generated-3d-rendering-of-a-man-shorts-on-transparent-background-ai-generated-free-png.webp",
        "label": "Shorts"
      },
      {
        "image":
            "assets/Shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png",
        "label": "Shoes"
      },
      {"image": "assets/Bags/Bag-PNG-Image.png", "label": "Bag"},
      {"image": "assets/accessories/sunglasses.png", "label": "Accessories"},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((category) {
        return FutureBuilder<List<Item>>(
          future: itemsMaleFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final itemsMale = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemsMale.length,
                itemBuilder: (context, index) {
                  final item = itemsMale[index];
                  return ListTile(
                    title: Text(item.name),
                    onTap: () {
                      switch (item.category) {
                        case "Hoodies":
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Hoodies()),
                          );
                          break;
                        case "Shorts":
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Shorts()),
                          );
                          break;
                        case "Shoes":
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Shoes()),
                          );
                          break;
                        case "Bag":
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Bags()),
                          );
                          break;
                        case "Accessories":
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Accessories()),
                          );
                          break;
                        default:
                          break;
                      }
                    },
                  );
                },
              );
            } else {
              return Center(child: Text("No items found"));
            }
          },
        );
      }).toList(),
    );
  }
}

// The TopSellingRow and NewInRow widgets remain unchanged

class TopSellingRow extends StatelessWidget {
  final String searchQuery;

  const TopSellingRow({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        "image": "assets/hoodies/hoodie_brown.webp",
        "name": "Men's Hoodiee NS",
        "price": "\$150"
      },
      {
        "image": "assets/men-s-slippers-slipper-o0LKMQ1-600.jpg",
        "name": "Max Ciro men's slippers",
        "price": "\$75"
      },
      {
        "image":
            "assets/accessories/png-clipart-apple-watch-apple-watch-white.png",
        "name": "Smart Watch",
        "price": "\$120"
      },
      {
        "image":
            "assets/accessories/png-clipart-hat-straw-hat-hat-photography.png",
        "name": "Straw Hat",
        "price": "\$40"
      },
    ];

    final filteredProducts = products
        .where((product) => product["name"].toLowerCase().contains(searchQuery))
        .toList();

    return filteredProducts.isEmpty
        ? const Center(
            child: Text(
              "No results found.",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          )
        : SizedBox(
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: filteredProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductOptionsScreen(
                                    productImage: products[index]["image"],
                                    productTitle: products[index]["name"],
                                    productPrice: products[index]["price"],
                                  )));
                    },
                    child: ProductCard(product: product));
              },
            ),
          );
  }
}

class NewInRow extends StatefulWidget {
  final String searchQuery;

    NewInRow({super.key, required this.searchQuery});

  @override
  State<NewInRow> createState() => _NewInRowState();
}

class _NewInRowState extends State<NewInRow> {
  late Future<List<Item>> itemsMaleFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemsMaleFuture = fetchProducts(byGender: "Male");
  }

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, dynamic>> newInItems = [
    //   {
    //     "image":
    //         "assets/accessories/yellow-baseball-cap-isolated-on-transparent-background-cap-cut-out-mock-up-generative-ai-png.webp",
    //     "name": "Baseball Cap",
    //     "price": "\$60"
    //   },
    //   // {
    //   //   "image": "assets/hoodies/hoodiee_black.webp",
    //   //   "name": "Hoodie NS",
    //   //   "price": "\$130"
    //   // },
    //   {
    //     "image": "assets/hoodies/HoodieTNHeatherGrey.webp",
    //     "name": "Hoodiee Winter",
    //     "price": "\$140"
    //   },
    //   {
    //     "image": "assets/Shorts/shorts.webp",
    //     "name": "Short NS",
    //     "price": "\$60"
    //   },
    // ];

    final filteredNewInItems = itemsMaleFuture
        .where((item) => item["name"].toLowerCase().contains(widget.searchQuery))
        .toList();

    return filteredNewInItems.isEmpty
        ? const Center(
            child: Text(
              "No results found.",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          )
        : SizedBox(
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: filteredNewInItems.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = filteredNewInItems[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductOptionsScreen(
                                    productImage: newInItems[index]["image"],
                                    productTitle: newInItems[index]["name"],
                                    productPrice: newInItems[index]["price"],
                                  )));
                    },
                    child: ProductCard(product: item));
              },
            ),
          );
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(widget.product["image"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.product["name"],
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.product["price"],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                isFavorite = !isFavorite;
              });
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
