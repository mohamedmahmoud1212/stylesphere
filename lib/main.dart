import 'package:flutter/material.dart';
import 'package:stylesphere/controllers/sharedpre.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stylesphere/screen/category/home_categories.dart';
 import 'package:stylesphere/screen/home_screen.dart';
import 'package:stylesphere/screen/product/Home.dart';
import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.cacheintialization();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Style Sphere',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'cairo',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 20),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ShoppingScreen(),
    );
  }
}
