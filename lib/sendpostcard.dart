import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dataHandler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html';
// import 'package:file_picker_web/file_picker_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';


class sendPostCard extends StatefulWidget {
  const sendPostCard({Key? key}) : super(key: key);

  @override
  State<sendPostCard> createState() => _sendPostCardState();
}

class _sendPostCardState extends State<sendPostCard> {
  final posterEmailControler = TextEditingController();
  final postContentControler = TextEditingController();
  String posterEmail = '';
  String postContent = '';
  File? postImage;
  String? imageName = "";
  final ImagePicker picker = ImagePicker();
  XFile? image;

  // final ImagePicker _picker = ImagePicker();



  void updatePostContent(String email, String postcontent) {
    setState(() {
      posterEmail = email;
      postContent = postcontent;
      // sendData();
    });
  }

  Future<void> selectImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      final file = result.files.single;
      final fileBytes = file.bytes!;
      final fileName = file.name;
      final filePath = file.path; // or file.path
      imageName = fileName;
      setState(() {
        postImage = File(filePath as List<Object>, fileName);
      });
      // print("the image name is " + imageName);
    }
  }



  // Future<String> sendPost(String email, String postContent, {XFile? imageFile}) async {
  //   var request = http.MultipartRequest('POST', Uri.parse('https://us-central1-ashesistream-383012.cloudfunctions.net/streamPosts/posts'));
  //   print("abount to send request");
  //   // add text field to request
  //   request.fields['text'] = postContent;
  //   request.fields['email'] = email;
  //   if(imageFile != null) {
  //     final bytes = imageFile.readAsBytes();
  //     request.fields['hasimage'] = "true";
  //     request.fields['imagename'] = imageFile.name;
  //     request.fields['image'] = imageFile.path;
  //     request.files.add(await http.MultipartFile.fromBytes('file', imageFile.path));
  //   }else{
  //     request.fields['hasimage'] = "false";
  //   }
  //   print("request sent to post");
  //   // send the request
  //   var response = await request.send();
  //   print(request.fields);
  //   // read the response
  //   var responseText = await response.stream.bytesToString();
  //
  //   // check if the response was successful
  //   if (response.statusCode == 200) {
  //     return responseText;
  //   } else {
  //     throw Exception('Failed to upload file');
  //   }
  // }

  static void uploadPost(String email, String postContent, {XFile? imageFile}) async{
    FormData formData;
    final dio = Dio();

    // imageFile.r
    //if there is no image
     if(imageFile == null){
       formData = FormData.fromMap({
         "text": postContent,
         "email": email,
         "hasimage" : 'false',
       });
     }else {
       // String? imagePath = imageFile?.path;
       final bytes = await imageFile.readAsBytes();
       formData = FormData.fromMap({
         "text": postContent,
         "email": email,
         "hasimage": 'true',
         "image": await MultipartFile.fromBytes(bytes, filename: imageFile.name),
         "imagename": imageFile.name,
       });
       }
     print(formData.fields);
    // dio.p
    final response = await dio.post("https://us-central1-ashesistream-383012.cloudfunctions.net/streamPosts/posts", data:formData);
     print(response.data);

  }

  //

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Form(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          width: screenWidth * 0.15,
          child:
          Column(
            children: [
              ListTile(
                title: const Text('New Post',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text(
                    'Share a new post with your friends!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.91,
                child: Column(
                  children: [
                    SizedBox(
                      height: 32, // <-- Set half the desired height here
                      child: TextFormField(
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        controller: posterEmailControler,
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

                    SizedBox(height: 16),
                    TextFormField(
                      controller: postContentControler,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      maxLines: 8,
                      // initialValue: 'Type your next post here!',
                      decoration: InputDecoration(
                        labelText: 'Post Content',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        Text(
                        imageName!,
                            style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                        ),
                        IconButton(
                          icon: Icon(Icons.image),
                          tooltip: "Attach an Image",
                          onPressed: ()  async {
                            // selectImage();

                            image = await picker.pickImage(source: ImageSource.gallery);
                            print(image?.name);
                            setState(() {
                              imageName = image?.name;
                            });

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          tooltip: "Send",
                          onPressed: () {
                            updatePostContent(posterEmailControler.text, postContentControler.text);
                            if(imageName!= null){
                              uploadPost(posterEmail,postContent,imageFile: image);
                            }else{
                              uploadPost(posterEmail,postContent);
                            }
                            setState(() {
                              imageName = "";
                              image = null;
                            });

                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
