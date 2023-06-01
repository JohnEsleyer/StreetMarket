import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:streetmarket/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/UserData.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  Color $whitesh = const Color(0xffF5F4F7);
  Color $mustard = const Color(0xffF4C900);
  Color $gray = const Color(0xff595757);
  Color $error = const Color(0xffED4337);
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) async {
    var model = Provider.of<UserModel>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      // Form is valid, perform registration logic here
      String email = _emailController.text;
      String password = _passwordController.text;
      String name = _nameController.text;

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        model.setId(credential.user?.uid);

        // Document for the user
        DocumentReference userDocument = FirebaseFirestore.instance
            .collection('Users')
            .doc(credential.user?.uid);

        print('UID: ${credential.user?.uid}');
        model.setUserCred(credential);

        // Write data to the document
        await userDocument.set({
          'name': name,
          'email': email,
        });

        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushNamed('/login');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Account successfully created, please sign in with that account"),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      // FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      //   if (user == null) {
      //     print('User is currently signed out!');
      //   } else {
      //     print('User is signed in!');
      //   }
      // });

      // Reset form after successful registration
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    var $screenWidth = MediaQuery.of(context).size.width;
    var $screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 90),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
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
                    SizedBox(height: 10),
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
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Display Name',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    NeumorphicButton(
                      onPressed: () {
                        _submitForm(context);
                      },
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
                            'Sign Up',
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/login');
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
