import 'package:final_project/allUsers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'allUsers.dart';
import 'currentUser.dart';
import 'mainFeed.dart';

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
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    width: screenWidth * 0.15,
                    child:
                    Column(
                      children: [
                        ListTile(
                          title: const Text('New Post',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          subtitle: Text(
                              'Share a new post with your friends!',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.91,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 32, // <-- Set half the desired height here
                                child: TextFormField(
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                  decoration: InputDecoration(
                                    // color: Colors.blueGrey.shade50,
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.greenAccent),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 16),
                              TextFormField(
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                maxLines: 8,
                                initialValue: 'Type your next post here!',
                                decoration: InputDecoration(
                                  labelText: 'Text',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.image),
                                    tooltip: "Attach an Image",
                                    onPressed: () {
                                      // Add attachment functionality here
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.send),
                                    tooltip: "Send",
                                    onPressed: () {
                                      // Add send message functionality here
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
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
                  SizedBox(height: 16,),
                  currentUser(),
                  SizedBox(height: 16),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      width: screenWidth * 0.2,
                      height: 100,
                      child: Center(
                        child: Text("Profile"),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      width: screenWidth * 0.2,
                      height: 100,
                      child: Center(
                        child: Text("Friends"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

