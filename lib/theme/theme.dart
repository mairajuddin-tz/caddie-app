import 'package:flutter/material.dart';

class CaddieColors {
  // Onboarding (dark)
  static const Color background = Color(0xFF001510);
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteSubtle = Color(0xCCFFFFFF);  // 80%
  static const Color whiteFaint = Color(0x80FFFFFF);   // 50%
  static const Color skipBg = Color(0xCCF2EFEE);       // 80% opacity

  // Auth screens (light)
  static const Color authBg = Color(0xFFF2EFEE);
  static const Color authTitle = Color(0xFF001510);
  static const Color authCard = Color(0xFFFFFFFF);
  static const Color authBorder = Color(0xFFE5E5E5);
  static const Color authInput = Color(0xFFF7F7F7);
  static const Color authInputBorder = Color(0xFFD9D9D9);

  // Green gradient button
  static const Color btnGradientTop = Color(0xFF437566);
  static const Color btnGradientBottom = Color(0xFF325A4E);
  static const Color btnBorder = Color(0xFF325B4F);
}

class CaddieSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 40;
}

class CaddieRadius {
  static const double input = 14;
  static const double button = 80;
  static const double chip = 10;
  static const double card = 28;
}

// Green gradient decoration
const LinearGradient greenGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [CaddieColors.btnGradientTop, CaddieColors.btnGradientBottom],
);

// Text styles
class CaddieText {
  static TextStyle heading(double size, {FontWeight weight = FontWeight.w600}) =>
      TextStyle(fontSize: size, fontWeight: weight, color: CaddieColors.white, height: 1.15);

  static TextStyle body(double size, {Color? color}) =>
      TextStyle(fontSize: size, fontWeight: FontWeight.w400, color: color ?? CaddieColors.whiteSubtle, height: 1.5);
}
