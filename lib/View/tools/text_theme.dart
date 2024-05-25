import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get promptStyle {
  return GoogleFonts.abel(
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white));
}

TextStyle get responseStyle {
  return GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 14, color: Colors.black));
}

TextStyle get headStyle {
  return GoogleFonts.acme(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black));
}



// TextStyle(
//               fontStyle: isprompt ? FontStyle.italic : FontStyle.normal,
//               fontWeight: isprompt ? FontWeight.bold : FontWeight.normal,
//               fontSize: 13,
//               color: isprompt ? Colors.white : Colors.black,
//             ),