import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetmarket/samples/profile_sample.dart';

import '../models/UserData.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform login logic here
      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        var model = Provider.of<UserModel>(context, listen: false);
        var auth = FirebaseAuth.instance;
        final credential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        var userCollection = FirebaseFirestore.instance.collection('Users');
        var documentReference = userCollection.doc(credential.user?.uid);

        documentReference.get().then((documentSnapshot) {
          // Access the data in the document
          final data = documentSnapshot.data();

          // Print the data
          print(data);
        });

        model.setUserDoc(documentReference);
        model.setUserCred(credential);
        model.setUserCollection(userCollection);
        model.setId(credential.user?.uid);
        Navigator.of(context).popAndPushNamed('/profile');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
      FirebaseAuth.instance.idTokenChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });

      // // Reset form after successful login
      // _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Login'),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, '/register');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Create new account",
                style: TextStyle(
                  color: Colors.amber,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
