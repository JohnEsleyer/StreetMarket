import 'package:cloud_firestore/cloud_firestore.dart';

class PostDataModel {
  final String? title;
  final String? imageUrl;
  final String? location;
  final int? minutes;
  final int? month;
  final int? year;
  final String? price;
  final String? username;

  PostDataModel(
      {this.title,
      this.imageUrl,
      this.location,
      this.minutes,
      this.year,
      this.month,
      this.price,
      this.username});

  // QuerySnapshot from Cloud Firestore to a list of objects of this DataModel

  List<PostDataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return PostDataModel(
        title: dataMap['title'],
        imageUrl: dataMap['imageUrl'],
        location: dataMap['location'],
        minutes: dataMap['minutes'],
        month: dataMap['month'],
        year: dataMap['year'],
      );
    }).toList();
  }
}
