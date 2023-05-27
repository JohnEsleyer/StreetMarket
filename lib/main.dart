import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetmarket/components/main_screen.dart';
import 'package:streetmarket/models/UserData.dart';
import 'package:streetmarket/samples/profile_sample.dart';
import 'components/search_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'samples/register_sample.dart';
import 'samples/login_sample.dart';
import 'package:flutter/foundation.dart';
import 'models/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserModel(),
      child: MaterialApp(
        routes: {
          '/': (context) {
            return Scaffold(
              body: LoginForm(), // First screen to open
            );
          },
          '/profile': (context) {
            return UserProfileScreen();
          },
          '/login': (context) {
            return LoginForm();
          },
          '/register': (context) {
            return RegisterForm();
          },
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.black,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color.fromARGB(255, 255, 170, 0),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
