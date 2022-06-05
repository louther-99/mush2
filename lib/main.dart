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

final navigatorKey = GlobalKey<NavigatorState>(); //navigatorKey: navigatorKey;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Binding first
  await Firebase.initializeApp(); //Initialize database
  //await AuthService().getOrCreateUser();
  runApp(MaterialApp(
    initialRoute: '/main',
    routes: {
      '/main' : (context) => Main(),
      '/login' : (context) => AuthService(),
      '/homepage' : (context) => HomePage(),
    },




  ));
}

//final navigatorKey = GlobalKey<NavigatorState>(); //navigatorKey: navigatorKey;



class Main extends StatefulWidget {


  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String name = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //for navigatorKey.currentState!.popUntil((route) => route.isFirst);
    //navigatorKey: navigatorKey,
    //scaffoldMessengerKey: Utils.messengerKey;
    return Scaffold(
      backgroundColor: Color(0xff946713),
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
            return HomePage();
            //Navigator.pushReplacementNamed(context, '/homepage'); //return HomePage();
          }
          else{
             return AuthService();

          }

        }
      ),
    );
  }
}





          

































































































