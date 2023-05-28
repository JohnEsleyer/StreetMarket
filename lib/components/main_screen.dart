import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streetmarket/components/search_bar.dart';
import './product_card.dart';
import 'package:streetmarket/components/signin.dart';
import 'package:streetmarket/components/signup.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color $whitesh = const Color(0xffF5F4F7);
  Color $mustard = const Color(0xffF4C900);
  Color $gray = const Color(0xff595757);
  @override
  Widget build(BuildContext context) {
  var $screenWidth = MediaQuery.of(context).size.width;
  var $screenHeight = MediaQuery.of(context).size.height;
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
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Image.asset(
      //         'assets/streetmarket_icon.png',
      //         width: 30,
      //         height: 30,
      //       ),
      //       Image.asset(
      //         'assets/streetmarket_text.png',
      //         width: 150,
      //         height: 150,
      //       ),
      //       const SizedBox(width: 50),
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: $whitesh,
              width: $screenWidth,
              height: $screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: $screenWidth,
                      height: 160,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          //! Relates to the search related text only
                          Container(
                            width: $screenWidth,
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Products related to ',
                                  style: GoogleFonts.inter(
                                    color: $gray,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  //TODO: Replacement for variable
                                  '"Searched Text"',
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //! Relates to the search related text only --END
                          // ignore: sized_box_for_whitespace

                          //! For the location
                          Container(
                            width: $screenWidth - 50,
                            child: Text(
                              //TODO: change to location variable
                              'Koronadal City',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                              fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          //! For the location --END
                        ],
                      ),
                    ),
                    //TODO: for a loop maybe?
                    //TODO: add params for the productcard maybe?

                    //! Part as TODO: for a loop maybe?
                    const ProductCard(),
                    const SizedBox(
                      height: 20,
                    ),
                    //! Part as TODO: for a loop maybe? --END
                    // Container(
                    //   color: Colors.red,
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height,
                    // )
                  ],
                ),
              ),
            ),
            const SearchBar()
          ],
        ),
      )
    );
  }
}
