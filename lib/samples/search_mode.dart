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

  Future<String> getUserProfile(String user) {
    // Get the reference to the image from Firebase Storage
    Reference imageRef2 =
        FirebaseStorage.instance.ref().child('users/$user/profile.jpg');
    var usrImageURL = '';
    return imageRef2.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreSearchScaffold(
        limitOfRetrievedData: 20,
        clearSearchButtonColor: Colors.amber,
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
                // return Column(
                //   children: [
                //     Center(child: Text(data.title as String)),
                //     Center(child: Text(data.imageUrl ?? 'null')),
                //     Center(child: Text(data.location ?? 'null')),
                //     Center(child: Text(data.details ?? 'null')),
                //     Center(child: Text(data.username ?? 'null')),
                //   ],
                // );
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Search Results...",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Koronadal City",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                      FutureBuilder(
                                        future:
                                            getUserProfile(data.user as String),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return CircleAvatar(
                                              radius: 15,
                                              backgroundImage: NetworkImage(
                                                  snapshot.data.toString()),
                                            );
                                          }

                                          return CircularProgressIndicator();
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.title as String,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "Posted by ${data.username as String}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "${data.location as String}",
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
                                        "PHP ${data.price}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "Date posted: ${data.month}/${data.day}/${data.year}",
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
                                  child: Text(data.details as String),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    data.imageUrl as String,
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
                }
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    FutureBuilder(
                                      future:
                                          getUserProfile(data.user as String),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return CircleAvatar(
                                            radius: 15,
                                            backgroundImage: NetworkImage(
                                                snapshot.data.toString()),
                                          );
                                        }

                                        return CircularProgressIndicator();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.title as String,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            "Posted by ${data.username}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            "${data.location}",
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
                                      "PHP ${data.price}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Date posted: ${data.month}/${data.day}/${data.year}",
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
                                child: Text(data.details as String),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  data.imageUrl as String,
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
