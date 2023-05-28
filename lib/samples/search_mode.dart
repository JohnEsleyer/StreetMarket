import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_search_input/firestore_search_input.dart';
import 'package:streetmarket/models/PostDataModel.dart';

import '../models/UserData.dart';

class SearchModeScreen extends StatefulWidget {
  @override
  _SearchModeScreenState createState() => _SearchModeScreenState();
}

class _SearchModeScreenState extends State<SearchModeScreen> {
  User? user;
  String profileURL = "";
  @override
  void initState() {
    super.initState();

    // Initialize Firebase Authentication
    FirebaseAuth auth = FirebaseAuth.instance;

    // Get the current user
    setState(() {
      user = auth.currentUser;
    });

    // Get the reference to the image from Firebase Storage
    Reference imageRef =
        FirebaseStorage.instance.ref().child('users/${user?.uid}/profile.jpg');

    // Get the download URL for the image
    imageRef.getDownloadURL().then((url) {
      setState(() {
        // Create an Image widget with the download URL
        profileURL = url;
      });
    });
  }

  Future<String> getUserProfile(
      QueryDocumentSnapshot<Map<String, dynamic>>? document) {
    // Get the reference to the image from Firebase Storage
    Reference imageRef2 = FirebaseStorage.instance
        .ref()
        .child('users/${document?['user']}/profile.jpg');
    var usrImageURL = '';
    return imageRef2.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreSearchScaffold(
        firestoreCollectionName: 'posts',
        searchBy: 'title',
        dataListFromSnapshot: PostDataModel().dataListFromSnapshot,
        scaffoldBody: Center(),
        builder: (context, snapshot) {
          print(snapshot.error);

          if (snapshot.hasData) {
            final List<PostDataModel>? dataList = snapshot.data;
            if (dataList!.isEmpty) {
              return const Center(
                child: Text('No Results Found!'),
              );
            }
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final PostDataModel data = dataList[index];

                return Container(
                  child: Text(data.title as String),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     backgroundColor: Color.fromARGB(255, 222, 182, 0),
    //     centerTitle: true,
    //     title: Row(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         Hero(
    //           tag: 'search',
    //           child: Icon(
    //             Icons.search,
    //             color: Colors.black,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   body: Center(
    //     child: Text("Search Mode"),
    //   ),
    // );
  }
}
