// import 'package:flutter/material.dart';
// import 'package:mush2/services/google_signIn.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:mush2/logInWidget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mush2/home.dart';
// import 'main.dart';
// import 'services/auth_service.dart';
// import 'package:mush2/services/auth_service.dart';
// import 'package:mush2/Utils.dart';
// import 'package:mush2/verfiy_email.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// // import 'package:open_document/open_document.dart';
// // import 'package:pdf/pdf.dart';
// // import 'package:path_provider/path_provider.dart';
//
// //Protips
// //Named parameters
// //Required tags
// //Check for nulll values (assert that something is not null assert ( content != null, 'content is empty')) - null in Lists
// //Default value
// //Immutable (final String name; to make it immutable
// //getter method int get favNum {return 12;}
// //setter method == set age (int years) {}
// //toString
//
// final navigatorKey = GlobalKey<NavigatorState>();
// class MyApp2 extends StatefulWidget {
//   final bool showMeMyHome;
//   static final String title = 'Mush Mush';
//
//
//   const MyApp2({
//     Key? key,
//     required this.showMeMyHome,
//   }) : super(key: key);
//
//   @override
//   State<MyApp2> createState() => _MyApp2State();
// }
//
// class _MyApp2State extends State<MyApp2> {
//   Utils m = Utils();
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => GoogleSignIn(),
//       child: MaterialApp(
//         // title: MyApp2.title,
//         // theme: ThemeData(primaryColor: bgColor, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: textColor)),
//         home: MainPage(),
//       ),
//     );
//   }
// }//MyApp
//
// class MainPage extends StatefulWidget {
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>( //Question mark for null content
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if(snapshot.connectionState == ConnectionState.waiting){ //If loading
//               return Center(child: CircularProgressIndicator());
//             }
//             else if(snapshot.hasError){
//               return Center (child: Text('Something went wrong!')); //Then error
//             }
//             else if(snapshot.hasData) {
//               //return HomePage();
//               return VerifyEmailPage();
//               //Navigator.pushReplacementNamed(context, '/homepage'); //return HomePage();
//             }
//             else{
//               return AuthService();
//
//             }
//
//           }
//       ),
//     );
//   }
// }//MainPage
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
