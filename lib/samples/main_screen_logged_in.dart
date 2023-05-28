import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/UserData.dart';

class MainScreenLoggedIn extends StatefulWidget {
  @override
  _MainScreenLoggedInState createState() => _MainScreenLoggedInState();
}

class _MainScreenLoggedInState extends State<MainScreenLoggedIn> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                print("Signed out!");

                Navigator.of(context).popAndPushNamed('/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 222, 182, 0),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 30),
                Image.asset(
                  'assets/streetmarket_icon.png',
                  width: 30,
                  height: 30,
                ),
                Image.asset(
                  'assets/streetmarket_text.png',
                  width: 150,
                  height: 150,
                ),
              ],
            ),
            Container(
              height: 35,
              width: 35,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/profile');
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(profileURL),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Colors.yellow,
                    child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        final document = snapshot.data?.docs[index];

                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 10,
                                    offset: Offset(2, 2),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundImage:
                                                  NetworkImage(profileURL),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    document?['title'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Posted by ${document?['username']}",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${document?['location']}",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "PHP ${document?['price']}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "Date posted: ${document?['month']}/${document?['day']}/${document?['year']}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 50,
                                      child: Expanded(
                                        child: Text(document?['details']),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          document?['imageUrl'],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                        // return Container(
                        //     child: Center(
                        //   child: Text(document?['title']),
                        // ));
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
