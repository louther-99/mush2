import 'package:mush2/logInWidget.dart';
import 'package:mush2/signup.dart';
import 'package:flutter/material.dart';


class AuthService extends StatefulWidget {
  const AuthService({Key? key}) : super(key: key);

  @override
  State<AuthService> createState() => _AuthServiceState();
}

class _AuthServiceState extends State<AuthService> {

  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LogInWidget(onClickedSignUp: toggle)
      : SignUp(onClickedSignIn: toggle);

    void toggle() => setState(() => isLogin = !isLogin);

}




