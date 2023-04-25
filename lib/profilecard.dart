import 'dart:async';
import 'package:final_project/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'firebase_options.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getwidget/getwidget.dart';
import 'dataHandler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'editprofile.dart';


class profilecard extends StatefulWidget {

  const profilecard({Key? key}) : super(key: key);


  @override
  State<profilecard> createState() => _profilecardState();
}

class _profilecardState extends State<profilecard> {
  /** A Class that performs all the tasks required to display the current user text field,
   * user profile and the friends.
   * Contains the depracated friendscard.dart
   */
  final currentUserEmailController = TextEditingController();
  String currentEmail = '';

  void updateEmail(String email) {
    // A method that updates the current email being used for the profile card
    setState(() {
      currentEmail = email;
    });
  }




  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // final Future<DocumentSnapshot> userData = FirebaseFirestore.instance
    //     .collection('users')
    //     .where('email', isEqualTo: 'samuel.blankson@ashesi.edu.gh')
    //     .get()
    //     .then((querySnapshot) => querySnapshot.docs.first);

    Future<Map<String, dynamic>?> fetchUrl() async {
      /*** The method that fetches the users data from the firestore db and
       * returns a json object which is then unpacked to build the profile card
       */
      String apiLink = "https://us-central1-ashesistream-383012.cloudfunctions.net/streamUsers/users?email=";
      String apiRequest = apiLink + currentEmail;
      print("the current actual email is $currentEmail" );
      final userData = await http.get(Uri.parse(apiRequest));
      print("Got response");
      if (userData.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(userData.body);
        print(data);
        return data;
      } else {
        print(userData.statusCode);
        return null;
      }
    }

    // The stream for the current/viewed user
    Stream<QuerySnapshot> friendsStream() {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(currentEmail)
          .collection('friends')
          .snapshots();
    }

    // The future builder that builds the section for endering the user data
    // previously the currentUser.dart
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchUrl(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [ Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),

              ),
              child: Container(

                width: screenWidth * 0.2,
                height: 100,
                child:
                Column(
                  children: [
                    ListTile(
                      title: const Text('Current User View',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      subtitle: Text(
                          'Enter your ID to switch the current User!',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.91,
                      child: SizedBox(
                        height: 32,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: currentUserEmailController, //email controller
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon:Icon(Icons.check_circle),
                              padding: EdgeInsets.only(bottom: 2.0),
                              tooltip: "Confirm account switch",
                              onPressed: (){
                                updateEmail(currentUserEmailController.text); //pass value to update email

                              },
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            ],
          );
        }

        // Unpacking the data from the send request which will be used for the
        // profile card
        final data = snapshot.data;
        final name = data?['name'] as String; //
        final email = data?['email'] as String; //
        final yeargroup = data?['yeargroup'].toString() as String; //
        final food = data?['food'] as String; //
        final major = data?['major'] as String; //
        final movie = data?['movie'] as String; //
        final postcount = data?['postcount'].toString() as String; //
        String residence = data?['residence'].toString() as String;
        final friendcount = data?['friendcount'].toString() as String; //
        final dob = data?['dob'] as String;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Card for entering your email
              Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),

              ),
              child: Container(
                width: screenWidth * 0.2,
                height: 100,
                child:
                Column(
                  children: [
                    ListTile(
                      title: const Text('Current User',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                      ),
                      subtitle: Text(
                          'Enter your ID to switch the current User!',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.91,
                      child: SizedBox(
                        height: 32,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: currentUserEmailController, //email controller
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon:Icon(Icons.check_circle),
                              padding: EdgeInsets.only(bottom: 2.0),
                              tooltip: "Confirm account switch",
                              onPressed: (){
                                updateEmail(currentUserEmailController.text);
                              },
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),



              // The second card that shows the actual profile
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
               child: Column(
                 children: [
                   SizedBox(
                     height: 12,
                     // width: 10,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
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
                                       height: screenHeight * 0.5,
                                       child: editprofilecard(userEmail: currentEmail),
                                   )
                                 );
                               },
                             );
                           },
                           text: "Edit",
                           type: GFButtonType.transparent,
                           hoverColor:Colors.blueGrey.shade50,
                           textColor: Colors.blue,
                           shape: GFButtonShape.pills,
                         ),
                       ],
                     ),
                   ),
                   // SizedBox(height: 5,),
                   ProfilePicture(
                     name: name,
                     radius: 30,
                     fontsize: 20,
                     random: true,
                     role: email ,
                     tooltip: true,
                   ),

                   ListTile(
                     title: Text(name,
                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                     textAlign: TextAlign.center,),
                     subtitle: Text( "$major · $yeargroup", textAlign: TextAlign.center,
                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                   ),
                   const Divider(
                     thickness: 1,
                     endIndent: 15,
                     indent: 15,
                   ),
                   SizedBox(
                     height: 5,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Column(
                         children: [
                           Text("Friends", style:
                           TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                             textAlign: TextAlign.center,
                           ),
                           Text(friendcount, style:
                           TextStyle(fontSize: 15),
                             textAlign: TextAlign.center,
                           ),
                         ],
                       ),
                       Column(
                         children: [
                           Text("Posts", style:
                           TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                             textAlign: TextAlign.center,
                           ),
                           Text(postcount, style:
                           TextStyle(fontSize: 15),
                             textAlign: TextAlign.center,
                           ),
                         ],
                       )
                     ],
                   ),
                   SizedBox(
                     height: 5,
                   ),
                   ListTile(
                     title: Text("Bio:",textAlign: TextAlign.center,
                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                     subtitle: Text("Born on $dob, lives $residence. Favorite movie is $movie \n"
                         "Loves to eat $food ",textAlign: TextAlign.center,),
                   ),
                   ListTile(
                     title: Text("Email:",textAlign: TextAlign.center,
                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                     subtitle: Text(email, textAlign: TextAlign.center,),
                   )
                 ],
               ),

              ),

                  // Third card that implements the friends list
                  // previously the friendscard.dart
                  SingleChildScrollView(
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
                  ),


        ],
          ),
        );
      },
    );
  }
}
