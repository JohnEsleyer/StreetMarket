import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:streetmarket/custom_widgets/small_widgets.dart';

import '../models/UserData.dart';

class PostProduct extends StatefulWidget {
  @override
  _PostProductState createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _price = '';
  String _details = '';
  String _location = '';
  late File _image;
  late User? _user;
  String _postImageURL = '';
  String _postId = '';

  late File imageFile = File.fromUri(Uri.http(
      'https://static.vecteezy.com/system/resources/previews/018/753/399/non_2x/naruto-chibi-icon-cute-free-vector.jpg'));

  void initState() {
    super.initState();
    // Initialize Firebase Authentication
    FirebaseAuth auth = FirebaseAuth.instance;
    var uuid = Uuid();

    // Get the current user
    setState(() {
      _user = auth.currentUser;
      _postId = uuid.v4();
    });
  }

  Future<void> uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageFile = File(pickedImage.path);

      // Perform any additional actions with the image file, if needed
    }

    print("upload Image executed!");
    if (imageFile == null) {
      // Handle the case where no image file is available
      return;
    }

    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('posts/$_postId.jpg');
      await storageRef.putFile(imageFile!);

      storageRef.getDownloadURL().then((url) {
        setState(() {
          // Create an Image widget with the download URL
          _postImageURL = url;
        });
      });

      print('Image uploaded successfully!');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> savePost() async {
    if (_formKey.currentState!.validate()) {
      await uploadImage();

      Reference ref =
          FirebaseStorage.instance.ref().child('posts/$_postId.jpg');
      var post = {
        'title': _title,
        'price': _price,
        'details': _details,
        'location': _location,
        'imageUrl': await ref.getDownloadURL(),
        'id': _postId,
        'user': _user?.uid,
      };
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set(post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publish Product Post'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  _title = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                onChanged: (value) {
                  _price = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Details'),
                onChanged: (value) {
                  _details = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                onChanged: (value) {
                  _location = value;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: savePost,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
