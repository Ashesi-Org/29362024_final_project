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


// String receiveData(dataHandler passMe){
//   String currentEmail = passMe.getData();
//   return currentEmail;
// }

class profilecard extends StatefulWidget {
  // final String userEmail;


  const profilecard({Key? key}) : super(key: key);

  // const profilecard({);

  // final dataHandler newHandler;
  // profilecard({required this.newHandler});

  @override
  State<profilecard> createState() => _profilecardState();
}

class _profilecardState extends State<profilecard> {
  final currentUserEmailController = TextEditingController();
  String currentEmail = '';

  void updateEmail(String email) {
    setState(() {
      currentEmail = email;
      // sendData();
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   userData = '...'; // get user data
  //   widget.newHandler.setData(userData);
  // }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final Future<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: 'samuel.blankson@ashesi.edu.gh')
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);

    Future<Map<String, dynamic>?> fetchUrl() async {
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
        print('Request failed with status: ${userData.statusCode}.');
        return null;
      }
    }


    Stream<QuerySnapshot> friendsStream() {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(currentEmail) // Replace with the ID of the document containing the sub-collection
          .collection('friends') // Replace with the name of the sub-collection
          .snapshots();
    }


    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchUrl(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [ Card(
              // color: Colors.lightBlue.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),

              ),
              child: Container(

                // color: Colors.lightBlue.shade300,
                width: screenWidth * 0.2,
                height: 100,
                child:
                Column(
                  children: [
                    ListTile(
                      title: const Text('Current User',
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
              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(16.0),
              //   ),
              //   child: FractionallySizedBox(
              //     widthFactor: 0.1,
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
            ],
          );
        }


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
            children: [Card(
              // color: Colors.lightBlue.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),

              ),
              child: Container(

                // color: Colors.lightBlue.shade300,
                width: screenWidth * 0.2,
                height: 100,
                child:
                Column(
                  children: [
                    ListTile(
                      title: const Text('Current User',
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
                           // height:
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
