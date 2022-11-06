import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:mush2/Utils.dart';
import 'package:mush2/utils/colors.dart';


final navigatorKey = GlobalKey<NavigatorState>();

class SignUp extends StatefulWidget {

  final Function() onClickedSignIn;
  const SignUp({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
    navigatorKey: navigatorKey;
    return GestureDetector( //Gesture detector to tap on the widget to perform action
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
                padding: EdgeInsets.fromLTRB(0,32,0,0),
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Center(
                      child: Text(
                        "Sign up to MushMush",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),

                      ),
                    ),
                    SizedBox(height: 50),
                    Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            TextFormField(
                              controller: emailController,
                              cursorColor: textColor,
                              textInputAction: TextInputAction.next,
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
                              cursorColor: textColor,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
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
                              onPressed: signUp, //Calling the function signUp below
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
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 20,
                                  ),
                                  text: 'Already have an account? ',
                                  children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = widget.onClickedSignIn,
                                        text: 'Log In',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: textColor,
                                        )
                                    )
                                  ]
                              ),
                            ),
                          ],
                        )
                    ),

                  ],
                ),
              )

          )

      ),
    );

  }


  Future signUp() async{ //Function

    final isValid = formKey.currentState!.validate(); //Assigning valid state of the form to isValid as true
    if(!isValid) return;

    showDialog( //Loading progress indicator
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
          );

    try{ //Creating user with email and password accepting the email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseAuthException catch(e){
      print(e);
      //Utils.showSnackBar(e.message);

    }
    //Navigator.of(context) not working!
    Navigator.of(context).pop();
    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

}




// color: Color(0xff946713),