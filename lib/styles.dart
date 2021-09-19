import 'dart:ui';
import 'package:flutter/material.dart';

const themeColor = Color(0xffffa726);
const primaryColor = Color(0xff203152);
const greyColor = Color(0xffaeaeae);
const greyColor2 = Color(0xffE8E8E8);
const bgColor = Color(0xff151718);

// HomeScreen screen text styles
const textStyle1 =
    TextStyle(color: Colors.amber, fontSize: 32, fontWeight: FontWeight.w500);
const textStyle2 =
    TextStyle(color: Colors.amber, fontSize: 45, fontWeight: FontWeight.w700);
// App bar title text
var titleText = const Text('Firebase Flutter Chat App');

var themeStyle = ThemeData(
  primarySwatch: Colors.orange,
  backgroundColor: bgColor,
  scaffoldBackgroundColor: bgColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

var profileText = const TextStyle(
  color: Colors.orangeAccent,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

var appBarTheme = const TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
);
