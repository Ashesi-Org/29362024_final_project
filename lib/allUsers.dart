import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class allUsers extends StatefulWidget {
  const allUsers({Key? key}) : super(key: key);

  @override
  State<allUsers> createState() => _allUsersState();
}


class _allUsersState extends State<allUsers> {
  final Stream<QuerySnapshot> usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();

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
              width: screenWidth * 0.15,
              child: ListTile(
                title: const Text('Active Users',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text(
                    'Connect with new people!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.15,
              height: 350,
              child: StreamBuilder<QuerySnapshot>(
                stream: usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('No Users');
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


























// void getList() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   FirebaseFirestore db = FirebaseFirestore.instance;
//
//   CollectionReference users = db.collection('users');
//   QuerySnapshot querySnapshot = await users.get();
//   List<QueryDocumentSnapshot> documents = querySnapshot.docs;
//   for (var document in documents) {
//     print(document.data());
//
//
//   }
