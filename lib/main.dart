import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mush2/logInWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mush2/home.dart';
import 'services/auth_service.dart';
import 'package:mush2/services/auth_service.dart';
import 'package:mush2/Utils.dart';
import 'package:mush2/verfiy_email.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:open_document/open_document.dart';
// import 'package:pdf/pdf.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:chaquopy/chaquopy.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Binding first
  await Firebase.initializeApp(); //Initialize database
  //await AuthService().getOrCreateUser();


  runApp(MyApp(
    // initialRoute: '/main',
    // routes: {
    //   '/main' : (context) => MyApp(),
    //   '/login' : (context) => AuthService(),
    //   '/homepage' : (context) => HomePage(),

    // },

  ));//MyApp
} //main

final navigatorKey = GlobalKey<NavigatorState>(); //navigatorKey: navigatorKey;

class MyApp extends StatelessWidget {

  
  static final String title = 'Mush Mush';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: title,
      //theme: ThemeData.dark().copyWith(),
      home: MainPage(),
    );
  }

}//MyApp

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center (child: Text('Somethig went wrong!'));
            }
            else if(snapshot.hasData) {
              //return HomePage();
              return VerifyEmailPage();
              //Navigator.pushReplacementNamed(context, '/homepage'); //return HomePage();
            }
            else{
              return AuthService();

            }

          }
      ),
    );
  }
}//MainPage








          


































































































