import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({ Key? key }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  Color $whitesh = const Color(0xffF5F4F7);
  Color $mustard = const Color(0xffF4C900);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              // remove this if done with outline
              // decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.blue,
                //   width: 1
                // )
              // ),
              height: 45,
              width: double.infinity,
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.asset('assets/streetmarket_logo_r1_colored.png',
                      width: 20.05,
                      height: 29.37,
                      ),
                      Image.asset('assets/streetmarket_r1_colored.png',
                      width: 75,
                      height: 8.25,
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Neumorphic(
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          depth: -3.5,
                          intensity: 0.8,
                          color: $whitesh
                        ),
                        child: Container(
                          width: 325,
                          height: 42,
                          padding: const EdgeInsets.fromLTRB(13, 0, 10, 1.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Search here',
                              hintStyle: TextStyle(
                                color: Colors.black45
                                ),
                              border: InputBorder.none,
                            ),
                            )
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 38,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              NeumorphicButton(
                              onPressed: (){},
                              padding: EdgeInsets.zero,
                              style: NeumorphicStyle(
                                color: $whitesh,
                                shape: NeumorphicShape.flat,
                                depth: 2,
                                intensity: 1,
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(5)
                                  )
                              ),
                              child: SizedBox(
                                width: 21.75,
                                height: 21.75,
                                // child: Icon(
                                // Iconsax.filter_search,
                                // size: 20.75,
                                // color: $mustard,
                                // ),
                                child: Text(
                                  String.fromCharCode(Iconsax.filter_search.codePoint),
                                  textAlign: TextAlign.center,
      
                                  style: TextStyle(
                                    inherit: false,
                                    color: $mustard,
                                    fontSize: 18.75,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: Iconsax.filter_search.fontFamily,
                                    package: Iconsax.filter_search.fontPackage,
                                  ),
                                )
                              )
                              ),
                            ]
                          ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              NeumorphicButton(
                              onPressed: (){},
                              padding: EdgeInsets.zero,
                              style: NeumorphicStyle(
                                color: $whitesh,
                                shape: NeumorphicShape.flat,
                                depth: 2,
                                intensity: 1,
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(5)
                                  )
                              ),
                              child: SizedBox(
                                width: 21.75,
                                height: 21.75,
                                // child: Icon(
                                // Iconsax.filter_search,
                                // size: 20.75,
                                // color: $mustard,
                                // ),
                                child: Text(
                                  String.fromCharCode(Iconsax.search_normal.codePoint),
                                  textAlign: TextAlign.center,
      
                                  style: TextStyle(
                                    inherit: false,
                                    color: $mustard,
                                    fontSize: 18.75,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: Iconsax.search_normal.fontFamily,
                                    package: Iconsax.search_normal.fontPackage,
                                  ),
                                )
                              )
                              ),
                            ]
                          ),
                      ),
                    ],
                  ),
                ],
                )
              ),
          ],
        ),
      ),
    );
  }
}