import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({ Key? key }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Container(
            // remove this if done with outline
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 1
              )
            ),
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
                    Container(
                      width: 325,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    )   
                  ],
                ),
              ],
              )
            ),
        ],
      ),
    );
  }
}