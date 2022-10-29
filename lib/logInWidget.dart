import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mush2/forgotPassword.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mush2/utils/colors.dart';
// import 'Utils.dart';



final navigatorKey = GlobalKey<NavigatorState>();

class LogInWidget extends StatefulWidget {

  final VoidCallback onClickedSignUp;

  const LogInWidget({
    Key? key,
    required this.onClickedSignUp,
}) : super(key: key);


  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  //Utils m = Utils();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String name = "";

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // navigatorKey: navigatorKey;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }

      },
      child: Scaffold(
          backgroundColor: bgColor,
          body: Container(
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
            padding: const EdgeInsets.only(left:40, right: 40),
              child: SingleChildScrollView(
                // padding: EdgeInsets.fromLTRB(0,45,0,0),
                reverse: true,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Center(
                      child: Column(
                        children: [
                          //buildLogo(),
                          Text(
                            "MushMush",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            TextFormField(
                              controller: emailController,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                color: textColor,
                              ),
                              decoration: InputDecoration(
                                labelText: "Enter your email",
                                fillColor: textColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: textColor, width: 32.0),
                                    borderRadius: BorderRadius.circular(25.0)),
                                prefixIcon: Icon(Icons.email_outlined),
                                // focusedBorder:OutlineInputBorder(
                                // borderSide: const BorderSide(color: Colors.black45, width: 2.0),
                                // borderRadius: BorderRadius.circular(25.0),
                                // ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? "Enter a valid email!"
                                  : null,
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: passwordController,
                              cursorColor: Colors.white,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                color: textColor,
                              ),
                              decoration: InputDecoration(
                                fillColor: textColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: textColor, width: 32.0),
                                    borderRadius: BorderRadius.circular(25.0)),
                                prefixIcon: Icon(Icons.lock_outlined),
                                labelText: "Enter your password",
                                //   focusedBorder:OutlineInputBorder(
                                //   borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                //   borderRadius: BorderRadius.circular(25.0),
                                // ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                              value != null && value.length < 6
                                  ? "Password must be at least 6 characters long"
                                  : null,
                            ),
                            SizedBox(height: 20),


                            OutlinedButton(
                              onPressed: signIn,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 24,

                                  color: textColor,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: StadiumBorder(),
                                minimumSize: Size.fromHeight (40),
                                backgroundColor: Colors.white70,
                              ),

                            ),
                            SizedBox(height: 24),
                            Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      height: 20,
                                      thickness: 2,
                                      color: textColor,
                                    ),
                                  ),

                                  Text("OR", style: TextStyle(color: textColor)),


                                  Expanded(
                                    child: Divider(
                                      height: 20,
                                      thickness: 2,
                                      color: textColor,
                                    ),
                                  ),
                                ]
                            ),
                            SizedBox(height: 24),

                            OutlinedButton(
                              onPressed: widget.onClickedSignUp,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 24,

                                  color: textColor,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: StadiumBorder(),
                                minimumSize: Size.fromHeight (40),
                                backgroundColor: Colors.white70,
                              ),

                            ),
                            SizedBox(height: 24),
                            Center(
                              child: GestureDetector(
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: textColor,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                )),
                              ),
                            ),
                            SizedBox(height: 24),

                          ],
                        )
                    ),

                  ],
                ),
              ),

          ),

      ),
    );


    }


  Future signIn() async{

    //Show a loading circle
    showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
          );

          try{
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
          } on FirebaseAuthException catch(e){
            print(e);
            //m.showSnackBar(e.message);
          }

          //Navigator.of(context) not working!
          Navigator.of(context).pop();
          //navigatorKey.currentState!.popUntil((route) => route.isFirst);

  }
  //
  // buildLogo() {
  //   // final urlLogo = assets
  // }

}


// color: Color(0xff946713),