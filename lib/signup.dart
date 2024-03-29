import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:mush2/Utils.dart';
import 'package:mush2/utils/colors.dart';

import 'model/userData.dart';


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
  String userID = "";
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String name = "";


  @override
  void dispose(){
    nameController.dispose();
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
                              controller: nameController,
                              cursorColor: textColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Enter your name",
                                fillColor: textColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: textColor, width: 32.0),
                                    borderRadius: BorderRadius.circular(25.0)),
                                prefixIcon: Icon(Icons.people),
                                // focusedBorder:OutlineInputBorder(
                                // borderSide: const BorderSide(color: Colors.black45, width: 2.0),
                                // borderRadius: BorderRadius.circular(25.0),
                                // ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"),
                                )
                              ],
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                              value != null && value.length < 1
                                  ? "Name must be valid"
                                  : null,
                            ),
                            SizedBox(height: 20),
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
      String a = await getID() as String;
      final docUser = await FirebaseFirestore.instance.collection('user').doc(a);
      print(a);
      print(docUser);
      //  AvatarURL
      // "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=1200&q=60"
      // IDUser
      // "Pm6dF0mb3qPIX87uTsqswNHvzlz1"
      // about
      // "Lorem upsum wakaru waku ahflasfjalksdfjal;skdfjal;skdfjla;sdkf"
      // email
      // "diazlouther@gmail.com"
      // imagePath
      // "https://flxt.tmsimg.com/assets/4950_v9_bb.jpg"
      // lastMessageTime
      // "2022-11-16 11:27:04.768087"
      // name
      // "Louther Olayres"

      final user = UserData(
      IDUser: a,
      profilePath: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      about: 'Short description about yourself',
      coverPath: 'https://removal.ai/wp-content/uploads/2021/02/no-img.png',
      lastMessageTime: DateTime.now().toString(),
  );

      final json = user.toJson();
      docUser.set(json);

    } on FirebaseAuthException catch(e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              e.toString()
          )));
      //Utils.showSnackBar(e.message);

    }
    //Navigator.of(context) not working!
    Navigator.of(context).pop();
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<String> getID() async {
    return userID = await FirebaseAuth.instance.currentUser!.uid;

  }

}




// color: Color(0xff946713),