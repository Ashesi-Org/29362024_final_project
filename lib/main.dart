import 'package:final_project/allUsers.dart';
import 'package:final_project/dataHandler.dart';
import 'package:final_project/friendscard.dart';
import 'package:final_project/profilecard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dataHandler.dart';
import 'firebase_options.dart';
import 'allUsers.dart';
import 'currentUser.dart';
import 'mainFeed.dart';
import 'profilecard.dart';
import 'package:getwidget/getwidget.dart';
import 'friendscard.dart';
import 'dataHandler.dart';
import 'sendpostcard.dart';
import 'signUp.dart';



void main() async {


  // Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(MaterialApp(
    title: "Ashesi Stream",
    // home: signUpPage(),
    home: ThreeColumnLayout(),
      theme: ThemeData(
        dividerTheme: const DividerThemeData(
          space: 0, // set vertical space to 0
        ),
      ),
  ));
}


class ThreeColumnLayout extends StatefulWidget {
  @override
  _ThreeColumnLayoutState createState() => _ThreeColumnLayoutState();
}

class _ThreeColumnLayoutState extends State<ThreeColumnLayout> {


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Form(
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.25,
            color: Colors.blueGrey.shade50,
            child: Column(
              children: [
                sendPostCard(),
                SizedBox(height: 16),
                allUsers(),
              ],
            ),
          ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.lightBlue.shade300,
                title: Text('Home'),
              ),
              body: Container(
                width: screenWidth * 0.5,
                height: screenHeight,
                color: Colors.blueGrey.shade50,
                child:
                  mainFeed(),

              ),
            ),
          ),
          Container(
            width: screenWidth * 0.25,
            color: Colors.blueGrey.shade50,
            child: Center(
              child: Column(
                children: [

                  Center(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: screenWidth * 0.20,
                            // Show profile card
                            child: profilecard(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Center(
                    // child: friendscard(),
                  ),
                  Center(
                    child:
                    Container(
                      width: screenWidth * 0.20,
                      // height: 10,
                      child:
                      GFButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Container(

                                  width: screenWidth *0.25,
                                    height: screenHeight * 0.66,
                                    // show sign up page
                                    child: signUpPage()),
                              );
                            },
                          );
                        },
                        text: "Need an account? Sign up!",
                        // hoverColor: Colors.green,
                        type: GFButtonType.transparent,
                        hoverColor:Colors.blueGrey.shade50,
                        textColor: Colors.blue,
                        shape: GFButtonShape.pills,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

