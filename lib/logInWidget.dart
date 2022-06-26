import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mush2/forgotPassword.dart';
import 'package:email_validator/email_validator.dart';



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
    // navigatorKey: navigatorKey;
    return Scaffold(
        backgroundColor: Color(0xff946713),
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
          padding: const EdgeInsets.only(left:40, right: 40),
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
                          color: Color(0xffdbc791),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
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
                          style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight (40)),
                          icon: Icon(Icons.login),
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
                        Center(
                          child: GestureDetector(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                              ),
                            ),
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            )),
                          ),
                        ),
                        SizedBox(height: 24),
                        Center(
                          child: RichText(
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
                                    decoration: TextDecoration.none,
                                    color: Theme.of(context).colorScheme.secondary,
                                  )
                                )
                              ]
                            ),
                          ),
                        ),

                      ],
                    )
                ),

              ],
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
            //Utils.showSnackBar(e.message);
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