import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mush2/editProfile.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:mush2/model/userData.dart';
import 'package:mush2/profileWidget.dart';
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

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool doesnothavecover = false;
  bool doesnothaveprofile = false;

  final userID = FirebaseAuth.instance.currentUser!.uid;
  final double coverHeight = 200;
  final double profileHeight = 150;

  // final user = UserPreferences.getUser(); //To change myUser to get the user instead of the default value
  // final Stream<QuerySnapshot> _usersStream =
  // FirebaseFirestore.instance.collection('users').snapshots();
  //
  // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user')
  //     .where("id", isEqualTo: userID) //id should match the id field in the database
  //     .snapshots();

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
            // child: Text("No Data was fetch"),
            // child: CircularProgressIndicator(
            //   color:  textColor,
            // ),
            child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_tmsiddoc.json'),

          );
  }
      ),
    );
  }


   Widget buildEverything(UserData usrs) {
    print("buildEverything");
    print(usrs.name);
    print(usrs.email);
    print(usrs.IDUser);
    print(usrs.about);
    print(usrs.profilePath);
    print(usrs.coverPath);
    Text(usrs.email);
    print(usrs.name);
    print(usrs.email);
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
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(usrs), //Error
          const SizedBox(height: 24),
          buildSignOutButton(),
          const SizedBox(height: 45),
        ]
    );

    print("BuildTOp");
    print(usrs.name);
    print(usrs.email);
    print(usrs.about!);
    print("Done about");
    buildName(usrs);
    buildProfileWidget(usrs);
    final  top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    print(top);
    print(bottom);
    // return Text(user.about!);
    return Stack(
      clipBehavior: Clip.none,
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

  Widget buildTop( UserData usrs ) {
    final  top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
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

    user.coverPath == "" ? doesnothavecover = true : doesnothavecover = false;
    print(doesnothavecover);
    return Container(
      color: Colors.grey,
      // child: Image.network('https://images.pexels.com/photos/268941/pexels-photo-268941.jpeg?cs=srgb&dl=pexels-pixabay-268941.jpg&fm=jpg',
      child: Image.network('https://removal.ai/wp-content/uploads/2021/02/no-img.png',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,),

    );

  }

  Widget buildProfileWidget( UserData user) {
    return ProfileWidget(
      imagePath: user.profilePath!,
      // imagePath: 'https://flxt.tmsimg.com/assets/4950_v9_bb.jpg',
      // imagePath: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
      onClicked: () async{
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfile(user: user)),
        );
        setState(() {}); //Update UI
      },
    );

    // return GestureDetector(
    //   onTap: () async{
    //     await Navigator.of(context).push(
    //       MaterialPageRoute(builder: (context) => EditProfile()),
    //     );
    //     setState(() {}); //Update UI
    //   },
    //   // child: CircleAvatar(
    //   //   backgroundColor: Colors.grey,
    //   //   backgroundImage: NetworkImage('https://flxt.tmsimg.com/assets/4950_v9_bb.jpg'),
    //   // ),
    // );


    //   buildProfileWidget(
    //     imagePath: user.imagePath,
    //     onClicked: () async{
    //       await Navigator.of(context).push(
    //         MaterialPageRoute(builder: (context) => EditProfile()),
    //       );
    //       setState(() {}); //Update UI
    //     },
    //   ),
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
  Widget buildSignOutButton() {
    return
    Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: OutlinedButton.icon(
        icon: Icon(Icons.run_circle, color: textColor, size: 24,),
        onPressed: () async {
          FirebaseAuth.instance.signOut();
          // final report = Invoice(
          //   userID
          // );

        },

        label: Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 24,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          minimumSize: Size.fromHeight (15),
          backgroundColor: bgCard,
        ),

      ),
    );

    //   ButtonWidget(
    //   text: 'Book Now',
    //   onClicked: () {},
    // );
  }




  //
  // Stream<List<UserData>>readUsers() {
  //   FirebaseFirestore.instance.collection('user')
  //       .where("id", isEqualTo: userID) //id should match the id field in the database
  //       .snapshots()
  //       .map((snapshot) =>
  //       snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());
  // }
  
  
} //end of class _ProfileState extends State<Profile>

