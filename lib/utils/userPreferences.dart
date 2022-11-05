// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mush2/model/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserPreferences{

//   Future<String> getUser()async {
//   String userID;
//   return userID = FirebaseAuth.instance.currentUser!.uid;
// }
  static String userID = FirebaseAuth.instance.currentUser!.uid;


  // static late SharedPreferences? _preferences;
  static SharedPreferences? _preferences;
  static const _keyUser = 'user';
  static var myUser = UserData(
    // IDUser: UserPreferences.getUser(),
    IDUser: userID,
    imagePath: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=1200&q=60',
    name: 'Louther Olayres',
    email: 'diazlouther@gmail.com',
    about: 'Lorem upsum wakaru waku ahflasfjalksdfjal;skdfjal;skdfjla;sdkf',
    AvatarURL: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=1200&q=60',
    lastMessageTime: DateTime.now(),
  );


  static Future init() async =>
  _preferences = await SharedPreferences.getInstance();

  static Future setUser(UserData user) async{
    final json = jsonEncode(user.toJson());

    await _preferences?.setString(_keyUser, json);
    // await _preferences.setString(_keyUser, json);
  }

  static UserData getUser(){
    final json =_preferences?.getString(_keyUser);
    // final json =_preferences.getString(_keyUser);
    return json == null ? myUser: UserData.fromJson(jsonDecode(json));
  }
}
// final user = FirebaseAuth.instance.currentUser!;
// email: "${user.email!}"',