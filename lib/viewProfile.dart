// import 'dart:convert';
//
// import 'package:final_project/allUsers.dart';
// import 'package:final_project/dataHandler.dart';
// import 'package:final_project/friendscard.dart';
// import 'package:final_project/profilecard.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
// import 'dataHandler.dart';
// import 'firebase_options.dart';
// import 'allUsers.dart';
// import 'currentUser.dart';
// import 'mainFeed.dart';
// import 'profilecard.dart';
// import 'package:getwidget/getwidget.dart';
// import 'friendscard.dart';
// import 'dataHandler.dart';
// import 'sendpostcard.dart';
// import 'signUp.dart';
// import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class viewProfileCard extends StatefulWidget {
//   final String userEmail;
//
//   const viewProfileCard({Key? key, required this.userEmail}) : super(key: key);
//
//   @override
//   State<viewProfileCard> createState() => _viewProfileCardState();
// }
//
// class _viewProfileCardState extends State<viewProfileCard> {
//   String userAccount = '';
//
//   void initState(){
//     super.initState();
//     userAccount = widget.userEmail;
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     Future<Map<String, dynamic>?> fetchUrl() async {
//       String apiLink = "https://us-central1-ashesistream-383012.cloudfunctions.net/streamUsers/users?email=";
//       String apiRequest = apiLink + userAccount;
//       print("the current actual email is $userAccount" );
//       final userData = await http.get(Uri.parse(apiRequest));
//       print("Got response");
//       if (userData.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(userData.body);
//         print(data);
//         return data;
//       } else {
//         print('Request failed with status: ${userData.statusCode}.');
//         return null;
//       }
//     }
//     return FutureBuilder<Map<String, dynamic>?>(
//         future: fetchUrl(),
//     builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
//
//       final data = snapshot.data;
//       final name = data?['name'] as String; //
//       final email = data?['email'] as String; //
//       final yeargroup = data?['yeargroup'].toString() as String; //
//       final food = data?['food'] as String; //
//       final major = data?['major'] as String; //
//       final movie = data?['movie'] as String; //
//       final postcount = data?['postcount'].toString() as String; //
//       String residence = data?['residence'].toString() as String;
//       final friendcount = data?['friendcount'].toString() as String; //
//       final dob = data?['dob'] as String;
//
//
//       return Column(
//         children: [
//           SizedBox(
//             height: 12,
//             // width: 10,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 GFButton(
//                   onPressed: (){
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         // return Dialog(
//                         //     shape: RoundedRectangleBorder(
//                         //       borderRadius: BorderRadius.circular(16.0),
//                         //     ),
//                         //     child: Container(
//                         //       width: screenWidth *0.25,
//                         //       height: screenHeight * 0.5,
//                         //       // child: editprofilecard(userEmail: currentEmail),
//                         //     )
//                         // );
//                       },
//                     );
//
//                   },
//                   text: "Edit",
//                   // height:
//                   type: GFButtonType.transparent,
//                   hoverColor:Colors.blueGrey.shade50,
//                   textColor: Colors.blue,
//                   shape: GFButtonShape.pills,
//                 ),
//               ],
//             ),
//           ),
//           // SizedBox(height: 5,),
//           ProfilePicture(
//             name: name,
//             radius: 30,
//             fontsize: 20,
//             random: true,
//             role: email ,
//             tooltip: true,
//           ),
//
//           ListTile(
//             title: Text(name,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               textAlign: TextAlign.center,),
//             subtitle: Text( "$major · $yeargroup", textAlign: TextAlign.center,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
//           ),
//           const Divider(
//             thickness: 1,
//             endIndent: 15,
//             indent: 15,
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 children: [
//                   Text("Friends", style:
//                   TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(friendcount, style:
//                   TextStyle(fontSize: 15),
//                     textAlign: TextAlign.center,
//                   ),
//
//                 ],
//               ),
//               Column(
//                 children: [
//                   Text("Posts", style:
//                   TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(postcount, style:
//                   TextStyle(fontSize: 15),
//                     textAlign: TextAlign.center,
//                   ),
//
//                 ],
//               )
//             ],
//           ),
//
//           SizedBox(
//             height: 5,
//           ),
//
//           ListTile(
//             title: Text("Bio:",textAlign: TextAlign.center,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//             subtitle: Text("Born on $dob, lives $residence. Favorite movie is $movie \n"
//                 "Loves to eat $food ",textAlign: TextAlign.center,),
//           ),
//           ListTile(
//             title: Text("Email:",textAlign: TextAlign.center,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//             subtitle: Text(email, textAlign: TextAlign.center,),
//           )
//         ],
//
//       );
//     }
//     );
//
//   }
// }
