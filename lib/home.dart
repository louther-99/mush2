import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mush2/messages.dart';
import 'package:mush2/profile.dart';
import 'package:mush2/status.dart';
import 'package:mush2/input.dart';
import 'package:mush2/data.dart';
import 'package:mush2/utils/colors.dart';
import 'package:mush2/notification.dart';
import 'package:mush2/utils/userPreferences.dart';
import 'package:mush2/timeline.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool profileclick = false;

  @override
  Widget build(BuildContext context) {
    // final u = UserPreferences.getUser();
    final user = FirebaseAuth.instance.currentUser!;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            toolbarHeight: 90,
            //leadingWidth: 50,
            // leading: CircleAvatar(
            //   // backgroundImage: AssetImage('assets/MushMush.png'),
            //   // radius: 20
            // ),
            // backgroundColor: Color(0xff946713),
            backgroundColor:  bgColor,
            // elevation: 10,
            // titleSpacing: 40,
            // actions: [
            //   IconButton(
            //       onPressed: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context) => M()),
            //         );
            //         },
            //       icon: Icon(Icons.message)),
            // ],
            bottom: TabBar(

              indicatorColor: textColor,
              indicatorWeight: 5,
              labelColor: textColor, //<-- selected text color
              unselectedLabelColor: Colors.white, //<-- Unselected text
              tabs: [
                // Tab(icon: Icon(Icons.insert_drive_file), text: 'INPUT'),
                // Tab(icon: Icon(Icons.table_view), text: 'DATA'),
                // Tab(icon: Icon(Icons.notifications), text: 'NOTIFICATION'),
                // Tab(icon: Icon(Icons.menu), text: 'MENU'),
                Tab(icon: Icon(Icons.insert_drive_file)),
                // Tab(icon: Icon(Icons.file_present)),
                Tab(icon: Icon(Icons.table_view)),
                // Tab(icon: Icon(Icons.home)),

                // Tab(icon: Icon(Icons.notifications)),

                Tab(icon: Icon(Icons.person)),
              ],
            ),
            title: Text("MushMush",
            style: TextStyle(
              color: textColor,
                fontSize: 30,
            ),),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Input(),
            ),
            // Center(
            //   child: Status(),
            //
            // ),
            // Center(
            //   // child: Timeline(),
            // ),

            // Center(
            //   child: Notif(),
            // // ),
            Center(
              child: Data(),
              //child: Text("STATUS"),
            ),
            Center(
              child: Profile(),
            ),
          ],
        ),
      ),

    );



  }
}


