import 'package:blur/blur.dart';
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
import 'package:dio/dio.dart';
import 'sendpostcard.dart';
import 'package:floating_bubbles/floating_bubbles.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({Key? key}) : super(key: key);

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final majorController = TextEditingController();
    final yeargroupController = TextEditingController();
    final idController = TextEditingController();
    final residenceController = TextEditingController();
    final dateofBirthController = TextEditingController();
    final foodController = TextEditingController();
    final movieController = TextEditingController();

    void uploadPost(String name,String email,String major,String year,
        String id, String residence, String dob, String movie,String food ) async{

      final dio = Dio();
      Map<String, String> userData = {
        "dob":dob,
        "email":email,
        "food":food,
        "id":id,
        "major":major,
        "movie":movie,
        "name":name,
        "residence":residence,
        "yeargroup":year
      };

      final response = await dio.post("https://us-central1-ashesistream-383012.cloudfunctions.net/streamUsers/users", data:userData);
      print(response.data);
    }

    return Container(
      width: screenWidth*0.25,
      height: screenHeight*0.66,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Column(children: <Widget>[
                  Text(
                    'Sign Up!',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
                        controller: nameController,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      // controller: posterEmailControler,
                      decoration: InputDecoration(
                        // color: Colors.blueGrey.shade50,
                        labelText: 'Name',
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
                        controller: emailController,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        // controller: posterEmailControler,
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
                        // controller: posterEmailControler,
                        decoration: InputDecoration(
                          // color: Colors.blueGrey.shade50,
                          labelText: 'Major',
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
                        // controller: posterEmailControler,
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
                        controller: idController,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        // controller: posterEmailControler,
                        decoration: InputDecoration(
                          // color: Colors.blueGrey.shade50,
                          labelText: 'ID',
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
                        // controller: posterEmailControler,
                        decoration: InputDecoration(
                          // color: Colors.blueGrey.shade50,
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
                        // controller: posterEmailControler,
                        decoration: InputDecoration(
                          // color: Colors.blueGrey.shade50,
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
                        // controller: posterEmailControler,
                        decoration: InputDecoration(
                          // color: Colors.blueGrey.shade50,
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
                        // controller: posterEmailControler,
                        decoration: InputDecoration(
                          // color: Colors.blueGrey.shade50,
                          labelText: 'Favorite Food',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    // height: 10,
                    child:
                    GFButton(
                      onPressed: (){
                        uploadPost(nameController.text, emailController.text,
                            majorController.text, yeargroupController.text,
                            idController.text, residenceController.text,
                            dateofBirthController.text, movieController.text, foodController.text);
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
      ),
    );

  }
}

