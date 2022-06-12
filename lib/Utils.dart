import 'package:flutter/material.dart';
import 'package:mush2/main.dart';

 class Utils {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

   static showSnackBar(String? text){
    if (text == null) return;
    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);
    //messengerKey.currentState!
    //..removeCurrentSnackBar()
    //..showSnackBar(snackBar);
  }
}
