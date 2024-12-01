// ignore: file_names
import 'package:flutter/material.dart';
import 'package:stylesphere/controllers/firebase_func.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _GUIDController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _catController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _intController = TextEditingController();
  double? parsedPrice;
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _newValController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Auto login for testing <3
    loginUser("p4nda@gmail.com", "@102030Aa");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Style Sphere - DEBUG")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields for product details
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _catController,
              decoration: InputDecoration(labelText: "Category"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _desController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: "Price"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _intController,
              decoration: InputDecoration(labelText: "Interest"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: "Image"),
            ),
            SizedBox(height: 20),

            // Add product button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => debugFetchin(),
                  child: Text("Fetch All products"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => {
                    parsedPrice = double.tryParse(_priceController.text),
                    addProduct(_nameController.text, _catController.text,
                        _desController.text, parsedPrice!, _intController.text,
                        image: _imageController.text),
                  },
                  child: Text("Add product"),
                ),
              ],
            ),

            TextField(
              controller: _GUIDController,
              decoration: InputDecoration(labelText: "Product GUID"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _fieldController,
              decoration: InputDecoration(labelText: "Field name"),
            ),
            SizedBox(height: 10),

            TextField(
              controller: _newValController,
              decoration: InputDecoration(labelText: "New value"),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    parsedPrice = double.tryParse(_priceController.text);
                    updateData(
                      'Products',
                      _GUIDController.text,
                      _fieldController.text,
                      _newValController.text,
                    );
                  },
                  child: Text("Update Product"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                      foregroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () async {
                    await deleteProduct(_GUIDController.text);
                  },
                  child: Text("Delete Product"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
