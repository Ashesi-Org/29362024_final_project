import 'package:final_project/allUsers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'allUsers.dart';
import 'userModel.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Stream<List<UserModel>> getUsers() {
  return db.collection('users') //connect to users db
      .snapshots() //get snapshot of users collection
      .map((snapShot) => snapShot.docs //get a map of all the docs in the collection
      .map((document) => UserModel.fromJson(document.data())) //call usermodel method to convert
      .toList());
}