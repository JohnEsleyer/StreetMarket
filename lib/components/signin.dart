import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import './signup.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Color $whitesh = const Color(0xffF5F4F7);
  Color $mustard = const Color(0xffF4C900);
  Color $gray = const Color(0xff595757);
  Color $error = const Color(0xffED4337);
  @override
  Widget build(BuildContext context) {
    var $screenWidth = MediaQuery.of(context).size.width;
    var $screenHeight = MediaQuery.of(context).size.height;
    double $fieldHeight = 47;
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   border: Border.all()
        // ),
        width: $screenWidth,
        height: $screenHeight,
        child: Column(
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
            Neumorphic(
              //! USERNAME or EMAIL
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  depth: -3.5,
                  intensity: 0.8,
                  color: $whitesh),
              child: Container(
                  width: $screenWidth - (90),
                  height: $fieldHeight,
                  padding: const EdgeInsets.fromLTRB(13, 0, 10, 1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      //TODO: var for username
                      decoration: InputDecoration(
                        hintText: 'Username or Email',
                        hintStyle: TextStyle(color: Colors.black45),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Neumorphic(
              //! Password
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  depth: -3.5,
                  intensity: 0.8,
                  color: $whitesh),
              child: Container(
                  width: $screenWidth - (90),
                  height: $fieldHeight,
                  padding: const EdgeInsets.fromLTRB(13, 0, 10, 1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      //TODO: var for password
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black45),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 35,
              child: Row(
                //! toggle only this if there's an error in password
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    String.fromCharCode(Iconsax.close_square.codePoint),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      inherit: false,
                      color: $error,
                      fontSize: 12.75,
                      fontWeight: FontWeight.w900,
                      fontFamily: Iconsax.close_square.fontFamily,
                      package: Iconsax.close_square.fontPackage,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Password does not match.',
                    style: GoogleFonts.inter(
                        fontSize: 11.75,
                        fontWeight: FontWeight.w400,
                        color: $error),
                  ),
                ],
              ),
            ),
            NeumorphicButton(
              onPressed: () {
                //TODO: add functionality
              },
              style: NeumorphicStyle(
                  color: $mustard,
                  shape: NeumorphicShape.flat,
                  depth: 2,
                  intensity: 1,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15))),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const SignUpScreen())));
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
      ),
    );
  }
}
