import 'package:flutter/material.dart';

AppBar StreetMarketAppBar = AppBar(
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
      SizedBox(width: 50),
    ],
  ),
);
