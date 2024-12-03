import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stylesphere/controllers/sharedpre.dart';
import 'package:stylesphere/models/Item.dart';
import 'package:stylesphere/models/Users.dart';

Users? myUser;

Users? myUsers;
var cache=CacheHelper();
String genTransactionId() {
  var random = Random();
  String randomDigits =
      List.generate(8, (_) => random.nextInt(10).toString()).join();
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String transactionId = "TXN-${timestamp.substring(7)}-$randomDigits";

  return transactionId;
}

Future<Users?> fetchUserdata({
  String? byName,
  String? byEmail,
  String? byPhoneNumber,
  String? byAccountType,
}) async {
  try {
    Query query = FirebaseFirestore.instance.collection('Users');

    if (byName != null) {
      query = query.where('Name', isEqualTo: byName);
    }
    if (byEmail != null) {
      query = query.where('Email', isEqualTo: byEmail);
    }
    if (byPhoneNumber != null) {
      query = query.where('PhoneNumber', isEqualTo: byPhoneNumber);
    }
    if (byAccountType != null) {
      query = query.where('accountType', isEqualTo: byAccountType);
    }

    final querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

      myUser = Users.fromJson(userData);
      return myUser;
    } else {
      return null;
    }
  } catch (e) {
    throw Exception('Failed to load user data: $e');
  }
}

Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        clientId:
            "530949211062-mpb77hsuj2jjjrlsaocpnib2hcsce2kf.apps.googleusercontent.com",
        scopes: ['email', 'profile', 'openid']).signIn();

    if (googleUser == null) {
      print('Google sign-in aborted by user.');
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final uid = userCredential.user?.uid;

    if (uid != null) {
      final user = userCredential.user;

      final userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (!userDoc.exists) {
        await FirebaseFirestore.instance.collection('Users').doc(uid).set({
          'Name': user?.displayName ?? '',
          'PhoneNumber': user?.phoneNumber ?? '',
          'Email': user?.email ?? '',
          'AvatarURL': user?.photoURL ?? '',
          'accountType': 'User',
        });
      }
      fetchUserdata(byEmail: user?.email);
    }

    return userCredential;
  } catch (e) {
    print('Error during Google sign-in: $e');
    return null;
  }
}

Future<List<Item>> fetchProducts({
  String? byName,
  double? byPrice,
  String? byCategory,
  String? byGender,
  String? byGUID,
}) async {
  try {
    Query query = FirebaseFirestore.instance.collection('Products');
    if (byCategory != null)
      query = query.where('Category', isEqualTo: byCategory);
    if (byGender != null) query = query.where('Interest', isEqualTo: byGender);
    if (byPrice != null)
      query = query.where('Price', isLessThanOrEqualTo: byPrice);
    if (byGUID != null)
      query = query.where(FieldPath.documentId, isEqualTo: byGUID);

    final querySnapshot = await query.get();

    return querySnapshot.docs.map<Item>((doc) {
      return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

Future<void> debugFetchin() async {
  List<Item> items = await fetchProducts(byGender: "Female");
  for (var item in items) {
    print('GUID: ${item.documentID}');
    print('Name: ${item.name}');
    print('Category: ${item.category}');
    print('Price: ${item.price}');
    print('Description: ${item.description}');
    print('Interest: ${item.interest}');
    print('Image: ${item.image}');
    print("====================================");
    // print('Email: ${item.email}');
    // print('Phone: ${item.phone}');
  }
}

Future<void> registerUser(
    {required String email,
    required String password,
    required String name,
    required String phone,
    String? AvatarURL}) async {
  try {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final uid = userCredential.user?.uid;

    if (uid != null) {
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'Name': name,
        // 'Address': addr,
        'PhoneNumber': phone,
        'Email': email,
        'accountType': 'User',
        'AvatarURL': AvatarURL ?? '',
      });
      print("User has been registered: $uid");
    }
  } catch (e) {
    throw Exception('Error registering user: $e');
  }
}

Future<void> deleteUser(String email) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: email)
        .get();

    for (var doc in querySnapshot.docs) {
      await FirebaseFirestore.instance.collection('Users').doc(doc.id).delete();
    }
    print('User with email $email deleted successfully.');
  } catch (e) {
    throw Exception('Failed to delete user: $e');
  }
}

Future<void> addProduct(String name, String category, String description,
    double price, String interest,
    {String image = ""}) async {
  try {
    await FirebaseFirestore.instance.collection('Products').add({
      'Name': name,
      'Category': category,
      'Description': description,
      'Price': price,
      'Interest': interest,
      'Image': image,
    });
    print("Product added successfully.");
  } catch (e) {
    throw Exception('Failed to add product: $e');
  }
}

Future<void> deleteProduct(String GUID) async {
  try {
    await FirebaseFirestore.instance.collection('Products').doc(GUID).delete();
    print('Product deleted successfully.');
  } catch (e) {
    throw Exception('Failed to delete product: $e');
  }
}

Future<void> updateData(
    String from, String GUID, String fieldName, dynamic newValue) async {
  try {
    final docRef = FirebaseFirestore.instance.collection(from).doc(GUID);
    await docRef.update({fieldName: newValue});
    print('Data updated successfully!');
  } catch (e) {
    throw Exception('Failed to update field data: $e');
  }
}

Future<bool> isUserLoggedIn() async {
  if (FirebaseAuth.instance.currentUser != null) {
    fetchUserdata(byEmail: FirebaseAuth.instance.currentUser?.email);
    return true;
  } else {
    return false;
  }
}

Future<void> loginUser(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("Login successful!");
    fetchUserdata(byEmail: email);
  } catch (e) {
    throw Exception('Login failed: $e');
  }
}

Future<void> logoutUser() async {
  try {
    await FirebaseAuth.instance.signOut();
    print("Logout successful!");
  } catch (e) {
    throw Exception('Logout failed: $e');
  }
}

Future<void> getUserID(String email) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: email)
        .get();
    String GUID = "";
    for (var doc in querySnapshot.docs) {
      GUID = await FirebaseFirestore.instance
          .collection('Users')
          .doc(doc.id)
          .toString();
    }
    print('User GUID is: $GUID');
  } catch (e) {
    throw Exception('Failed to fetch user GUID: $e');
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getUserNameByEmail(String email) async {
  try {
    // Query Firestore for a document in the 'Users' collection with the matching email
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: email)
        .get();

    // Check if a matching document exists
    if (querySnapshot.docs.isNotEmpty) {
      // Extract the user's name from the document
      final userName = querySnapshot.docs.first.data()['Name'] as String;
      return userName;
    } else {
      throw Exception('No user found with this email.');
    }
  } catch (e) {
    throw Exception('Failed to fetch user name: $e');
  }
}
final username=getUserNameByEmail(cache.getData(key: "user"));
final List<Item> itemsMale =   fetchProducts(byGender: "Male") as List<Item>;
final List<Item> itemsFemale=  fetchProducts(byGender: "Female") as List<Item>;

Future<String> getProductsCat(String gender) async {
  List<Item> items = await fetchProducts(byGender: gender);
  try {
    for (var item in items) {
      print('GUID: ${item.documentID}');
      print('Name: ${item.name}');
      print('Category: ${item.category}');
      print('Price: ${item.price}');
      print('Description: ${item.description}');
      print('Interest: ${item.interest}');
      print('Image: ${item.image}');
      print("====================================");
      return item.category.toString();
    }
  } catch (ex) {
    return 'error: $ex';
  }
  return '';
}