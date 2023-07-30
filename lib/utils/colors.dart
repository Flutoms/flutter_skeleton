import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF014751);
const kTextColor = Color(0xFF565758);
const kSkyBlue = Color(0xffd7e6f4);
const Color kTextFieldStroke = Color(0xffE4E7EC);

// const MaterialColor materialPrimaryColor = MaterialColor(
//   0xffdd3730,
//   <int, Color>{
//     50: Color(0xffdd3730), //10%
//     100: Color(0xffc7322b), //2ti
//     200: Color(0xffb12c26), //30%
//     300: Color(0xff9b2722), //40%
//     400: Color(0xff85211d), //50%
//     500: Color(0xff6f1c18), //60%
//     600: Color(0xff581613), //70%
//     700: Color(0xff42100e), //80%
//     800: Color(0xff2c0b0a), //90%
//     900: Color(0xff160505) //100%
//   },
// );

MaterialColor materialPrimaryColor() {
  Color color = kPrimaryColor;
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red,
      g = color.green,
      b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
