// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
// import 'package:backendless_sdk/backendless_sdk.dart';
// import 'package:stylesphere/models/Item.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:oauth2/oauth2.dart' as oauth2;
// import 'package:url_launcher/url_launcher.dart';

// Future<void> authenticateWithDiscord() async {
//   final authorizationEndpoint =
//       Uri.parse('https://discord.com/api/oauth2/authorize');
//   final tokenEndpoint = Uri.parse('https://discord.com/api/oauth2/token');

//   const clientId = '1046157009478746212'; // Store securely
//   const clientSecret = 'ey9goIowPUSjRiqbRMvU-Gq7w3xaUinG'; // Store securely
//   final redirectUri = Uri.parse(
//       'https://cleardress-us.backendless.app/api/users/oauth/discord/authorize');

//   final grant = oauth2.AuthorizationCodeGrant(
//     clientId,
//     authorizationEndpoint,
//     tokenEndpoint,
//     secret: clientSecret,
//   );

//   final authorizationUrl = grant.getAuthorizationUrl(
//     redirectUri,
//     scopes: ['identify', 'email'],
//   );

//   if (await canLaunch(authorizationUrl.toString())) {
//     await launch(authorizationUrl.toString());
//   } else {
//     print('Could not launch $authorizationUrl');
//   }

//   final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
//   try {
//     final request = await server.first;
//     final queryParams = request.uri.queryParameters;
//     final code = queryParams[''];

//     if (code == null) {
//       print('Authorization failed: No code received');
//       request.response
//         ..statusCode = HttpStatus.badRequest
//         ..write('Authorization failed!')
//         ..close();
//       return;
//     }

//     request.response
//       ..statusCode = HttpStatus.ok
//       ..write('Authorization successful! You can close this tab.')
//       ..close();

//     final client = await grant.handleAuthorizationResponse(queryParams);
//     print('Access Token: ${client.credentials.accessToken}');

//     final userResponse =
//         await client.get(Uri.parse('https://discord.com/api/users/@me'));
//     print('User Info: ${userResponse.body}');
//   } catch (e) {
//     print('An error occurred: $e');
//   } finally {
//     await server.close();
//   }
// }

// String genTransactionId() {
//   var random = Random();
//   String randomDigits =
//       List.generate(8, (_) => random.nextInt(10).toString()).join();
//   String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//   String transactionId = "TXN-${timestamp.substring(7)}-$randomDigits";

//   return transactionId;
// }

// Future<List<Item>?> fetchData(dynamic from,
//     {String? byName,
//     String? byEmail,
//     String? byPhone,
//     double? byPrice,
//     String? byCategory,
//     String? byGender,
//     String? byGUID}) async {
//   try {
//     String whereClause = "";
//     if (byName != null) {
//       whereClause = "name = '$byName'";
//     }
//     if (byCategory != null) {
//       whereClause = whereClause.isNotEmpty
//           ? "$whereClause AND Category = '$byCategory'"
//           : "Category = '$byCategory'";
//     }
//     if (byGender != null) {
//       whereClause = whereClause.isNotEmpty
//           ? "$whereClause AND Interest = '$byGender'"
//           : "Interest = '$byGender'";
//     }
//     if (byEmail != null) {
//       whereClause = whereClause.isNotEmpty
//           ? "$whereClause AND email = '$byEmail'"
//           : "email = '$byEmail'";
//     }
//     if (byPhone != null) {
//       whereClause = whereClause.isNotEmpty
//           ? "$whereClause AND PhoneNumber = '$byPhone'"
//           : "PhoneNumber = '$byPhone'";
//     }
//     if (byPrice != null) {
//       whereClause = whereClause.isNotEmpty
//           ? "$whereClause AND Price <= '$byPrice'"
//           : "Price <= '$byPrice'";
//     }
//     if (byGUID != null) {
//       whereClause = whereClause.isNotEmpty
//           ? "$whereClause AND objectId = '$byGUID'"
//           : "objectId = '$byGUID'";
//     }

//     DataQueryBuilder queryBuilder = DataQueryBuilder()
//       ..whereClause = whereClause;
//     final response =
//         await Backendless.data.of(from).find(queryBuilder: queryBuilder);

//     print(response);
//     return response?.map<Item>((json) => Item.fromJson(json)).toList();
//   } catch (e) {
//     throw Exception('Failed to load data: $e');
//   }
// }

// void updateData(
//     dynamic from, String GUID, String fieldName, dynamic newValue) async {
//   try {
//     String Name = "";
//     DataQueryBuilder queryBuilder = DataQueryBuilder()
//       ..whereClause = "objectId = '$GUID'";

//     final response =
//         await Backendless.data.of(from).find(queryBuilder: queryBuilder);

//     if (response != null && response.isNotEmpty) {
//       Name = response.first['Name'] ?? 'Null';

//       for (var field in response) {
//         field[fieldName] = newValue;
//         await Backendless.data.of(from).save(field);
//       }
//       print('$Name data updated successfully!');
//     } else {
//       print('No field found with ID $GUID.');
//     }
//   } catch (e) {
//     throw Exception('Failed to update field data: $e');
//   }
// }

// void registerUser(
//     String email, String password, String name, String addr, String phone) {
//   BackendlessUser user = BackendlessUser();
//   user.email = email;
//   user.password = password;
//   user.setProperty("Name", name);
//   user.setProperty("Address", addr);
//   user.setProperty("PhoneNumber", phone);

//   Backendless.userService
//       .register(user)
//       .then((BackendlessUser? registeredUser) {
//     if (registeredUser != null) {
//       print("User has been registered: ${registeredUser.getObjectId()}");
//     } else {
//       print("User registration failed: User data is null");
//     }
//   }).catchError((error) {
//     print("Error registering user: $error");
//   });
// }

// void deleteUser(String email) async {
//   try {
//     DataQueryBuilder queryBuilder = DataQueryBuilder()
//       ..whereClause = "Email = '$email'";
//     final response =
//         await Backendless.data.of('Users').find(queryBuilder: queryBuilder);

//     if (response != null && response.isNotEmpty) {
//       for (var user in response) {
//         await Backendless.data.of('Users').remove(user);
//       }
//       print('User with email $email deleted successfully.');
//     } else {
//       print('No users found with email $email.');
//     }
//   } catch (e) {
//     throw Exception('Failed to delete user: $e');
//   }
// }

// void addProduct(String Name, String Category, String Description, double Price,
//     String Interest,
//     {String Image = ""}) {
//   Map newProduct = {
//     "Name": Name,
//     "Category": Category,
//     "Description": Description,
//     "Price": Price,
//     "Interest": Interest,
//     "Image": Image,
//   };

//   Backendless.data.of("Products").save(newProduct).then((response) =>
//       print("Object is saved in Backendless. Please check in the console."));
// }

// void deleteProduct(String GUID) async {
//   try {
//     String productName = "";
//     DataQueryBuilder queryBuilder = DataQueryBuilder()
//       ..whereClause = "objectId = '$GUID'";

//     final response =
//         await Backendless.data.of('Products').find(queryBuilder: queryBuilder);

//     if (response != null && response.isNotEmpty) {
//       productName = response.first['Name'] ?? 'Unnamed Product';

//       for (var product in response) {
//         await Backendless.data.of('Products').remove(product);
//       }
//       print('Product $productName deleted successfully.');
//     } else {
//       print('No products found with ID $GUID.');
//     }
//   } catch (e) {
//     throw Exception('Failed to delete product: $e');
//   }
// }

// // Login Check
// Future<bool> isUserLoggedIn() async {
//   bool isLoggedIn = false;
//   try {
//     isLoggedIn = await Backendless.userService.isValidLogin();
//     print("User is already logged in.");
//   } catch (e) {
//     print("login status error: $e");
//   }
//   return isLoggedIn;
// }

// Future<void> loginUser(String email, String password) async {
//   try {
//     await Backendless.userService.login(email, password, stayLoggedIn: true);
//     print("Login successful!");
//   } catch (e) {
//     print("Login failed: $e");
//   }
// }

// Future<void> logoutUser() async {
//   try {
//     await Backendless.userService.logout();
//     print("Logout successful!");
//   } catch (e) {
//     print("Logout failed: $e");
//   }
// }

// // GoogleSignIn _googleSignIn = GoogleSignIn(
// //     clientId:
// //         '530949211062-mpb77hsuj2jjjrlsaocpnib2hcsce2kf.apps.googleusercontent.com',
// //     scopes: ['profile', 'email', 'openid']);

// // Future<void> signInWithGoogle() async {
// //   try {
// //     // Trigger the Google Sign-In process
// //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

// //     if (googleUser == null) {
// //       print('User canceled the sign-in.');
// //       return;
// //     }

// //     final GoogleSignInAuthentication googleAuth =
// //         await googleUser.authentication;

// //     final String? idToken = googleAuth.idToken;
// //     final String? accessToken = googleAuth.accessToken;

// //     if (idToken == null || accessToken == null) {
// //       print('Failed to retrieve ID token or access token.');
// //       return;
// //     }

// //     // Attempt to log in the user via Backendless with Google OAuth2
// //     BackendlessUser? user;
// //     try {
// //       user = await Backendless.userService.loginWithOauth2(
// //         'googleplus', // OAuth2 provider
// //         accessToken, // OAuth2 access token
// //         {
// //           "email": googleUser.email.toString(),
// //           "name": googleUser.displayName.toString()
// //         }, // Additional login parameters
// //         stayLoggedIn: true, // Keep the user logged in
// //       );
// //     } catch (e) {
// //       if (e.toString().contains('User not found')) {
// //         print('User not found in Backendless. Registering new user...');

// //         try {
// //           registerUser(googleUser.email.toString(), "123456789",
// //               googleUser.displayName.toString(), "Address", "01003448857");
// //           print('User successfully registered in Backendless.');
// //         } catch (registerError) {
// //           print('Error registering user: $registerError');
// //           return;
// //         }
// //       } else {
// //         print('Error during Backendless login: $e');
// //         return;
// //       }
// //     }

// //     if (user != null) {
// //       print('Logged in as: ${user.email}');
// //     }
// //   } catch (error) {
// //     print('Error during Google sign-in: $error');
// //   }
// // }
