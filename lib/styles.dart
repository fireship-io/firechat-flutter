import 'package:flutter/material.dart';

const titleText = Text('Firechat - Flutter');

const themeColor = Color(0xffffa726);
const primaryColor = Color(0xff203152);
const greyColor = Color(0xffaeaeae);
const greyColor2 = Color(0xffE8E8E8);
const bgColor = Color(0xff151718);

var themeStyle = ThemeData(
  primarySwatch: Colors.orange,
  backgroundColor: bgColor,
  scaffoldBackgroundColor: bgColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

const textStyle1 = TextStyle(
  color: Colors.amber,
  fontSize: 32,
  fontWeight: FontWeight.w500,
);
const textStyle2 = TextStyle(
  color: Colors.amber,
  fontSize: 45,
  fontWeight: FontWeight.w700,
);

const profileText = TextStyle(
  color: Colors.orangeAccent,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

const appBarTheme = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

const googleText = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

const boxShadow = BoxShadow(
  spreadRadius: 0.0,
  blurRadius: 0.0,
  color: Colors.black12,
  offset: Offset.zero,
);

const inputText = TextStyle(
  color: Colors.lightBlue,
  fontSize: 20,
  fontWeight: FontWeight.w500,
  letterSpacing: 1,
);

const blackText = TextStyle(
  color: Colors.black,
);

const placeholder = TextStyle(
  color: Color(0xFF666666),
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

const outlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(
      50.0,
    ),
  ),
  borderSide: BorderSide.none,
);

const roundedBorder = OutlineInputBorder(
  borderRadius: round,
  borderSide: BorderSide.none,
);

const sent = LinearGradient(
  colors: [
    Colors.orange,
    Colors.orangeAccent,
  ],
);

const received = LinearGradient(
  colors: [Colors.lightBlue, Colors.lightBlueAccent],
);

const chatText = TextStyle(
  color: Colors.black87,
  fontSize: 20,
  fontWeight: FontWeight.w500,
);

const chatConstraints = BoxConstraints(
  maxWidth: 310.0,
);

const round = BorderRadius.all(
  Radius.circular(40),
);
