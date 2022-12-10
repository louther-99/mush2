// // import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mush2/model/userData.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class UserPreferences{
//
// //   Future<String> getUser()async {
// //   String userID;
// //   return userID = FirebaseAuth.instance.currentUser!.uid;
// // }
//   static String userID = FirebaseAuth.instance.currentUser!.uid;
//
//
//   // static late SharedPreferences? _preferences;
//   // static SharedPreferences? _preferences;
//   static late SharedPreferences _preferences;
//   static const _keyUser = 'user'; //To store info of the user we need key for shared preferebces
//   static var myUser = UserData(
//     // IDUser: UserPreferences.getUser(),
//     IDUser: userID,
//     profilePath: 'https://flxt.tmsimg.com/assets/4950_v9_bb.jpg',
//     name: 'Louther Olayres',
//     email: 'diazlouther@gmail.com',
//     about: 'Lorem upsum wakaru waku ahflasfjalksdfjal;skdfjal;skdfjla;sdkf',
//     coverPath: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=1200&q=60',
//     lastMessageTime: DateTime.now().toString(),
//   );
//
//
//   static Future init() async => //To initialize shared preferences
//   _preferences = await SharedPreferences.getInstance();
//
//   static Future setUser(UserData user) async{ // A function to set our user locally within the shared preferences database by referring to the UserData Class
//     final json = jsonEncode(user.toJson()); //Calling the toJSON to return map string dynamic
//
//     await _preferences.setString(_keyUser, json);
//     // await _preferences.setString(_keyUser, json);
//   }
//
//   static UserData getUser(){ //Load the user inside the shared preferences
//     final json =_preferences.getString(_keyUser); // Load the user data inside the shared preferences using the key user to load the data
//     // final json =_preferences.getString(_keyUser);
//
//     //If the user is null, then return myUser that is the initial data then decode the json before converting to user object
//     return json == null ? myUser: UserData.fromJson(jsonDecode(json)); //Converting json back to user object
//   }
// }
// // final user = FirebaseAuth.instance.currentUser!;
// // email: "${user.email!}"',