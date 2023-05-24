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
            color: Colors.blue,
            height: 45,
            width: double.infinity,
            child: Row(
              children: [
                Image.asset('assets/streetmarket_r1_colored.png',
                ),
              ],
              )
            ),
        ],
      ),
    );
  }
}