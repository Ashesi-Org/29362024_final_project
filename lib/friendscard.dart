import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';


class friendscard extends StatefulWidget {
  const friendscard({Key? key}) : super(key: key);

  @override
  State<friendscard> createState() => _friendscardState();
}

class _friendscardState extends State<friendscard> {
  final Stream<QuerySnapshot> usersStream =
  FirebaseFirestore.instance.collection('users').orderBy("name",descending: true).snapshots();



  Stream<QuerySnapshot> friendsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('samuel.blankson@ashesi.edu.gh') // Replace with the ID of the document containing the sub-collection
        .collection('friends') // Replace with the name of the sub-collection
        .snapshots();
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.2,
              child: ListTile(
                title: const Text('Friends',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text(
                    'All your friends in one place',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.2,
              height: 220,
              child: StreamBuilder<QuerySnapshot>(
                stream: friendsStream(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading Users');
                  }
                  final users = snapshot.data!.docs.map((DocumentSnapshot document) {
                    final data = document.data() as Map<String, dynamic>;
                    final name = data['name'] as String;
                    final yeargroup = data['yeargroup'].toString() as String;
                    final email = data['email'].toString() as String;
                    return Column(
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
                                subtitle: Text(yeargroup,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              tooltip: "View $name\'s profile",
                              onPressed: () {
                                // TODO: add http request
                              },
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    );
                  }).toList();
                  return ListView(
                    children: users,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}








