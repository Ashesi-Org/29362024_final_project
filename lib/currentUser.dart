import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';


class currentUser extends StatefulWidget {
  const currentUser({Key? key}) : super(key: key);

  @override
  State<currentUser> createState() => _currentUserState();
}

class _currentUserState extends State<currentUser> {


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
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
