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
                    for (int i = 0; i < 20; i++)...[ //! test only for loop
                    const ProductCard(
                      nameOnly: true,
                      posterName: 'Jan Mar',
                      posterProfileURL: 'https://images.generated.photos/NVJOK3XVAitYE-EIT9ffzsZjoyryw9KPx9z87M9kkQc/rs:fit:512:512/wm:0.95:sowe:18:18:0.33/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/NjE5MjI0LmpwZw.jpg',
                      productName: 'Test1',
                      productDesc: '"Nostrud sint officia Lorem laboris exercitation minim dolor quis nostrud consectetur ex dolor commodo. Aliqua adipisicing Lorem nostrud esse est ea ipsum duis commodo. Eu culpa officia ea reprehenderit ex sunt amet in laborum veniam dolore pariatur fugiat. Aliqua Lorem eu magna deserunt proident incididunt nulla nisi ex adipisicing."',
                      productImgURL1: 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-select-202207-6-1inch-pink?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1657641867367',
                      productImgURL2: 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-select-202207-6-1inch-pink?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1657641867367',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ],
                    //! Part as TODO: for a loop maybe? --END
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
