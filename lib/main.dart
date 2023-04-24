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


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env"); // Load the environment variables
  // String apiKey = dotenv.env['FIREBASE_API_KEY']!; // Get the API key
  // // Initialize Firebase with the API key
  // await Firebase.initializeApp();

  // Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  // FirebaseFirestore db = FirebaseFirestore.instance;
  //
  // CollectionReference users = db.collection('users');
  // QuerySnapshot querySnapshot = await users.get();
  // List<QueryDocumentSnapshot> documents = querySnapshot.docs;
  // for (var document in documents) {
  //   print(document.data());
  // }

  runApp(MaterialApp(
    title: "Ashesi Stream",
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
  // late dataHandler handleMe; // declare dataHandler as a late variable

  // @override
  // void initState() {
  //   super.initState();
  //   handleMe = dataHandler(); // initialize dataHandler in initState
  // }

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
                  // SizedBox(height: 16,),
                  // currentUser(),
                  SizedBox(height: 8),
                  Center(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: screenWidth * 0.20,
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
                        onPressed: (){},
                        text: "Need an account? Sign up!",
                        // hoverColor: Colors.green,
                        type: GFButtonType.transparent,
                        hoverColor:Colors.blueGrey.shade50,
                        // color: Colors.lightBlue.shade300 ,
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

