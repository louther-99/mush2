import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
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
  final emailController = TextEditingController();

  // print(doc_ref); //P7vYlvT5twXR7GtBsokC
  // print(ID); //ih0mXMco2OalE7ZpnqPcvT1HcPk1
  // print(_db);  //FirebaseFirestore(app: [DEFAULT])
  // print(dotaUser); //User(displayName: , email: diazlouther@gmail.com, emailVerified: true, isAnonymous: false, metadata: UserMetadata(creationTime: 2023-01-24 14:54:56.986Z, lastSignInTime: 2023-01-24 15:38:12.202Z), phoneNumber: , photoURL: null, providerData, [UserInfo(displayName: , email: diazlouther@gmail.com, phoneNumber: , photoURL: null, providerId: password, uid: diazlouther@gmail.com)], refreshToken: , tenantId: null, uid: ih0mXMco2OalE7ZpnqPcvT1HcPk1)
  final firestoreInstance = FirebaseFirestore.instance;
  String doc_ref= FirebaseFirestore.instance.collection("user").doc().id; //hVYSZklL56uOuMrVC32s //7EKfQFBtwHIquF2DcQmt
  // String d = firestoreInstance.collection("user").where('IDUser' =  ID);//hVYSZklL56uOuMrVC32s //7EKfQFBtwHIquF2DcQmt
  final String ID = FirebaseAuth.instance.currentUser!.uid;
  final _db = FirebaseFirestore.instance;
  final dotaUser = FirebaseAuth.instance.currentUser;
  final lols = FirebaseFirestore.instance.collection('user').id; //user


  final CollectionReference _user = FirebaseFirestore.instance.collection('user');


  // User user = UserPreferences.myUser;
  // final String userID = FirebaseAuth.instance.currentUser!.uid;
  final double coverHeight = 200;
  final double profileHeight = 150;

  late UserData user;
  // UserData user = UserPreferences.myUser;
  final String userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _retrieve();
    // user = UserPreferences.getUser();
    // userData = UserPreferences.getUser(); //persistent image edit
  }


  Future <void> _retrieve([DocumentSnapshot? documentSnapshot]) async {
    FirebaseFirestore.instance.collection('user')
        .where("IDUser",
        isEqualTo: userID) //id should match the id field in the database
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());
  }
  Future <void> _updateUsers(UserData user) async {
    final docUser = await FirebaseFirestore.instance.collection('user').doc();
    print("Function _updateUsers");
    print(doc_ref); //P7vYlvT5twXR7GtBsokC
    print(ID); //ih0mXMco2OalE7ZpnqPcvT1HcPk1
    print(_db);  //FirebaseFirestore(app: [DEFAULT])
    print(dotaUser); //User(displayName: , email: diazlouther@gmail.com, emailVerified: true, isAnonymous: false, metadata: UserMetadata(creationTime: 2023-01-24 14:54:56.986Z, lastSignInTime: 2023-01-24 15:38:12.202Z), phoneNumber: , photoURL: null, providerData, [UserInfo(displayName: , email: diazlouther@gmail.com, phoneNumber: , photoURL: null, providerId: password, uid: diazlouther@gmail.com)], refreshToken: , tenantId: null, uid: ih0mXMco2OalE7ZpnqPcvT1HcPk1)
    print(lols);
    print(dotaUser!.uid);
    print(user.IDUser);
    print(user.name);
    print(user.about);
    print(user.email);
    print(user.coverPath);
    print(user.profilePath);

    final json = user.toJson();
    docUser.update(json);
    // await _db.collection('user').doc(user.IDUser).update({IDUser: userID, profilePath: widget.user.profilePath, name: widget.user.name, email: widget.user.email, about: widget.user.about, coverPath: widget.user.coverPath, lastMessageTime: widget.user.lastMessageTime});
    await _db.collection('user').doc(dotaUser!.uid).update(user.toJson());
    // await _db.collection('user').doc('RJSFlOB048I7hiIYMTFa').update(user.toJson());
    // FirebaseFirestore.instance.collection('mushroom')

    print("After _db.collection('user').doc().update(user.toJson());");
    print(doc_ref);
    print(doc_ref);
    print(ID);
    print(_db);
    print(dotaUser);
    print(lols);
    print(dotaUser!.uid);
    print(user.IDUser);
    print(user.name);
    print(user.about);
    print(user.email);
    print(user.coverPath);
    print(user.profilePath);
    // await _db.collection('user').doc(user.IDUser).update({IDUser: userID, profilePath: widget.user.profilePath, name: widget.user.name, email: widget.user.email, about: widget.user.about, coverPath: widget.user.coverPath, lastMessageTime: widget.user.lastMessageTime});

  }

  //
  // Future <void> _update([DocumentSnapshot? documentSnapshot]) async { //Function to update
  //   if(documentSnapshot != null){
      // widget.user.name = documentSnapshot['name'].toString();
      // _lightLevelController.text = documentSnapshot['lightLevel'].toString();
      // _roomTemperatureController.text = documentSnapshot['roomTemp'].toString();
      // _roomHumidityController.text = documentSnapshot['humidity'].toString();
      // _productionController.text = documentSnapshot['outcome'].toString();
      // _dateController.text = documentSnapshot['datetime'].toString();

    // }

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
          // TextFormField(
          //   onChanged: (email) => user = widget.user.copyWith(email: email), //Create copy of the user object in the UserData class
          //   controller: emailController,
          //   cursorColor: textColor,
          //   textInputAction: TextInputAction.next,
          //   decoration: InputDecoration(
          //     labelText: "Enter your email",
          //     fillColor: textColor,
          //     border: OutlineInputBorder(
          //         borderSide: BorderSide(color: textColor, width: 32.0),
          //         borderRadius: BorderRadius.circular(25.0)),
          //     prefixIcon: Icon(Icons.email_outlined),
          //     // focusedBorder:OutlineInputBorder(
          //     // borderSide: const BorderSide(color: Colors.black45, width: 2.0),
          //     // borderRadius: BorderRadius.circular(25.0),
          //     // ),
          //   ),
          //   autovalidateMode: AutovalidateMode.onUserInteraction,
          //   validator: (email) =>
          //   email != null && !EmailValidator.validate(email)
          //       ? "Enter a valid email!"
          //       : null,
          // ),
          // TextFieldWidget(
          //   label: 'Email',
          //   text: widget.user.email,
          //   // onChanged: (email) {},
          //   validator: (email) =>
          //   email != null && !EmailValidator.validate(email)
          //       ? "Enter a valid email!"
          //       : null,
          //   onChanged: (email) => user = widget.user.copyWith(email: email), //Create copy of the user object in the UserData class
          //
          // ),
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
        onPressed: () async {
          // UserPreferences.setUser(user); //Calling setUSer method passing the user object
          Navigator.of(context).pop(); //Pop the editing page to show up the profile page
          // await _mushroom.doc(IDUser: userID, profilePath: widget.user.profilePath, name: widget.user.name, email: widget.user.email, about: widget.user.about, coverPath: widget.user.coverPath, lastMessageTime: widget.user.lastMessageTime);
          // await _user.doc(documentSnapshot!.id).update({});
          print("OutlinedButton");
          // doc_ref
          print(doc_ref);
          print(lols);
          print(user.IDUser);
          print(user.name);
          print(user.about);
          print(user.email);
          print(user.coverPath);
          print(user.profilePath);
          _updateUsers(user);

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

