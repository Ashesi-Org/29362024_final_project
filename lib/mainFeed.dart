import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';


var userDetailsMap;

class mainFeed extends StatefulWidget {
  const mainFeed({Key? key}) : super(key: key);

  @override
  State<mainFeed> createState() => _mainFeedState();
}

/** A Method that returns the user details of the person who created a post **/
Future<Map<String, String>> getPosterDetails(String id) async{

  // Create firebase instance and connect to users db
  FirebaseFirestore fbInstance = FirebaseFirestore.instance;
  CollectionReference db = fbInstance.collection('users');
  final userDoc = await db.where("id",isEqualTo: id ).get();
  final List<DocumentSnapshot> documents = userDoc.docs;
  final DocumentReference userRef = documents[0].reference;

  String name = (await userRef.get())['name'];
  String email = (await userRef.get())['email'];
  String yeargroup = (await userRef.get())['email'].toString();

  Map<String, String> userDetails = Map<String, String>.from({
    'name': name,
    'email': email,
    'yeargroup' : yeargroup,
  });

  return userDetails;

}


  // Stream currentUserStream(String imagename) async* {
  //   String imageurl = await getImage(imagename);
  // }

var globalImage;

void passer(imagename) {
  getImage(imagename);
}

void getImage(String imagename) async {
  final ref = FirebaseStorage.instance.ref().child(imagename);
  var url = await ref.getDownloadURL();
  print(url);
  globalImage = url;
}

// Future<String> getImage(String imagename) async {
//   final ref = FirebaseStorage.instance.ref().child(imagename);
//   var url = await ref.getDownloadURL();
//
//   return url;
// }

class _mainFeedState extends State<mainFeed> {
  @override
  Widget build(BuildContext context) {
    var globalUserID;
    var globalPostContent;
    var globalHasImage;
    // var email;
    // var detailsMap;


    final screenWidth = MediaQuery.of(context).size.width;

    final Stream<QuerySnapshot> usersStream =
    FirebaseFirestore.instance.collection('posts').snapshots();



    return  Container(
      color: Colors.blueGrey.shade50,
      child: Container(
        width: screenWidth * 0.15,
        height: 350,
        child: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading Post...");
            }
            final users = snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data() as Map<String, dynamic>;
              final name = data['username'] as String;
              final posttime = data['posttime'] as String;
              final email = data['email'] as String;
              final postText = data['text'] as String;
              final hasImage = data['hasimage'] as String;
              final imageurl = data['imageurl'] as String;
              final imagename = data['imagename'] as String;
              passer(imagename);
              // globalPostContent = data['text'].toString() as String;
              // globalHasImage = data['hasimage'].toString() as String;




              final storageRef = FirebaseStorage.instance.ref();
              final httpsReference = FirebaseStorage.instance.refFromURL(imageurl);



              StreamController<String> streamController = StreamController();



              // Stream imageStream = currentUserStream(imagename);

                        // Use the user object returned by getuser() and data from the stream snapshot
                        return Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  ProfilePicture(
                                    name: name,
                                    radius: 22,
                                    fontsize: 17,
                                    random: true,
                                    role: email ,
                                    tooltip: true,
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(name,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                      subtitle: Text("$email · $posttime",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.person_add_alt_1),
                                    tooltip: "Send $name a friend request",
                                    onPressed: () {
                                      // TODO: add http request
                                    },
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(postText),
                              Image.network(
                                imageurl,
                              fit: BoxFit.cover,
                              ),

                            ],
                          ),
                        );
            }).toList();
            return ListView(
            children: users
            );
          },
        ),
      ),
    );
  }
}
