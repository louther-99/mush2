import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mush2/Utils.dart';


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
                              labelText: "Enter your name"
                          ),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Username cannot be empty!";
                            }
                            else if (value != null && value.length <= 5) {
                              return "Username should be greater than 5 characters";
                            }
                            else {
                              return null;
                            }

                          },
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
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Password cannot be empty!";
                            }
                            else if (value != null && value.length <= 8) {
                              return "Password should be greater than 8 characters";
                            }
                            else {
                              return null;
                            }

                          },
                        ),
                        SizedBox(height: 20),

                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight (50)),
                          icon: Icon(Icons.lock),
                          label: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black
                            ),
                          ),
                          onPressed: signIn,
                        ),
                        SizedBox(height: 24),
                        GestureDetector(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                            ),
                          ),
                          onTap: => Navigator.of(context).push(MaterialPageRoute),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            text: 'No account? ',
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignUp,
                                text: 'Sign Up',
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


  Future signIn() async{
    showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
          );

          try{
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
          } on FirebaseAuthException catch(e){
            print(e);
            Utils.showSnackBar(e.message);

          }


          //Navigator.of(context) not working!
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

}


// color: Color(0xff946713),