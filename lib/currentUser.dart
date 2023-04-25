import 'package:final_project/profilecard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dataHandler.dart';
import 'dataHandler.dart';
import 'dataHandler.dart';
import 'firebase_options.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'profilecard.dart';

////////////// NO LONGER IN USE //////////////////////

class currentUser extends StatefulWidget {
  const currentUser({Key? key}) : super(key: key);

  @override
  State<currentUser> createState() => _currentUserState();
}

class _currentUserState extends State<currentUser> {
  /** A class that renders the textbox to switch to/view a user **/

  // Variables needed for state management
  final currentUserEmailController = TextEditingController();
  String currentEmail = '';
  String userData = '';

  void updateEmail(String email) {
    setState(() {
      currentEmail = email;
    });
  }




  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
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
      );

  }
}
