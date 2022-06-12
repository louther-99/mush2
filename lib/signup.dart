import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:mush2/Utils.dart';


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
    return Scaffold(
        backgroundColor: Color(0xff946713),
        body: Container(
            margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
            padding: const EdgeInsets.only(left:40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Center(
                  child: Text(
                    "Log in to MushMush",
                    style: TextStyle(
                      color: Color(0xffdbc791),
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
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              labelText: "Enter your email"
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
                          decoration: InputDecoration(
                              labelText: "Enter your password"
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                          value != null && value.length < 6
                              ? "Password must be at least 6 characters long"
                              : null,
                        ),
                        SizedBox(height: 20),

                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight (50)),
                          icon: Icon(Icons.lock),
                          label: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black
                            ),
                          ),
                          onPressed: signUp,
                        ),
                        SizedBox(height: 24),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.white,
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
                                      color: Theme.of(context).colorScheme.secondary,
                                    )
                                )
                              ]
                          ),
                        ),
                      ],
                    )
                ),

              ],
            )

        )

    );

  }


  Future signUp() async{

    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
          );

    try{
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