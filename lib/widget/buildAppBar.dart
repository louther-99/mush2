
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mush2/utils/userPreferences.dart';

import '../utils/colors.dart';

AppBar buildAppBar(BuildContext context){
  // final user = UserPreferences.getUser();
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: BackButton(color: textColor),
    backgroundColor: bgColor,
    elevation: 0,
    actions: [
      IconButton(
          onPressed: (){},
          icon: Icon(icon, color: textColor),
      ),
    ],
  );

}