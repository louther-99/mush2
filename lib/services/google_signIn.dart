import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignIn extends ChangeNotifier {

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  // Future<String> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   final AuthResult authResult = await _auth.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;
  //
  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);
  //
  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);
  //
  //   return 'signInWithGoogle succeeded: $user';
  // }

  // final googleSignIn = GoogleSignIn();
  // GoogleSignInAccount? _user;
  //
  // GoogleSignInAccount get user => _user!;


  // // Jo
  // final googleSignIn = GoogleSignIn();
  //
  // GoogleSignInAccount? _user;
  //
  // GoogleSignInAuthentication get user => _user!;
  //
  // Future googleLogIn() async {
  //   //Original:
  //   // final googleUser = await googleSignIn.signIn();
  //
  //   final googleUser = await googleSignIn.signIn();
  //
  //   if (googleUser == null) return;
  //   _user = googleUser;
  //
  //   final googleAuth = await googleUser.authentication;
  //
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //   notifyListeners();
  // }//End jo


//
// }

// signInWithGoogle() async{
//     final GoogleSignInAccount? googleUser = await GoogleSignIn(
//       scopes: <String>["email"]).signIn();
//
//     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//
//     //Create new credential
//   final credential = GoogleAuthProvider().credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//
//   //Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
//
// }
//
// signOut(){
//   FirebaseAuth.instance.signOut();
// }


//
// FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
// signInWithGoogle() async {
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//   final credential GoogleAuthProvider.credential(
//   accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//
//   await _firebaseAuth.signInWithCredential(credential);
// }

//Build Social
//   @override
//   void initState(){
//     super.initState();
//     googleSignIn.onCurretUserChanged.listen((account)){
//       if(account != null){
//         print('user sign in: $account');
//
//       }else{
//         print('not');
//       }
//     }
//   }
//
//
// final GoogleSignIn googleSignIn = GoogleSignIn();
//
// login(){
//   googleSignIn.signIn();
// }



}