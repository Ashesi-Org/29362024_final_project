import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
// import 'package:firebase_image/firebase_image.dart';


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



class _mainFeedState extends State<mainFeed> {
  /*** A class that uses a serverless connection and a stream builder
   * to listen for changes in the posts collection and render them
   * using a predefined templated
   */
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    // Stream that connects to the posts database and orders by the post time
    final Stream<QuerySnapshot> usersStream =
    FirebaseFirestore.instance.collection('posts').orderBy('sortTime', descending: true).snapshots();


    // Stream builder for th e
    return  Container(
      color: Colors.blueGrey.shade50,
      child: Container(
        width: screenWidth * 0.15,
        height: 350,
        child: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading Posts...");
            }
            // get variables from snapshot and use to populate template
            final users = snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data() as Map<String, dynamic>;
              final name = data['username'] as String;
              final posttime = data['posttime'] as String;
              final email = data['email'] as String;
              final postText = data['text'] as String;
              final hasImage = data['hasimage'] as String;
              var imageurl;
              var imagename;
              if (hasImage == "true"){
                imageurl = data['imageurl'] as String;
                imagename = data['imagename'] as String;}

              // Returning a card with the content of the snapshot
                        return Column(
                          children: [
                            Card(
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
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
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
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                                      child: Text(postText,
                                      textAlign: TextAlign.left,),
                                    ),
                                  ),
                                  if (hasImage == "true")
                                  Image.network(
                                    imageurl,
                                  fit: BoxFit.cover,
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
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
