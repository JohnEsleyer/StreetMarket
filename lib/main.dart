import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:streetmarket/models/UserData.dart';
import 'package:streetmarket/components/signup.dart';
import 'package:streetmarket/components/signin.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetmarket/samples/main_screen_logged_in.dart';
import 'package:streetmarket/samples/main_screen_sample.dart';
import 'package:streetmarket/models/UserData.dart';
import 'package:streetmarket/samples/post_product_sample.dart';
import 'package:streetmarket/samples/profile_sample.dart';
import 'package:streetmarket/samples/search_mode.dart';
import 'package:streetmarket/samples/view_product.dart';

import 'components/search_bar.dart';
import 'components/product_card.dart';
import 'samples/register_sample.dart';
import 'samples/login_sample.dart';
import 'samples/main_screen_sample.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/foundation.dart';
import 'models/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MaterialColor myColor = const MaterialColor(0xFFFFC107, {
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SignInScreen(),
          // '/': (context) => LoginForm(), // First screen to open
          '/profile': (context) => UserProfileScreen(),
          '/login': (context) => LoginForm(),
          '/register': (context) => RegisterForm(),
          '/post-product': (context) => PostProduct(),
          '/main_screen': (context) => MainScreen(),
          '/main_screen_login': (context) => MainScreenLoggedIn(),
          '/search_mode': (context) => SearchModeScreen(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.black,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color.fromARGB(255, 255, 170, 0),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 255, 170, 0)),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
