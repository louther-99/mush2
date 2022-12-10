import 'package:flutter/material.dart';
import 'package:mush2/utils/colors.dart';

Container circularProgress(){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(textColor),

    ),
  );

}

Container linearProgress(){
  return  Container(
    // alignment: Alignment.center,
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(textColor),

    ),
  );
}