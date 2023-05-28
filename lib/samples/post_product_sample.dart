import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

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
  double _latitude = 0.0;
  double _longitude = 0.0;
  late File _image;
  late User? _user = FirebaseAuth.instance.currentUser;
  String _postImageURL = '';
  String _postId = '';
  String _username = '';

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
      await storageRef.putFile(imageFile);

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

  Future<void> savePost(BuildContext context) async {
    var model = Provider.of<UserModel>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      Reference ref =
          FirebaseStorage.instance.ref().child('posts/$_postId.jpg');
      String docName = DateTime.now().millisecondsSinceEpoch.toString();
      var post = {
        'title': _title,
        'price': _price,
        'details': _details,
        'location': _location,
        'latitude': _latitude,
        'longitude': _longitude,
        'imageUrl': await ref.getDownloadURL(),
        'id': _postId,
        'user': _user?.uid,
        'day': DateTime.now().day,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
        'minutes': DateTime.now().minute,
        'username': model.name,
        'document_name': int.parse(docName),
      };
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(docName)
          .set(post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Publish Product Post'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _postImageURL == ''
                  ? GestureDetector(
                      onTap: uploadImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 224, 224, 224),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Icon(Icons.image),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: double.infinity,
                      height: 150,
                      child: Image.network(
                        _postImageURL,
                      ),
                    ),
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
                maxLines: 5,
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
                height: 10,
              ),
              Text(
                'Google Map Coordinates (Optional)',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'latitude'),
                onChanged: (value) {
                  _latitude = double.parse(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'longitude'),
                onChanged: (value) {
                  _longitude = double.parse(value);
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {
                  await savePost(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
