import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mush2/model/userData.dart';
import 'package:mush2/profileWidget.dart';
import 'package:mush2/utils/colors.dart';
import 'package:mush2/utils/userPreferences.dart';
import 'package:mush2/widget/buildAppBar.dart';
import 'package:mush2/widget/buttonWidget.dart';
import 'package:mush2/widget/textFieldWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // User user = UserPreferences.myUser;

  late UserData user;
  // UserData user = UserPreferences.myUser;
  final String userID = FirebaseAuth.instance.currentUser!.uid;


  @override
  void initState(){
    super.initState();
    user = UserPreferences.getUser();
    // userData = UserPreferences.getUser(); //persistent image edit
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCard,
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: () async {
                final image = await ImagePicker()
                    .pickImage(source: ImageSource.gallery); //Open the phone gallery to pick image
                if(image == null) return; //Check image if null or not
                final directory = await getApplicationDocumentsDirectory();//store directory if image is not null
                final name = basename(image.path); //Getting the name of the file and the extension using the package path
                final imageFile = File('${directory.path}/$name'); //Creating the image file base on the directory
                final newImage = await File(image.path).copy(imageFile.path);

                setState(() => user = user.copyWith(imagePath: newImage.path));
                // setState(() => userData = userData.copyWith(imagePath: newImage.path));

                },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: user.name,
            // onChanged: (name) {},
            onChanged: (name) => user = user.copyWith(name: name), //Create copy of the user object in the UserData class
            // onChanged: (name) => userData = userData.copyWith(name: name),

          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: user.email,
            // onChanged: (email) {},
            onChanged: (email) => user = user.copyWith(email: email), //Create copy of the user object in the UserData class

          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: user.about,
            maxLines: 5,
            // onChanged: (about) {},
            onChanged: (about) => user = user.copyWith(about: about),


          ),
          const SizedBox(height: 24),
      OutlinedButton(
        onPressed: (){
          UserPreferences.setUser(user); //Calling setUSer method passing the user object
          Navigator.of(context).pop(); //Pop the editing page to show up the profile page
        },
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 24,
            color: textColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          //minimumSize: Size.fromHeight (40),
          backgroundColor: pinkColor,
        ),

      ),
          // ButtonWidget(
          //     text: 'Save',
          //     onClicked: (){
          //       UserPreferences.setUser(user);
          //       Navigator.of(context).pop();
          //     },
          // ),

        ],
      ),
    );
  }
}
