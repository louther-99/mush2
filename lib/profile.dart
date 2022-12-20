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

  Stream<List<UserData>>? readUsers() {
    userID = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('user')
        .where("IDUser", isEqualTo: userID) //id should match the id field in the database
        .snapshots()
        .map((querySnapshot) =>
        querySnapshot.docs.map((doc) => UserData.fromDocument(doc)).toList());
    // snapshot.docs.map((doc) => print(doc.data())));
    print(userID);

  //  AvatarURL
    // "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=1200&q=60"
    // IDUser
    // "Pm6dF0mb3qPIX87uTsqswNHvzlz1"
    // about
    // "Lorem upsum wakaru waku ahflasfjalksdfjal;skdfjal;skdfjla;sdkf"
    // email
    // "diazlouther@gmail.com"
    // imagePath
    // "https://flxt.tmsimg.com/assets/4950_v9_bb.jpg"
    // lastMessageTime
    // "2022-11-16 11:27:04.768087"
    // name
    // "Louther Olayres"

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: StreamBuilder<UserData>(
      //   body: StreamBuilder<List<UserData>>(
          // stream: readUsers(),
          // stream: FirebaseFirestore.instance.collection('user')
          //     .where("id", isEqualTo: userID) //id should match the id field in the database
          //     .snapshots()
          //     .map((snapshot) =>
          //     snapshot.docs.map((doc) => UserData.fromJson(doc.data()))),

        // builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        //   builder: (context, snapshot) {
            // if (streamSnapshot.hasData) {
        body: StreamBuilder<List<UserData>>(
        // stream: readUsers(),
        stream:
            FirebaseFirestore.instance.collection('user')
            .where("IDUser", isEqualTo: userID) //id should match the id field in the database
            .snapshots()
            .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => UserData.fromDocument(doc)).toList()),
            builder: (context,snapshot){
          // final DocumentSnapshot documentSnapshot = snapshot.data;
          // final List<UserData>? documentSnapshot = snapshot.data;
          // final user = documentSnapshot;
          // final user = snapshot.data;
          print("The user: $snapshot");
        // body: StreamBuilder (
        // stream: _usersStream,
        // builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){ //streamSnapshot: all data available on the database
          if (snapshot.hasData) {
            print('Has data');
            // final DocumentSnapshot documentSnapshot = streamSnapshot.data!;
            // UserData user = documentSnapshot.toObject(UserData.class);
            // UserData user = documentSnapshot.toObject;
            final user = snapshot.data!;
            print(user);
          // print("this is user: " + user.toString()); //The user: AsyncSnapshot<List<UserData>>(ConnectionState.none, null, null, null)print("this is user: " + user.toString());
          // print("this is user: " + user[1].toString());

            return ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  buildTop(user), //Error
                  const SizedBox(height: 24),
                  buildName(user), //Error
                  const SizedBox(height: 24),
                  NumbersWidget(),
                  const SizedBox(height: 48),
                  buildAbout(user), //Error
                  const SizedBox(height: 24),
                  Center(child: buildUpgradeButton()),
                  const SizedBox(height: 24),
                ]
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

  Widget buildName(List<UserData> user) {
    return Column(
      children: [
        Text(user.toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color:  textColor),
        ),
        Text(
         "user.email",
          style: TextStyle(color: textColor),
        ),

      ],
    );

  }

  Widget buildUpgradeButton() {
    return OutlinedButton(
      onPressed: (){},
      child: Text(
        'Book Now',
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

    );

    //   ButtonWidget(
    //   text: 'Book Now',
    //   onClicked: () {},
    // );
  }

  buildAbout(List<UserData> user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: textColor),
          borderRadius: BorderRadius.circular(50),
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
            'user.about!',
            style: TextStyle(fontSize: 16, height: 1.4, color: textColor),
          ),
          ],
        ),
      ),
    );
  }

  Widget buildCoverPhoto() {
    return Container(
      color: Colors.grey,
      child: Image.network('https://images.pexels.com/photos/268941/pexels-photo-268941.jpeg?cs=srgb&dl=pexels-pixabay-268941.jpg&fm=jpg',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,),

    );
    
  }

  Widget buildProfileWidget() {
    return ProfileWidget(
      // imagePath: user.profilePath!,
      imagePath: 'https://flxt.tmsimg.com/assets/4950_v9_bb.jpg',
      onClicked: () async{
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfile()),
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

  Widget buildTop(List<UserData> user ) {
    final  top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
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


  //
  // Stream<List<UserData>>readUsers() {
  //   FirebaseFirestore.instance.collection('user')
  //       .where("id", isEqualTo: userID) //id should match the id field in the database
  //       .snapshots()
  //       .map((snapshot) =>
  //       snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());
  // }
  
  
} //end of class _ProfileState extends State<Profile>

