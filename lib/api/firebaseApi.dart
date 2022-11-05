// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mush2/model/userData.dart';
// import 'package:meta/meta.dart';
// import 'package:mush2/utils/utils.dart/';
//
// class FirebaseApi {
//
//   static Stream <List<UserData>> getUsers()
//     => FirebaseFirestore.instance
//         .collection('users')
//         .orderBy(UserField.lastMessageTime, descending: true)
//   .snapshots()
//   .transform(Utils.transformer(UserData.fromJson));
//
// }