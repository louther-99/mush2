import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mush2/services/google_signIn.dart';
import 'package:mush2/utils/colors.dart';
import 'package:mush2/utils/userPreferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mush2/logInWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mush2/home.dart';
import 'services/auth_service.dart';
import 'package:mush2/services/auth_service.dart';
import 'package:mush2/Utils.dart';
import 'package:mush2/verfiy_email.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:open_document/open_document.dart';
// import 'package:pdf/pdf.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:chaquopy/chaquopy.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';
import 'package:lottie/lottie.dart';

//Protips
//Named parameters
//Required tags
//Check for nulll values (assert that something is not null assert ( content != null, 'content is empty')) - null in Lists
//Default value
//Immutable (final String name; to make it immutable
//getter method int get favNum {return 12;}
//setter method == set age (int years) {}
//toString


Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Binding first
  await Firebase.initializeApp(); //Initialize database
  // await UserPreferences.init(); //Execute user preferences init
  //await AuthService().getOrCreateUser();

//added comment in the main

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
  Utils m = Utils();
  static final String title = 'Mush Mush';


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignIn(),
      child: MaterialApp(
        //scaffoldMessengerKey: Utils m = Utils();
        scaffoldMessengerKey: m.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: title,
        // theme: ThemeData(primaryColor: bgColor, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: textColor)),
        home: MainPage(),
      ),
    );
  }

}//MyApp

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>( //Question mark for null content
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){ //If loading
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center (child: Text('Something went wrong!')); //Then error
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








          


































































































