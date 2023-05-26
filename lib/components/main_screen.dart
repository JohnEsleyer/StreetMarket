import 'package:flutter/material.dart';
import 'package:streetmarket/components/signin.dart';
import 'package:streetmarket/components/signup.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            GestureDetector(
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => SignInScreen())));
                }),
            GestureDetector(
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => SignUpScreen())));
                }),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/streetmarket_icon.png',
              width: 30,
              height: 30,
            ),
            Image.asset(
              'assets/streetmarket_text.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(width: 50),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
