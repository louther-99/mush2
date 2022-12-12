import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mush2/home.dart';
import 'package:mush2/utils/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';


class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        color: bgCard,
        child: Padding(
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RichText(
                    text: TextSpan(
                      //style: Theme.of(context).textTheme.body1,
                      children: [
                        // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(Icons.email, color: textColor, size: 24,),
                          ),
                        ),
                        TextSpan(text:  '${user.email!}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24,
                            color: textColor,
                          ),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RichText(
                    text: TextSpan(
                      //style: Theme.of(context).textTheme.body1,
                      children: [
                        // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(Icons.credit_card_outlined, color: textColor, size: 24,),
                          ),
                        ),
                        TextSpan(text:  '${user.uid}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24,
                            color: textColor,
                          ),),
                      ],
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RichText(
                    text: TextSpan(
                      //style: Theme.of(context).textTheme.body1,
                      children: [
                        // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(Icons.credit_card_outlined, color: textColor, size: 24,),
                          ),
                        ),
                        TextSpan(text:  '${user}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24,
                            color: textColor,
                          ),),
                      ],
                    ),
                  ),

                ),
                Text(
                  '${user.email!}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                OutlinedButton.icon(
                  icon: Icon(Icons.login, color: textColor, size: 24,),
                  onPressed: () async {
                    onPressed: () => FirebaseAuth.instance.signOut();
                  },

                  label: Text(
                    'Sign out',
                    style: TextStyle(
                      fontSize: 24,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: Size.fromHeight (40),
                    backgroundColor: bgCard,
                  ),

                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
}
