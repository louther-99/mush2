import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mush2/status.dart';
import 'package:mush2/input.dart';
import 'package:mush2/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/M1_effects2.jpeg'),
          ),
          backgroundColor: Color(0xff946713),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.insert_drive_file), text: 'INPUT'),
              Tab(icon: Icon(Icons.table_view), text: 'DATA'),
              Tab(icon: Icon(Icons.notifications), text: 'NOTIFICATION'),
              Tab(icon: Icon(Icons.menu), text: 'MENU'),

            ],
          ),
          title: Text("MushMush"),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Input(),
            ),
            Center(
              child: Data(),
            ),
            Center(
              child: Text("NOTIFICATION"),
            ),
            Center(
              child: Status(),
              //child: Text("STATUS"),
            ),
          ],
        ),
      ),

    );



  }
}


