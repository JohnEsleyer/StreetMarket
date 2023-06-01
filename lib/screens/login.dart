import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:streetmarket/screens/profile.dart';

import '../models/UserData.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Color $whitesh = const Color(0xffF5F4F7);
  Color $mustard = const Color(0xffF4C900);
  Color $gray = const Color(0xff595757);
  Color $error = const Color(0xffED4337);

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
    var $screenWidth = MediaQuery.of(context).size.width;
    var $screenHeight = MediaQuery.of(context).size.height;
    double $fieldHeight = 47;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/streetmarket_logo_r1_colored.png',
            width: 80,
          ),
          Image.asset(
            'assets/streetmarket_r1_colored.png',
            width: $screenWidth - 150,
          ),
          const SizedBox(
            height: 50,
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      depth: -3.5,
                      intensity: 0.8,
                      color: $whitesh,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      depth: -3.5,
                      intensity: 0.8,
                      color: $whitesh,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  NeumorphicButton(
                    onPressed: _submitForm,
                    style: NeumorphicStyle(
                        color: $mustard,
                        shape: NeumorphicShape.flat,
                        depth: 2,
                        intensity: 1,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(15))),
                    child: SizedBox(
                      width: $screenWidth - 300,
                      height: 27,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: GoogleFonts.inter(
                  fontSize: 10,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
