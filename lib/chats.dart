// import 'package:flutter/material.dart';
// import 'package:mush2/api/firebaseApi.dart';
// import 'package:mush2/utils/colors.dart';
// import 'package:mush2/model/userData.dart';
// class Chats extends StatelessWidget {
//   const Chats({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: SafeArea(
//         child: StreamBuilder<List<UserData>>(
//           stream: FirebaseApi.getUsers(),
//           builder: (context, snapshot) {
//
//             final users = snapshot.data;
//
//             return Column(
//               children: [
//                 //ChatHeaderWidget(users: users),
//                 //ChatBodyWidget(users: users),
//               ],
//             );
//           }
//         ),
//       ),
//     );
//   }
// }
