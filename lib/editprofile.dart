import 'dart:convert';

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
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class editprofilecard extends StatefulWidget {
  final String userEmail;

  const editprofilecard({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<editprofilecard> createState() => _editprofilecardState();
}



Future<void> newPatch(String email, String major, String food, String movie, String residence, String yeargroup, String dob) async {
  /*** A funciton that sends a patch request to change a users details ***/
  String apiLink = "https://us-central1-ashesistream-383012.cloudfunctions.net/streamUsers/users";
  final url = Uri.parse(apiLink);
  final headers = {"Content-Type": "application/json"};

  final json = {
    "dob":"$dob",
    "food":"$food",
    "email":"$email",
    "major":"$major",
    "movie":"$movie",
    "residence":"$residence",
    "yeargroup":"$yeargroup"
  };

  final response = await http.patch(url, headers: headers, body: jsonEncode(json));
  print(response.body);

}


class _editprofilecardState extends State<editprofilecard> {
  // Variables needed for state management
  String userEmail = '';
  String yeargroupIn = "";
  String foodIn = "";
  String majorIn = "";
  String movieIn = "";
  String postcountIn = "";
  String residenceIn = "";
  String friendcountIn = "";
  String dobIn ="";
  String emailIn="";
  var data;

  // text controllers for the form
  late TextEditingController majorController;
  late TextEditingController yeargroupController;
  late TextEditingController residenceController;
  late TextEditingController dateofBirthController;
  late TextEditingController foodController;
  late TextEditingController movieController;


  void initState(){
    super.initState();
    userEmail = widget.userEmail;
    yeargroupIn = "";
    foodIn = "";
    data;
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    late TextEditingController nameController;
    majorController = TextEditingController(text: majorIn);
    yeargroupController = TextEditingController(text: yeargroupIn);
    residenceController = TextEditingController(text: residenceIn);
    dateofBirthController = TextEditingController(text: dobIn);
    foodController = TextEditingController(text: foodIn);
    movieController = TextEditingController(text: movieIn);



    void getUserData(String currentEmail) async {
      /*** A method to get the users current data and populate the edit form ***/

      final Map<String, dynamic> data;

      String apiLink = "https://us-central1-ashesistream-383012.cloudfunctions.net/streamUsers/users?email=";
      String apiRequest = apiLink + currentEmail;
      final userData = await http.get(Uri.parse(apiRequest));

      if (userData.statusCode == 200) {
        data = jsonDecode(userData.body);
      } else {
        print(userData.statusCode);
        return null;
      }

      // Set the text fields to the data that was jus fetched
        yeargroupController.text = data['yeargroup'].toString() as String; //
        foodController.text = data['food'] as String; //
        majorController.text = data['major'] as String; //
        movieController.text = data['movie'] as String; //
        residenceController.text = data['residence'].toString() as String;
        dateofBirthController.text = data['dob'] as String;
    }

    // function call to get the users data
    getUserData(userEmail);



        return Container(
          width: screenWidth*0.25,
          height: screenHeight*0.35,
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Column(children: <Widget>[
                    Text(
                      'Edit Profile',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FractionallySizedBox(
                      child: SizedBox(
                        height: 32,
                        width: 350,
                        child: TextFormField(
                          controller: majorController,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          decoration: InputDecoration(
                            labelText: 'Major',
                            enabled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FractionallySizedBox(
                      child: SizedBox(
                        height: 32,
                        width: 350,
                        child: TextFormField(
                          controller: yeargroupController,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          decoration: InputDecoration(
                            // color: Colors.blueGrey.shade50,
                            labelText: 'Year Group',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FractionallySizedBox(
                      child: SizedBox(
                        height: 32,
                        width: 350,
                        child: TextFormField(
                          controller: residenceController,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          decoration: InputDecoration(
                            labelText: 'Residence',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FractionallySizedBox(
                      child: SizedBox(
                        height: 32,
                        width: 350,
                        child: TextFormField(
                          controller: dateofBirthController,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FractionallySizedBox(
                      child: SizedBox(
                        height: 32,
                        width: 350,
                        child: TextFormField(
                          controller: movieController,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          decoration: InputDecoration(
                            labelText: 'Favorite Movie',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FractionallySizedBox(
                      child: SizedBox(
                        height: 32,
                        width: 350,
                        child: TextFormField(
                          controller: foodController,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          decoration: InputDecoration(
                            labelText: 'Favorite Food',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 70,
                      // height: 10,
                      child:
                      GFButton(
                        onPressed: (){
                          setState(() {
                            userEmail = widget.userEmail;
                          });
                          // Update user details and refresh the edit form
                          newPatch(userEmail, majorController.text, foodController.text,
                              movieController.text, residenceController.text, yeargroupController.text, dateofBirthController.text);
                          getUserData(userEmail);
                        },
                        text: "Submit!",
                        color: Colors.lightBlue.shade300,
                        textColor: Colors.white,
                        shape: GFButtonShape.pills,
                      ),
                    ),
                  ]
                    ,)
                  ),
                ],
              ),
            ],
          ),
        );


  }
}
