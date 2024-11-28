import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  ///Add product from admin panel to Ui
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

  ///update product from admin panel to Ui
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

  /// delete product from Ui
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

  ///delete User from app
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

}
