// import 'dart.io';
import 'dart:io';
import 'package:lottie/lottie.dart';


import 'package:flutter/material.dart';
import 'package:mush2/profile.dart';
class ProfileWidget2 extends StatelessWidget {
  final bool isEdit;
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget2({ //Constructor class
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final color = Theme.of(context).colorScheme.primary;
    return Center(
      child:  Stack( //To overlap multitple image
        children: [
          buildImage()
    ],
    ));
  }

  Widget buildImage() {
    final image  = imagePath.contains('https://')
        ? NetworkImage(imagePath) //Image contains https
        : FileImage(File(imagePath)); //Image doesn't contain https
    return ClipOval( //make pic rounded
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          // child: InkWell(onTap: onClicked), // for final VoidCallback onClicked; //Also for splash effect
        ),
      ),
    );
  }


  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}

