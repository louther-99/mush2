import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_forgot_password/utils.dart';
import 'package:flutter/material.dart';
import 'package:mush2/Utils.dart';
import 'package:mush2/utils/colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  Utils m = Utils();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
        padding: const EdgeInsets.only(left:40, right: 40),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget> [
                Text('Receive an email to reset your password',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 30,
                    )),
                SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  cursorColor: Colors.white,
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
                SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: resetPassword, //Calling resetPassword function below
                  icon: Icon(
                    Icons.mail_outline_outlined,
                    size: 24.0,
                    color: textColor,
                  ),
                  label: Text(
                    'Reset Password',
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


              ],
            )
        ),
      ),
    );
  }

  Future resetPassword() async{ //Function to reset password
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try{ //Sending password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

      //m.showSnackBar('Password email has been sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    }on FirebaseAuthException catch(e){
      print(e);

      //m.showSnackBar(e.message);
      Navigator.of(context).pop(); //Removing snackbar error message

    }


  }
}
