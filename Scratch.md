  // Create a FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a FirebaseFirestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new user
  UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
    email: 'johndoe@example.com',
    password: 'password',
  );




 // Create a document in Firestore for that user
  DocumentReference userDocument = _db.collection('Users').doc(userCredential.user.uid);

  // Write data to the document
  await userDocument.set({
    'name': 'John Doe',
    'email': 'johndoe@example.com'
  });

  // Read the name of the user from Firestore
  DocumentSnapshot userSnapshot = await userDocument.get();

  // Print the name of the user
  String name = userSnapshot.data()['name'];

  // Print the email of the user
  String email = userSnapshot.data()['email'];

  print('Name: $name');
  print('Email: $email');




### Store images in Firebase storage
```dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

void main() {
  // Get a reference to the storage bucket
  final storage = FirebaseStorage.instance;

  // Get a reference to the image file
  final imageFile = File('path/to/image.jpg');

  // Upload the image file to the storage bucket
  storage.ref('images/my-image.jpg').putFile(imageFile).then((snapshot) {
    // The image has been uploaded successfully
  });
}
```
Once you have uploaded an image to Firebase Storage, you can access it using the ref() method. For example, the following code will get a reference to the image that was uploaded in the previous example:

```dart
final imageRef = FirebaseStorage.instance.ref('images/my-image.jpg');
```
You can then use the getDownloadURL() method to get the URL of the image. The getDownloadURL() method will return a Future that will resolve to the URL of the image. You can then use the URL to download the image or to display it in your app.

Here is an example of how to get the URL of an image that was uploaded to Firebase Storage:

```dart
final imageRef = FirebaseStorage.instance.ref('images/my-image.jpg');

// Get the URL of the image
imageRef.getDownloadURL().then((url) {
  // Use the URL to download the image or to display it in your app
});
```


