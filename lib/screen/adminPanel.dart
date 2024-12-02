// ignore: file_names
import 'package:flutter/material.dart';
import 'package:stylesphere/controllers/firebase_func.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _GUIDController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedCategory;
  String? _selectedCategory2;

  String? _selectedGender = 'Male';
  String? _selectedGender2 = 'Male';

  double _price = 0.0;
  double _price2 = 0.0;

  String? _fetchFilter;
  final Map<String, Widget> _fetchInputs = {};
  final List<String> _categoriesMale = [
    'Top',
    'Bottom',
    'Shoes',
    'Bags',
    'Accessories'
  ];
  final List<String> _categoriesFemale = [
    'Top',
    'Bottom',
    'Dress',
    'Shoes',
    'Accessories',
    'Bags',
    'Makeup',
    'SkinCare'
  ];
  final List<String> _fetchOptions = [
    'All',
    'Filter by Name',
    'Filter by Category',
    'Filter by Gender',
    'Filter by Price'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Admin Panel", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF8678B2),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Add Product"),
              _buildTextField(_nameController, "Product Name"),
              _buildTextField(_descriptionController, "Description"),
              _buildDropdown("Select Category", _getAvailableCategories(),
                  (value) {
                setState(() {
                  _selectedCategory = value;
                });
              }, _selectedCategory),
              _buildTextField(_imageController, "Image URL"),
              _buildPriceSlider(),
              _buildGenderRadioButtons(),
              _space(),
              _buildActionButtonRow(
                  "Add Product", Colors.blue, _handleAddProduct),
              _space(),
              _buildDivider(),
              _space(),
              _buildSectionTitle("Fetch Data"),
              _buildDropdown("Filter by", _fetchOptions, (value) {
                setState(() {
                  _fetchFilter = value;
                  _fetchInputs['input'] = _createFetchInput();
                });
              }, _fetchFilter),
              _fetchInputs['input'] ?? SizedBox.shrink(),
              _space(),
              _buildActionButtonRow("GET", Colors.blue, _handleFetchData),
              _space(),
              _buildDivider(),
              _buildSectionTitle("Delete Product"),
              _buildTextField(_GUIDController, "Product GUID"),
              _space(),
              _buildActionButtonRow(
                  "Delete Product", Colors.red, _handleDeleteProduct),
              _space(),
              _buildDivider(),
              _buildSectionTitle("Delete User"),
              _buildTextField(_emailController, "User Email"),
              _space(),
              _buildActionButtonRow(
                  "Delete User", Colors.red, _handleDeleteUser),
              _space(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items,
      ValueChanged<String?>? onChanged, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
        value: value,
        hint: Text(hint),
        onChanged: onChanged,
        items: items
            .map((item) => DropdownMenuItem(child: Text(item), value: item))
            .toList(),
      ),
    );
  }

  Widget _buildPriceSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price: \$${_price.toStringAsFixed(0)}"),
        Slider(
          value: _price,
          min: 0,
          max: 999,
          divisions: 999,
          label: "\$${_price.toStringAsFixed(0)}",
          onChanged: (value) => setState(() => _price = value),
        ),
      ],
    );
  }

  Widget _buildPriceSlider2() {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price: \$${_price2.toStringAsFixed(0)}"),
          Slider(
            value: _price2,
            min: 0,
            max: 999,
            divisions: 999,
            label: "\$${_price2.toStringAsFixed(0)}",
            onChanged: (value) => setState(() => _price2 = value),
          ),
        ],
      );
    });
  }

  Widget _buildGenderRadioButtons() {
    return Column(
      children: ['Male', 'Female'].map((gender) {
        return RadioListTile<String>(
          title: Text(gender),
          value: gender,
          groupValue: _selectedGender,
          onChanged: (value) => setState(() {
            _selectedGender = value;
            _selectedCategory = null;
          }),
        );
      }).toList(),
    );
  }

  Widget _buildGenderRadioButtons2() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: ['Male', 'Female'].map((gender) {
            return RadioListTile<String>(
              title: Text(gender),
              value: gender,
              groupValue: _selectedGender2,
              onChanged: (val) {
                setState(() {
                  _selectedGender2 = val;
                  _selectedCategory2 = null;
                });
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _createFetchInput() {
    if (_fetchFilter == 'Filter by Price') {
      return _buildPriceSlider2();
    } else if (_fetchFilter == 'Filter by Gender') {
      return _buildGenderRadioButtons2();
    } else if (_fetchFilter == 'All') {
      return SizedBox();
    } else if (_fetchFilter == 'Filter by Category') {
      return _buildDropdown("Select Category", _categoriesFemale, (value) {
        setState(() {
          _selectedCategory2 = value;
        });
      }, _selectedCategory2);
    } else {
      return _buildTextField(TextEditingController(), _fetchFilter ?? '');
    }
  }

  Widget _buildActionButtonRow(
      String label, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                fixedSize: Size(150, 35)),
            onPressed: onPressed,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  List<String> _getAvailableCategories() {
    return _selectedGender == 'Male' ? _categoriesMale : _categoriesFemale;
  }

  Widget _space() {
    return SizedBox(height: 12);
  }

  Widget _buildDivider() {
    return Divider(thickness: 2, color: Colors.grey[300]);
  }

  void _handleAddProduct() {
    print("Adding product with details: ${_nameController.text}");
  }

  void _handleFetchData() {
    print("Fetching data based on $_fetchFilter");
  }

  void _handleDeleteProduct() {
    print("Deleting product with GUID: ${_GUIDController.text}");
  }

  void _handleDeleteUser() {
    print("Deleting user with Email: ${_emailController.text}");
  }
}
