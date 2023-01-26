import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mush2/editProfile.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:mush2/model/userData.dart';
import 'package:mush2/profileWidget.dart';
import 'package:mush2/profileWidget2.dart';
import 'package:mush2/utils/colors.dart';
import 'package:mush2/utils/colors.dart';
import 'package:mush2/utils/colors.dart';
import 'package:mush2/utils/colors.dart';
import 'package:mush2/utils/userPreferences.dart';
import 'package:mush2/widget/numbersWidget.dart';
import 'package:mush2/widget/textFieldWidget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mush2/logInWidget.dart';
import 'package:mush2/home.dart';
import 'services/auth_service.dart';
import 'package:mush2/services/auth_service.dart';
import 'package:mush2/Utils.dart';
import 'package:mush2/verfiy_email.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';



final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
String userID = "";
bool hide = false;


class EditAbout extends StatefulWidget {


  final UserData user;
  const EditAbout({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditAbout> createState() => _EditAboutState();
}

class _EditAboutState extends State<EditAbout> {

  bool doesnothavecover = false;
  var  CoverUrlDownload;
  PlatformFile? pickFileCover;
  UploadTask? uploadTaskCover;
  final dotaUser = FirebaseAuth.instance.currentUser;


  var coverPath;
  var coverFile;
  final userID = FirebaseAuth.instance.currentUser!.uid;
  final double coverHeight = 200;
  final double profileHeight = 150;


  @override
  void initState() {
    // TODO: implement initState
    fetchRecords();
    super.initState();
  }


  fetchRecords () async {
    var records = await FirebaseFirestore.instance.collection('user')
        .where("id", isEqualTo: userID) //id should match the id field in the database
        .snapshots();
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records ){


  }

  Stream<List<UserData>> ? readUsers() {

    FirebaseFirestore.instance.collection('user')
        .where("IDUser", isEqualTo: userID) //id should match the id field in the database
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());
    // snapshot.docs.map((doc) => print(doc.data())));
    print(userID);
  }
  Future <void> _updateUsers(UserData user) async {

    // final docUser = await FirebaseFirestore.instance.collection('user').doc(dotaUser!.uid);
    CollectionReference collection = FirebaseFirestore.instance.collection('user');
    DocumentReference document = collection.doc(dotaUser!.uid);

    print("_updateUsers user.name " + user.name);
    print("_updateUsers user.about " + user.about.toString());
    final json = user.toJson();
    print("_updateUsers Before update");
    // docUser.update(json);
    print("_updateUsers dotaUser!.uid " + dotaUser!.uid.toString());
    document.update(json);

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: StreamBuilder<List<UserData>>(
          // stream: readUsers(),
            stream: FirebaseFirestore.instance.collection('user')
                .where("IDUser", isEqualTo: userID) //id should match the id field in the database
                .snapshots()
                .map((snapshot) =>
                snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList()),
            builder: (context,  streamSnapshot){
              print("The user: $streamSnapshot");

              if (streamSnapshot.hasData) {
                final usr = streamSnapshot.data! as List<UserData>;
                print(usr[0]);
                final listUser = usr.map((e) => e).toList();
                print(listUser[0]);
                final ab = listUser[0];
                final UserData e = listUser[0] as UserData;
                print('Has data');
                print(usr[0].email);
                print("printed");
                var u = usr.map;
                print(u);
                print(usr.length);
                final usr1 = usr[0] as UserData;
                return ListView(
                  // children: widget()buildEverything(usr[1]).toList(),
                  children: <Widget>[
                    buildEverything(usr1),
                  ],
                  // children:  usr(buildEverything),
                );


              }
              return Center(

                child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_tmsiddoc.json'),

              );
            }
        ),
      ),
    );
  }


  Widget buildEverything(UserData usrs) {
    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(usrs), //Error
          const SizedBox(height: 24),
          buildName(usrs), //Error
          const SizedBox(height: 24),
          const SizedBox(height: 48),
          buildAbout(usrs), //Error
          const SizedBox(height: 24),
          buildTextField(usrs),
        ]
    );


  }

  Widget buildTop( UserData usrs ) {
    final  top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      // clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverPhoto(usrs),
        ),
        Positioned(
          top: top,
          child: buildProfileWidget(usrs),
        ),
      ],
    );
  }
  Widget buildCoverPhoto(UserData user) {
    return GestureDetector(
      onTap: selectFile2,
      child: Container(
        // padding: EdgeInsets.all(0),
        color: Colors.grey,
        // child: Image.network('https://images.pexels.com/photos/268941/pexels-photo-268941.jpeg?cs=srgb&dl=pexels-pixabay-268941.jpg&fm=jpg',
        child: pickFileCover == null ? Image.network(widget.user.coverPath.toString(),
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,)
            : Image.file(File(pickFileCover!.path!),
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,),



      ),
    );

  }

  Widget buildProfileWidget( UserData user) {
    return ProfileWidget2(
      imagePath: user.profilePath!,
      onClicked: () {
      },
    );


  }
  Widget buildName(UserData user) {
    return Column(
      children: [

        Text(user.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color:  textColor),
        ),
        Text(
          user.email,
          style: TextStyle(color: textColor),
        ),


      ],
    );

  }
  Widget buildAbout(UserData user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: textColor),
          borderRadius: BorderRadius.circular(20),
          color: bgCard,
        ),

        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 24),
            Text(
              user.about!,
              style: TextStyle(fontSize: 16, height: 1.4, color: textColor),
            ),
          ],

        ),
      ),
    );
  }

  Future  selectFile2() async{
    final result2 = await FilePicker.platform.pickFiles();

    if(result2 == null) return; //Check image if null or not2

    setState(() {
      pickFileCover = result2!.files.first;
      // user = widget.user.copyWith(profilePath: urlDownload);
    });

    // setState(() => userData = userData.copyWith(imagePath: newImage.path));


  }

 Widget buildTextField(user) {
   return Center(
     child: Container(
       margin: EdgeInsets.all(30),
       child: TextFieldWidget(
         label: 'About (Auto Save)',
         text: widget.user.about.toString(),
         onChanged: (about)  {user = widget.user.copyWith(about: about); print(user.about); _updateUsers(user);}, //Create copy of the user object in the UserData class
       ),
     ),
   );
 }





} //end of class _ProfileState extends State<Profile>

