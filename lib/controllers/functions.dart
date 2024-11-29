import 'dart:async';
import 'dart:math';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:stylesphere/models/Item.dart';

String genTransactionId() {
  var random = Random();
  String randomDigits =
      List.generate(8, (_) => random.nextInt(10).toString()).join();
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String transactionId = "TXN-${timestamp.substring(7)}-$randomDigits";

  return transactionId;
}

Future<List<Item>?> fetchData(dynamic from,
    {String? byName,
    String? byEmail,
    String? byPhone,
    double? byPrice,
    String? byCategory,
    String? byGender,
    String? byGUID}) async {
  try {
    String whereClause = "";
    if (byName != null) {
      whereClause = "Name = '$byName'";
    }
    if (byCategory != null) {
      whereClause = whereClause.isNotEmpty
          ? "$whereClause AND Category = '$byCategory'"
          : "Category = '$byCategory'";
    }
    if (byGender != null) {
      whereClause = whereClause.isNotEmpty
          ? "$whereClause AND Interest = '$byGender'"
          : "Interest = '$byGender'";
    }
    if (byEmail != null) {
      whereClause = whereClause.isNotEmpty
          ? "$whereClause AND Email = '$byEmail'"
          : "Email = '$byEmail'";
    }
    if (byPhone != null) {
      whereClause = whereClause.isNotEmpty
          ? "$whereClause AND PhoneNumber = '$byPhone'"
          : "PhoneNumber = '$byPhone'";
    }
    if (byPrice != null) {
      whereClause = whereClause.isNotEmpty
          ? "$whereClause AND Price = '$byPrice'"
          : "Price = '$byPrice'";
    }
    if (byGUID != null) {
      whereClause = whereClause.isNotEmpty
          ? "$whereClause AND objectID = '$byGUID'"
          : "objectID = '$byGUID'";
    }

    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = whereClause;
    final response =
        await Backendless.data.of(from).find(queryBuilder: queryBuilder);

    print(response);
    return response?.map<Item>((json) => Item.fromJson(json)).toList();
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

void updateData(
    dynamic from, String GUID, String fieldName, dynamic newValue) async {
  try {
    String Name = "";
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "objectId = '$GUID'";

    final response =
        await Backendless.data.of(from).find(queryBuilder: queryBuilder);

    if (response != null && response.isNotEmpty) {
      Name = response.first['Name'] ?? 'Null';

      for (var field in response) {
        field[fieldName] = newValue;
        await Backendless.data.of(from).save(field);
      }
      print('$Name data updated successfully!');
    } else {
      print('No field found with ID $GUID.');
    }
  } catch (e) {
    throw Exception('Failed to update field data: $e');
  }
}

void registerNewUser(
    String email, String password, String name, String addr, String phone) {
  BackendlessUser user = BackendlessUser();
  user.email = email;
  user.password = password;
  user.setProperty("Name", name);
  user.setProperty("Address", addr);
  user.setProperty("PhoneNumber", phone);

  Backendless.userService
      .register(user)
      .then((BackendlessUser? registeredUser) {
    if (registeredUser != null) {
      print("User has been registered: ${registeredUser.getObjectId()}");
    } else {
      print("User registration failed: User data is null");
    }
  }).catchError((error) {
    print("Error registering user: $error");
  });
}

void deleteUser(String email) async {
  try {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "Email = '$email'";
    final response =
        await Backendless.data.of('Users').find(queryBuilder: queryBuilder);

    if (response != null && response.isNotEmpty) {
      for (var user in response) {
        await Backendless.data.of('Users').remove(user);
      }
      print('User with email $email deleted successfully.');
    } else {
      print('No users found with email $email.');
    }
  } catch (e) {
    throw Exception('Failed to delete user: $e');
  }
}

void addProduct(String Name, String Category, String Description, double Price,
    String Interest,
    {String Image = ""}) {
  Map newProduct = {
    "Name": Name,
    "Category": Category,
    "Description": Description,
    "Price": Price,
    "Interest": Interest,
    "Image": Image,
  };

  Backendless.data.of("Products").save(newProduct).then((response) =>
      print("Object is saved in Backendless. Please check in the console."));
}

void deleteProduct(String GUID) async {
  try {
    String productName = "";
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "objectId = '$GUID'";

    final response =
        await Backendless.data.of('Products').find(queryBuilder: queryBuilder);

    if (response != null && response.isNotEmpty) {
      productName = response.first['Name'] ?? 'Unnamed Product';

      for (var product in response) {
        await Backendless.data.of('Products').remove(product);
      }
      print('Product $productName deleted successfully.');
    } else {
      print('No products found with ID $GUID.');
    }
  } catch (e) {
    throw Exception('Failed to delete product: $e');
  }
}
