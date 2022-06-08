import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// Optional Color
  static Color backgroundColor = Colors.white;
  static LinearGradient buttonColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
     Color.fromRGBO(38, 203, 255, 1),
     Color.fromRGBO(105, 128, 253, 1)
    ],
    tileMode: TileMode.mirror,
  );
  static Color subTitle =const Color.fromRGBO(90, 90, 90, 1);
  static Color bottomBar =const Color.fromRGBO(252, 254, 251, 1);

  static LinearGradient nameGradientColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
     Color.fromRGBO(105, 128, 253, 0.8),
     Color.fromRGBO(38, 203, 255, 0.8),
    ],
  );

  ///Default font
  static TextStyle headLine1 = GoogleFonts.roboto(
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: backgroundColor
  );
  static TextStyle headLine2 = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 22,
    color: backgroundColor
  );
  static TextStyle headLine3 = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: backgroundColor
  );
    static TextStyle headLine4 = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: subTitle
  );
      static TextStyle headLine5 = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: Colors.white70
  );


  ///Singleton factory
  static final AppTheme _instance = AppTheme._internal();
  static const double padding =20;
  static const double avatarRadius =45;
  factory AppTheme(){
    return _instance;
  }

  AppTheme._internal();
}