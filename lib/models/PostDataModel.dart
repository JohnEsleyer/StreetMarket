import 'package:cloud_firestore/cloud_firestore.dart';

class PostDataModel {
  String? title = '';
  String? imageUrl = '';
  final String? location;
  final int? minutes;
  final int? day;
  final int? month;
  final int? year;
  final String? price;
  String? username = '';
  final String? details;
  final String? user;

  PostDataModel({
    this.title,
    this.imageUrl,
    this.location,
    this.minutes,
    this.year,
    this.month,
    this.day,
    this.price,
    this.username,
    this.details,
    this.user,
  });

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
        day: dataMap['day'],
        details: dataMap['details'],
        user: dataMap['user'],
        username: dataMap['username'],
        price: dataMap['price'],
      );
    }).toList();
  }
}
