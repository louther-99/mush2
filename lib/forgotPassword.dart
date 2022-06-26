import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_forgot_password/utils.dart';
import 'package:flutter/material.dart';
import 'package:mush2/Utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff946713),
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
                  color: Colors.white,
                  fontSize: 30,
                )),
                SizedBox(height: 20),
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


                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight (50)),
                  icon: Icon(Icons.mail),
                  label: Text(
                    'Reset Password',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black
                    ),
                  ),
                  onPressed: resetPassword,
                ),
                SizedBox(height: 24),


              ],
            )
        ),
      ),
    );
  }

  Future resetPassword() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('Password email has been sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    }on FirebaseAuthException catch(e){
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();

    }


  }
}
