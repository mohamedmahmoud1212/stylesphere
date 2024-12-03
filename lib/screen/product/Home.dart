import 'package:flutter/material.dart';
import 'package:stylesphere/controllers/firebase_func.dart';
import 'package:stylesphere/screen/home_screen.dart';
import 'package:stylesphere/screen/product/homePage1.dart';
import 'package:stylesphere/screen/profile/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
String searchQuery = '';

class _HomeState extends State<Home> {
  List<Widget> _pages = [
  const HomepageContent(
     searchQuery: '',
  ),
  HomeScreen(),
    ProfileScreen(userName: username.toString()),
];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body:SafeArea(child: _selectedIndex == 0
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
