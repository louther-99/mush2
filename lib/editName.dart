import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  var profilePath;
  var profileFile;
  var coverPath;
  var coverFile;
  var profileUrlDownload ,CoverUrlDownload;
  PlatformFile? pickFile, pickFileCover;
  UploadTask? uploadTaskProfile, uploadTaskCover;

  bool doesnothavecover = false;
  final dotaUser = FirebaseAuth.instance.currentUser;

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
    print("_updateUsers user.coverPath " + user.coverPath.toString());
    print("_updateUsers user.profilePath " + user.profilePath.toString());
    print("_updateUsers dotaUser!.uid " + dotaUser!.uid.toString());
    document.update(json);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          buildSaveButton(usrs),
          const SizedBox(height: 45),
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
    return Container(
      // padding: EdgeInsets.all(0),
        color: Colors.grey,
        // child: Image.network('https://images.pexels.com/photos/268941/pexels-photo-268941.jpeg?cs=srgb&dl=pexels-pixabay-268941.jpg&fm=jpg',
        child: Image.network(user.profilePath.toString(),
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,)
    );

  }

  Widget buildProfileWidget( UserData user) {
    return Column(
      children: [
        if (pickFile != null)
          Visibility(
            visible: true,
            child: ProfileWidget(
              imagePath: pickFile!.path!,
              isEdit: true,
              onClicked: selectFile,

            ),

          ),
        pickFile == null ? Visibility(visible: true, child: ProfileWidget(imagePath: widget.user.coverPath!, onClicked: selectFile)) : Visibility(visible: false, child: ProfileWidget(imagePath: widget.user.coverPath!, onClicked: selectFile)),
      ],
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
  buildAbout(UserData user) {
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


  Future  selectFile() async{
    final result = await FilePicker.platform.pickFiles();

    if(result == null) return; //Check image if null or not

    setState(() {
      pickFile = result!.files.first;
      // user = widget.user.copyWith(profilePath: urlDownload);
    });

    // setState(() => userData = userData.copyWith(imagePath: newImage.path));


  }

  Widget buildSaveButton(UserData user) {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child:   OutlinedButton(
          onPressed: () async {

            print('OutlinedButton pickFileCover != null?????');
            if(pickFile != null) {
              print('OutlinedButton pickFileCover != null?????=TRUEEEeE');
              profilePath = 'files/${pickFile!.name}';
              profileFile = File(pickFile!.path!);
              print('OutlinedButton profilePath != null?????=TRUEEEeE pickFileCover  coverPath: $profilePath');
              print('OutlinedButton profileFile != null?????=TRUEEEeE pickFileCover  coverFile: $profileFile');
              final ref = FirebaseStorage.instance.ref().child(profilePath);

              setState(() {
                uploadTaskProfile = ref.putFile(profileFile);
              });
              // print('After some covering: $user.coverPath');
              final snapshot = await uploadTaskProfile!.whenComplete(() {});
              profileUrlDownload = await snapshot.ref.getDownloadURL();
              print("OutlinedButton profileUrlDownload: " + profileUrlDownload);
              user = widget.user.copyWith(profilePath: profileUrlDownload);
              print("OutlinedButton user.profilePath in pickFileCover != null " +
                  user.profilePath.toString());
            }

            _updateUsers(user);
            final snackBar = SnackBar(content: Text("Data has been updated."));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pop(); //Pop the editing page to show up the profile page

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
      );

    //   ButtonWidget(
    //   text: 'Book Now',
    //   onClicked: () {},
    // );
  }




} //end of class _ProfileState extends State<Profile>

