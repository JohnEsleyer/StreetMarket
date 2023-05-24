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
  MaterialColor myColor = MaterialColor(0xFFFFC107, {
    50: Color(0xFFFFF8E1),
    100: Color(0xFFFFECB3),
    200: Color(0xFFFFE082),
    300: Color(0xFFFFD54F),
    400: Color(0xFFFFCA28),
    500: Color(0xFFFFC107),
    600: Color(0xFFFFB300),
    700: Color(0xFFFFA000),
    800: Color(0xFFFF8F00),
    900: Color.fromARGB(255, 0, 0, 0),
  });

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: myColor,
      ),
      home: ChangeNotifierProvider(
        create: (_) => UserModel(auth: _auth, db: _db),
        child: Scaffold(
          body: RegisterForm(),
        ),
      ),
    );
  }
}
