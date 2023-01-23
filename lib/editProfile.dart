import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final UserData user;
  const EditProfile({
    Key? key,
    required this.user,
  }) : super(key: key);


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // User user = UserPreferences.myUser;
  // final String userID = FirebaseAuth.instance.currentUser!.uid;
  final double coverHeight = 200;
  final double profileHeight = 150;

  late UserData user;
  // UserData user = UserPreferences.myUser;
  final String userID = FirebaseAuth.instance.currentUser!.uid;


  @override
  void initState(){
    super.initState();
    // user = UserPreferences.getUser();
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
          buildTop(),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: widget.user.name,
            // onChanged: (name) {},
            onChanged: (name) => user = widget.user.copyWith(name: name), //Create copy of the user object in the UserData class
            // onChanged: (name) => userData = userData.copyWith(name: name),

          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: widget.user.email,
            // onChanged: (email) {},
            onChanged: (email) => user = widget.user.copyWith(email: email), //Create copy of the user object in the UserData class

          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: widget.user.about.toString(),
            maxLines: 5,
            // onChanged: (about) {},
            onChanged: (about) => user = widget.user.copyWith(about: about),


          ),
          const SizedBox(height: 24),
      OutlinedButton(
        onPressed: (){
          // UserPreferences.setUser(user); //Calling setUSer method passing the user object
          Navigator.of(context).pop(); //Pop the editing page to show up the profile page
          createUser(IDUser: userID, profilePath: widget.user.profilePath, name: widget.user.name, email: widget.user.email, about: widget.user.about, coverPath: widget.user.coverPath, lastMessageTime: widget.user.lastMessageTime);

          final snackBar = SnackBar(content: Text("Data has been updated."));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        //required IDUser, required profilePath, required name, required email, required about, required coverPath, required lastMessageTime
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

 Widget buildTop() {

    final  top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          // padding: EdgeInsets.all(0),
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverPhoto(),
        ),
        Positioned(
          top: top,
          child: buildProfileWidget(),
        ),
      ],
    );
  }

  Widget buildProfileWidget() {
    return ProfileWidget(
      // imagePath: widget.user.profilePath.toString(),
      imagePath: widget.user.profilePath.toString(),
      isEdit: true,
      onClicked: () async {
        final image = await ImagePicker()
            .pickImage(source: ImageSource.gallery); //Open the phone gallery to pick image
        if(image == null) return; //Check image if null or not
        final directory = await getApplicationDocumentsDirectory();//store directory if image is not null
        final name = basename(image.path); //Getting the name of the file and the extension using the package path
        final imageFile = File('${directory.path}/$name'); //Creating the image file base on the directory
        final newImage = await File(image.path).copy(imageFile.path);

        setState(() => user = widget.user.copyWith(profilePath: newImage.path));
        // setState(() => userData = userData.copyWith(imagePath: newImage.path));

      },
    );
  }

  Widget buildCoverPhoto() {
    return Container(
      // padding: EdgeInsets.all(0),
      color: Colors.grey,
      // child: Image.network('https://images.pexels.com/photos/268941/pexels-photo-268941.jpeg?cs=srgb&dl=pexels-pixabay-268941.jpg&fm=jpg',
      child: Image.network('https://removal.ai/wp-content/uploads/2021/02/no-img.png',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,),

    );
  }

  Future createUser({   required IDUser, required profilePath, required name, required email, required about, required coverPath, required lastMessageTime}) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();
    final user  = UserData(
      IDUser: IDUser,
      profilePath: profilePath,
      name: name,
      email: email,
      about: about,
      coverPath: coverPath,
      lastMessageTime: lastMessageTime,
    );

    final json = user.toJson();
    await docUser.set(json);
  }
  }

