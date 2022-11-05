import 'dart:async';
import 'package:mush2/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mush2/home.dart';
import 'package:mush2/utils/colors.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Utils m = Utils();
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    //user needs to be created first
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) { //if the user is not verified, send verification email
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 3),
          (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose(){ //Dispose the time if not needed
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    //call after email verification
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    });

    if(isEmailVerified) timer?.cancel();

  }

    Future sendVerificationEmail() async { //Function
      try{
        final user = FirebaseAuth.instance.currentUser!;
        await user.sendEmailVerification();

        setState(() => canResendEmail = false);
        await Future.delayed(Duration(seconds: 5));
        setState(() => canResendEmail = true);
      }catch (e){
        m.showSnackBar(e.toString()); //Snackbar for showing message error
      }
    }




  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
    appBar: AppBar(
      backgroundColor:  bgColor,
      title: Text(
          'Verify Email',
        style: TextStyle(
          color: textColor,
        ),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'A verification email has been sent to your email.',
            style: TextStyle(
              fontSize: 20,
              color: textColor,

            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          OutlinedButton.icon(
            icon: Icon(Icons.mail, color: textColor,),
            onPressed: canResendEmail? sendVerificationEmail: null,
            label: Text(
              'Resend Email',
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
          SizedBox(height: 8),
          TextButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            child: Text(
                'Cancel',
              style: TextStyle(
                  fontSize: 24,
              color: textColor,
              ),
            ),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
    ),
  );

}

