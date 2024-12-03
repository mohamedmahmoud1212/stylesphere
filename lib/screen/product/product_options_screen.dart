import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:stylesphere/screen/product/option_tile.dart';

class ProductOptionsScreen extends StatefulWidget {
  const ProductOptionsScreen(
      {super.key,
      required this.productImage,
      required this.productTitle,
      required this.productPrice});
  final productImage;
  final productTitle;
  final productPrice;
  @override
  State<ProductOptionsScreen> createState() => _ProductOptionsScreenState();
}

class _ProductOptionsScreenState extends State<ProductOptionsScreen> {
  String selectedSize = 'S'; // Default size
  String selectedColor = 'Green'; // Default color
  int quantity = 1;
  final LinearGradient _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[HexColor("9A7FF1"), HexColor("746EB7")],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Product Options',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.30,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(widget.productImage))),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.030,
            ),
            Text(widget.productTitle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.010,
            ),
      ShaderMask(
        shaderCallback: (Rect rect) {
          return _gradient.createShader(rect);
        },child:  Text(widget.productPrice,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),),
              SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.030,
            ),
            OptionTile(
              label: "Size",
              child: DropdownButton<String>(
                dropdownColor: HexColor("9A7FF1"),
                value: selectedSize,
                items: ['S', 'M', 'L', 'XL']
                    .map(
                      (size) => DropdownMenuItem<String>(

                        value: size,
                        child: Text(size),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSize = value!;
                  });
                },
                underline: const SizedBox(),
              ),
            ),
            const SizedBox(height: 16),
            OptionTile(
              label: "Color",
              child: DropdownButton<String>(
                value: selectedColor,
                items: ['Green', 'Blue', 'Red', 'Yellow']
                    .map(
                      (color) => DropdownMenuItem<String>(
                        value: color,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: _getColor(color),
                              radius: 8,
                            ),
                            const SizedBox(width: 8),
                            Text(color),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedColor = value!;
                  });
                },
                underline: const SizedBox(),
              ),
            ),
            const SizedBox(height: 16),
            OptionTile(
              label: "Quantity",
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:HexColor("9A7FF1"),
                    child: IconButton(
                     
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                      icon: Icon(Icons.remove, color: Colors.white),
                      color: Colors.purple,
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      quantity.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: HexColor("9A7FF1"),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                      color: Colors.purple,
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ),
              SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.080,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("9A7FF1"),
                fixedSize: Size.fromHeight(60)
              ),
              onPressed: () {
              
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(widget.productPrice,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              
              Text("Add to cart",style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
            ],))
          ],
        ),
      ),
    );
  }
}

Color _getColor(String colorName) {
  switch (colorName) {
    case 'Green':
      return Colors.green;
    case 'Blue':
      return Colors.blue;
    case 'Red':
      return Colors.red;
    case 'Yellow':
      return Colors.yellow;
    default:
      return Colors.grey;
  }
}
