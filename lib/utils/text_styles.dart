import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalTextStyles {
  static TextStyle regularText({Color? color, double fontSize = 14}) {
    return GoogleFonts.dmSans(color: color, fontSize: fontSize);
  }

  static TextStyle medium({Color? color, double fontSize = 16}) {
    return GoogleFonts.dmSans(
        color: color, fontWeight: FontWeight.w500, fontSize: fontSize);
  }

  static TextStyle semiBold({Color? color, double fontSize = 16}) {
    return GoogleFonts.dmSans(
        color: color, fontWeight: FontWeight.w600, fontSize: fontSize);
  }

  static TextStyle bold({Color? color, double fontSize = 16}) {
    return GoogleFonts.dmSans(
        color: color, fontWeight: FontWeight.bold, fontSize: fontSize);
  }
}
