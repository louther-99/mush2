import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mush2/status.dart';
import 'package:mush2/input.dart';
import 'package:mush2/data.dart';
import 'package:mush2/utils/colors.dart';

class Notif extends StatefulWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgCard,
      child: Text(
        "Notification",
      ),
    );
  }
}
