// import 'package:flutter/material.dart';
// import 'package:mush2/services/google_signIn.dart';
// import 'package:mush2/utils/colors.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:mush2/logInWidget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mush2/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'main2.dart';
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
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
//
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final pre = await SharedPreferences.getInstance();
//   final showMeMyHome = pre.getBool('showMeMyHome') ?? false;
//   await Firebase.initializeApp(); //Initialize database
//   // await UserPreferences.init(); //Execute user preferences init
//   //await AuthService().getOrCreateUser();
//
// //added comment in the main
//
//   runApp(MyApp(
//       showMeMyHome: showMeMyHome
//     // initialRoute: '/main',
//     // routes: {
//     //   '/main' : (context) => MyApp(),
//     //   '/login' : (context) => AuthService(),
//     //   '/homepage' : (context) => HomePage(),
//
//     // },
//
//   ));//MyApp
// } //main
//
// final navigatorKey = GlobalKey<NavigatorState>(); //navigatorKey: navigatorKey;
//
// class MyApp extends StatefulWidget {
//   final bool showMeMyHome;
//   const MyApp({
//     Key? key,
//     required this.showMeMyHome,
//   }) : super(key: key);
//
//
//   static final String title = 'Mush Mush';
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final pre = SharedPreferences.getInstance();
//   Utils m = Utils();
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => GoogleSignIn(),
//       child: MaterialApp(
//         title: MyApp.title,
//         // theme: ThemeData(primaryColor: bgColor, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: textColor)),
//         home: widget.showMeMyHome ?  MyApp2(showMeMyHome: true) : MainPages(),
//       ),
//     );
//   }
// }//MyApp
//
// class MainPages extends StatefulWidget {
//
//
//   @override
//   State<MainPages> createState() => _MainPagesState();
//
//
// }
//
//
// class _MainPagesState extends State<MainPages> {
//   final controller = PageController();
//   bool isLastPage = false;
//
//
//
//   @override
//   void dispose(){
//     controller.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.only(bottom: 80),
//         child: PageView(
//           controller: controller,
//           onPageChanged: (index) {
//             setState(() => isLastPage = index == 2);
//           },
//           children: [
//             Container(
//               color: textColor,
//               child: const Center(
//                 child: Text(
//                     'Page 1'
//                 ),
//               ),
//             ), Container(
//               color: pinkColor,
//               child: const Center(
//                 child: Text(
//                     'Page 2'
//                 ),
//               ),
//             ), Container(
//               color: blue,
//               child: const Center(
//                 child: Text(
//                     'Page 3'
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomSheet: isLastPage ? TextButton(onPressed: ()async{
//
//         final pre = await SharedPreferences.getInstance();
//         pre.setBool('showMeMyHome', true);
//         final bool show = true;
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => MyApp2(showMeMyHome: true)),
//         );
//       },
//           style: TextButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//             primary:  textColor,
//             backgroundColor: pinkColor,
//             minimumSize: Size.fromHeight(80),
//           ),
//           child: Text(
//             'Get Started',
//             style: TextStyle(fontSize: 24),
//
//           ))
//           :
//       Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 80,
//         ),
//         height: 80,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(onPressed: () => controller.jumpToPage(2), child: Text('SKIP'),),
//               Center(
//                 child: SmoothPageIndicator(
//                   controller: controller,
//                   count: 3,
//                   effect: WormEffect(
//                     spacing: 16,
//                     dotColor: bgColorTwo,
//                     activeDotColor: bgCard,
//
//                   ),
//                   onDotClicked: (index) => controller.animateToPage(
//                     index,
//                     duration: Duration(milliseconds: 500),
//                     curve: Curves.easeIn,
//                   ),
//                 ),
//               ),
//               TextButton(onPressed: () => controller.nextPage(
//                 duration: Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               ), child: Text('NEXT'),),
//             ],
//           ),
//         ),
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
//
