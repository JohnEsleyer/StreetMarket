// Main imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Mains
import 'package:streetmarket/components/main_screen.dart';
import 'package:streetmarket/models/UserData.dart';
// Components
import 'components/search_bar.dart';
import 'components/product_card.dart';
// Samples
import 'samples/register_sample.dart';
import 'samples/login_sample.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return MaterialApp(
      theme: ThemeData(
      // title: 'Flutter Demo',
        primarySwatch: myColor,
        fontFamily: GoogleFonts.inter().fontFamily
      ),
      home: const Scaffold(
        body: ProductCard(),
      ),
    );
  }
}
