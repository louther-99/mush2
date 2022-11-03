import 'package:mush2/logInWidget.dart';
import 'package:mush2/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends StatefulWidget {
  const AuthService({Key? key}) : super(key: key);

  @override
  State<AuthService> createState() => _AuthServiceState();
}

class _AuthServiceState extends State<AuthService> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> getCurrentId() async {
    return (await _firebaseAuth.currentUser!).uid;

}
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LogInWidget(onClickedSignUp: toggle)
      : SignUp(onClickedSignIn: toggle);

    void toggle() => setState(() => isLogin = !isLogin);

}




